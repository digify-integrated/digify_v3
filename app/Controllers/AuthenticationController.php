<?php
namespace App\Controllers;

require_once '../../config/config.php';

use App\Models\Authentication;
use App\Models\EmailSetting;
use App\Models\NotificationSetting;
use App\Models\SecuritySetting;
use App\Core\Security;
use App\Core\Email;
use App\Helpers\SystemHelper;

/**
 * Class AuthenticationController
 *
 * Handles authentication-related actions such as login, 
 * OTP verification, password reset, and rate limiting.
 *
 * Acts as the entry point for user authentication flows and ensures
 * that security measures like CSRF validation, rate limiting,
 * account activity status, and optional two-factor authentication
 * are properly enforced.
 */
class AuthenticationController
{
    protected Authentication $authentication;
    protected SecuritySetting $securitySetting;
    protected NotificationSetting $notificationSetting;
    protected Security $security;
    protected Email $email;
    protected SystemHelper $systemHelper;

    /**
     * AuthenticationController constructor.
     *
     * @param Authentication      $authentication       Handles DB operations for login, OTP, and sessions.
     * @param SecuritySetting     $securitySetting      Provides security-related configuration.
     * @param NotificationSetting $notificationSetting  Provides templates and settings for notifications.
     * @param Security            $security             Provides cryptographic utilities (hash, encrypt, tokens).
     * @param Email               $email                Handles email composition and sending.
     * @param SystemHelper        $systemHelper         Utility for sending API/system responses.
     */
    public function __construct(
        Authentication $authentication,
        SecuritySetting $securitySetting,
        NotificationSetting $notificationSetting,
        Security $security,
        Email $email,
        SystemHelper $systemHelper
    ) {
        $this->authentication       = $authentication;
        $this->securitySetting      = $securitySetting;
        $this->notificationSetting  = $notificationSetting;
        $this->security             = $security;
        $this->email                = $email;
        $this->systemHelper         = $systemHelper;
    }

    /**
     * Entry point for handling a POST request.
     *
     * Validates request type and transaction type.
     * Dispatches execution based on the transaction provided in POST.
     *
     * Supported transactions:
     * - authenticate
     * - otp verification
     * - resend otp
     * - forgot password
     * - password reset
     *
     * @return void
     */
    public function handleRequest(): void
    {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            $this->systemHelper::sendErrorResponse('Invalid Request', 'Only POST requests are allowed.');
            return;
        }

        $transaction = $_POST['transaction'] ?? null;

        if (!$transaction) {
            $this->systemHelper::sendErrorResponse('Missing Transaction', 'No transaction type was provided.');
            return;
        }

        $transaction = strtolower(trim($transaction));

