import { disableButton, enableButton, generateDropdownOptions, generateDualListBox, resetForm } from '../../utilities/form-utilities.js';
import { initializeDatatable, initializeDatatableControls, reloadDatatable } from '../../utilities/datatable.js';
import { attachLogNotesHandler, attachLogNotesClassHandler  } from '../../utilities/log-notes.js';
import { handleSystemError } from '../../modules/system-errors.js';
import { showNotification, setNotification } from '../../modules/notifications.js';

$(document).ready(function () {
    $('#update_full_name_form').validate({
        rules: {
            full_name: {
                required: true
            }
        },
        messages: {
            full_name: {
                required: 'Enter the full name'
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

            const user_account_id   = $('#details-id').text();
            const transaction       = 'update user account full name';

            $.ajax({
                type: 'POST',
                url: './app/Controllers/UserAccountController.php',
                data: $(form).serialize() + '&transaction=' + transaction + '&user_account_id=' + encodeURIComponent(user_account_id),
                dataType: 'JSON',
                beforeSend: function() {
                    disableButton('update_full_name_submit');
                },
                success: function(response) {
                    if (response.success) {
                        showNotification(response.title, response.message, response.message_type);
                        displayDetails();
                        toggleSection('change_full_name');
                        enableButton('update_full_name_submit');
                    }
                    else{
                        if(response.invalid_session){
                            setNotification(response.title, response.message, response.message_type);
                            window.location.href = response.redirect_link;
                        }
                        else{
                            showNotification(response.title, response.message, response.message_type);
                            enableButton('update_full_name_submit');
                        }
                    }
                },
                error: function(xhr, status, error) {
                    enableButton('update_full_name_submit');
                    handleSystemError(xhr, status, error);
                }
            });

            return false;
        }
    });

    $('#update_email_form').validate({
        rules: {
            email: {
                required: true
            }
        },
        messages: {
            email: {
                required: 'Enter the email'
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

            const user_account_id   = $('#details-id').text();
            const transaction       = 'update user account email';

            $.ajax({
                type: 'POST',
                url: './app/Controllers/UserAccountController.php',
                data: $(form).serialize() + '&transaction=' + transaction + '&user_account_id=' + encodeURIComponent(user_account_id),
                dataType: 'JSON',
                beforeSend: function() {
                    disableButton('update_email_submit');
                },
                success: function(response) {
                    if (response.success) {
                        showNotification(response.title, response.message, response.message_type);
                        displayDetails();
                        toggleSection('change_email');
                        enableButton('update_email_submit');
                    }
                    else{
                        if(response.invalid_session){
                            setNotification(response.title, response.message, response.message_type);
                            window.location.href = response.redirect_link;
                        }
                        else{
                            showNotification(response.title, response.message, response.message_type);
                            enableButton('update_email_submit');
                        }
                    }
                },
                error: function(xhr, status, error) {
                    enableButton('update_email_submit');
                    handleSystemError(xhr, status, error);
                }
            });

            return false;
        }
    });

    $('#update_phone_form').validate({
        rules: {
            phone: {
                required: true
            }
        },
        messages: {
            phone: {
                required: 'Enter the phone'
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

            const user_account_id   = $('#details-id').text();
            const transaction       = 'update user account phone';

            $.ajax({
                type: 'POST',
                url: './app/Controllers/UserAccountController.php',
                data: $(form).serialize() + '&transaction=' + transaction + '&user_account_id=' + encodeURIComponent(user_account_id),
                dataType: 'JSON',
                beforeSend: function() {
                    disableButton('update_phone_submit');
                },
                success: function(response) {
                    if (response.success) {
                        showNotification(response.title, response.message, response.message_type);
                        displayDetails();
                        toggleSection('change_phone');
                        enableButton('update_phone_submit');
                    }
                    else{
                        if(response.invalid_session){
                            setNotification(response.title, response.message, response.message_type);
                            window.location.href = response.redirect_link;
                        }
                        else{
                            showNotification(response.title, response.message, response.message_type);
                            enableButton('update_phone_submit');
                        }
                    }
                },
                error: function(xhr, status, error) {
                    enableButton('update_phone_submit');
                    handleSystemError(xhr, status, error);
                }
            });

            return false;
        }
    });

    $('#update_password_form').validate({
        rules: {
            new_password: {
                required: true,
                password_strength: true
            }
        },
        messages: {
            new_password: {
                required: 'Enter the new password'
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

            const user_account_id   = $('#details-id').text();
            const transaction       = 'update user account password';

            $.ajax({
                type: 'POST',
                url: './app/Controllers/UserAccountController.php',
                data: $(form).serialize() + '&transaction=' + transaction + '&user_account_id=' + encodeURIComponent(user_account_id),
                dataType: 'JSON',
                beforeSend: function() {
                    disableButton('update_password_submit');
                },
                success: function(response) {
                    if (response.success) {
                        showNotification(response.title, response.message, response.message_type);
                        displayDetails();
                        toggleSection('change_password');
                        enableButton('update_password_submit');
                    }
                    else{
                        if(response.invalid_session){
                            setNotification(response.title, response.message, response.message_type);
                            window.location.href = response.redirect_link;
                        }
                        else{
                            showNotification(response.title, response.message, response.message_type);
                            enableButton('update_password_submit');
                        }
                    }
                },
                error: function(xhr, status, error) {
                    enableButton('update_password_submit');
                    handleSystemError(xhr, status, error);
                }
            });

            return false;
        }
    });

    displayDetails();

    attachLogNotesHandler('#log-notes-main', '#details-id', 'user_account');

    $(document).on('click','#delete-user-account',function() {
        const user_account_id   = $('#details-id').text();
        const page_link         = document.getElementById('page-link').getAttribute('href'); 
        const transaction       = 'delete user account';
    
        Swal.fire({
            title: 'Confirm User Account Deletion',
            text: 'Are you sure you want to delete this user account?',
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
                    url: './app/Controllers/UserAccountController.php',
                    dataType: 'json',
                    data: {
                        user_account_id : user_account_id, 
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

    $(document).on('click', '[data-toggle-section]', function () {
        const section = $(this).data('toggle-section');
        toggleSection(section);
    });

    $(document).on('click','#two-factor-authentication',function() {
        const user_account_id   = $('#details-id').text();
        const transaction       = 'update user account two factor authentication';
    
        $.ajax({
            type: 'POST',
            url: './app/Controllers/UserAccountController.php',
            dataType: 'json',
            data: {
                user_account_id : user_account_id, 
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
    })

    $(document).on('click','#multiple-login-sessions',function() {
        const user_account_id   = $('#details-id').text();
        const transaction       = 'update user account multiple login sessions';
    
        $.ajax({
            type: 'POST',
            url: './app/Controllers/UserAccountController.php',
            dataType: 'json',
            data: {
                user_account_id : user_account_id, 
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
    })
});

function displayDetails(){
    const page_link         = document.getElementById('page-link').getAttribute('href');
    const transaction       = 'fetch user account details';
    const user_account_id  = $('#details-id').text();
            
    $.ajax({
        url: './app/Controllers/UserAccountController.php',
        method: 'POST',
        dataType: 'json',
        data: {
            user_account_id : user_account_id,
            transaction : transaction
        },
        beforeSend: function(){
            resetForm('user_account_form');
        },
        success: function(response) {
            if (response.success) {
                $('#full_name_side_summary').text(response.fileAs);
                $('#email_side_summary').text(response.email);
                $('#phone_side_summary').text(response.phoneSummary);
                $('#last_password_date_side_summary').text(response.lastPasswordChange);
                $('#last_connection_date_side_summary').text(response.lastConnectionDate);
                $('#last_password_reset_request_side_summary').text(response.lastPasswordResetRequest);
                $('#last_failed_connection_date_side_summary').text(response.lastFailedConnectionDate);

                $('#full_name_summary').text(response.fileAs);
                $('#email_summary').text(response.email);
                $('#phone_summary').text(response.phoneSummary);

                document.getElementById('two-factor-authentication').checked = response.twoFactorAuthentication === 'Yes';
                document.getElementById('multiple-login-sessions').checked = response.multipleSession === 'Yes';

                document.getElementById('profile_picture_image').style.backgroundImage = `url(${response.profilePicture})`;

                document.getElementById('status_side_summary').innerHTML = response.activeBadge;
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

function toggleSection(section) {
    $(`#${section}_button`).toggleClass('d-none');
    $(`#${section}`).toggleClass('d-none');
    $(`#${section}_edit`).toggleClass('d-none');

    const formName = section.replace(/^change_/, '');
    resetForm(`update_${formName}_form`);
}