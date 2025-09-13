<?php
namespace App\Models;

use App\Core\Model;

class Authentication extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveResetToken(
        $p_user_account_id,
        $p_reset_token,
        $p_reset_token_expiry_date
    ) {
        $sql = 'CALL saveResetToken(
            :p_user_account_id,
            :p_reset_token,
            :p_reset_token_expiry_date
        )';
        
        return $this->query($sql, [
            'p_user_account_id'         => $p_user_account_id,
            'p_reset_token'             => $p_reset_token,
            'p_reset_token_expiry_date' => $p_reset_token_expiry_date
        ]);
    }
    
    public function saveSession(
        $p_user_account_id,
        $p_session_token
    ) {
        $sql = 'CALL saveSession(
            :p_user_account_id,
            :p_session_token
        )';
        
        return $this->query($sql, [
            'p_user_account_id' => $p_user_account_id,
            'p_session_token'   => $p_session_token
        ]);
    }
    
    public function saveOTP(
        $p_user_account_id,
        $p_otp,
        $otp_expiry_date
    ) {
        $sql = 'CALL saveOTP(
            :p_user_account_id,
            :p_otp,
            :otp_expiry_date
        )';

        return $this->query($sql, [
            'p_user_account_id' => $p_user_account_id,
            'p_otp'             => $p_otp,
            'otp_expiry_date'   => $otp_expiry_date
        ]);
    }

    /* =============================================================================================
        SECTION 2: INSERT METHODS
    ============================================================================================= */

    public function insertLoginAttempt(
        $p_user_account_id,
        $p_email,
        $p_ip_address,
        $p_success
    )    {
        $sql = 'CALL insertLoginAttempt(
            :p_user_account_id,
            :p_email,
            :p_ip_address,
            :p_success
        )';

        return $this->query($sql, [
            'p_user_account_id' => $p_user_account_id,
            'p_email'           => $p_email,
            'p_ip_address'      => $p_ip_address,
            'p_success'         => $p_success
        ]);
    }

    /* =============================================================================================
        SECTION 3: UPDATE METHODS
    =============================================================================================  */

    public function updateFailedOTPAttempts(
        $p_user_account_id,
        $p_failed_otp_attempts
    ) {
        $sql = 'CALL updateFailedOTPAttempts(
            :p_user_account_id,
            :p_failed_otp_attempts
        )';
        
        return $this->query($sql, [
            'p_user_account_id'     => $p_user_account_id,
            'p_failed_otp_attempts' => $p_failed_otp_attempts
        ]);
    }

    public function updateUserPassword(
        $p_user_account_id,
        $p_password
    ) {
        $sql = 'CALL updateUserPassword(
            :p_user_account_id,
            :p_password
        )';
        
        return $this->query($sql, [
            'p_user_account_id' => $p_user_account_id,
            'p_password'        => $p_password
        ]);
    }

    public function updateOTPAsExpired(
        $p_user_account_id
    ) {
        $sql = 'CALL updateOTPAsExpired(
            :p_user_account_id
        )';
        
        return $this->query($sql, [
            'p_user_account_id' => $p_user_account_id
        ]);
    }

    public function updateResetTokenAsExpired(
        $p_user_account_id
    ) {
        $sql = 'CALL updateResetTokenAsExpired(
            :p_user_account_id
        )';
        
        return $this->query($sql, [
            'p_user_account_id' => $p_user_account_id
        ]);
    }

    /* =============================================================================================
        SECTION 4: FETCH METHODS
    ============================================================================================= */

    public function fetchLoginCredentials(
        $p_credendtial
    ) {
        $sql = 'CALL fetchLoginCredentials(
            :p_credendtial
        )';
        
        return $this->fetch($sql, [
            'p_credendtial' => $p_credendtial
        ]);
    }

    public function fetchOTP(
        $p_user_account_id
    ) {
        $sql = 'CALL fetchOTP(
            :p_user_account_id
        )';
        
        return $this->fetch($sql, [
            'p_user_account_id' => $p_user_account_id
        ]);
    }

    public function fetchResetToken(
        $p_user_account_id
    ) {
        $sql = 'CALL fetchResetToken(
            :p_user_account_id
        )';
        
        return $this->fetch($sql, [
            'p_user_account_id' => $p_user_account_id
        ]);
    }

    public function fetchSession(
        $p_user_account_id
    ) {
        $sql = 'CALL fetchSession(
            :p_user_account_id
        )';

        return $this->fetch($sql, [
            'p_user_account_id' => $p_user_account_id
        ]);
    }

    public function fetchAppModuleStack(
        $p_user_account_id
    ) {
        $sql = 'CALL fetchAppModuleStack(
            :p_user_account_id
        )';
        
        return $this->fetchAll($sql, [
            'p_user_account_id' => $p_user_account_id
        ]);
    }

    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkLoginCredentialsExist(
        $p_email
    ) {
        $sql = 'CALL checkLoginCredentialsExist(
            :p_email
        )';
        
        return $this->fetch($sql, [
            'p_email' => $p_email
        ]);
    }

    public function checkUserSystemActionPermission(
        $p_user_account_id,
        $p_system_action_id
    ) {
        $sql = 'CALL checkUserSystemActionPermission(
            :p_user_account_id,
            :p_system_action_id
        )';
        
        return $this->fetch($sql, [
            'p_user_account_id'     => $p_user_account_id,
            'p_system_action_id'    => $p_system_action_id
        ]);
    }

    public function checkUserPermission(
        $p_user_account_id,
        $p_menu_item_id,
        $p_access_type
    ) {
        $sql = 'CALL checkUserPermission(
            :p_user_account_id,
            :p_menu_item_id,
            :p_access_type
        )';
        
        return $this->fetch($sql, [
            'p_user_account_id'     => $p_user_account_id,
            'p_menu_item_id'        => $p_menu_item_id,
            'p_access_type'         => $p_access_type
        ]);
    }
    
    public function checkRateLimited(
        $p_email,
        $p_ip_address
    )    {
        $window = RATE_LIMITER_WINDOW;

        $sql = 'CALL checkRateLimited(
            :p_email,
            :p_ip_address,
            :p_window
        )';

        $result = $this->fetch($sql, [
            'p_email'           => $p_email,
            'p_ip_address'      => $p_ip_address,
            'p_window'          => $window
        ]);

        return (int) ($result['total'] ?? 0);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
}