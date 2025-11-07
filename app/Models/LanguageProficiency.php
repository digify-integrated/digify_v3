<?php
namespace App\Models;

use App\Core\Model;

class LanguageProficiency extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveLanguageProficiency(
        null|int $p_language_proficiency_id,
        string $p_language_proficiency_name,
        string $p_language_proficiency_description,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveLanguageProficiency(
            :p_language_proficiency_id,
            :p_language_proficiency_name,
            :p_language_proficiency_description,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_language_proficiency_id'             => $p_language_proficiency_id,
            'p_language_proficiency_name'           => $p_language_proficiency_name,
            'p_language_proficiency_description'    => $p_language_proficiency_description,
            'p_last_log_by'                         => $p_last_log_by
        ]);

        return $row['new_language_proficiency_id'] ?? null;
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

    public function fetchLanguageProficiency(
        int $p_language_proficiency_id
    ) {
        $sql = 'CALL fetchLanguageProficiency(
            :p_language_proficiency_id
        )';
        
        return $this->fetch($sql, [
            'p_language_proficiency_id' => $p_language_proficiency_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteLanguageProficiency(
        int $p_language_proficiency_id
    ) {
        $sql = 'CALL deleteLanguageProficiency(
            :p_language_proficiency_id
        )';
        
        return $this->query($sql, [
            'p_language_proficiency_id' => $p_language_proficiency_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkLanguageProficiencyExist(
        int $p_language_proficiency_id
    ) {
        $sql = 'CALL checkLanguageProficiencyExist(
            :p_language_proficiency_id
        )';
        
        return $this->fetch($sql, [
            'p_language_proficiency_id' => $p_language_proficiency_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateLanguageProficiencyTable() {
        $sql = 'CALL generateLanguageProficiencyTable()';
        
        return $this->fetchAll($sql);
    }

    public function generateLanguageProficiencyOptions() {
        $sql = 'CALL generateLanguageProficiencyOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}