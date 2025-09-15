import { initializeDatatable, initializeDatatableControls, reloadDatatable, manageActionDropdown } from '../../utilities/datatable.js';
import { initializeExportFeature } from '../../utilities/export.js';
import { showNotification, setNotification } from '../../modules/notifications.js';

$(document).ready(function () {
    initializeDatatableControls('#system-action-table');
    initializeExportFeature('system_action');

    initializeDatatable({
        selector: '#system-action-table',
        ajaxUrl: './app/Controllers/SystemActionController.php',
        transaction: 'generate system action table',
        columns: [
            { data: 'CHECK_BOX' },
            { data: 'SYSTEM_ACTION_NAME' }
        ],
        columnDefs: [
            { width: '1%', bSortable: false, targets: 0, responsivePriority: 1 },
            { width: 'auto', targets: 1, responsivePriority: 2 }
        ],
        onRowClick: (rowData) => {
            if (rowData?.LINK) window.open(rowData.LINK, '_blank');
        }
    });

    $(document).on('click','#delete-system-action',function() {
        let system_action_id = [];
        const transaction = 'delete multiple system action';

        $('.datatable-checkbox-children').each((index, element) => {
            if ($(element).is(':checked')) {
                system_action_id.push(element.value);
            }
        });
    
        if(system_action_id.length > 0){
            Swal.fire({
                title: 'Confirm Multiple System Actions Deletion',
                text: 'Are you sure you want to delete these system actions?',
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
                        url: './app/Controllers/SystemActionController.php',
                        dataType: 'json',
                        data: {
                            system_action_id: system_action_id,
                            transaction : transaction
                        },
                        success: function (response) {
                            if (response.success) {
                                showNotification(response.title, response.message, response.message_type);
                                reloadDatatable('#system-action-table');
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
            showNotification('Deletion Multiple System Action Error', 'Please select the system actions you wish to delete.', 'error');
        }
    });
});