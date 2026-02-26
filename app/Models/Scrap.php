<?php
namespace App\Models;

use App\Core\Model;

class Scrap extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */
    
    /* =============================================================================================
        SECTION 2: INSERT METHODS
    ============================================================================================= */

    public function insertScrap(
        null|string|int $p_product_id,
        null|string $p_product_name,
        string $p_quantity_on_hand,
        string $p_inventory_count,
        string $p_inventory_difference,
        string $p_inventory_date,
        string $p_remarks,
        int $p_last_log_by
    )    {
        $sql = 'CALL insertScrap(
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

        return $row['new_scrap_id'] ?? null;
    }

    /* =============================================================================================
        SECTION 3: UPDATE METHODS
    =============================================================================================  */

    public function updateScrap(
        int $p_scrap_id,
        string $p_inventory_count,
        string $p_inventory_difference,
        string $p_inventory_date,
        string $p_remarks,
        int $p_last_log_by
    )    {
        $sql = 'CALL updateScrap(
            :p_scrap_id,
            :p_inventory_count,
            :p_inventory_difference,
            :p_inventory_date,
            :p_remarks,
            :p_last_log_by
        )';

        return $this->query($sql, [
            'p_scrap_id'   => $p_scrap_id,
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

    public function fetchScrap(
        null|string|int $p_scrap_id
    ) {
        $sql = 'CALL fetchScrap(
            :p_scrap_id
        )';
        
        return $this->fetch($sql, [
            'p_scrap_id' => $p_scrap_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteScrap(
        int $p_scrap_id
    ) {
        $sql = 'CALL deleteScrap(
            :p_scrap_id
        )';
        
        return $this->query($sql, [
            'p_scrap_id' => $p_scrap_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkScrapExist(
        int $p_scrap_id
    ) {
        $sql = 'CALL checkScrapExist(
            :p_scrap_id
        )';
        
        return $this->fetch($sql, [
            'p_scrap_id' => $p_scrap_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateScrapTable(
        null|string $p_filter_by_product,
        null|string $p_inventory_start_date,
        null|string $p_inventory_end_date,
        null|string $p_scrap_status,
    ) {
        $sql = 'CALL generateScrapTable(
            :p_filter_by_product,
            :p_inventory_start_date,
            :p_inventory_end_date,
            :p_scrap_status
        )';
        
        return $this->fetchAll($sql, [
            'p_filter_by_product'           => $p_filter_by_product,
            'p_inventory_start_date'        => $p_inventory_start_date,
            'p_inventory_end_date'          => $p_inventory_end_date,
            'p_scrap_status'   => $p_scrap_status
        ]);
    }

    public function generateScrapOptions() {
        $sql = 'CALL generateScrapOptions()';
        
        return $this->fetchAll($sql);
    }

     public function generateParentCategoryOptions(
        int $p_scrap_id
    ) {
        $sql = 'CALL generateParentCategoryOptions(:p_scrap_id)';
        
        return $this->fetchAll($sql, [
            'p_scrap_id' => $p_scrap_id
        ]);
    }

    /* =============================================================================================
        SECTION 8: CUSTOM METHODS
    ============================================================================================= */

    public function applyScrapAdjustment(
        int $p_scrap_id,
        int $p_last_log_by
    ) {
        $sql = 'CALL applyScrapAdjustment(
            :p_scrap_id,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_scrap_id' => $p_scrap_id,
            'p_last_log_by' => $p_last_log_by
        ]);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}