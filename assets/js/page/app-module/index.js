import { initializeDatatable, datatableLength, datatableSearch, toggleSingleTableCheckBox, toggleAllTableCheckBox, reloadDatatable } from '../../utilities/datatable.js';
import { generateExportColumns, exportData } from '../../utilities/export.js';
import { showNotification, setNotification } from '../../modules/notifications.js';

$(document).ready(function () {
    datatableLength('#app-module-table');
    datatableSearch('#app-module-table');
    toggleSingleTableCheckBox();
    toggleAllTableCheckBox();
    generateExportColumns('app_module');
    exportData('app_module');

    $(document).on('click','#delete-app-module',function() {
        let app_module_id = [];
        const transaction = 'delete multiple app module';

        $('.datatable-checkbox-children').each((index, element) => {
            if ($(element).is(':checked')) {
                app_module_id.push(element.value);
            }
        });
    
        if(app_module_id.length > 0){
            Swal.fire({
                title: 'Confirm Multiple App Modules Deletion',
                text: 'Are you sure you want to delete these app modules?',
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
                        url: './app/Controllers/AppModuleController.php',
                        dataType: 'json',
                        data: {
                            app_module_id: app_module_id,
                            transaction : transaction
                        },
                        success: function (response) {
                            if (response.success) {
                                showNotification(response.title, response.message, response.messageType);
                                reloadDatatable('#app-module-table');
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
                        },
                        complete: function(){
                            toggleHideActionDropdown();
                        }
                    });
                        
                    return false;
                }
            });
        }
        else{
            showNotification('Deletion Multiple App Module Error', 'Please select the app modules you wish to delete.', 'error');
        }
    });

    initializeDatatable({
        selector: '#app-module-table',
        ajaxUrl: './app/Controllers/AppModuleController.php',
        transaction: 'generate app module table',
        columns: [
            { data: 'CHECK_BOX' },
            { data: 'APP_MODULE_NAME' }
        ],
        columnDefs: [
            { width: '5%', bSortable: false, targets: 0, responsivePriority: 1 },
            { width: 'auto', targets: 1, responsivePriority: 2 }
        ],
        onRowClick: (rowData) => {
            if (rowData?.LINK) window.open(rowData.LINK, '_blank');
        }
    });
});