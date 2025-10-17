import { initializeDatatable, initializeDatatableControls, reloadDatatable } from '../../utilities/datatable.js';
import { initializeExportFeature } from '../../utilities/export.js';
import { showNotification, setNotification } from '../../modules/notifications.js';

document.addEventListener('DOMContentLoaded', () => {
    initializeDatatableControls('#product-type-table');
    initializeExportFeature('product_type');

    initializeDatatable({
        selector: '#product-type-table',
        ajaxUrl: './app/Controllers/ProductTypeController.php',
        transaction: 'generate product type table',
        columns: [
            { data: 'CHECK_BOX' },
            { data: 'PRODUCT_TYPE_NAME' }
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
        if (!event.target.closest('#delete-product-type')) return;

        const transaction       = 'delete multiple product type';
        const product_type_id   = Array.from(document.querySelectorAll('.datatable-checkbox-children'))
                                    .filter(el => el.checked)
                                    .map(el => el.value);

        if (product_type_id.length === 0) {
            showNotification('Deletion Multiple Product Types Error', 'Please select the product types you wish to delete.', 'error');
            return;
        }

        const result = await Swal.fire({
            title: 'Confirm Multiple Product Types Deletion',
            text: 'Are you sure you want to delete these product types?',
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
            product_type_id.forEach(id => formData.append('product_type_id[]', id));

            const response = await fetch('./app/Controllers/ProductTypeController.php', {
                method: 'POST',
                body: formData
            });

            if (!response.ok) {
                throw new Error(`Deletion failed with status: ${response.status}`);
            }

            const data = await response.json();

            if (data.success) {
                showNotification(data.title, data.message, data.message_type);
                reloadDatatable('#product-type-table');
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