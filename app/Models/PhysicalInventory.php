<?php
namespace App\Models;

use App\Core\Model;

class PhysicalInventory extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */
    
    /* =============================================================================================
        SECTION 2: INSERT METHODS
    ============================================================================================= */

    public function insertPhysicalInventory(
        null|string|int $p_product_id,
        null|string $p_product_name,
        string $p_quantity_on_hand,
        string $p_inventory_count,
        string $p_inventory_difference,
        string $p_inventory_date,
        string $p_remarks,
        int $p_last_log_by
    )    {
        $sql = 'CALL insertPhysicalInventory(
            :p_product_id,
            :p_product_name,
            :p_quantity_on_hand,
            :p_inventory_count,
            :p_inventory_difference,
            :p_inventory_date,
            :p_remarks,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_product_id'              => $p_product_id,
            'p_product_name'            => $p_product_name,
            'p_quantity_on_hand'        => $p_quantity_on_hand,
            'p_inventory_count'         => $p_inventory_count,
            'p_inventory_date'          => $p_inventory_date,
            'p_inventory_difference'    => $p_inventory_difference,
            'p_remarks'                 => $p_remarks,
            'p_last_log_by'             => $p_last_log_by
        ]);

        return $row['new_physical_inventory_id'] ?? null;
    }

    /* =============================================================================================
        SECTION 3: UPDATE METHODS
    =============================================================================================  */

    public function updatePhysicalInventory(
        int $p_physical_inventory_id,
        string $p_inventory_count,
        string $p_inventory_difference,
        string $p_inventory_date,
        string $p_remarks,
        int $p_last_log_by
    )    {
        $sql = 'CALL updatePhysicalInventory(
            :p_physical_inventory_id,
            :p_inventory_count,
            :p_inventory_difference,
            :p_inventory_date,
            :p_remarks,
            :p_last_log_by
        )';

        return $this->query($sql, [
            'p_physical_inventory_id'   => $p_physical_inventory_id,
            'p_inventory_count'         => $p_inventory_count,
            'p_inventory_difference'    => $p_inventory_difference,
            'p_inventory_date'          => $p_inventory_date,
            'p_remarks'                 => $p_remarks,
            'p_last_log_by'             => $p_last_log_by
        ]);
    }

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
        null|string $p_filter_by_product,
        null|string $p_inventory_start_date,
        null|string $p_inventory_end_date,
        null|string $p_physical_inventory_status,
    ) {
        $sql = 'CALL generatePhysicalInventoryTable(
            :p_filter_by_product,
            :p_inventory_start_date,
            :p_inventory_end_date,
            :p_physical_inventory_status
        )';
        
        return $this->fetchAll($sql, [
            'p_filter_by_product'           => $p_filter_by_product,
            'p_inventory_start_date'        => $p_inventory_start_date,
            'p_inventory_end_date'          => $p_inventory_end_date,
            'p_physical_inventory_status'   => $p_physical_inventory_status
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
        SECTION 8: CUSTOM METHODS
    ============================================================================================= */

    public function applyPhysicalInventoryAdjustment(
        int $p_physical_inventory_id,
        int $p_last_log_by
    ) {
        $sql = 'CALL applyPhysicalInventoryAdjustment(
            :p_physical_inventory_id,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_physical_inventory_id' => $p_physical_inventory_id,
            'p_last_log_by' => $p_last_log_by
        ]);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}