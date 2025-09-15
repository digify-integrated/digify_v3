import { initializeDatatable, initializeDatatableControls, reloadDatatable, manageActionDropdown } from '../../utilities/datatable.js';
import { initializeExportFeature } from '../../utilities/export.js';
import { showNotification, setNotification } from '../../modules/notifications.js';
import { generateDropdownOptions } from '../../utilities/form-utilities.js';

$(document).ready(function () {
    initializeDatatableControls('#menu-item-table');
    initializeExportFeature('menu_item');

    generateDropdownOptions({
        url: './app/Controllers/MenuItemController.php',
        dropdownSelector: '#parent_id_filter',
        data: { 
            transaction: 'generate menu item options',
            multiple : true
        }
    });

    generateDropdownOptions({
        url: './app/Controllers/AppModuleController.php',
        dropdownSelector: '#app_module_filter',
        data: { 
            transaction: 'generate app module options',
            multiple : true
        }
    });

    const datatableConfig = () => ({
        selector: '#menu-item-table',
        ajaxUrl: './app/Controllers/MenuItemController.php',
        transaction: 'generate menu item table',
        ajaxData: {
            app_module_filter: $('#app_module_filter').val(),
            parent_id_filter: $('#parent_id_filter').val()
        },
        columns: [
            { data: 'CHECK_BOX' },
            { data: 'MENU_ITEM_NAME' },
            { data: 'APP_MODULE_NAME' },
            { data: 'PARENT_NAME' },
            { data: 'ORDER_SEQUENCE' }
        ],
        columnDefs: [
            { width: '5%', bSortable: false, targets: 0, responsivePriority: 1 },
            { width: 'auto', targets: 1, responsivePriority: 2 },
            { width: 'auto', targets: 2, responsivePriority: 3 },
            { width: 'auto', targets: 3, responsivePriority: 4 },
            { width: 'auto', targets: 4, responsivePriority: 5 }
        ],
        onRowClick: (rowData) => {
            if (rowData?.LINK) window.open(rowData.LINK, '_blank');
        }
    });

    initializeDatatable(datatableConfig());

    $(document).on('click', '#apply-filter', function() {
        initializeDatatable(datatableConfig());
    });

    $(document).on('click', '#reset-filter', function() {
        $('#app_module_filter').val(null).trigger('change');
        $('#parent_id_filter').val(null).trigger('change');

        initializeDatatable(datatableConfig());
    });

    $(document).on('click','#delete-menu-item',function() {
        let menu_item_id = [];
        const transaction = 'delete multiple menu item';

        $('.datatable-checkbox-children').each((index, element) => {
            if ($(element).is(':checked')) {
                menu_item_id.push(element.value);
            }
        });
    
        if(menu_item_id.length > 0){
            Swal.fire({
                title: 'Confirm Multiple Menu Items Deletion',
                text: 'Are you sure you want to delete these menu items?',
                icon: 'warning',
                showCancelButton: !0,
                confirmButtonText: 'Delete',
                cancelButtonText: 'Cancel',
                customClass: {
                    confirmButton: 'btn btn-danger',
                    cancelButton: 'btn btn-secondary'
                },
                buttonsStyling: !1
            }).then(function(result) {
                if (result.value) {
                    $.ajax({
                        type: 'POST',
                        url: './app/Controllers/MenuItemController.php',
                        dataType: 'json',
                        data: {
                            menu_item_id: menu_item_id,
                            transaction : transaction
                        },
                        success: function (response) {
                            if (response.success) {
                                showNotification(response.title, response.message, response.message_type);
                                reloadDatatable('#menu-item-table');
                            }
                            else{
                                if(response.invalid_session){
                                    setNotification(response.title, response.message, response.message_type);
                                    window.location.href = response.redirect_link;
                                }
                                else{
                                    showNotification(response.title, response.message, response.message_type);
                                }
                            
                            }
                        },
                        error: function(xhr, status, error) {
                            handleSystemError(xhr, status, error);
                        }
                    });
                        
                    return false;
                }
            });
        }
        else{
            showNotification('Deletion Multiple Menu Item Error', 'Please select the menu items you wish to delete.', 'error');
        }
    });
});