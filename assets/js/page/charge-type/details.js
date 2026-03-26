import { disableButton, enableButton, resetForm } from '../../utilities/form-utilities.js';
import { attachLogNotesHandler  } from '../../utilities/log-notes.js';
import { handleSystemError } from '../../modules/system-errors.js';
import { showNotification, setNotification } from '../../modules/notifications.js';

document.addEventListener('DOMContentLoaded', () => {
    const page_link         = document.getElementById('page-link')?.getAttribute('href') || 'apps.php';
    const charge_type_id  = document.getElementById('details-id')?.textContent.trim();

    const displayDetails = async () => {
        const transaction = 'fetch charge type details';

        try {
            resetForm('charge_type_form');
            
            const formData = new URLSearchParams();
            formData.append('transaction', transaction);
            formData.append('charge_type_id', charge_type_id);

            const response = await fetch('./app/Controllers/ChargeTypeController.php', {
                method: 'POST',
                body: formData
            });

            if (!response.ok) {
                throw new Error(`Request failed with status: ${response.status}`);
            }

            const data = await response.json();

            if (data.success) {
                document.getElementById('charge_type_name').value = data.chargeTypeName || '';
                document.getElementById('charge_value').value = data.chargeValue || '';

                $('#value_type').val(data.valueType).trigger('change');
                $('#is_variable').val(data.isVariable).trigger('change');
                $('#application_order').val(data.applicationOrder).trigger('change');
                $('#tax_type').val(data.taxType).trigger('change');
            }
            else if (data.notExist) {
                setNotification(data.title, data.message, data.message_type);
                window.location.href = page_link;
            }
            else {
                showNotification(data.title, data.message, data.message_type);
            }
        } catch (error) {
            handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
        }
    };

    attachLogNotesHandler('#log-notes-main', '#details-id', 'charge_type');
    displayDetails();

    $('#charge_type_form').validate({
        rules: {
            charge_type_name: { required: true },
            value_type: { required: true },
            charge_value: {  
                required: function() {
                    return $('#value_type').val() != '';
                },
                number: true,
                maxPercentage: true 
            },
            is_variable: { required: true },
            application_order: { required: true },
            tax_type: { required: true },
        },
        messages: {
            charge_type_name: { required: 'Enter the display name' },
            value_type: { required: 'Choose the value type' },
            charge_value: {
                required: 'Enter charge value',
                number: 'Please enter a valid number'
            },
            is_variable: { required: 'Choose is variable' },
            application_order: { required: 'Choose the application order' },
            tax_type: { required: 'Choose the tax type' },
        },
        errorPlacement: (error, element) => {
            showNotification('Action Needed: Issue Detected', error.text(), 'error', 2500);
        },
        highlight: (element) => {
            const $element = $(element);
            const $target = $element.hasClass('select2-hidden-accessible')
                ? $element.next().find('.select2-selection')
                : $element;
            $target.addClass('is-invalid');
        },
        unhighlight: (element) => {
            const $element = $(element);
            const $target = $element.hasClass('select2-hidden-accessible')
                ? $element.next().find('.select2-selection')
                : $element;
            $target.removeClass('is-invalid');
        },
        submitHandler: async (form, event) => {
            event.preventDefault();

            const transaction = 'save charge type';

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('charge_type_id', charge_type_id);

            disableButton('submit-data');

            try {
                const response = await fetch('./app/Controllers/ChargeTypeController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) {
                    throw new Error(`Save charge type failed with status: ${response.status}`);
                }

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('submit-data');
                }
                else if(data.invalid_session){
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else{
                    showNotification(data.title, data.message, data.message_type);
                    enableButton('submit-data');
                }
            } catch (error) {
                enableButton('submit-data');
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }

            return false;
        }
    });

    document.addEventListener('click', async (event) => {
        if (!event.target.closest('#delete-charge-type')) return;

        const transaction = 'delete charge type';

        const result = await Swal.fire({
            title: 'Confirm Charge Type Deletion',
            text: 'Are you sure you want to delete this charge type?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Delete',
            cancelButtonText: 'Cancel',
            customClass: {
                confirmButton: 'btn btn-danger mt-2',
                cancelButton: 'btn btn-secondary ms-2 mt-2'
            },
            buttonsStyling: false
        });

        if (result.isConfirmed) {
            try {
                const formData = new URLSearchParams();
                formData.append('transaction', transaction);
                formData.append('charge_type_id', charge_type_id);

                const response = await fetch('./app/Controllers/ChargeTypeController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                const data = await response.json();

                if (data.success) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = page_link;
                }
                else if (data.invalid_session) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else {
                    showNotification(data.title, data.message, data.message_type);
                }
            } catch (error) {
                handleSystemError(error, 'fetch_failed', `Fetch request failed: ${error.message}`);
            }
        }
    });

    $('#is_variable').on('change', function () {
        const isYes = $(this).val() === 'Yes';
        const $chargeInput = $('#charge_value');

        if (isYes) $chargeInput.val(0);
        
        $chargeInput.prop('readonly', isYes);
    });

    $.validator.addMethod("maxPercentage", function(value, element) {
        let chargeType = $('#value_type').val();

        if (chargeType === 'Percentage') {
            return parseFloat(value) <= 100;
        }
        return true;
    }, "Percentage charge cannot exceed 100%");
});