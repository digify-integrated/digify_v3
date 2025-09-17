import { disableButton, enableButton, generateDualListBox, resetForm } from '../../utilities/form-utilities.js';
import { initializeDatatable, initializeSubDatatableControls, reloadDatatable } from '../../utilities/datatable.js';
import { attachLogNotesHandler, attachLogNotesClassHandler  } from '../../utilities/log-notes.js';
import { handleSystemError } from '../../modules/system-errors.js';
import { showNotification, setNotification } from '../../modules/notifications.js';

document.addEventListener('DOMContentLoaded', () => {
    const displayDetails = () => {
        const page_link     = document.getElementById('page-link').getAttribute('href');
        const transaction   = 'fetch role details';
        const role_id       = $('#details-id').text();
                
        $.ajax({
            url: './app/Controllers/RoleController.php',
            method: 'POST',
            dataType: 'json',
            data: {
                role_id : role_id,
                transaction : transaction
            },
            beforeSend: function(){
                resetForm('role_form');
            },
            success: function(response) {
                if (response.success) {
                    $('#role_name').val(response.roleName);
                    $('#role_description').val(response.roleDescription);
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

    initializeDatatable({
        selector: '#menu-item-permission-table',
        ajaxUrl: './app/Controllers/RoleController.php',
        transaction: 'generate role assigned menu item table',
        ajaxData: {
            role_id: $('#details-id').text()
        },
        columns: [
            { data: 'MENU_ITEM_NAME' },
            { data: 'READ_ACCESS' },
            { data: 'CREATE_ACCESS' },
            { data: 'WRITE_ACCESS' },
            { data: 'DELETE_ACCESS' },
            { data: 'IMPORT_ACCESS' },
            { data: 'EXPORT_ACCESS' },
            { data: 'LOG_NOTES_ACCESS' },
            { data: 'ACTION' }
        ],
        columnDefs: [
            { width: 'auto', targets: 0, responsivePriority: 1 },
            { width: 'auto', bSortable: false, targets: 1, responsivePriority: 2 },
            { width: 'auto', bSortable: false, targets: 2, responsivePriority: 3 },
            { width: 'auto', bSortable: false, targets: 3, responsivePriority: 4 },
            { width: 'auto', bSortable: false, targets: 4, responsivePriority: 5 },
            { width: 'auto', bSortable: false, targets: 5, responsivePriority: 6 },
            { width: 'auto', bSortable: false, targets: 6, responsivePriority: 7 },
            { width: 'auto', bSortable: false, targets: 7, responsivePriority: 8 },
            { width: 'auto', bSortable: false, targets: 8, responsivePriority: 1 }
        ],
        order : [[0, 'asc']]
    });

    initializeDatatable({
        selector: '#system-action-permission-table',
        ajaxUrl: './app/Controllers/RoleController.php',
        transaction: 'generate role assigned system action table',
        ajaxData: {
            role_id: $('#details-id').text()
        },
        columns: [
            { data: 'SYSTEM_ACTION_NAME' },
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

    initializeSubDatatableControls('#menu-item-permission-datatable-search', '#menu-item-permission-datatable-length', '#menu-item-permission-table')
    initializeSubDatatableControls('#system-action-permission-datatable-search', '#system-action-permission-datatable-length', '#system-action-permission-table')

    displayDetails();

    attachLogNotesHandler('#log-notes-main', '#details-id', 'role');

    $('#role_form').validate({
        rules: {
            role_name: {
                required: true
            },
            role_description: {
                required: true
            }
        },
        messages: {
            role_name: {
                required: 'Enter the display name'
            },
            role_description: {
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
    
            const role_id       = $('#details-id').text();
            const transaction   = 'save role';
    
            $.ajax({
                type: 'POST',
                url: './app/Controllers/RoleController.php',
                data: $(form).serialize() + '&transaction=' + transaction + '&role_id=' + encodeURIComponent(role_id),
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

    $('#menu_item_permission_assignment_form').validate({
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

            const role_id       = $('#details-id').text();
            const transaction   = 'save role menu item permission';

            $.ajax({
                type: 'POST',
                url: './app/Controllers/RoleController.php',
                data: $(form).serialize() + '&transaction=' + transaction + '&role_id=' + encodeURIComponent(role_id),
                dataType: 'JSON',
                beforeSend: function() {
                    disableButton('submit-menu-item-assignment');
                },
                success: function(response) {
                    if (response.success) {
                        showNotification(response.title, response.message, response.message_type);
                        enableButton('submit-menu-item-assignment');
                        reloadDatatable('#menu-item-permission-table');
                        $('#menu-item-permission-assignment-modal').modal('hide');
                    }
                   else{
                        if(response.invalid_session){
                            setNotification(response.title, response.message, response.message_type);
                            window.location.href = response.redirect_link;
                        }
                        else{
                            showNotification(response.title, response.message, response.message_type);
                            enableButton('submit-menu-item-assignment');
                        }
                    }
                },
                error: function(xhr, status, error) {
                    enableButton('submit-menu-item-assignment');
                    handleSystemError(xhr, status, error);
                }
            });

            return false;
        }
    });

    $('#system_action_permission_assignment_form').validate({
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

            const role_id       = $('#details-id').text();
            const transaction   = 'save role system action permission';

            $.ajax({
                type: 'POST',
                url: './app/Controllers/RoleController.php',
                data: $(form).serialize() + '&transaction=' + transaction + '&role_id=' + encodeURIComponent(role_id),
                dataType: 'JSON',
                beforeSend: function() {
                    disableButton('submit-system-action-assignment');
                },
                success: function(response) {
                    if (response.success) {
                        showNotification(response.title, response.message, response.message_type);
                        enableButton('submit-system-action-assignment');
                        reloadDatatable('#system-action-permission-table');
                        $('#system-action-permission-assignment-modal').modal('hide');
                    }
                   else{
                        if(response.invalid_session){
                            setNotification(response.title, response.message, response.message_type);
                            window.location.href = response.redirect_link;
                        }
                        else{
                            showNotification(response.title, response.message, response.message_type);
                            enableButton('submit-system-action-assignment');
                        }
                    }
                },
                error: function(xhr, status, error) {
                    enableButton('submit-system-action-assignment');
                    handleSystemError(xhr, status, error);
                }
            });

            return false;
        }
    });

    $(document).on('click','#delete-role',function() {
        const role_id       = $('#details-id').text();
        const page_link     = document.getElementById('page-link').getAttribute('href'); 
        const transaction   = 'delete role';
    
        Swal.fire({
            title: 'Confirm Role Deletion',
            text: 'Are you sure you want to delete this role?',
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
                    url: './app/Controllers/RoleController.php',
                    dataType: 'json',
                    data: {
                        role_id : role_id, 
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

    $(document).on('click','#assign-menu-item-permission',function() {
        generateDualListBox({
            url: './app/Controllers/RoleController.php',
            selectSelector: 'menu_item_id',
            data: { 
                transaction: 'generate role menu item dual listbox options',
                role_id: $('#details-id').text()
            }
        });
    });

    $(document).on('click','.update-menu-item-permission',function() {
        const role_permission_id    = $(this).data('role-permission-id');
        const access_type           = $(this).data('access-type');
        const access                = $(this).is(':checked') ? '1' : '0';
        const transaction           = 'update role menu item permission';
    
        $.ajax({
            type: 'POST',
            url: './app/Controllers/RoleController.php',
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

    $(document).on('click','.delete-menu-item-permission',function() {
        const role_permission_id = $(this).data('role-permission-id');
        const transaction       = 'delete role menu item permission';
    
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
                    url: './app/Controllers/RoleController.php',
                    dataType: 'json',
                    data: {
                        role_permission_id : role_permission_id, 
                        transaction : transaction
                    },
                    success: function (response) {
                        if (response.success) {
                            showNotification(response.title, response.message, response.message_type);
                            reloadDatatable('#menu-item-permission-table');
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

    $(document).on('click','.view-menu-item-permission-log-notes',function() {
        const role_permission_id = $(this).data('role-permission-id');

        attachLogNotesClassHandler('role_permission', role_permission_id);
    });

    $(document).on('click','#assign-system-action-permission',function() {
        generateDualListBox({
            url: './app/Controllers/RoleController.php',
            selectSelector: 'system_action_id',
            data: { 
                transaction: 'generate role system action dual listbox options',
                role_id: $('#details-id').text()
            }
        });
    });

    $(document).on('click','.update-system-action-permission',function() {
        const role_permission_id    = $(this).data('role-permission-id');
        const access_type           = $(this).data('access-type');
        const access                = $(this).is(':checked') ? '1' : '0';
        const transaction           = 'update role system action permission';
    
        $.ajax({
            type: 'POST',
            url: './app/Controllers/RoleController.php',
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

    $(document).on('click','.delete-system-action-permission',function() {
        const role_permission_id = $(this).data('role-permission-id');
        const transaction       = 'delete role system action permission';
    
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
                    url: './app/Controllers/RoleController.php',
                    dataType: 'json',
                    data: {
                        role_permission_id : role_permission_id, 
                        transaction : transaction
                    },
                    success: function (response) {
                        if (response.success) {
                            showNotification(response.title, response.message, response.message_type);
                            reloadDatatable('#system-action-permission-table');
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

    $(document).on('click','.view-system-action-permission-log-notes',function() {
        const role_system_action_permission_id = $(this).data('role-permission-id');

        attachLogNotesClassHandler('role_system_action_permission', role_system_action_permission_id);
    });
});