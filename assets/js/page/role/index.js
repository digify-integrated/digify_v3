import { initializeDatatable, initializeDatatableControls, reloadDatatable } from '../../utilities/datatable.js';
import { initializeExportFeature } from '../../utilities/export.js';
import { showNotification, setNotification } from '../../modules/notifications.js';

document.addEventListener('DOMContentLoaded', () => {
    initializeDatatableControls('#role-table');
    initializeExportFeature('role');

    initializeDatatable({
        selector: '#role-table',
        ajaxUrl: './app/Controllers/RoleController.php',
        transaction: 'generate role table',
        columns: [
            { data: 'CHECK_BOX' },
            { data: 'ROLE_NAME' }
        ],
        columnDefs: [
            { width: '1%', bSortable: false, targets: 0, responsivePriority: 1 },
            { width: 'auto', targets: 1, responsivePriority: 2 }
        ],
        onRowClick: (rowData) => {
            if (rowData?.LINK) window.open(rowData.LINK, '_blank');
        }
    });

    $(document).on('click','#delete-role',function() {
        let role_id = [];
        const transaction = 'delete multiple role';

        $('.datatable-checkbox-children').each((index, element) => {
            if ($(element).is(':checked')) {
                role_id.push(element.value);
            }
        });
    
        if(role_id.length > 0){
            Swal.fire({
                title: 'Confirm Multiple Roles Deletion',
                text: 'Are you sure you want to delete these roles?',
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
                        url: './app/Controllers/RoleController.php',
                        dataType: 'json',
                        data: {
                            role_id: role_id,
                            transaction : transaction
                        },
                        success: function (response) {
                            if (response.success) {
                                showNotification(response.title, response.message, response.message_type);
                                reloadDatatable('#role-table');
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
            showNotification('Deletion Multiple Role Error', 'Please select the roles you wish to delete.', 'error');
        }
    });
});