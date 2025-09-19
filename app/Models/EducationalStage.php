<?php
namespace App\Models;

use App\Core\Model;

class EducationalStage extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveEducationalStage(
        $p_educational_stage_id,
        $p_educational_stage_name,
        $p_last_log_by
    )    {
        $sql = 'CALL saveEducationalStage(
            :p_educational_stage_id,
            :p_educational_stage_name,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_educational_stage_id'    => $p_educational_stage_id,
            'p_educational_stage_name'  => $p_educational_stage_name,
            'p_last_log_by'             => $p_last_log_by
        ]);

        return $row['new_educational_stage_id'] ?? null;
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

    public function fetchEducationalStage(
        $p_educational_stage_id
    ) {
        $sql = 'CALL fetchEducationalStage(
            :p_educational_stage_id
        )';
        
        return $this->fetch($sql, [
            'p_educational_stage_id' => $p_educational_stage_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteEducationalStage(
        $p_educational_stage_id
    ) {
        $sql = 'CALL deleteEducationalStage(
            :p_educational_stage_id
        )';
        
        return $this->query($sql, [
            'p_educational_stage_id' => $p_educational_stage_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkEducationalStageExist(
        $p_educational_stage_id
    ) {
        $sql = 'CALL checkEducationalStageExist(
            :p_educational_stage_id
        )';
        
        return $this->fetch($sql, [
            'p_educational_stage_id' => $p_educational_stage_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateEducationalStageTable() {
        $sql = 'CALL generateEducationalStageTable()';
        
        return $this->fetchAll($sql);
    }

    public function generateEducationalStageOptions() {
        $sql = 'CALL generateEducationalStageOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}