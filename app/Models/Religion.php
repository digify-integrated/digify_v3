<?php
namespace App\Models;

use App\Core\Model;

class Religion extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveReligion(
        int $p_religion_id,
        string $p_religion_name,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveReligion(
            :p_religion_id,
            :p_religion_name,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_religion_id'     => $p_religion_id,
            'p_religion_name'   => $p_religion_name,
            'p_last_log_by'     => $p_last_log_by
        ]);

        return $row['new_religion_id'] ?? null;
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

    public function fetchReligion(
        int $p_religion_id
    ) {
        $sql = 'CALL fetchReligion(
            :p_religion_id
        )';
        
        return $this->fetch($sql, [
            'p_religion_id' => $p_religion_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteReligion(
        int $p_religion_id
    ) {
        $sql = 'CALL deleteReligion(
            :p_religion_id
        )';
        
        return $this->query($sql, [
            'p_religion_id' => $p_religion_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkReligionExist(
        int $p_religion_id
    ) {
        $sql = 'CALL checkReligionExist(
            :p_religion_id
        )';
        
        return $this->fetch($sql, [
            'p_religion_id' => $p_religion_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateReligionTable() {
        $sql = 'CALL generateReligionTable()';
        
        return $this->fetchAll($sql);
    }

    public function generateReligionOptions() {
        $sql = 'CALL generateReligionOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}