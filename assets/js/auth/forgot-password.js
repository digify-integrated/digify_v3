/**
 * Import utility functions for button control, error handling, and notifications.
 */
import { disableButton, enableButton } from '../utilities/form-utilities.js';
import { handleSystemError } from '../modules/system-errors.js';
import { showNotification, setNotification } from '../modules/notifications.js';

$(document).ready(function () {
    /**
     * Initialize validation on the forgot password form.
     * 
     * Rules:
     * - Email field is required.
     * 
     * Custom error handling:
     * - Notifications are shown instead of inline messages.
     * - Invalid inputs are highlighted with Bootstrap's "is-invalid" class.
     */
    $('#forgot_password_form').validate({
        rules: {
            email: {
                required: true,
            }
        },
        messages: {
            email: {
                required: 'Enter the email',
            }
        },
        /**
         * Display error messages in a notification popup.
         */
        errorPlacement: (error, element) => {
            showNotification('Action Needed: Issue Detected', error.text(), 'error', 2500);
        },
        /**
         * Highlight invalid inputs for better UX.
         * Special handling for Select2 fields.
         */
        highlight: (element) => {
            const $element = $(element);
            const $target = $element.hasClass('select2-hidden-accessible')
                ? $element.next().find('.select2-selection')
                : $element;
            $target.addClass('is-invalid');
        },
        /**
         * Remove highlight once the input is valid.
         */
        unhighlight: (element) => {
            const $element = $(element);
            const $target = $element.hasClass('select2-hidden-accessible')
                ? $element.next().find('.select2-selection')
                : $element;
            $target.removeClass('is-invalid');
        },
        /**
         * Submit handler for the forgot password form.
         * - Prevents default form submission.
         * - Sends AJAX request to backend for password reset.
         * - Disables button during processing.
         * - Shows notifications for success/error.
         */
        submitHandler: async (form, event) => {
            event.preventDefault();

            const transaction = 'forgot password';

            $.ajax({
                type: 'POST',
                url: './app/Controllers/AuthenticationController.php',
                data: $(form).serialize() + '&transaction=' + transaction,
                dataType: 'JSON',
                beforeSend: function() {
                    // Prevent duplicate requests
                    disableButton('forgot-password');
                },
                success: function(response) {
                    if (response.success) {
                        // Show confirmation and redirect user
                        setNotification(response.title, response.message, response.message_type);
                        window.location.href = response.redirect_link;
                    }
                    else {
                        // Show error and re-enable button
                        showNotification(response.title, response.message, response.message_type);
                        enableButton('forgot-password');
                    }
                },
                error: function(xhr, status, error) {
                    // Re-enable button and handle unexpected errors
                    enableButton('forgot-password');
                    handleSystemError(xhr, status, error);
                }
            });

            return false; // Prevent normal form submission
        }
    });
});
