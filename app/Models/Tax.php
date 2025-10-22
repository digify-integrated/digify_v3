<?php
namespace App\Models;

use App\Core\Model;

class Tax extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveTax(
        $p_tax_id,
        $p_tax_name,
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
        $p_tax_id_number,
        $p_last_log_by
    )    {
        $sql = 'CALL saveTax(
            :p_tax_id,
            :p_tax_name,
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
            'p_tax_id'     => $p_tax_id,
            'p_tax_name'   => $p_tax_name,
            'p_contact_person'  => $p_contact_person,
            'p_address'         => $p_address,
            'p_phone'           => $p_phone,
            'p_telephone'       => $p_telephone,
            'p_email'           => $p_email,
            'p_city_id'         => $p_city_id,
            'p_city_name'       => $p_city_name,
            'p_state_id'        => $p_state_id,
            'p_state_name'      => $p_state_name,
            'p_country_id'      => $p_country_id,
            'p_country_name'    => $p_country_name,
            'p_tax_id_number'   => $p_tax_id_number,
            'p_last_log_by'     => $p_last_log_by
        ]);

        return $row['new_tax_id'] ?? null;
    }
    
    /* =============================================================================================
        SECTION 2: INSERT METHODS
    ============================================================================================= */

    /* =============================================================================================
        SECTION 3: UPDATE METHODS
    =============================================================================================  */

    public function updateTaxArchive(
        $p_tax_id,
        $p_last_log_by
    ) {
        $sql = 'CALL updateTaxArchive(
            :p_tax_id,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_tax_id'     => $p_tax_id,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function updateTaxUnarchive(
        $p_tax_id,
        $p_last_log_by
    ) {
        $sql = 'CALL updateTaxUnarchive(
            :p_tax_id,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_tax_id'     => $p_tax_id,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    /* =============================================================================================
        SECTION 4: FETCH METHODS
    ============================================================================================= */

    public function fetchTax(
        $p_tax_id
    ) {
        $sql = 'CALL fetchTax(
            :p_tax_id
        )';
        
        return $this->fetch($sql, [
            'p_tax_id' => $p_tax_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteTax(
        $p_tax_id
    ) {
        $sql = 'CALL deleteTax(
            :p_tax_id
        )';
        
        return $this->query($sql, [
            'p_tax_id' => $p_tax_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkTaxExist(
        $p_tax_id
    ) {
        $sql = 'CALL checkTaxExist(
            :p_tax_id
        )';
        
        return $this->fetch($sql, [
            'p_tax_id' => $p_tax_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateTaxTable(
        $p_filter_by_city,
        $p_filter_by_state,
        $p_filter_by_country,
        $p_filter_by_tax_status
    ) {
        $sql = 'CALL generateTaxTable(
            :p_filter_by_city,
            :p_filter_by_state,
            :p_filter_by_country,
            :p_filter_by_tax_status
        )';
        
        return $this->fetchAll($sql, [
            'p_filter_by_city'              => $p_filter_by_city,
            'p_filter_by_state'             => $p_filter_by_state,
            'p_filter_by_country'           => $p_filter_by_country,
            'p_filter_by_tax_status'   => $p_filter_by_tax_status
        ]);
    }

    public function generateTaxOptions() {
        $sql = 'CALL generateTaxOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}