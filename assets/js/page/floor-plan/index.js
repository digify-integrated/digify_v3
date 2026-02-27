import { initializeDatatable, initializeDatatableControls, reloadDatatable } from '../../utilities/datatable.js';
import { initializeExportFeature } from '../../utilities/export.js';
import { showNotification, setNotification } from '../../modules/notifications.js';

document.addEventListener('DOMContentLoaded', () => {
    initializeDatatable({
        selector: '#floor-plan-table',
        ajaxUrl: './app/Controllers/FloorPlanController.php',
        transaction: 'generate floor plan table',
        columns: [
            { data: 'CHECK_BOX' },
            { data: 'FLOOR_PLAN_NAME' }
        ],
        columnDefs: [
            { width: '5%', bSortable: false, targets: 0, responsivePriority: 1 },
            { width: 'auto', targets: 1, responsivePriority: 2 }
        ],
        onRowClick: (rowData) => {
            if (rowData?.LINK) window.open(rowData.LINK, '_blank');
        }
    });
    
    initializeDatatableControls('#floor-plan-table');
    initializeExportFeature('floor_plan');

    document.addEventListener('click', async (event) => {
        if (!event.target.closest('#delete-floor-plan')) return;

        const transaction           = 'delete multiple floor plan';
        const floor_plan_id   = Array.from(document.querySelectorAll('.datatable-checkbox-children'))
                                            .filter(el => el.checked)
                                            .map(el => el.value);

        if (floor_plan_id.length === 0) {
            showNotification('Deletion Multiple Floor Plans Error', 'Please select the floor plans you wish to delete.', 'error');
            return;
        }

        const result = await Swal.fire({
            title: 'Confirm Multiple Floor Plans Deletion',
            text: 'Are you sure you want to delete these floor plans?',
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
            floor_plan_id.forEach(id => formData.append('floor_plan_id[]', id));

            const response = await fetch('./app/Controllers/FloorPlanController.php', {
                method: 'POST',
                body: formData
            });

            if (!response.ok) {
                throw new Error(`Deletion failed with status: ${response.status}`);
            }

            const data = await response.json();

            if (data.success) {
                showNotification(data.title, data.message, data.message_type);
                reloadDatatable('#floor-plan-table');
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