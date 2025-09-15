import { disableButton, enableButton, generateDropdownOptions, resetForm } from '../../utilities/form-utilities.js';
import { attachLogNotesHandler  } from '../../utilities/log-notes.js';
import { handleSystemError } from '../../modules/system-errors.js';
import { showNotification, setNotification } from '../../modules/notifications.js';

$(document).ready(function () {
    generateDropdownOptions({
        url: './app/Controllers/MenuItemController.php',
        dropdownSelector: '#menu_item_id',
        data: { transaction: 'generate menu item options' },
        validateOnChange: true
    });

    displayDetails();

    attachLogNotesHandler('#log-notes-main', '#details-id', 'app_module');

    $(document).on('click','#delete-app-module',function() {
        const app_module_id     = $('#details-id').text();
        const page_link         = document.getElementById('page-link').getAttribute('href'); 
        const transaction       = 'delete app module';
    
        Swal.fire({
            title: 'Confirm App Module Deletion',
            text: 'Are you sure you want to delete this app module?',
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
                    url: './app/Controllers/AppModuleController.php',
                    dataType: 'json',
                    data: {
                        app_module_id : app_module_id, 
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

    $(document).on('change','#app_logo',function() {
        if ($(this).val() !== '' && $(this)[0].files.length > 0) {
            const transaction       = 'update app module logo';
            const app_module_id     = $('#details-id').text();

            let formData = new FormData();
            formData.append('app_logo', $(this)[0].files[0]);
            formData.append('transaction', transaction);
            formData.append('app_module_id', app_module_id);
        
            $.ajax({
                type: 'POST',
                url: './app/Controllers/AppModuleController.php',
                dataType: 'json',
                data: formData,
                contentType: false,
                processData: false,
                success: function(response) {
                    if (response.success) {
                        showNotification(response.title, response.message, response.message_type);
                        displayDetails();
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
        }
    });
    
    $('#app_module_form').validate({
        rules: {
            app_module_name: {
                required: true
            },
            app_module_description: {
                required: true
            },
            menu_item_id: {
                required: true
            },
            order_sequence: {
                required: true
            }
        },
        messages: {
            app_module_name: {
                required: 'Enter the display name'
            },
            app_module_description: {
                required: 'Enter the description'
            },
            menu_item_id: {
                required: 'Select the default page'
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

            const app_module_id = $('#details-id').text();
            const transaction   = 'save app module';

            $.ajax({
                type: 'POST',
                url: './app/Controllers/AppModuleController.php',
                data: $(form).serialize() + '&transaction=' + transaction + '&app_module_id=' + encodeURIComponent(app_module_id),
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
});

function displayDetails(){
    const page_link         = document.getElementById('page-link').getAttribute('href');
    const transaction       = 'fetch app module details';
    const app_module_id     = $('#details-id').text();
            
    $.ajax({
        url: './app/Controllers/AppModuleController.php',
        method: 'POST',
        dataType: 'json',
        data: {
            app_module_id : app_module_id,
            transaction : transaction
        },
        beforeSend: function(){
            resetForm('app_module_form');
        },
        success: function(response) {
            if (response.success) {
                $('#app_module_name').val(response.appModuleName);
                $('#app_module_description').val(response.appModuleDescription);
                $('#order_sequence').val(response.orderSequence);
                        
                $('#menu_item_id').val(response.menuItemID).trigger('change');

                document.getElementById('app_thumbnail').style.backgroundImage = `url(${response.appLogo})`;
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