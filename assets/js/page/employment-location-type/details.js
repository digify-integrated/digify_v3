import { disableButton, enableButton, resetForm } from '../../utilities/form-utilities.js';
import { attachLogNotesHandler  } from '../../utilities/log-notes.js';
import { handleSystemError } from '../../modules/system-errors.js';
import { showNotification, setNotification } from '../../modules/notifications.js';

document.addEventListener('DOMContentLoaded', () => {
    const displayDetails = async () => {
        const transaction                   = 'fetch employment location type details';
        const page_link                     = document.getElementById('page-link')?.getAttribute('href') || 'apps.php';
        const employment_location_type_id   = document.getElementById('details-id')?.textContent.trim();

        try {
            resetForm('employment_location_type_form');
            
            const formData = new URLSearchParams();
            formData.append('transaction', transaction);
            formData.append('employment_location_type_id', employment_location_type_id);

            const response = await fetch('./app/Controllers/EmploymentLocationTypeController.php', {
                method: 'POST',
                body: formData
            });

            if (!response.ok) {
                throw new Error(`Request failed with status: ${response.status}`);
            }

            const data = await response.json();

            if (data.success) {
                document.getElementById('employment_location_type_name').value = data.employmentLocationTypeName || '';
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

    attachLogNotesHandler('#log-notes-main', '#details-id', 'employment_location_type');
    displayDetails();

    $('#employment_location_type_form').validate({
        rules: {
            employment_location_type_name: { required: true }
        },
        messages: {
            employment_location_type_name: { required: 'Enter the display name' }
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

            const transaction                   = 'save employment location type';
            const employment_location_type_id   = document.getElementById('details-id')?.textContent.trim();

            const formData = new URLSearchParams(new FormData(form));
            formData.append('transaction', transaction);
            formData.append('employment_location_type_id', employment_location_type_id);

            disableButton('submit-data');

            try {
                const response = await fetch('./app/Controllers/EmploymentLocationTypeController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) {
                    throw new Error(`Save employment location type failed with status: ${response.status}`);
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
        if (!event.target.closest('#delete-employment-location-type')) return;

        const transaction                   = 'delete employment location type';
        const employment_location_type_id   = document.getElementById('details-id')?.textContent.trim();
        const page_link                     = document.getElementById('page-link')?.getAttribute('href') || 'apps.php';

        const result = await Swal.fire({
            title: 'Confirm Employment Location Type Deletion',
            text: 'Are you sure you want to delete this employment location type?',
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
                formData.append('employment_location_type_id', employment_location_type_id);

                const response = await fetch('./app/Controllers/EmploymentLocationTypeController.php', {
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
});