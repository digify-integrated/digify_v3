<?php
namespace App\Models;

use App\Core\Model;

class ContactInformationType extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveContactInformationType(
        null|int $p_contact_information_type_id,
        string $p_contact_information_type_name,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveContactInformationType(
            :p_contact_information_type_id,
            :p_contact_information_type_name,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_contact_information_type_id'     => $p_contact_information_type_id,
            'p_contact_information_type_name'   => $p_contact_information_type_name,
            'p_last_log_by'                     => $p_last_log_by
        ]);

        return $row['new_contact_information_type_id'] ?? null;
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

    public function fetchContactInformationType(
        int $p_contact_information_type_id
    ) {
        $sql = 'CALL fetchContactInformationType(
            :p_contact_information_type_id
        )';
        
        return $this->fetch($sql, [
            'p_contact_information_type_id' => $p_contact_information_type_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteContactInformationType(
        int $p_contact_information_type_id
    ) {
        $sql = 'CALL deleteContactInformationType(
            :p_contact_information_type_id
        )';
        
        return $this->query($sql, [
            'p_contact_information_type_id' => $p_contact_information_type_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkContactInformationTypeExist(
        int $p_contact_information_type_id
    ) {
        $sql = 'CALL checkContactInformationTypeExist(
            :p_contact_information_type_id
        )';
        
        return $this->fetch($sql, [
            'p_contact_information_type_id' => $p_contact_information_type_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateContactInformationTypeTable() {
        $sql = 'CALL generateContactInformationTypeTable()';
        
        return $this->fetchAll($sql);
    }

    public function generateContactInformationTypeOptions() {
        $sql = 'CALL generateContactInformationTypeOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}