import { initializeDatatable, initializeDatatableControls, reloadDatatable } from '../../utilities/datatable.js';
import { initializeExportFeature } from '../../utilities/export.js';
import { showNotification, setNotification } from '../../modules/notifications.js';
import { generateDropdownOptions, initializeDateRangePicker } from '../../utilities/form-utilities.js';

document.addEventListener('DOMContentLoaded', () => {
    const datatableConfig = () => ({
        selector: '#scrap-table',
        ajaxUrl: './app/Controllers/ScrapController.php',
        transaction: 'generate scrap table',
        ajaxData: {
            filter_by_product: $('#filter_by_product').val(),
            filter_by_completed_date: $('#filter_by_completed_date').val(),
            filter_by_scrap_status: $('#filter_by_scrap_status').val()
        },
        columns: [
            { data: 'CHECK_BOX' },
            { data: 'PRODUCT' },
            { data: 'REFERENCE_NO' },
            { data: 'SCRAP_QUANTITY' },
            { data: 'SCRAP_REASON' },
            { data: 'STATUS' }
        ],
        columnDefs: [
            { width: '5%', bSortable: false, targets: 0, responsivePriority: 1 },
            { width: 'auto', targets: 1, responsivePriority: 2 },
            { width: 'auto', targets: 2, responsivePriority: 3 },
            { width: 'auto', targets: 3, responsivePriority: 4 },
            { width: 'auto', targets: 4, responsivePriority: 5 },
        ],
        onRowClick: (rowData) => {
            if (rowData?.LINK) window.open(rowData.LINK, '_blank');
        }
    });

    generateDropdownOptions({
        url: './app/Controllers/ProductController.php',
        dropdownSelector: '#filter_by_product',
        data: { transaction: 'generate product options' , multiple : true }
    });

    initializeDateRangePicker("#filter_by_completed_date");
    initializeDatatable(datatableConfig());
    initializeDatatableControls('#scrap-table');
    initializeExportFeature('scrap');

    document.addEventListener('click', async (event) => {
        if (event.target.closest('#apply-filter')) {
            initializeDatatable(datatableConfig());
        }

        if (event.target.closest('#reset-filter')) {
            $('#filter_by_product').val(null).trigger('change');
            $('#filter_by_scrap_status').val(null).trigger('change');

            initializeDatatable(datatableConfig());
        }

        if (event.target.closest('#delete-scrap')){
            const transaction   = 'delete multiple scrap';
            const scrap_id      = Array.from(document.querySelectorAll('.datatable-checkbox-children'))
                                    .filter(el => el.checked)
                                    .map(el => el.value);

            if (scrap_id.length === 0) {
                showNotification('Deletion Multiple Scraps Error', 'Please select the scraps you wish to delete.', 'error');
                return;
            }

            const result = await Swal.fire({
                title: 'Confirm Multiple Scraps Deletion',
                text: 'Are you sure you want to delete these scraps?',
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
                scrap_id.forEach(id => formData.append('scrap_id[]', id));

                const response = await fetch('./app/Controllers/ScrapController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) {
                    throw new Error(`Deletion failed with status: ${response.status}`);
                }

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    reloadDatatable('#scrap-table');
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