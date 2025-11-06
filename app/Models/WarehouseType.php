<?php
namespace App\Models;

use App\Core\Model;

class WarehouseType extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveWarehouseType(
        int $p_warehouse_type_id,
        string $p_warehouse_type_name,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveWarehouseType(
            :p_warehouse_type_id,
            :p_warehouse_type_name,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_warehouse_type_id'     => $p_warehouse_type_id,
            'p_warehouse_type_name'   => $p_warehouse_type_name,
            'p_last_log_by'         => $p_last_log_by
        ]);

        return $row['new_warehouse_type_id'] ?? null;
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

    public function fetchWarehouseType(
        int $p_warehouse_type_id
    ) {
        $sql = 'CALL fetchWarehouseType(
            :p_warehouse_type_id
        )';
        
        return $this->fetch($sql, [
            'p_warehouse_type_id' => $p_warehouse_type_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteWarehouseType(
        int $p_warehouse_type_id
    ) {
        $sql = 'CALL deleteWarehouseType(
            :p_warehouse_type_id
        )';
        
        return $this->query($sql, [
            'p_warehouse_type_id' => $p_warehouse_type_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkWarehouseTypeExist(
        int $p_warehouse_type_id
    ) {
        $sql = 'CALL checkWarehouseTypeExist(
            :p_warehouse_type_id
        )';
        
        return $this->fetch($sql, [
            'p_warehouse_type_id' => $p_warehouse_type_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateWarehouseTypeTable() {
        $sql = 'CALL generateWarehouseTypeTable()';
        
        return $this->fetchAll($sql);
    }

    public function generateWarehouseTypeOptions() {
        $sql = 'CALL generateWarehouseTypeOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}