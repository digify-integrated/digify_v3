<?php
namespace App\Models;

use App\Core\Model;

/**
 * Authentication model
 *
 * Provides database access methods for authentication-related operations,
 * including login, password management, permissions, and rate limiting.
 */
class Authentication extends Model {

    # -------------------------------------------------------------
    #   Fetch methods
    # -------------------------------------------------------------

    /**
     * Fetch login credentials for a user by email.
     *
     * @param string $p_email User's email address
     * @return array|null User account row or null if not found
     */
    public function fetchLoginCredentials($p_email) {
        $sql = 'CALL fetchLoginCredentials(:p_email)';
        
        return $this->fetch($sql, [
            'p_email' => $p_email
        ]);
    }

    /**
     * Fetch otp for a user by user account ID.
     *
     * @param int $p_user_account_id User account ID
     * @return array|null User account row or null if not found
     */
    public function fetchOTP($p_user_account_id) {
        $sql = 'CALL fetchOTP(:p_user_account_id)';
        
        return $this->fetch($sql, [
            'p_user_account_id' => $p_user_account_id
        ]);
    }

    /**
     * Fetch reset token for a user by user account ID.
     *
     * @param int $p_user_account_id User account ID
     * @return array|null User account row or null if not found
     */
    public function fetchResetToken($p_user_account_id) {
        $sql = 'CALL fetchResetToken(:p_user_account_id)';
        
        return $this->fetch($sql, [
            'p_user_account_id' => $p_user_account_id
        ]);
    }

    /**
     * Fetch password history for a given user account.
     *
     * @param int $p_user_account_id User account ID
     * @return array List of password history records
     */
    public function fetchPasswordHistory($p_user_account_id) {
        $sql = 'CALL fetchPasswordHistory(:p_user_account_id)';
        
        return $this->fetchAll($sql, [
            'p_user_account_id' => $p_user_account_id
        ]);
    }

    /**
     * Fetch attachments for a specific internal note.
     *
     * @param int $p_internal_notes_id Internal note ID
     * @return array List of attachments
     */
    public function fetchInternalNotesAttachment($p_internal_notes_id) {
        $sql = 'CALL fetchInternalNotesAttachment(:p_internal_notes_id)';

        return $this->fetchAll($sql, [
            'p_internal_notes_id' => $p_internal_notes_id
        ]);
    }

    # -------------------------------------------------------------

    # -------------------------------------------------------------
    #   Check exist methods
    # -------------------------------------------------------------

    /**
     * Check if login credentials exist for a given email.
     *
     * @param string $p_email User's email address
     * @return array|null Single record if found, otherwise null
     */
    public function checkLoginCredentialsExist($p_email) {
        $sql = 'CALL checkLoginCredentialsExist(:p_email)';
        
        return $this->fetch($sql, [
            'p_email' => $p_email
        ]);
    }

    # -------------------------------------------------------------

    # -------------------------------------------------------------
    #   Check methods
    # -------------------------------------------------------------

    /**
     * Check if a user has permission for a specific system action.
     *
     * @param int $p_user_account_id User account ID
     * @param int $p_system_action_id System action ID
     * @return array|null Permission record or null if not allowed
     */
    public function checkUserSystemActionPermission($p_user_account_id, $p_system_action_id) {
        $sql = 'CALL checkUserSystemActionPermission(:p_user_account_id, :p_system_action_id)';
        
        return $this->fetch($sql, [
            'p_user_account_id'     => $p_user_account_id,
            'p_system_action_id'    => $p_system_action_id
        ]);
    }

    /**
     * Check if a user has a specific type of access for a menu item.
     *
     * @param int $p_user_account_id User account ID
     * @param int $p_menu_item_id Menu item ID
     * @param string $p_access_type Access type (read, write, create, etc.)
     * @return array|null Permission record or null if not allowed
     */
    public function checkUserPermission($p_user_account_id, $p_menu_item_id, $p_access_type) {
        $sql = 'CALL checkUserPermission(:p_user_account_id, :p_menu_item_id, :p_access_type)';
        
        return $this->fetch($sql, [
            'p_user_account_id' => $p_user_account_id,
            'p_menu_item_id'    => $p_menu_item_id,
            'p_access_type'     => $p_access_type
        ]);
    }
    
    /**
     * Check if a user, email, or IP address is rate-limited.
     *
     * @param int $p_user_account_id User account ID
     * @param string $p_email Email address
     * @param string $p_ip_address IP address
     * @return int Number of failed attempts in the rate limit window
     */
    public function checkRateLimited($p_email, $p_ip_address)
    {
        $window = RATE_LIMITER_WINDOW;

        $sql = 'CALL checkRateLimited(:p_email, :p_ip_address, :p_window)';

        $result = $this->fetch($sql, [
            'p_email'           => $p_email,
            'p_ip_address'      => $p_ip_address,
            'p_window'          => $window
        ]);

        return (int) ($result['total'] ?? 0);
    }
    
