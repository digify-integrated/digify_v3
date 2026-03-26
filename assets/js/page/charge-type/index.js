import { initializeDatatable, initializeDatatableControls, reloadDatatable } from '../../utilities/datatable.js';
import { initializeExportFeature } from '../../utilities/export.js';
import { showNotification, setNotification } from '../../modules/notifications.js';

document.addEventListener('DOMContentLoaded', () => {
    initializeDatatable({
        selector: '#charge-type-table',
        ajaxUrl: './app/Controllers/ChargeTypeController.php',
        transaction: 'generate charge type table',
        columns: [
            { data: 'CHECK_BOX' },
            { data: 'CHARGE_NAME' },
            { data: 'VALUE_TYPE' },
            { data: 'CHARGE_VALUE' },
            { data: 'IS_VARIABLE' },
            { data: 'APPLICATION_ORDER' },
            { data: 'TAX_TYPE' },
        ],
        columnDefs: [
            { width: '5%', bSortable: false, targets: 0, responsivePriority: 1 },
            { width: 'auto', targets: 1, responsivePriority: 2 },
            { width: 'auto', targets: 2, responsivePriority: 3 },
            { width: 'auto', targets: 3, responsivePriority: 4 },
            { width: 'auto', targets: 4, responsivePriority: 5 },
            { width: 'auto', targets: 5, responsivePriority: 6 },
            { width: 'auto', targets: 6, responsivePriority: 7 },
        ],
        onRowClick: (rowData) => {
            if (rowData?.LINK) window.open(rowData.LINK, '_blank');
        }
    });
    
    initializeDatatableControls('#charge-type-table');
    initializeExportFeature('charge_type');

    document.addEventListener('click', async (event) => {
        if (!event.target.closest('#delete-charge-type')) return;

        const transaction       = 'delete multiple charge type';
        const charge_type_id  = Array.from(document.querySelectorAll('.datatable-checkbox-children'))
                                            .filter(el => el.checked)
                                            .map(el => el.value);

        if (charge_type_id.length === 0) {
            showNotification('Deletion Multiple Charge Types Error', 'Please select the charge types you wish to delete.', 'error');
            return;
        }

        const result = await Swal.fire({
            title: 'Confirm Multiple Charge Types Deletion',
            text: 'Are you sure you want to delete these charge types?',
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
            charge_type_id.forEach(id => formData.append('charge_type_id[]', id));

            const response = await fetch('./app/Controllers/ChargeTypeController.php', {
                method: 'POST',
                body: formData
            });

            if (!response.ok) {
                throw new Error(`Deletion failed with status: ${response.status}`);
            }

            const data = await response.json();

            if (data.success) {
                showNotification(data.title, data.message, data.message_type);
                reloadDatatable('#charge-type-table');
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