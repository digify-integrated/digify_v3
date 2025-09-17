import { initializeDatatable, initializeDatatableControls, reloadDatatable } from '../../utilities/datatable.js';
import { initializeExportFeature } from '../../utilities/export.js';
import { showNotification, setNotification } from '../../modules/notifications.js';

document.addEventListener('DOMContentLoaded', () => {
    initializeDatatableControls('#user-account-table');
    initializeExportFeature('user_account');

    const datatableConfig = () => ({
        selector: '#user-account-table',
        ajaxUrl: './app/Controllers/UserAccountController.php',
        transaction: 'generate user account table',
        ajaxData: {
            user_account_status_filter: $('#user_account_status_filter').val()
        },
        columns: [
            { data: 'CHECK_BOX' },
            { data: 'USER_ACCOUNT' },
            { data: 'USER_ACCOUNT_STATUS' },
            { data: 'LAST_CONNECTION_DATE' }
        ],
        columnDefs: [
            { width: '5%', bSortable: false, targets: 0, responsivePriority: 1 },
            { width: 'auto', targets: 1, responsivePriority: 2 },
            { width: 'auto', targets: 2, responsivePriority: 3 },
            { width: 'auto', targets: 3, type: 'date', responsivePriority: 4 }
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
        $('#user_account_status_filter').val(null).trigger('change');

        initializeDatatable(datatableConfig());
    });

    $(document).on('click','#activate-user-account',function() {
        let user_account_id = [];
        const transaction = 'activate multiple user account';

        $('.datatable-checkbox-children').each((index, element) => {
            if ($(element).is(':checked')) {
                user_account_id.push(element.value);
            }
        });
    
        if(user_account_id.length > 0){
            Swal.fire({
                title: 'Confirm Multiple User Accounts Activation',
                text: 'Are you sure you want to activate these user accounts?',
                icon: 'info',
                showCancelButton: !0,
                confirmButtonText: 'Activate',
                cancelButtonText: 'Cancel',
                customClass: {
                    confirmButton: 'btn btn-success',
                    cancelButton: 'btn btn-secondary'
                },
                buttonsStyling: !1
            }).then(function(result) {
                if (result.value) {
                    $.ajax({
                        type: 'POST',
                        url: './app/Controllers/UserAccountController.php',
                        dataType: 'json',
                        data: {
                            user_account_id: user_account_id,
                            transaction : transaction
                        },
                        success: function (response) {
                            if (response.success) {
                                showNotification(response.title, response.message, response.message_type);
                                reloadDatatable('#user-account-table');
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
            showNotification('Activate Multiple User Account Error', 'Please select the user accounts you wish to activate.', 'error');
        }
    });

    $(document).on('click','#deactivate-user-account',function() {
        let user_account_id = [];
        const transaction = 'deactivate multiple user account';

        $('.datatable-checkbox-children').each((index, element) => {
            if ($(element).is(':checked')) {
                user_account_id.push(element.value);
            }
        });
    
        if(user_account_id.length > 0){
            Swal.fire({
                title: 'Confirm Multiple User Accounts Deactivation',
                text: 'Are you sure you want to deactivate these user accounts?',
                icon: 'warning',
                showCancelButton: !0,
                confirmButtonText: 'Deactivate',
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
                        url: './app/Controllers/UserAccountController.php',
                        dataType: 'json',
                        data: {
                            user_account_id: user_account_id,
                            transaction : transaction
                        },
                        success: function (response) {
                            if (response.success) {
                                showNotification(response.title, response.message, response.message_type);
                                reloadDatatable('#user-account-table');
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
            showNotification('Deactivate Multiple User Account Error', 'Please select the user accounts you wish to deactivate.', 'error');
        }
    });

    $(document).on('click','#delete-user-account',function() {
        let user_account_id = [];
        const transaction = 'delete multiple user account';

        $('.datatable-checkbox-children').each((index, element) => {
            if ($(element).is(':checked')) {
                user_account_id.push(element.value);
            }
        });
    
        if(user_account_id.length > 0){
            Swal.fire({
                title: 'Confirm Multiple User Accounts Deletion',
                text: 'Are you sure you want to delete these user accounts?',
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
                        url: './app/Controllers/UserAccountController.php',
                        dataType: 'json',
                        data: {
                            user_account_id: user_account_id,
                            transaction : transaction
                        },
                        success: function (response) {
                            if (response.success) {
                                showNotification(response.title, response.message, response.message_type);
                                reloadDatatable('#user-account-table');
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
            showNotification('Deletion Multiple User Account Error', 'Please select the user accounts you wish to delete.', 'error');
        }
    });
});