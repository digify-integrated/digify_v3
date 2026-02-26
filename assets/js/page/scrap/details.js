import { disableButton, enableButton, resetForm, generateDropdownOptions, initializeDatePicker } from '../../utilities/form-utilities.js';
import { attachLogNotesHandler  } from '../../utilities/log-notes.js';
import { handleSystemError } from '../../modules/system-errors.js';
import { showNotification, setNotification } from '../../modules/notifications.js';

document.addEventListener('DOMContentLoaded', () => {
    const page_link = document.getElementById('page-link')?.getAttribute('href') || 'apps.php';
    const scrap_id  = document.getElementById('details-id')?.textContent.trim();

    const displayDetails = async () => {
        const transaction = 'fetch scrap details';

        try {
            resetForm('scrap_form');
            
            const formData = new URLSearchParams();
            formData.append('transaction', transaction);
            formData.append('scrap_id', scrap_id);

            const response = await fetch('./app/Controllers/ScrapController.php', {
                method: 'POST',
                body: formData
            });

            if (!response.ok) {
                throw new Error(`Request failed with status: ${response.status}`);
            }

            const data = await response.json();

            if (data.success) {
                document.getElementById('product_name').value = data.productName || '';
                document.getElementById('reference_number').value = data.referenceNumber || '';
                document.getElementById('quantity_on_hand').value = data.quantityOnHand || '';
                document.getElementById('scrap_quantity').value = data.scrapQuantity || '';
                document.getElementById('detailed_scrap_reason').value = data.detailedScrapReason || '';

                $('#scrap_reason_id').val(data.scrapReasonId || '').trigger('change');

                
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

    (async () => {
        await generateDropdownOptions({
            url: './app/Controllers/ScrapReasonController.php',
            dropdownSelector: '#scrap_reason_id',
            data: { transaction: 'generate scrap reason options' }
        });
    
        await displayDetails();
    })();

    attachLogNotesHandler('#log-notes-main', '#details-id', 'scrap');
    initializeDatePicker('#inventory_date');
    displayDetails();

    $('#scrap_form').validate({
        rules: {
            reference_number: { required: true },
            scrap_quantity: { required: true },
            scrap_reason_id: { required: true },
        },
        messages: {
            reference_number: { required: 'Enter the reference number' },
            scrap_quantity: { required: 'Enter the scrap quantity' },
            scrap_reason_id: { required: 'Choose the scrap reason' },
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

            const transaction = 'update scrap';

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('scrap_id', scrap_id);

            disableButton('submit-data');

            try {
                const response = await fetch('./app/Controllers/ScrapController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) {
                    throw new Error(`Save scrap failed with status: ${response.status}`);
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
        if (event.target.closest('#delete-scrap')){
            const transaction = 'delete scrap';

            const result = await Swal.fire({
                title: 'Confirm Physical Inventory Deletion',
                text: 'Are you sure you want to delete this scrap?',
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
                    formData.append('scrap_id', scrap_id);

                    const response = await fetch('./app/Controllers/ScrapController.php', {
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
        }

        if (event.target.closest('#apply-adjustment')){
            const transaction = 'apply adjustment';

            const result = await Swal.fire({
                title: 'Confirm Physical Inventory Deletion',
                text: 'Are you sure you want to delete this scrap?',
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
                    formData.append('scrap_id', scrap_id);

                    const response = await fetch('./app/Controllers/ScrapController.php', {
                        method: 'POST',
                        body: formData
                    });

                    if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                    const data = await response.json();

                    if (data.success) {
                        setNotification(data.title, data.message, data.message_type);
                        window.location.reload();
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
        }
    });
});