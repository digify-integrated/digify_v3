import { initializeDatatable, initializeDatatableControls, reloadDatatable } from '../../utilities/datatable.js';
import { initializeExportFeature } from '../../utilities/export.js';
import { showNotification, setNotification } from '../../modules/notifications.js';

document.addEventListener('DOMContentLoaded', () => {
    initializeDatatableControls('#employment-type-table');
    initializeExportFeature('employment_type');

    initializeDatatable({
        selector: '#employment-type-table',
        ajaxUrl: './app/Controllers/EmploymentTypeController.php',
        transaction: 'generate employment type table',
        columns: [
            { data: 'CHECK_BOX' },
            { data: 'EMPLOYMENT_TYPE_NAME' }
        ],
        columnDefs: [
            { width: '5%', bSortable: false, targets: 0, responsivePriority: 1 },
            { width: 'auto', targets: 1, responsivePriority: 2 }
        ],
        onRowClick: (rowData) => {
            if (rowData?.LINK) window.open(rowData.LINK, '_blank');
        }
    });

    document.addEventListener('click', async (event) => {
        if (!event.target.closest('#delete-employment-type')) return;

        const transaction           = 'delete multiple employment type';
        const employment_type_id    = Array.from(document.querySelectorAll('.datatable-checkbox-children'))
                                            .filter(el => el.checked)
                                            .map(el => el.value);

        if (employment_type_id.length === 0) {
            showNotification('Deletion Multiple Employment Types Error', 'Please select the employment types you wish to delete.', 'error');
            return;
        }

        const result = await Swal.fire({
            title: 'Confirm Multiple Employment Types Deletion',
            text: 'Are you sure you want to delete these employment types?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Delete',
            cancelButtonText: 'Cancel',
            customClass: {
                confirmButton: 'btn btn-danger',
                cancelButton: 'btn btn-secondary'
            },
            buttonsStyling: false
        });

        if (!result.isConfirmed) return;

        try {
            const formData = new URLSearchParams();
            formData.append('transaction', transaction);
            employment_type_id.forEach(id => formData.append('employment_type_id[]', id));

            const response = await fetch('./app/Controllers/EmploymentTypeController.php', {
                method: 'POST',
                body: formData
            });

            if (!response.ok) {
                throw new Error(`Deletion failed with status: ${response.status}`);
            }

            const data = await response.json();

            if (data.success) {
                showNotification(data.title, data.message, data.message_type);
                reloadDatatable('#employment-type-table');
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
    });
});