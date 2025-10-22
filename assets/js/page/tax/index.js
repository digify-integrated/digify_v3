import { initializeDatatable, initializeDatatableControls, reloadDatatable } from '../../utilities/datatable.js';
import { initializeExportFeature } from '../../utilities/export.js';
import { showNotification, setNotification } from '../../modules/notifications.js';

document.addEventListener('DOMContentLoaded', () => {
    const datatableConfig = () => ({
        selector: '#tax-table',
        ajaxUrl: './app/Controllers/TaxController.php',
        transaction: 'generate tax table',
        ajaxData: {
            city_filter: $('#city_filter').val(),
            state_filter: $('#state_filter').val(),
            country_filter: $('#country_filter').val(),
            tax_status_filter: $('#tax_status_filter').val()
        },
        columns: [
            { data: 'CHECK_BOX' },
            { data: 'TAX' },
            { data: 'TAX_RATE' },
            { data: 'TAX_TYPE' },
            { data: 'TAX_SCOPE' }
        ],
        columnDefs: [
            { width: '5%', bSortable: false, targets: 0, responsivePriority: 1 },
            { width: 'auto', targets: 1, responsivePriority: 2 },
            { width: 'auto', targets: 2, responsivePriority: 2 },
            { width: 'auto', targets: 3, responsivePriority: 2 },
            { width: 'auto', targets: 4, responsivePriority: 2 }
        ],
        onRowClick: (rowData) => {
            if (rowData?.LINK) window.open(rowData.LINK, '_blank');
        }
    });

    initializeDatatableControls('#tax-table');
    initializeExportFeature('tax');
    initializeDatatable(datatableConfig());

    document.addEventListener('click', async (event) => {
        if (event.target.closest('#apply-filter')) {
            initializeDatatable(datatableConfig());
        }

        if (event.target.closest('#reset-filter')) {
            $('#tax_type_filter').val(null).trigger('change');
            $('#tax_computation_filter').val(null).trigger('change');
            $('#tax_scope_filter').val(null).trigger('change');
            $('#tax_status_filter').val(null).trigger('change');

            initializeDatatable(datatableConfig());
        }

        if (event.target.closest('#delete-tax')){
            const transaction   = 'delete multiple tax';
            const tax_id        = Array.from(document.querySelectorAll('.datatable-checkbox-children'))
                                    .filter(checkbox => checkbox.checked)
                                    .map(checkbox => checkbox.value);

            if (tax_id.length === 0) {
                showNotification('Deletion Multiple Taxes Error', 'Please select the taxes you wish to delete.', 'error');
                return;
            }

            const result = await Swal.fire({
                title: 'Confirm Multiple Taxes Deletion',
                text: 'Are you sure you want to delete these taxes?',
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

            if (!result.value) return;

            try {
                const formData = new URLSearchParams();
                formData.append('transaction', transaction);
                tax_id.forEach(id => formData.append('tax_id[]', id));

                const response = await fetch('./app/Controllers/TaxController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    reloadDatatable('#tax-table');
                } 
                else if (data.invalid_session) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else {
                    showNotification(data.title, data.message, data.message_type);
                }
            } catch (error) {
                handleSystemError(error, 'fetch_failed', `Failed to delete taxes: ${error.message}`);
            }
        }
    });
});