<?php
namespace App\Models;

use App\Core\Model;

class Supplier extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveSupplier(
        int $p_supplier_id,
        string $p_supplier_name,
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
        string $p_tax_id_number,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveSupplier(
            :p_supplier_id,
            :p_supplier_name,
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
            :p_tax_id_number,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_supplier_id'     => $p_supplier_id,
            'p_supplier_name'   => $p_supplier_name,
            'p_contact_person'  => $p_contact_person,
            'p_phone'           => $p_phone,
            'p_telephone'       => $p_telephone,
            'p_email'           => $p_email,
            'p_address'         => $p_address,
            'p_city_id'         => $p_city_id,
            'p_city_name'       => $p_city_name,
            'p_state_id'        => $p_state_id,
            'p_state_name'      => $p_state_name,
            'p_country_id'      => $p_country_id,
            'p_country_name'    => $p_country_name,
            'p_tax_id_number'   => $p_tax_id_number,
            'p_last_log_by'     => $p_last_log_by
        ]);

        return $row['new_supplier_id'] ?? null;
    }
    
    /* =============================================================================================
        SECTION 2: INSERT METHODS
    ============================================================================================= */

    /* =============================================================================================
        SECTION 3: UPDATE METHODS
    =============================================================================================  */

    public function updateSupplierArchive(
        int $p_supplier_id,
        int $p_last_log_by
    ) {
        $sql = 'CALL updateSupplierArchive(
            :p_supplier_id,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_supplier_id'     => $p_supplier_id,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateSupplierUnarchive(
        int $p_supplier_id,
        int $p_last_log_by
    ) {
        $sql = 'CALL updateSupplierUnarchive(
            :p_supplier_id,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_supplier_id'     => $p_supplier_id,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    /* =============================================================================================
        SECTION 4: FETCH METHODS
    ============================================================================================= */

    public function fetchSupplier(
        int $p_supplier_id
    ) {
        $sql = 'CALL fetchSupplier(
            :p_supplier_id
        )';
        
        return $this->fetch($sql, [
            'p_supplier_id' => $p_supplier_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteSupplier(
        int $p_supplier_id
    ) {
        $sql = 'CALL deleteSupplier(
            :p_supplier_id
        )';
        
        return $this->query($sql, [
            'p_supplier_id' => $p_supplier_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkSupplierExist(
        int $p_supplier_id
    ) {
        $sql = 'CALL checkSupplierExist(
            :p_supplier_id
        )';
        
        return $this->fetch($sql, [
            'p_supplier_id' => $p_supplier_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateSupplierTable(
        string $p_filter_by_city,
        string $p_filter_by_state,
        string $p_filter_by_country,
        string $p_filter_by_supplier_status
    ) {
        $sql = 'CALL generateSupplierTable(
            :p_filter_by_city,
            :p_filter_by_state,
            :p_filter_by_country,
            :p_filter_by_supplier_status
        )';
        
        return $this->fetchAll($sql, [
            'p_filter_by_city'              => $p_filter_by_city,
            'p_filter_by_state'             => $p_filter_by_state,
            'p_filter_by_country'           => $p_filter_by_country,
            'p_filter_by_supplier_status'   => $p_filter_by_supplier_status
        ]);
    }

    public function generateSupplierOptions() {
        $sql = 'CALL generateSupplierOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}