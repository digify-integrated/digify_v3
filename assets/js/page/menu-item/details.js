import { disableButton, enableButton, generateDropdownOptions, generateDualListBox, resetForm } from '../../utilities/form-utilities.js';
import { initializeDatatable, initializeDatatableControls, reloadDatatable } from '../../utilities/datatable.js';
import { attachLogNotesHandler, attachLogNotesClassHandler  } from '../../utilities/log-notes.js';
import { handleSystemError } from '../../modules/system-errors.js';
import { showNotification, setNotification } from '../../modules/notifications.js';

$(document).ready(function () {
    initializeDatatableControls('#role-permission-table');

    generateDropdownOptions({
        url: './app/Controllers/MenuItemController.php',
        dropdownSelector: '#parent_id',
        data: { 
            transaction: 'generate menu item options',
            menu_item_id: $('#details-id').text()
        }
    });

    generateDropdownOptions({
        url: './app/Controllers/AppModuleController.php',
        dropdownSelector: '#app_module_id',
        data: { 
            transaction: 'generate app module options'
        }
    });

    generateDropdownOptions({
        url: './app/Controllers/ExportController.php',
        dropdownSelector: '#table_name',
        data: { 
            transaction: 'generate export table options'
        }
    });
    
    $('#menu_item_form').validate({
        rules: {
            menu_item_name: {
                required: true
            },
            app_module_id: {
                required: true
            },
            order_sequence: {
                required: true
            }
        },
        messages: {
            menu_item_name: {
                required: 'Enter the display name'
            },
            app_module_id: {
                required: 'Choose the app module'
            },
            order_sequence: {
                required: 'Enter the order sequence'
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

            const menu_item_id  = $('#details-id').text();
            const transaction   = 'save menu item';

            $.ajax({
                type: 'POST',
                url: './app/Controllers/MenuItemController.php',
                data: $(form).serialize() + '&transaction=' + transaction + '&menu_item_id=' + encodeURIComponent(menu_item_id),
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

            const menu_item_id  = $('#details-id').text();
            const transaction   = 'save menu item role permission';

            $.ajax({
                type: 'POST',
                url: './app/Controllers/MenuItemController.php',
                data: $(form).serialize() + '&transaction=' + transaction + '&menu_item_id=' + encodeURIComponent(menu_item_id),
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

    initializeDatatable({
        selector: '#role-permission-table',
        ajaxUrl: './app/Controllers/MenuItemController.php',
        transaction: 'generate menu item assigned role table',
        ajaxData: {
            menu_item_id: $('#details-id').text()
        },
        columns: [
            { data: 'ROLE_NAME' },
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

    displayDetails();

    attachLogNotesHandler('#log-notes-main', '#details-id', 'menu_item');

    $(document).on('click','#delete-menu-item',function() {
        const menu_item_id      = $('#details-id').text();
        const page_link         = document.getElementById('page-link').getAttribute('href'); 
        const transaction       = 'delete menu item';
    
        Swal.fire({
            title: 'Confirm Menu Item Deletion',
            text: 'Are you sure you want to delete this menu item?',
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
                    url: './app/Controllers/MenuItemController.php',
                    dataType: 'json',
                    data: {
                        menu_item_id : menu_item_id, 
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
            url: './app/Controllers/MenuItemController.php',
            selectSelector: 'role_id',
            data: { 
                transaction: 'generate menu item role dual listbox options',
                menu_item_id: $('#details-id').text()
            }
        });
    });

    $(document).on('click','.update-role-permission',function() {
        const role_permission_id    = $(this).data('role-permission-id');
        const access_type           = $(this).data('access-type');
        const access                = $(this).is(':checked') ? '1' : '0';
        const transaction           = 'update menu item role permission';
    
        $.ajax({
            type: 'POST',
            url: './app/Controllers/MenuItemController.php',
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
        const transaction       = 'delete menu item role permission';
    
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
                    url: './app/Controllers/MenuItemController.php',
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
        const role_permission_id = $(this).data('role-permission-id');

        attachLogNotesClassHandler('role_permission', role_permission_id);
    });
});

function displayDetails(){
    const page_link     = document.getElementById('page-link').getAttribute('href');
    const transaction   = 'fetch menu item details';
    const menu_item_id  = $('#details-id').text();
            
    $.ajax({
        url: './app/Controllers/MenuItemController.php',
        method: 'POST',
        dataType: 'json',
        data: {
            menu_item_id : menu_item_id,
            transaction : transaction
        },
        beforeSend: function(){
            resetForm('menu_item_form');
        },
        success: function(response) {
            if (response.success) {
                $('#menu_item_name').val(response.menuItemName);
                $('#order_sequence').val(response.orderSequence);
                $('#menu_item_url').val(response.menuItemURL);
                        
                $('#app_module_id').val(response.appModuleID).trigger('change');
                $('#parent_id').val(response.parentID).trigger('change');
                $('#menu_item_icon').val(response.menuItemIcon).trigger('change');
                $('#table_name').val(response.tableName).trigger('change');
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