import { disableButton, enableButton, generateDropdownOptions, generateDualListBox, resetForm } from '../../utilities/form-utilities.js';
import { initializeDatatable, initializeDatatableControls, reloadDatatable } from '../../utilities/datatable.js';
import { attachLogNotesHandler, attachLogNotesClassHandler  } from '../../utilities/log-notes.js';
import { handleSystemError } from '../../modules/system-errors.js';
import { showNotification, setNotification } from '../../modules/notifications.js';

document.addEventListener('DOMContentLoaded', () => {
    const displayDetails = () => {
        const page_link         = document.getElementById('page-link').getAttribute('href');
        const transaction       = 'fetch system action details';
        const system_action_id  = $('#details-id').text();
                
        $.ajax({
            url: './app/Controllers/SystemActionController.php',
            method: 'POST',
            dataType: 'json',
            data: {
                system_action_id : system_action_id,
                transaction : transaction
            },
            beforeSend: function(){
                resetForm('system_action_form');
            },
            success: function(response) {
                if (response.success) {
                    $('#system_action_name').val(response.systemActionName);
                    $('#system_action_description').val(response.systemActionDescription);
                } 
                else {
                    if (response.notExist) {
                        setNotification(response.title, response.message, response.message_type);
                        window.location = page_link;
                    }
                    else {
                        showNotification(response.title, response.message, response.message_type);
                    }
                }
            },
            error: function(xhr, status, error) {
                handleSystemError(xhr, status, error);
            }
        });
    }

    initializeDatatableControls('#role-permission-table');

    initializeDatatable({
        selector: '#role-permission-table',
        ajaxUrl: './app/Controllers/SystemActionController.php',
        transaction: 'generate system action assigned role table',
        ajaxData: {
            system_action_id: $('#details-id').text()
        },
        columns: [
            { data: 'ROLE_NAME' },
            { data: 'ACCESS' },
            { data: 'ACTION' }
        ],
        columnDefs: [
            { width: 'auto', targets: 0, responsivePriority: 1 },
            { width: 'auto', bSortable: false, targets: 1, responsivePriority: 2 },
            { width: '5%', bSortable: false, targets: 2, responsivePriority: 1 }
        ],
        order : [[0, 'asc']]
    });

    displayDetails();

    attachLogNotesHandler('#log-notes-main', '#details-id', 'system_action');

    $('#system_action_form').validate({
        rules: {
            system_action_name: {
                required: true
            },
            system_action_description: {
                required: true
            }
        },
        messages: {
            system_action_name: {
                required: 'Enter the display name'
            },
            system_action_description: {
                required: 'Ether the description'
            }
        },
        errorPlacement: (error, element) => {
            showNotification('Action Needed: Issue Detected', error.text(), 'error', 2500);
        },
        highlight: (element) => {
            const $element = $(element);
            const $target = $element.hasClass('select2-hidden-accessible')
                ? $element.next().find('.select2-selection')
                : $element;
            $target.addClass('is-invalid');
        },
        unhighlight: (element) => {
            const $element = $(element);
            const $target = $element.hasClass('select2-hidden-accessible')
                ? $element.next().find('.select2-selection')
                : $element;
            $target.removeClass('is-invalid');
        },
        submitHandler: async (form, event) => {
            event.preventDefault();

            const system_action_id  = $('#details-id').text();
            const transaction       = 'save system action';

            $.ajax({
                type: 'POST',
                url: './app/Controllers/SystemActionController.php',
                data: $(form).serialize() + '&transaction=' + transaction + '&system_action_id=' + encodeURIComponent(system_action_id),
                dataType: 'JSON',
                beforeSend: function() {
                    disableButton('submit-data');
                },
                success: function(response) {
                    if (response.success) {
                        showNotification(response.title, response.message, response.message_type);
                        enableButton('submit-data');
                        displayDetails();
                    }
                   else{
                        if(response.invalid_session){
                            setNotification(response.title, response.message, response.message_type);
                            window.location.href = response.redirect_link;
                        }
                        else{
                            showNotification(response.title, response.message, response.message_type);
                            enableButton('submit-data');
                        }
                    }
                },
                error: function(xhr, status, error) {
                    enableButton('submit-data');
                    handleSystemError(xhr, status, error);
                }
            });

            return false;
        }
    });
    
    $('#role_permission_assignment_form').validate({
        errorPlacement: (error, element) => {
            showNotification('Action Needed: Issue Detected', error.text(), 'error', 2500);
        },
        highlight: (element) => {
            const $element = $(element);
            const $target = $element.hasClass('select2-hidden-accessible')
                ? $element.next().find('.select2-selection')
                : $element;
            $target.addClass('is-invalid');
        },
        unhighlight: (element) => {
            const $element = $(element);
            const $target = $element.hasClass('select2-hidden-accessible')
                ? $element.next().find('.select2-selection')
                : $element;
            $target.removeClass('is-invalid');
        },
        submitHandler: async (form, event) => {
            event.preventDefault();

            const system_action_id  = $('#details-id').text();
            const transaction       = 'save system action role permission';

            $.ajax({
                type: 'POST',
                url: './app/Controllers/SystemActionController.php',
                data: $(form).serialize() + '&transaction=' + transaction + '&system_action_id=' + encodeURIComponent(system_action_id),
                dataType: 'JSON',
                beforeSend: function() {
                    disableButton('submit-assignment');
                },
                success: function(response) {
                    if (response.success) {
                        showNotification(response.title, response.message, response.message_type);
                        enableButton('submit-assignment');
                        reloadDatatable('#role-permission-table');
                        $('#role-permission-assignment-modal').modal('hide');
                    }
                   else{
                        if(response.invalid_session){
                            setNotification(response.title, response.message, response.message_type);
                            window.location.href = response.redirect_link;
                        }
                        else{
                            showNotification(response.title, response.message, response.message_type);
                            enableButton('submit-assignment');
                        }
                    }
                },
                error: function(xhr, status, error) {
                    enableButton('submit-assignment');
                    handleSystemError(xhr, status, error);
                }
            });

            return false;
        }
    });

    $(document).on('click','#delete-system-action',function() {
        const system_action_id      = $('#details-id').text();
        const page_link             = document.getElementById('page-link').getAttribute('href'); 
        const transaction           = 'delete system action';
    
        Swal.fire({
            title: 'Confirm System Action Deletion',
            text: 'Are you sure you want to delete this system action?',
            icon: 'warning',
            showCancelButton: !0,
            confirmButtonText: 'Delete',
            cancelButtonText: 'Cancel',
            customClass: {
                confirmButton: 'btn btn-danger mt-2',
                cancelButton: 'btn btn-secondary ms-2 mt-2'
            },
            buttonsStyling: !1
        }).then(function(result) {
            if (result.value) {
                 $.ajax({
                    type: 'POST',
                    url: './app/Controllers/SystemActionController.php',
                    dataType: 'json',
                    data: {
                        system_action_id : system_action_id, 
                        transaction : transaction
                    },
                    success: function (response) {
                        if (response.success) {
                            setNotification(response.title, response.message, response.message_type);
                            window.location = page_link;
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
    });

    $(document).on('click','#assign-role-permission',function() {
        generateDualListBox({
            url: './app/Controllers/SystemActionController.php',
            selectSelector: 'role_id',
            data: { 
                transaction: 'generate system action role dual listbox options',
                system_action_id: $('#details-id').text()
            }
        });
    });

    $(document).on('click','.update-role-permission',function() {
        const role_permission_id    = $(this).data('role-permission-id');
        const access_type           = $(this).data('access-type');
        const access                = $(this).is(':checked') ? '1' : '0';
        const transaction           = 'update system action role permission';
    
        $.ajax({
            type: 'POST',
            url: './app/Controllers/SystemActionController.php',
            dataType: 'json',
            data: {
                role_permission_id : role_permission_id,
                access_type : access_type,
                access : access,
                transaction : transaction
            },
            success: function (response) {
                if (response.success) {
                    showNotification(response.title, response.message, response.message_type);
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
    });

    $(document).on('click','.delete-role-permission',function() {
        const role_permission_id = $(this).data('role-permission-id');
        const transaction       = 'delete system action role permission';
    
        Swal.fire({
            title: 'Confirm Role Permission Deletion',
            text: 'Are you sure you want to delete this role permission?',
            icon: 'warning',
            showCancelButton: !0,
            confirmButtonText: 'Delete',
            cancelButtonText: 'Cancel',
            customClass: {
                confirmButton: 'btn btn-danger mt-2',
                cancelButton: 'btn btn-secondary ms-2 mt-2'
            },
            buttonsStyling: !1
        }).then(function(result) {
            if (result.value) {
                 $.ajax({
                    type: 'POST',
                    url: './app/Controllers/SystemActionController.php',
                    dataType: 'json',
                    data: {
                        role_permission_id : role_permission_id, 
                        transaction : transaction
                    },
                    success: function (response) {
                        if (response.success) {
                            showNotification(response.title, response.message, response.message_type);
                            reloadDatatable('#role-permission-table');
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
    });

    $(document).on('click','.view-role-permission-log-notes',function() {
        const role_system_action_permission_id = $(this).data('role-permission-id');

        attachLogNotesClassHandler('role_system_action_permission', role_system_action_permission_id);
    });
});