<?php
namespace App\Models;

use App\Core\Model;

class Warehouse extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveWarehouse(
        $p_warehouse_id,
        $p_warehouse_name,
        $p_short_name,
        $p_contact_person,
        $p_phone,
        $p_telephone,
        $p_email,
        $p_address,
        $p_city_id,
        $p_city_name,
        $p_state_id,
        $p_state_name,
        $p_country_id,
        $p_country_name,
        $p_warehouse_type_id,
        $p_warehouse_type_name,
        $p_last_log_by
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
        $p_warehouse_id,
        $p_last_log_by
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
        $p_warehouse_id,
        $p_last_log_by
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
        $p_warehouse_id
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
        $p_warehouse_id
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
        $p_warehouse_id
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
        $p_filter_by_warehouse_type,
        $p_filter_by_city,
        $p_filter_by_state,
        $p_filter_by_country,
        $p_filter_by_warehouse_status
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