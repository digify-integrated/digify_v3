<?php
namespace App\Models;

use App\Core\Model;

class Nationality extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveNationality(
        int $p_nationality_id,
        string $p_nationality_name,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveNationality(
            :p_nationality_id,
            :p_nationality_name,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_nationality_id'      => $p_nationality_id,
            'p_nationality_name'    => $p_nationality_name,
            'p_last_log_by'         => $p_last_log_by
        ]);

        return $row['new_nationality_id'] ?? null;
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

    public function fetchNationality(
        int $p_nationality_id
    ) {
        $sql = 'CALL fetchNationality(
            :p_nationality_id
        )';
        
        return $this->fetch($sql, [
            'p_nationality_id' => $p_nationality_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteNationality(
        int $p_nationality_id
    ) {
        $sql = 'CALL deleteNationality(
            :p_nationality_id
        )';
        
        return $this->query($sql, [
            'p_nationality_id' => $p_nationality_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkNationalityExist(
        int $p_nationality_id
    ) {
        $sql = 'CALL checkNationalityExist(
            :p_nationality_id
        )';
        
        return $this->fetch($sql, [
            'p_nationality_id' => $p_nationality_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateNationalityTable() {
        $sql = 'CALL generateNationalityTable()';
        
        return $this->fetchAll($sql);
    }

    public function generateNationalityOptions() {
        $sql = 'CALL generateNationalityOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}