<?php
namespace App\Models;

use App\Core\Model;

class JobPosition extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveJobPosition(
        int $p_job_position_id,
        string $p_job_position_name,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveJobPosition(
            :p_job_position_id,
            :p_job_position_name,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_job_position_id'     => $p_job_position_id,
            'p_job_position_name'   => $p_job_position_name,
            'p_last_log_by'         => $p_last_log_by
        ]);

        return $row['new_job_position_id'] ?? null;
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

    public function fetchJobPosition(
        int $p_job_position_id
    ) {
        $sql = 'CALL fetchJobPosition(
            :p_job_position_id
        )';
        
        return $this->fetch($sql, [
            'p_job_position_id' => $p_job_position_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteJobPosition(
        int $p_job_position_id
    ) {
        $sql = 'CALL deleteJobPosition(
            :p_job_position_id
        )';
        
        return $this->query($sql, [
            'p_job_position_id' => $p_job_position_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkJobPositionExist(
        int $p_job_position_id
    ) {
        $sql = 'CALL checkJobPositionExist(
            :p_job_position_id
        )';
        
        return $this->fetch($sql, [
            'p_job_position_id' => $p_job_position_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateJobPositionTable() {
        $sql = 'CALL generateJobPositionTable()';
        
        return $this->fetchAll($sql);
    }

    public function generateJobPositionOptions() {
        $sql = 'CALL generateJobPositionOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}