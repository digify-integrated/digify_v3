<?php
namespace App\Models;

use App\Core\Model;

class Language extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveLanguage(
        int $p_language_id,
        string $p_language_name,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveLanguage(
            :p_language_id,
            :p_language_name,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_language_id'     => $p_language_id,
            'p_language_name'   => $p_language_name,
            'p_last_log_by'     => $p_last_log_by
        ]);

        return $row['new_language_id'] ?? null;
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

    public function fetchLanguage(
        int $p_language_id
    ) {
        $sql = 'CALL fetchLanguage(
            :p_language_id
        )';
        
        return $this->fetch($sql, [
            'p_language_id' => $p_language_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteLanguage(
        int $p_language_id
    ) {
        $sql = 'CALL deleteLanguage(
            :p_language_id
        )';
        
        return $this->query($sql, [
            'p_language_id' => $p_language_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkLanguageExist(
        int $p_language_id
    ) {
        $sql = 'CALL checkLanguageExist(
            :p_language_id
        )';
        
        return $this->fetch($sql, [
            'p_language_id' => $p_language_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateLanguageTable() {
        $sql = 'CALL generateLanguageTable()';
        
        return $this->fetchAll($sql);
    }

    public function generateLanguageOptions() {
        $sql = 'CALL generateLanguageOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}