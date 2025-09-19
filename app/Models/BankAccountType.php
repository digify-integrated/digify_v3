<?php
namespace App\Models;

use App\Core\Model;

class BankAccountType extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveBankAccountType(
        $p_bank_account_type_id,
        $p_bank_account_type_name,
        $p_last_log_by
    )    {
        $sql = 'CALL saveBankAccountType(
            :p_bank_account_type_id,
            :p_bank_account_type_name,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_bank_account_type_id'     => $p_bank_account_type_id,
            'p_bank_account_type_name'   => $p_bank_account_type_name,
            'p_last_log_by'                     => $p_last_log_by
        ]);

        return $row['new_bank_account_type_id'] ?? null;
    }
    
    /* =============================================================================================
        SECTION 2: INSERT METHODS
    ============================================================================================= */

    /* =============================================================================================
        SECTION 3: UPDATE METHODS
    =============================================================================================  */

    /* =============================================================================================
        SECTION 4: FETCH METHODS
    ============================================================================================= */

    public function fetchBankAccountType(
        $p_bank_account_type_id
    ) {
        $sql = 'CALL fetchBankAccountType(
            :p_bank_account_type_id
        )';
        
        return $this->fetch($sql, [
            'p_bank_account_type_id' => $p_bank_account_type_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteBankAccountType(
        $p_bank_account_type_id
    ) {
        $sql = 'CALL deleteBankAccountType(
            :p_bank_account_type_id
        )';
        
        return $this->query($sql, [
            'p_bank_account_type_id' => $p_bank_account_type_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkBankAccountTypeExist(
        $p_bank_account_type_id
    ) {
        $sql = 'CALL checkBankAccountTypeExist(
            :p_bank_account_type_id
        )';
        
        return $this->fetch($sql, [
            'p_bank_account_type_id' => $p_bank_account_type_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateBankAccountTypeTable() {
        $sql = 'CALL generateBankAccountTypeTable()';
        
        return $this->fetchAll($sql);
    }

    public function generateBankAccountTypeOptions() {
        $sql = 'CALL generateBankAccountTypeOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}