import { initializeDatatable, initializeDatatableControls, reloadDatatable } from '../../utilities/datatable.js';
import { initializeExportFeature } from '../../utilities/export.js';
import { showNotification, setNotification } from '../../modules/notifications.js';

document.addEventListener('DOMContentLoaded', () => {
    initializeDatatableControls('#attribute-table');
    initializeExportFeature('attribute');

    initializeDatatable({
        selector: '#attribute-table',
        ajaxUrl: './app/Controllers/AttributeController.php',
        transaction: 'generate attribute table',
        columns: [
            { data: 'CHECK_BOX' },
            { data: 'ATTRIBUTE_NAME' }
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
        if (!event.target.closest('#delete-attribute')) return;

        const transaction   = 'delete multiple attribute';
        const attribute_id     = Array.from(document.querySelectorAll('.datatable-checkbox-children'))
                                    .filter(el => el.checked)
                                    .map(el => el.value);

        if (attribute_id.length === 0) {
            showNotification('Deletion Multiple Attributes Error', 'Please select the attributes you wish to delete.', 'error');
            return;
        }

        const result = await Swal.fire({
            title: 'Confirm Multiple Attributes Deletion',
            text: 'Are you sure you want to delete these attributes?',
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
            attribute_id.forEach(id => formData.append('attribute_id[]', id));

            const response = await fetch('./app/Controllers/AttributeController.php', {
                method: 'POST',
                body: formData
            });

            if (!response.ok) {
                throw new Error(`Deletion failed with status: ${response.status}`);
            }

            const data = await response.json();

            if (data.success) {
                showNotification(data.title, data.message, data.message_type);
                reloadDatatable('#attribute-table');
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