    # -------------------------------------------------------------

    # -------------------------------------------------------------
    #   Save methods
    # -------------------------------------------------------------

    /**
     * Save or update a reset token for a user.
     *
     * @param int $p_user_account_id User account ID
     * @param string $p_reset_token Reset token
     * @param string $p_reset_token_expiry_date Expiry date/time for the token
     */
    public function saveResetToken($p_user_account_id, $p_reset_token, $p_reset_token_expiry_date) {
        $sql = 'CALL saveResetToken(:p_user_account_id, :p_reset_token, :p_reset_token_expiry_date)';
        
        return $this->query($sql, [
            'p_user_account_id'         => $p_user_account_id,
            'p_reset_token'             => $p_reset_token,
            'p_reset_token_expiry_date' => $p_reset_token_expiry_date
        ]);
    }
    
    /**
     * Save or update a user session.
     *
     * @param int $p_user_account_id User account ID
     * @param string $p_session_token Session token
     */
    public function saveSession($p_user_account_id, $p_session_token) {
        $sql = 'CALL saveSession(:p_user_account_id, :p_session_token)';
        
        return $this->query($sql, [
            'p_user_account_id' => $p_user_account_id,
            'p_session_token'   => $p_session_token
        ]);
    }
    
    /**
     * Save or update a OTP.
     *
     * @param int $p_user_account_id User account ID
     * @param string $p_otp OTP code
     * @param string $otp_expiry_date Expiry date/time for the OTP
     */
    public function saveOTP($p_user_account_id, $p_otp, $otp_expiry_date) {
        $sql = 'CALL saveOTP(:p_user_account_id, :p_otp, :otp_expiry_date)';

        return $this->query($sql, [
            'p_user_account_id' => $p_user_account_id,
            'p_otp'             => $p_otp,
            'otp_expiry_date'   => $otp_expiry_date
        ]);
    }
    
    # -------------------------------------------------------------

    # -------------------------------------------------------------
    #   Insert methods
    # -------------------------------------------------------------

    /**
     * Insert a login attempt record.
     *
     * @param int|null $p_user_account_id User account ID (nullable for unknown users)
     * @param string $p_email Email address used
     * @param string $p_ip_address IP address
     * @param bool $p_success Whether the attempt was successful
     */
    public function insertLoginAttempt($p_user_account_id, $p_email, $p_ip_address, $p_success)
    {
        $sql = 'CALL insertLoginAttempt(:p_user_account_id, :p_email, :p_ip_address, :p_success)';

        return $this->query($sql, [
            'p_user_account_id' => $p_user_account_id,
            'p_email'           => $p_email,
            'p_ip_address'      => $p_ip_address,
            'p_success'         => $p_success
        ]);
    }

    # -------------------------------------------------------------

    # -------------------------------------------------------------
    #   Update methods
    # -------------------------------------------------------------

    /**
     * Update the number of failed OTP attempts for a user.
     *
     * @param int $p_user_account_id User account ID
     * @param int $p_failed_otp_attempts Number of failed attempts
     */
    public function updateFailedOTPAttempts($p_user_account_id, $p_failed_otp_attempts) {
        $sql = 'CALL updateFailedOTPAttempts(:p_user_account_id, :p_failed_otp_attempts)';
        
        return $this->query($sql, [
            'p_user_account_id'     => $p_user_account_id,
            'p_failed_otp_attempts' => $p_failed_otp_attempts
        ]);
    }

    /**
     * Update a user's password.
     *
     * @param int $p_user_account_id User account ID
     * @param string $p_password New password hash
     */
    public function updateUserPassword($p_user_account_id, $p_password) {
        $sql = 'CALL updateUserPassword(:p_user_account_id, :p_password)';
        
        return $this->query($sql, [
            'p_user_account_id' => $p_user_account_id,
            'p_password'        => $p_password
        ]);
    }

    /**
     * Update an otp's expiry date.
     *
     * @param int $p_user_account_id User account ID
     */
    public function updateOTPAsExpired($p_user_account_id) {
        $sql = 'CALL updateOTPAsExpired(:p_user_account_id)';
        
        return $this->query($sql, [
            'p_user_account_id' => $p_user_account_id
        ]);
    }

    /**
     * Update an reset token's expiry date.
     *
     * @param int $p_user_account_id User account ID
     */
    public function updateResetTokenAsExpired($p_user_account_id) {
        $sql = 'CALL updateResetTokenAsExpired(:p_user_account_id)';
        
        return $this->query($sql, [
            'p_user_account_id' => $p_user_account_id
        ]);
    }
    
    # -------------------------------------------------------------
}
