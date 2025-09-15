<?php
namespace App\Models;

use App\Core\Model;

class UserAccount extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    /* =============================================================================================
        SECTION 2: INSERT METHODS
    ============================================================================================= */

    public function insertUserAccount(
        $p_file_as,
        $p_email,
        $p_password,
        $p_phone,
        $p_last_log_by
    )    {
        $sql = 'CALL insertUserAccount(
            :p_file_as,
            :p_email,
            :p_password,
            :p_phone,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_file_as'     => $p_file_as,
            'p_email'       => $p_email,
            'p_password'    => $p_password,
            'p_phone'       => $p_phone,
            'p_last_log_by' => $p_last_log_by
        ]);

        return $row['new_user_account_id'] ?? null;
    }

    /* =============================================================================================
        SECTION 3: UPDATE METHODS
    =============================================================================================  */

    public function updateUserAccountFullName(
        $p_user_account_id,
        $p_file_as,
        $p_last_log_by
    ) {
        $sql = 'CALL updateUserAccountFullName(
            :p_user_account_id,
            :p_file_as,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_user_account_id'     => $p_user_account_id,
            'p_file_as'             => $p_file_as,
            'p_last_log_by'         => $p_last_log_by
        ]);
    }

    public function updateUserAccountEmailAddress(
        $p_user_account_id,
        $p_email,
        $p_last_log_by
    ) {
        $sql = 'CALL updateUserAccountEmailAddress(
            :p_user_account_id,
            :p_email,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_user_account_id'     => $p_user_account_id,
            'p_email'               => $p_email,
            'p_last_log_by'         => $p_last_log_by
        ]);
    }

    public function updateUserAccountPhone(
        $p_user_account_id,
        $p_phone,
        $p_last_log_by
    ) {
        $sql = 'CALL updateUserAccountPhone(
            :p_user_account_id,
            :p_phone,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_user_account_id'     => $p_user_account_id,
            'p_phone'               => $p_phone,
            'p_last_log_by'         => $p_last_log_by
        ]);
    }

    public function updateUserAccountPassword(
        $p_user_account_id,
        $p_password,
        $p_last_log_by
    ) {
        $sql = 'CALL updateUserAccountPassword(
            :p_user_account_id,
            :p_password,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_user_account_id'     => $p_user_account_id,
            'p_password'            => $p_password,
            'p_last_log_by'         => $p_last_log_by
        ]);
    }

    public function updateProfilePicture(
        $p_user_account_id,
        $p_profile_picture,
        $p_last_log_by
    ) {
        $sql = 'CALL updateProfilePicture(
            :p_user_account_id,
            :p_profile_picture,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_user_account_id'     => $p_user_account_id,
            'p_profile_picture'     => $p_profile_picture,
            'p_last_log_by'         => $p_last_log_by
        ]);
    }

    public function updateTwoFactorAuthenticationStatus(
        $p_user_account_id,
        $p_two_factor_auth,
        $p_last_log_by
    ) {
        $sql = 'CALL updateTwoFactorAuthenticationStatus(
            :p_user_account_id,
            :p_two_factor_auth,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_user_account_id'     => $p_user_account_id,
            'p_two_factor_auth'     => $p_two_factor_auth,
            'p_last_log_by'         => $p_last_log_by
        ]);
    }

    public function updateMultipleLoginSessionsStatus(
        $p_user_account_id,
        $p_multiple_session,
        $p_last_log_by
    ) {
        $sql = 'CALL updateMultipleLoginSessionsStatus(
            :p_user_account_id,
            :p_multiple_session,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_user_account_id'     => $p_user_account_id,
            'p_multiple_session'     => $p_multiple_session,
            'p_last_log_by'         => $p_last_log_by
        ]);
    }

    public function updateUserAccountStatus(
        $p_user_account_id,
        $p_active,
        $p_last_log_by
    ) {
        $sql = 'CALL updateUserAccountStatus(
            :p_user_account_id,
            :p_active,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_user_account_id'     => $p_user_account_id,
            'p_active'              => $p_active,
            'p_last_log_by'         => $p_last_log_by
        ]);
    }

    /* =============================================================================================
        SECTION 4: FETCH METHODS
    ============================================================================================= */

    public function fetchUserAccount(
        $p_user_account_id
    ) {
        $sql = 'CALL fetchUserAccount(
            :p_user_account_id
        )';
        
        return $this->fetch($sql, [
            'p_user_account_id' => $p_user_account_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteUserAccount(
        $p_user_account_id
    ) {
        $sql = 'CALL deleteUserAccount(
            :p_user_account_id
        )';
        
        return $this->query($sql, [
            'p_user_account_id' => $p_user_account_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkUserAccountExist(
        $p_user_account_id
    ) {
        $sql = 'CALL checkUserAccountExist(
            :p_user_account_id
        )';
        
        return $this->fetch($sql, [
            'p_user_account_id' => $p_user_account_id
        ]);
    }

    public function checkUserAccountEmailExist(
        $p_user_account_id,
        $p_email
    ) {
        $sql = 'CALL checkUserAccountEmailExist(
            :p_user_account_id,
            :p_email
        )';
        
        return $this->fetch($sql, [
            'p_user_account_id' => $p_user_account_id,
            'p_email'           => $p_email
        ]);
    }

    public function checkUserAccountPhoneExist(
        $p_user_account_id,
        $p_phone
    ) {
        $sql = 'CALL checkUserAccountPhoneExist(
            :p_user_account_id,
            :p_phone
        )';
        
        return $this->fetch($sql, [
            'p_user_account_id' => $p_user_account_id,
            'p_phone'           => $p_phone
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateUserAccountTable() {
        $sql = 'CALL generateUserAccountTable()';
        
        return $this->fetchAll($sql);
    }

    public function generateUserAccountOptions() {
        $sql = 'CALL generateUserAccountOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}