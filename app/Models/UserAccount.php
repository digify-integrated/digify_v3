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

    public function updateUserAccount(
        $p_user_account_id,
        $p_value,
        $p_update_type,
        $p_last_log_by
    ) {
        $sql = 'CALL updateUserAccount(
            :p_user_account_id,
            :p_value,
            :p_update_type,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_user_account_id'     => $p_user_account_id,
            'p_value'               => $p_value,
            'p_update_type'         => $p_update_type,
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

    public function generateUserAccountTable(
        $p_active,
    ) {
        $sql = 'CALL generateUserAccountTable(
            :p_active
        )';
        
        return $this->fetchAll($sql, [
            'p_active' => $p_active
        ]);
    }

    public function generateUserAccountOptions() {
        $sql = 'CALL generateUserAccountOptions()';
        
        return $this->fetchAll($sql);
    }

    public function generateUserAccountRoleList(
        $p_user_account_id
    ) {
        $sql = 'CALL generateUserAccountRoleList(
            :p_user_account_id
        )';
        
        return $this->fetchAll($sql, [
            'p_user_account_id' => $p_user_account_id
        ]);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}