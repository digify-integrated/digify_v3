import { initializeDatatable, initializeDatatableControls, reloadDatatable } from '../../utilities/datatable.js';
import { initializeExportFeature } from '../../utilities/export.js';
import { showNotification, setNotification } from '../../modules/notifications.js';
import { generateDropdownOptions } from '../../utilities/form-utilities.js';

document.addEventListener('DOMContentLoaded', () => {
    const datatableConfig = () => ({
        selector: '#shop-table',
        ajaxUrl: './app/Controllers/ShopController.php',
        transaction: 'generate shop table',
        ajaxData: {
            filter_by_company: $('#filter_by_company').val(),
            filter_by_shop_type: $('#filter_by_shop_type').val(),
            filter_by_shop_status: $('#filter_by_shop_status').val(),
            filter_by_register_status: $('#filter_by_register_status').val()
        },
        columns: [
            { data: 'CHECK_BOX' },
            { data: 'SHOP_NAME' },
            { data: 'COMPANY_NAME' },
            { data: 'SHOP_TYPE_NAME' },
            { data: 'SHOP_STATUS' },
            { data: 'REGISTER_STATUS' }
        ],
        columnDefs: [
            { width: '5%', bSortable: false, targets: 0, responsivePriority: 1 },
            { width: 'auto', targets: 1, responsivePriority: 2 },
            { width: 'auto', targets: 2, responsivePriority: 3 },
            { width: 'auto', targets: 3, responsivePriority: 4 },
            { width: 'auto', targets: 4, responsivePriority: 5 },
            { width: 'auto', targets: 5, responsivePriority: 6 }
        ],
        onRowClick: (rowData) => {
            if (rowData?.LINK) window.open(rowData.LINK, '_blank');
        }
    });

    const dropdownConfigs = [
        { url: './app/Controllers/CompanyController.php', selector: '#filter_by_company', transaction: 'generate company options' },
        { url: './app/Controllers/ShopTypeController.php', selector: '#filter_by_shop_type', transaction: 'generate shop type options' }
    ];
    
    dropdownConfigs.forEach(cfg => {
        generateDropdownOptions({
            url: cfg.url,
            dropdownSelector: cfg.selector,
            data: { transaction: cfg.transaction, multiple : true }
        });
    });

    initializeDatatable(datatableConfig());
    initializeDatatableControls('#shop-table');
    initializeExportFeature('shop');

    document.addEventListener('click', async (event) => {
        if (event.target.closest('#apply-filter')) {
            initializeDatatable(datatableConfig());
        }

        if (event.target.closest('#reset-filter')) {
            $('#filter_by_company').val(null).trigger('change');
            $('#filter_by_shop_type').val(null).trigger('change');
            $('#filter_by_shop_status').val(null).trigger('change');
            $('#filter_by_register_status').val(null).trigger('change');

            initializeDatatable(datatableConfig());
        }

        if (event.target.closest('#delete-shop')){
            const transaction   = 'delete multiple shop';
            const shop_id       = Array.from(document.querySelectorAll('.datatable-checkbox-children'))
                                    .filter(checkbox => checkbox.checked)
                                    .map(checkbox => checkbox.value);

            if (shop_id.length === 0) {
                showNotification('Deletion Multiple Shops Error', 'Please select the shops you wish to delete.', 'error');
                return;
            }

            const result = await Swal.fire({
                title: 'Confirm Multiple Shops Deletion',
                text: 'Are you sure you want to delete these shops?',
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
                shop_id.forEach(id => formData.append('shop_id[]', id));

                const response = await fetch('./app/Controllers/ShopController.php', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) throw new Error(`Request failed with status: ${response.status}`);

                const data = await response.json();

                if (data.success) {
                    showNotification(data.title, data.message, data.message_type);
                    reloadDatatable('#shop-table');
                } 
                else if (data.invalid_session) {
                    setNotification(data.title, data.message, data.message_type);
                    window.location.href = data.redirect_link;
                }
                else {
                    showNotification(data.title, data.message, data.message_type);
                }
            } catch (error) {
                handleSystemError(error, 'fetch_failed', `Failed to delete shops: ${error.message}`);
            }
        }
    });
});