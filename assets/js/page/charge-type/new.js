import { disableButton, enableButton } from '../../utilities/form-utilities.js';
import { handleSystemError } from '../../modules/system-errors.js';
import { showNotification, setNotification } from '../../modules/notifications.js';

document.addEventListener('DOMContentLoaded', () => {    
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
            affects_tax: { required: true }
        },
        messages: {
            charge_type_name: { required: 'Enter the display name' },
            value_type: { required: 'Choose the value type' },
            charge_value: {
                required: 'Enter charge value',
                number: 'Please enter a valid number'
            },
            is_variable: { required: 'Choose is variable' },
            affects_tax: { required: 'Choose affects tax' }
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

            const transaction   = 'save charge type';
            const page_link     = document.getElementById('page-link').getAttribute('href') || 'apps.php';

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);

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
                    setNotification(data.title, data.message, data.message_type);
                    window.location = `${page_link}&id=${data.charge_type_id}`;
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