        match ($transaction) {
            'authenticate'      => $this->authenticate(),
            'otp verification'  => $this->verifyOTP(),
            'resend otp'        => $this->resendOTP(),
            'forgot password'   => $this->forgotPassword(),
            'password reset'    => $this->passwordReset(),
            default             => $this->systemHelper::sendErrorResponse(
                'Transaction Failed',
                'We encountered an issue while processing your request.'
            ),
        };
    }

    # -------------------------------------------------------------
    #   Authenticate Function
    # -------------------------------------------------------------

    /**
     * Attempts to authenticate a user.
     *
     * Steps:
     * - Validates CSRF token.
     * - Enforces rate limiting on failed attempts.
     * - Validates user credentials and account status.
     * - Handles two-factor authentication if enabled.
     * - Creates a session on successful login.
     *
     * @return void
     */
    public function authenticate(): void
    {
        $csrfToken = $_POST['csrf_token'] ?? null;

        // Validate CSRF Token
        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'login_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $email      = trim($_POST['email'] ?? '');
        $password   = $_POST['password'] ?? '';
        $ip_address = $_SERVER['REMOTE_ADDR'] ?? 'unknown';

        // Rate limiting check
        $attempts = $this->authentication->checkRateLimited(
            $email, 
            $ip_address
        );

        if ($attempts >= RATE_LIMITER_THRESHOLD) {
            $this->systemHelper::sendErrorResponse(
                'Too Many Attempts',
                'Please wait a few minutes before trying again.'
            );
        }

        // User existence check
        $loginCredentials = $this->authentication->checkLoginCredentialsExist($email);

        if (empty($loginCredentials) || ($loginCredentials['total'] ?? 0) === 0) {
            $this->authentication->insertLoginAttempt(null, $email, $ip_address, false);

            $this->systemHelper::sendErrorResponse(
                'Authentication Failed',
                'Invalid credentials. Please check and try again.'
            );
        }

        // Fetch credentials
        $credentials           = $this->authentication->fetchLoginCredentials($email);
        $userAccountId         = $credentials['user_account_id'] ?? '';
        $isActive              = $credentials['active'] ?? 'No';
        $userPassword          = $credentials['password'] ?? null;
        $twoFactorAuthEnabled  = $credentials['two_factor_auth'] ?? 'Yes';

        // Validate password
        if (!password_verify($password, $userPassword)) {
            $this->authentication->insertLoginAttempt($userAccountId, $email, $ip_address, false);

            $this->systemHelper->sendErrorResponse(
                'Authentication Failed',
                'Invalid credentials. Please check and try again.'
            );
        }

        // Check account status
        if ($isActive === 'No') {
            $this->systemHelper->sendErrorResponse(
                'Account Inactive', 
                'Your account is inactive. Please contact your administrator for assistance.'
            );
        }
    
        // If 2FA is enabled → handle OTP flow
        if ($twoFactorAuthEnabled === 'Yes') {
            $this->handleTwoFactorAuth($userAccountId, $email);
        }

        // Generate and save session token
        $sessionToken   = $this->security::generateToken(6);
        $sessionHash    = $this->security::hashToken($sessionToken);

        $this->authentication->insertLoginAttempt($userAccountId, $email, $ip_address, true);
        $this->authentication->saveSession($userAccountId, $sessionHash);

        // Store in session
        $_SESSION['user_account_id'] = $userAccountId;
        $_SESSION['session_token']   = $sessionHash;
    }
    
    # -------------------------------------------------------------
    #   Handle Two-Factor Authentication
    # -------------------------------------------------------------

    /**
     * Handles OTP-based two-factor authentication.
     *
     * - Generates and saves OTP.
     * - Retrieves email template from notification settings.
     * - Sends OTP email using configured SMTP settings.
     * - Responds with a redirect link on success, or error on failure.
     *
     * @param string $userAccountId  The user ID.
     * @param string $email          The user's email address.
     *
     * @return void
     */
    private function handleTwoFactorAuth(string $userAccountId, string $email): void
    {
        $encryptedUserAccountID = $this->security->encryptData($userAccountId);
        $otp                    = $this->security::generateOtp();
        $otpHash                = $this->security::hashToken($otp);
        $otpExpiryDate          = date('Y-m-d H:i:s', strtotime('+'. OTP_DURATION .' minutes'));

        // Save OTP in DB
        $this->authentication->saveOTP($userAccountId, $otpHash, $otpExpiryDate);

        // Get template and settings
        $notificationSettingDetails = $this->notificationSetting->getNotificationSettingEmailTemplate(1);
        $emailSettingID             = $notificationSettingDetails['email_setting_id'] ?? null;

        $emailSubject   = $notificationSettingDetails['email_notification_subject'] ?? null;
        $emailBody      = $notificationSettingDetails['email_notification_body'] ?? null;
        $emailBody      = str_replace('#{OTP_CODE}', $otp, $emailBody);
        $emailBody      = str_replace('#{OTP_CODE_VALIDITY}', OTP_DURATION . ' minutes', $emailBody);

        // Send email
        $result = $this->email->sendEmail(
            $emailSettingID,
            $email,
            $emailSubject,
            $emailBody
        );

        if ($result === true) {
            $this->systemHelper->sendSuccessResponse(
                '',
                '',
                additionalData: ['redirect_link' => OTP_VERIFICATION_LINK . $encryptedUserAccountID]
            );
        } else {
            $this->systemHelper->sendErrorResponse(
                'Email Sending Failed',
                is_string($result) ? $result : 'Unable to send OTP email. Please try again later.'
            );
        }
    }
}

# Bootstrap the controller
$controller = new AuthenticationController(
    new Authentication(),
    new SecuritySetting(),
    new NotificationSetting(),
    new Security(),
    new Email(new EmailSetting(), new Security()),
    new SystemHelper()
);

$controller->handleRequest();
