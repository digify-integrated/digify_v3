<?php
namespace App\Models;

use App\Core\Model;

class CredentialType extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveCredentialType(
        int $p_credential_type_id,
        string $p_credential_type_name,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveCredentialType(
            :p_credential_type_id,
            :p_credential_type_name,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_credential_type_id'      => $p_credential_type_id,
            'p_credential_type_name'    => $p_credential_type_name,
            'p_last_log_by'             => $p_last_log_by
        ]);

        return $row['new_credential_type_id'] ?? null;
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

    public function fetchCredentialType(
        int $p_credential_type_id
    ) {
        $sql = 'CALL fetchCredentialType(
            :p_credential_type_id
        )';
        
        return $this->fetch($sql, [
            'p_credential_type_id' => $p_credential_type_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteCredentialType(
        int $p_credential_type_id
    ) {
        $sql = 'CALL deleteCredentialType(
            :p_credential_type_id
        )';
        
        return $this->query($sql, [
            'p_credential_type_id' => $p_credential_type_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkCredentialTypeExist(
        int $p_credential_type_id
    ) {
        $sql = 'CALL checkCredentialTypeExist(
            :p_credential_type_id
        )';
        
        return $this->fetch($sql, [
            'p_credential_type_id' => $p_credential_type_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateCredentialTypeTable() {
        $sql = 'CALL generateCredentialTypeTable()';
        
        return $this->fetchAll($sql);
    }

    public function generateCredentialTypeOptions() {
        $sql = 'CALL generateCredentialTypeOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}