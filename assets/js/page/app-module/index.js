/**
 * Import utility functions for button control, error handling, and notifications.
 */
import { disableButton, enableButton } from '../../utilities/form-utilities.js';
import { handleSystemError } from '../../modules/system-errors.js';
import { showNotification } from '../../modules/notifications.js';

$(document).ready(function () {
    /**
     * Initialize validation for the login form.
     * 
     * Validation rules:
     * - Email: required
     * - Password: required
     * 
     * Custom behavior:
     * - Error messages displayed as notifications instead of inline labels.
     * - Invalid fields highlighted using Bootstrap's `is-invalid` class.
     */
    $('#login_form').validate({
        rules: {
            email: {
                required: true,
            },
            password: {
                required: true
            }
        },
        messages: {
            email: {
                required: 'Enter the email',
            },
            password: {
                required: 'Enter the password'
            }
        },
        /**
         * Override error placement by showing a popup notification.
         */
        errorPlacement: (error, element) => {
            showNotification('Action Needed: Issue Detected', error.text(), 'error', 2500);
        },
        /**
         * Highlight invalid input fields.
         * Handles both standard inputs and Select2 dropdowns.
         */
        highlight: (element) => {
            const $element = $(element);
            const $target = $element.hasClass('select2-hidden-accessible')
                ? $element.next().find('.select2-selection')
                : $element;
            $target.addClass('is-invalid');
        },
        /**
         * Remove highlight when the input is valid.
         */
        unhighlight: (element) => {
            const $element = $(element);
            const $target = $element.hasClass('select2-hidden-accessible')
                ? $element.next().find('.select2-selection')
                : $element;
            $target.removeClass('is-invalid');
        },
        /**
         * Handles form submission via AJAX.
         * 
         * - Prevents default browser submission.
         * - Sends login data to the AuthenticationController.
         * - Disables "Sign In" button during request to prevent duplicate submissions.
         * - Redirects on success, or shows error notifications on failure.
         * 
         * @param {HTMLFormElement} form - The login form element.
         * @param {Event} event - The form submission event.
         * @returns {boolean} Always returns false to prevent default submission.
         */
        submitHandler: async (form, event) => {
            event.preventDefault();

            const transaction = 'authenticate';

            $.ajax({
                type: 'POST',
                url: './app/Controllers/AuthenticationController.php',
                data: $(form).serialize() + '&transaction=' + transaction,
                dataType: 'JSON',
                beforeSend: function() {
                    // Disable "Sign In" button while request is processing
                    disableButton('signin');
                },
                success: function(response) {
                    if (response.success) {
                        // Redirect to dashboard or intended page
                        window.location.href = response.redirect_link;
                    }
                    else {
                        // Show error and re-enable button
                        showNotification(response.title, response.message, response.message_type);
                        enableButton('signin');
                    }
                },
                error: function(xhr, status, error) {
                    // Re-enable button and handle system-level errors
                    enableButton('signin');
                    handleSystemError(xhr, status, error);
                }
            });

            return false; // Prevents normal form submission
        }
    });
});
