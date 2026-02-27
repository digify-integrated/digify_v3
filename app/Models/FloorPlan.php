<?php
namespace App\Models;

use App\Core\Model;

class FloorPlan extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveFloorPlan(
        null|int $p_floor_plan_id,
        string $p_floor_plan_name,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveFloorPlan(
            :p_floor_plan_id,
            :p_floor_plan_name,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_floor_plan_id'   => $p_floor_plan_id,
            'p_floor_plan_name' => $p_floor_plan_name,
            'p_last_log_by'     => $p_last_log_by
        ]);

        return $row['new_floor_plan_id'] ?? null;
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

    public function fetchFloorPlan(
        int $p_floor_plan_id
    ) {
        $sql = 'CALL fetchFloorPlan(
            :p_floor_plan_id
        )';
        
        return $this->fetch($sql, [
            'p_floor_plan_id' => $p_floor_plan_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteFloorPlan(
        int $p_floor_plan_id
    ) {
        $sql = 'CALL deleteFloorPlan(
            :p_floor_plan_id
        )';
        
        return $this->query($sql, [
            'p_floor_plan_id' => $p_floor_plan_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkFloorPlanExist(
        int $p_floor_plan_id
    ) {
        $sql = 'CALL checkFloorPlanExist(
            :p_floor_plan_id
        )';
        
        return $this->fetch($sql, [
            'p_floor_plan_id' => $p_floor_plan_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateFloorPlanTable() {
        $sql = 'CALL generateFloorPlanTable()';
        
        return $this->fetchAll($sql);
    }

    public function generateFloorPlanOptions() {
        $sql = 'CALL generateFloorPlanOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}