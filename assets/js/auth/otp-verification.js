/**
 * OTP Verification Script
 * 
 * Features:
 * - Auto-focus between OTP input boxes
 * - Handles OTP pasting
 * - Backspace navigation
 * - Resend OTP with countdown (persists across refresh using localStorage)
 * - Countdown displayed in MM:SS format
 */

import { disableButton, enableButton } from '../utilities/form-utilities.js';
import { handleSystemError } from '../modules/system-errors.js';
import { showNotification, setNotification } from '../modules/notifications.js';

$(document).ready(function () {
    /**
     * ==========================
     * OTP INPUT HANDLING
     * ==========================
     */

    // Auto-focus next input when max length is reached
    $('.otp-input').on('input', function () {
        var maxLength = parseInt($(this).attr('maxlength'));
        var currentLength = $(this).val().length;

        if (currentLength === maxLength) {
            $(this).next('.otp-input').focus();
        }
    });

    // Handle OTP paste (only alphanumeric)
    $('.otp-input').on('paste', function (e) {
        e.preventDefault();

        var pastedData = (e.originalEvent || e).clipboardData.getData('text/plain');
        var filteredData = pastedData.replace(/[^a-zA-Z0-9]/g, '');

        for (var i = 0; i < filteredData.length; i++) {
            if (i < 6) {
                $('#otp_code_' + (i + 1)).val(filteredData.charAt(i));
            }
        }
    });

    // Handle backspace navigation
    $('.otp-input').on('keydown', function (e) {
        if (e.which === 8 && $(this).val().length === 0) {
            $(this).prev('.otp-input').focus();
        }
    });

    /**
     * ==========================
     * RESEND OTP HANDLING
     * ==========================
     */

    // Resend OTP click handler
    $('#resend-link').on('click', function () {
        resendOTP(180);
    });

    // Restore countdown state on page load if still active
    const expireTime = localStorage.getItem('otpExpireTime');
    if (expireTime) {
        const remaining = Math.floor((expireTime - Date.now()) / 1000);
        if (remaining > 0) {
            startCountdown(remaining);
        } else {
            localStorage.removeItem('otpExpireTime');
        }
    }

    /**
     * ==========================
     * OTP FORM VALIDATION
     * ==========================
     */
    $('#otp_form').validate({
        rules: {
            otp_code_1: { required: true },
            otp_code_2: { required: true },
            otp_code_3: { required: true },
            otp_code_4: { required: true },
            otp_code_5: { required: true },
            otp_code_6: { required: true }
        },
        messages: {
            otp_code_1: { required: 'Enter the security code' },
            otp_code_2: { required: 'Enter the security code' },
            otp_code_3: { required: 'Enter the security code' },
            otp_code_4: { required: 'Enter the security code' },
            otp_code_5: { required: 'Enter the security code' },
            otp_code_6: { required: 'Enter the security code' }
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

            const transaction = 'otp verification';

            $.ajax({
                type: 'POST',
                url: './app/Controllers/AuthenticationController.php',
                data: $(form).serialize() + '&transaction=' + transaction,
                dataType: 'JSON',
                beforeSend: function () {
                    disableButton('verify');
                },
                success: function (response) {
                    if (response.success) {
                        window.location.href = response.redirect_link;
                    }
                    else {
                        showNotification(response.title, response.message, response.message_type);
                        enableButton('verify');
                    }
                },
                error: function (xhr, status, error) {
                    enableButton('verify');
                    handleSystemError(xhr, status, error);
                }
            });

            return false;
        }
    });
});

/**
 * ==========================
 * COUNTDOWN FUNCTIONS
 * ==========================
 */

/**
 * Starts a countdown timer and saves its expiry in localStorage.
 * @param {number} duration - Countdown duration in seconds.
 */
function startCountdown(duration) {
    const $countdown = $('#countdown');
    const $resendLink = $('#resend-link');

    let remaining = duration;
    let countdownTimer;

    $countdown.removeClass('d-none').text(formatTime(remaining));
    $resendLink.addClass('d-none');

    // Save expiry timestamp
    const expireTime = Date.now() + duration * 1000;
    localStorage.setItem('otpExpireTime', expireTime);

    // Clear any existing timer before starting a new one
    if (window.otpCountdownTimer) {
        clearInterval(window.otpCountdownTimer);
    }

    window.otpCountdownTimer = setInterval(() => {
        remaining--;

        if (remaining >= 0) {
            $countdown.text(formatTime(remaining));
        } else {
            clearInterval(window.otpCountdownTimer);
            $countdown.addClass('d-none');
            $resendLink.removeClass('d-none');
            localStorage.removeItem('otpExpireTime'); // cleanup
        }
    }, 1000);
}

/**
 * Resets countdown and requests a new OTP from backend.
 * @param {number} countdownValue - Countdown duration in seconds.
 */
function resendOTP(countdownValue) {
    const user_account_id = $('#user_account_id').val();
    const transaction = 'resend otp';

    $.ajax({
        type: 'POST',
        url: './app/Controllers/AuthenticationController.php',
        dataType: 'json',
        data: {
            user_account_id: user_account_id,
            transaction: transaction
        },
        beforeSend: function () {
            $('#countdown').removeClass('d-none');
            $('#resend-link').addClass('d-none');

            document.getElementById('countdown').innerHTML = formatTime(countdownValue);

            startCountdown(countdownValue);
        },
        success: function (response) {
            if (response.success) {
                showNotification(response.title, response.message, response.message_type);
            }
            else {
                window.location.href = 'index.php';
                setNotification(response.title, response.message, response.messageType);
            }
        },
        error: function (xhr, status, error) {
            handleSystemError(xhr, status, error);
        }
    });
}

/**
 * Converts seconds into MM:SS format.
 * @param {number} seconds - Time in seconds.
 * @returns {string} Formatted time (MM:SS).
 */
function formatTime(seconds) {
    const minutes = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${minutes}:${secs < 10 ? '0' : ''}${secs}`;
}
