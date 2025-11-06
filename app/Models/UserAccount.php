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
        string $p_file_as,
        string $p_email,
        string $p_password,
        string $p_phone,
        int $p_last_log_by
    )    {
        $sql = 'CALL insertUserAccount(
            :p_file_as,
            :p_email,
            :p_password,
            :p_phone,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_file_as'         => $p_file_as,
            'p_email'           => $p_email,
            'p_password'        => $p_password,
            'p_phone'           => $p_phone,
            'p_last_log_by'     => $p_last_log_by
        ]);

        return $row['new_user_account_id'] ?? null;
    }

    /* =============================================================================================
        SECTION 3: UPDATE METHODS
    =============================================================================================  */

    public function updateUserAccount(
        int $p_user_account_id,
        string $p_value,
        string $p_update_type,
        int $p_last_log_by
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
        int $p_user_account_id
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
        int $p_user_account_id
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
        int $p_user_account_id
    ) {
        $sql = 'CALL checkUserAccountExist(
            :p_user_account_id
        )';
        
        return $this->fetch($sql, [
            'p_user_account_id' => $p_user_account_id
        ]);
    }

    public function checkUserAccountEmailExist(
        int $p_user_account_id,
        string $p_email
    ) {
        $sql = 'CALL checkUserAccountEmailExist(
            :p_user_account_id,
            :p_email
        )';
        
        return $this->fetch($sql, [
            'p_user_account_id'     => $p_user_account_id,
            'p_email'               => $p_email
        ]);
    }

    public function checkUserAccountInsertEmailExist(
        string $p_email
    ) {
        $sql = 'CALL checkUserAccountInsertEmailExist(
            :p_email
        )';
        
        return $this->fetch($sql, [
            'p_email'               => $p_email
        ]);
    }

    public function checkUserAccountPhoneExist(
        int $p_user_account_id,
        string $p_phone
    ) {
        $sql = 'CALL checkUserAccountPhoneExist(
            :p_user_account_id,
            :p_phone
        )';
        
        return $this->fetch($sql, [
            'p_user_account_id'     => $p_user_account_id,
            'p_phone'               => $p_phone
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateUserAccountTable(
        string $p_filter_by_active,
    ) {
        $sql = 'CALL generateUserAccountTable(
            :p_filter_by_active
        )';
        
        return $this->fetchAll($sql, [
            'p_filter_by_active' => $p_filter_by_active
        ]);
    }

    public function generateUserAccountOptions() {
        $sql = 'CALL generateUserAccountOptions()';
        
        return $this->fetchAll($sql);
    }

    public function generateUserAccountRoleList(
        int $p_user_account_id
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