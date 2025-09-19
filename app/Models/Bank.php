<?php
namespace App\Models;

use App\Core\Model;

class Bank extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveBank(
        $p_bank_id,
        $p_bank_name,
        $p_bank_identifier_code,
        $p_last_log_by
    )    {
        $sql = 'CALL saveBank(
            :p_bank_id,
            :p_bank_name,
            :p_bank_identifier_code,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_bank_id'                 => $p_bank_id,
            'p_bank_name'               => $p_bank_name,
            'p_bank_identifier_code'    => $p_bank_identifier_code,
            'p_last_log_by'             => $p_last_log_by
        ]);

        return $row['new_bank_id'] ?? null;
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

    public function fetchBank(
        $p_bank_id
    ) {
        $sql = 'CALL fetchBank(
            :p_bank_id
        )';
        
        return $this->fetch($sql, [
            'p_bank_id' => $p_bank_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteBank(
        $p_bank_id
    ) {
        $sql = 'CALL deleteBank(
            :p_bank_id
        )';
        
        return $this->query($sql, [
            'p_bank_id' => $p_bank_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkBankExist(
        $p_bank_id
    ) {
        $sql = 'CALL checkBankExist(
            :p_bank_id
        )';
        
        return $this->fetch($sql, [
            'p_bank_id' => $p_bank_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateBankTable() {
        $sql = 'CALL generateBankTable()';
        
        return $this->fetchAll($sql);
    }

    public function generateBankOptions() {
        $sql = 'CALL generateBankOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}