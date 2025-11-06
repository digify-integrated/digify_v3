<?php
namespace App\Models;

use App\Core\Model;

class Warehouse extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveWarehouse(
        int $p_warehouse_id,
        string $p_warehouse_name,
        string $p_short_name,
        string $p_contact_person,
        string $p_phone,
        string $p_telephone,
        string $p_email,
        string $p_address,
        int $p_city_id,
        string $p_city_name,
        int $p_state_id,
        string $p_state_name,
        int $p_country_id,
        string $p_country_name,
        int $p_warehouse_type_id,
        string $p_warehouse_type_name,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveWarehouse(
            :p_warehouse_id,
            :p_warehouse_name,
            :p_short_name,
            :p_contact_person,
            :p_phone,
            :p_telephone,
            :p_email,
            :p_address,
            :p_city_id,
            :p_city_name,
            :p_state_id,
            :p_state_name,
            :p_country_id,
            :p_country_name,
            :p_warehouse_type_id,
            :p_warehouse_type_name,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_warehouse_id'            => $p_warehouse_id,
            'p_warehouse_name'          => $p_warehouse_name,
            'p_short_name'              => $p_short_name,
            'p_contact_person'          => $p_contact_person,
            'p_phone'                   => $p_phone,
            'p_telephone'               => $p_telephone,
            'p_email'                   => $p_email,
            'p_address'                 => $p_address,
            'p_city_id'                 => $p_city_id,
            'p_city_name'               => $p_city_name,
            'p_state_id'                => $p_state_id,
            'p_state_name'              => $p_state_name,
            'p_country_id'              => $p_country_id,
            'p_country_name'            => $p_country_name,
            'p_warehouse_type_id'       => $p_warehouse_type_id,
            'p_warehouse_type_name'     => $p_warehouse_type_name,
            'p_last_log_by'             => $p_last_log_by
        ]);

        return $row['new_warehouse_id'] ?? null;
    }
    
    /* =============================================================================================
        SECTION 2: INSERT METHODS
    ============================================================================================= */

    /* =============================================================================================
        SECTION 3: UPDATE METHODS
    =============================================================================================  */

    public function updateWarehouseArchive(
        int $p_warehouse_id,
        int $p_last_log_by
    ) {
        $sql = 'CALL updateWarehouseArchive(
            :p_warehouse_id,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_warehouse_id'    => $p_warehouse_id,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateWarehouseUnarchive(
        int $p_warehouse_id,
        int $p_last_log_by
    ) {
        $sql = 'CALL updateWarehouseUnarchive(
            :p_warehouse_id,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_warehouse_id'    => $p_warehouse_id,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    /* =============================================================================================
        SECTION 4: FETCH METHODS
    ============================================================================================= */

    public function fetchWarehouse(
        int $p_warehouse_id
    ) {
        $sql = 'CALL fetchWarehouse(
            :p_warehouse_id
        )';
        
        return $this->fetch($sql, [
            'p_warehouse_id' => $p_warehouse_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteWarehouse(
        int $p_warehouse_id
    ) {
        $sql = 'CALL deleteWarehouse(
            :p_warehouse_id
        )';
        
        return $this->query($sql, [
            'p_warehouse_id' => $p_warehouse_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkWarehouseExist(
        int $p_warehouse_id
    ) {
        $sql = 'CALL checkWarehouseExist(
            :p_warehouse_id
        )';
        
        return $this->fetch($sql, [
            'p_warehouse_id' => $p_warehouse_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateWarehouseTable(
        string $p_filter_by_warehouse_type,
        string $p_filter_by_city,
        string $p_filter_by_state,
        string $p_filter_by_country,
        string $p_filter_by_warehouse_status
    ) {
        $sql = 'CALL generateWarehouseTable(
            :p_filter_by_warehouse_type,
            :p_filter_by_city,
            :p_filter_by_state,
            :p_filter_by_country,
            :p_filter_by_warehouse_status
        )';
        
        return $this->fetchAll($sql, [
            'p_filter_by_warehouse_type'    => $p_filter_by_warehouse_type,
            'p_filter_by_city'              => $p_filter_by_city,
            'p_filter_by_state'             => $p_filter_by_state,
            'p_filter_by_country'           => $p_filter_by_country,
            'p_filter_by_warehouse_status'  => $p_filter_by_warehouse_status
        ]);
    }

    public function generateWarehouseOptions() {
        $sql = 'CALL generateWarehouseOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}