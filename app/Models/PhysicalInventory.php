<?php
namespace App\Models;

use App\Core\Model;

class PhysicalInventory extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function savePhysicalInventory(
        null|int $p_physical_inventory_id,
        string $p_physical_inventory_name,
        null|string|int $p_parent_category_id,
        null|string $p_parent_category_name,
        string $p_costing_method,
        int $p_display_order,
        int $p_last_log_by
    )    {
        $sql = 'CALL savePhysicalInventory(
            :p_physical_inventory_id,
            :p_physical_inventory_name,
            :p_parent_category_id,
            :p_parent_category_name,
            :p_costing_method,
            :p_display_order,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_physical_inventory_id'     => $p_physical_inventory_id,
            'p_physical_inventory_name'   => $p_physical_inventory_name,
            'p_parent_category_id'      => $p_parent_category_id,
            'p_parent_category_name'    => $p_parent_category_name,
            'p_costing_method'          => $p_costing_method,
            'p_display_order'           => $p_display_order,
            'p_last_log_by'             => $p_last_log_by
        ]);

        return $row['new_physical_inventory_id'] ?? null;
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

    public function fetchPhysicalInventory(
        null|string|int $p_physical_inventory_id
    ) {
        $sql = 'CALL fetchPhysicalInventory(
            :p_physical_inventory_id
        )';
        
        return $this->fetch($sql, [
            'p_physical_inventory_id' => $p_physical_inventory_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deletePhysicalInventory(
        int $p_physical_inventory_id
    ) {
        $sql = 'CALL deletePhysicalInventory(
            :p_physical_inventory_id
        )';
        
        return $this->query($sql, [
            'p_physical_inventory_id' => $p_physical_inventory_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkPhysicalInventoryExist(
        int $p_physical_inventory_id
    ) {
        $sql = 'CALL checkPhysicalInventoryExist(
            :p_physical_inventory_id
        )';
        
        return $this->fetch($sql, [
            'p_physical_inventory_id' => $p_physical_inventory_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generatePhysicalInventoryTable(
        null|string $p_filter_by_parent_category,
        null|string $p_filter_by_costing_method,
    ) {
        $sql = 'CALL generatePhysicalInventoryTable(
            :p_filter_by_parent_category,
            :p_filter_by_costing_method
        )';
        
        return $this->fetchAll($sql, [
            'p_filter_by_parent_category'   => $p_filter_by_parent_category,
            'p_filter_by_costing_method'    => $p_filter_by_costing_method
        ]);
    }

    public function generatePhysicalInventoryOptions() {
        $sql = 'CALL generatePhysicalInventoryOptions()';
        
        return $this->fetchAll($sql);
    }

     public function generateParentCategoryOptions(
        int $p_physical_inventory_id
    ) {
        $sql = 'CALL generateParentCategoryOptions(:p_physical_inventory_id)';
        
        return $this->fetchAll($sql, [
            'p_physical_inventory_id' => $p_physical_inventory_id
        ]);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}