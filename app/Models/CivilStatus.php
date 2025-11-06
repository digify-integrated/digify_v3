<?php
namespace App\Models;

use App\Core\Model;

class CivilStatus extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveCivilStatus(
        int $p_civil_status_id,
        string $p_civil_status_name,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveCivilStatus(
            :p_civil_status_id,
            :p_civil_status_name,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_civil_status_id'     => $p_civil_status_id,
            'p_civil_status_name'   => $p_civil_status_name,
            'p_last_log_by'         => $p_last_log_by
        ]);

        return $row['new_civil_status_id'] ?? null;
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

    public function fetchCivilStatus(
        int $p_civil_status_id
    ) {
        $sql = 'CALL fetchCivilStatus(
            :p_civil_status_id
        )';
        
        return $this->fetch($sql, [
            'p_civil_status_id' => $p_civil_status_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteCivilStatus(
        int $p_civil_status_id
    ) {
        $sql = 'CALL deleteCivilStatus(
            :p_civil_status_id
        )';
        
        return $this->query($sql, [
            'p_civil_status_id' => $p_civil_status_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkCivilStatusExist(
        int $p_civil_status_id
    ) {
        $sql = 'CALL checkCivilStatusExist(
            :p_civil_status_id
        )';
        
        return $this->fetch($sql, [
            'p_civil_status_id' => $p_civil_status_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateCivilStatusTable() {
        $sql = 'CALL generateCivilStatusTable()';
        
        return $this->fetchAll($sql);
    }

    public function generateCivilStatusOptions() {
        $sql = 'CALL generateCivilStatusOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}