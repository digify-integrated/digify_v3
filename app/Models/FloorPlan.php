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

    public function saveFloorPlanTable(
        null|string|int $p_floor_plan_table_id,
        int $p_floor_plan_id,
        string $p_floor_plan_name,
        int $p_table_number,
        int $p_seats,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveFloorPlanTable(
            :p_floor_plan_table_id,
            :p_floor_plan_id,
            :p_floor_plan_name,
            :p_table_number,
            :p_seats,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_floor_plan_table_id'     => $p_floor_plan_table_id,
            'p_floor_plan_id'           => $p_floor_plan_id,
            'p_floor_plan_name'         => $p_floor_plan_name,
            'p_table_number'            => $p_table_number,
            'p_seats'                   => $p_seats,
            'p_last_log_by'             => $p_last_log_by
        ]);

        return $row['new_floor_plan_table_id'] ?? null;
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

    public function fetchFloorPlanTable(
        int $p_floor_plan_table_id
    ) {
        $sql = 'CALL fetchFloorPlanTable(
            :p_floor_plan_table_id
        )';
        
        return $this->fetch($sql, [
            'p_floor_plan_table_id' => $p_floor_plan_table_id
        ]);
    }

    public function fetchFloorPlanTableCount(
        int $p_floor_plan_id
    ) {
        $sql = 'CALL fetchFloorPlanTableCount(
            :p_floor_plan_id
        )';
        
        return $this->fetch($sql, [
            'p_floor_plan_id' => $p_floor_plan_id
        ]);
    }

     public function fetchFloorPlanSeatCount(
        int $p_floor_plan_id
    ) {
        $sql = 'CALL fetchFloorPlanSeatCount(
            :p_floor_plan_id
        )';
        
        return $this->fetch($sql, [
            'p_floor_plan_id' => $p_floor_plan_id
        ]);
    }

     public function fetchFloorPlanTables(
        int $p_floor_plan_id
    ) {
        $sql = 'CALL fetchFloorPlanTables(
            :p_floor_plan_id
        )';
        
        return $this->fetchAll($sql, [
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

    public function deleteFloorPlanTable(
        int $p_floor_plan_table_id
    ) {
        $sql = 'CALL deleteFloorPlanTable(
            :p_floor_plan_table_id
        )';
        
        return $this->query($sql, [
            'p_floor_plan_table_id' => $p_floor_plan_table_id
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

    public function checkFloorPlanTableExist(
        int $p_floor_plan_table_id
    ) {
        $sql = 'CALL checkFloorPlanTableExist(
            :p_floor_plan_table_id
        )';
        
        return $this->fetch($sql, [
            'p_floor_plan_table_id' => $p_floor_plan_table_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateFloorPlanTable() {
        $sql = 'CALL generateFloorPlanTable()';
        
        return $this->fetchAll($sql);
    }

    public function generateFloorPlanTablesTable(
        int $p_floor_plan_id
    ) {
        $sql = 'CALL generateFloorPlanTablesTable(
            :p_floor_plan_id
        )';
        
        return $this->fetchAll($sql, [
            'p_floor_plan_id' => $p_floor_plan_id
        ]);
    }

    public function generateFloorPlanOptions() {
        $sql = 'CALL generateFloorPlanOptions()';
        
        return $this->fetchAll($sql);
    }

    public function generateShopFloorPlanOptions(
        int $p_shop_id
    ) {
        $sql = 'CALL generateShopFloorPlanOptions(
            :p_shop_id
        )';
        
        return $this->fetchAll($sql, [
            'p_shop_id' => $p_shop_id
        ]);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}