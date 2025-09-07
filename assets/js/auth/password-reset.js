/**
 * Import utility functions for form handling, error handling, and notifications.
 */
import { disableButton, enableButton } from '../utilities/form-utilities.js';
import { handleSystemError } from '../modules/system-errors.js';
import { showNotification, setNotification } from '../modules/notifications.js';

$(document).ready(function () {
    /**
     * Initialize jQuery Validation on the password reset form.
     * 
     * Validation rules:
     * - new_password: required and must pass custom password strength validation.
     * - confirm_password: required and must match the value of new_password.
     * 
     * Custom error messages are displayed using notification popups.
     */
    $('#password_reset_form').validate({
        rules: {
            new_password: {
                required: true,
                password_strength: true // Custom rule for password strength
            },
            confirm_password: {
                required: true,
                equalTo: '#new_password' // Must match the "new_password" field
            }
        },
        messages: {
            new_password: {
                required: 'Enter the password'
            },
            confirm_password: {
                required: 'Enter the confirm password',
                equalTo: 'The passwords you entered do not match'
            }
        },
        /**
         * Display validation errors using a notification popup instead of default placement.
         */
        errorPlacement: (error, element) => {
            showNotification('Action Needed: Issue Detected', error.text(), 'error', 2500);
        },
        /**
         * Highlight invalid form fields by adding a Bootstrap "is-invalid" class.
         * Special handling for Select2 fields to ensure styling applies correctly.
         */
        highlight: (element) => {
            const $element = $(element);
            const $target = $element.hasClass('select2-hidden-accessible')
                ? $element.next().find('.select2-selection')
                : $element;
            $target.addClass('is-invalid');
        },
        /**
         * Remove the "is-invalid" class when a field becomes valid again.
         */
        unhighlight: (element) => {
            const $element = $(element);
            const $target = $element.hasClass('select2-hidden-accessible')
                ? $element.next().find('.select2-selection')
                : $element;
            $target.removeClass('is-invalid');
        },
        /**
         * Handle successful form submission via AJAX.
         * 
         * - Prevents default submission.
         * - Sends serialized form data to AuthenticationController.php.
         * - Disables the reset button while processing to avoid duplicate submissions.
         * - Redirects on success, or displays error notifications otherwise.
         */
        submitHandler: async (form, event) => {
            event.preventDefault();

            const transaction = 'password reset';

            $.ajax({
                type: 'POST',
                url: './app/Controllers/AuthenticationController.php',
                data: $(form).serialize() + '&transaction=' + transaction,
                dataType: 'JSON',
                beforeSend: function () {
                    // Disable reset button while request is being processed
                    disableButton('reset');
                },
                success: function (response) {
                    if (response.success) {
                        setNotification(response.title, response.message, response.message_type);
                        // Redirect user to provided link on successful reset
                        window.location.href = response.redirect_link;
                    } else {
                        // Show server-provided error notification and re-enable button
                        showNotification(response.title, response.message, response.message_type);
                        enableButton('reset');
                    }
                },
                error: function (xhr, status, error) {
                    // Re-enable button and handle unexpected system errors
                    enableButton('reset');
                    handleSystemError(xhr, status, error);
                }
            });

            return false; // Prevent form from submitting normally
        }
    });
});
