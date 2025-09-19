<?php
namespace App\Models;

use App\Core\Model;

class Company extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveCompany(
        $p_company_id,
        $p_company_name,
        $p_address,
        $p_city_id,
        $p_city_name,
        $p_state_id,
        $p_state_name,
        $p_country_id,
        $p_country_name,
        $p_tax_id,
        $p_currency_id,
        $p_currency_name,
        $p_phone,
        $p_telephone,
        $p_email,
        $p_website,
        $p_last_log_by
    )    {
        $sql = 'CALL saveCompany(
            :p_company_id,
            :p_company_name,
            :p_address,
            :p_city_id,
            :p_city_name,
            :p_state_id,
            :p_state_name,
            :p_country_id,
            :p_country_name,
            :p_tax_id,
            :p_currency_id,
            :p_currency_name,
            :p_phone,
            :p_telephone,
            :p_email,
            :p_website,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_company_id'      => $p_company_id,
            'p_company_name'    => $p_company_name,
            'p_address'         => $p_address,
            'p_city_id'         => $p_city_id,
            'p_city_name'       => $p_city_name,
            'p_state_id'        => $p_state_id,
            'p_state_name'      => $p_state_name,
            'p_country_id'      => $p_country_id,
            'p_country_name'    => $p_country_name,
            'p_tax_id'          => $p_tax_id,
            'p_currency_id'     => $p_currency_id,
            'p_currency_name'   => $p_currency_name,
            'p_phone'           => $p_phone,
            'p_telephone'       => $p_telephone,
            'p_email'           => $p_email,
            'p_website'         => $p_website,
            'p_last_log_by'     => $p_last_log_by
        ]);

        return $row['new_company_id'] ?? null;
    }
    
    /* =============================================================================================
        SECTION 2: INSERT METHODS
    ============================================================================================= */

    /* =============================================================================================
        SECTION 3: UPDATE METHODS
    =============================================================================================  */

    public function updateCompanyLogo(
        $p_company_id,
        $p_company_logo,
        $p_last_log_by
    ) {
        $sql = 'CALL updateCompanyLogo(
            :p_company_id,
            :p_company_logo,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_company_id'      => $p_company_id,
            'p_company_logo'    => $p_company_logo,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    /* =============================================================================================
        SECTION 4: FETCH METHODS
    ============================================================================================= */

    public function fetchCompany(
        $p_company_id
    ) {
        $sql = 'CALL fetchCompany(
            :p_company_id
        )';
        
        return $this->fetch($sql, [
            'p_company_id' => $p_company_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteCompany(
        $p_company_id
    ) {
        $sql = 'CALL deleteCompany(
            :p_company_id
        )';
        
        return $this->query($sql, [
            'p_company_id' => $p_company_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkCompanyExist(
        $p_company_id
    ) {
        $sql = 'CALL checkCompanyExist(
            :p_company_id
        )';
        
        return $this->fetch($sql, [
            'p_company_id' => $p_company_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateCompanyTable(
        $p_filter_by_city,
        $p_filter_by_state,
        $p_filter_by_country,
        $p_filter_by_currency
    ) {
        $sql = 'CALL generateCompanyTable(
            :p_filter_by_city,
            :p_filter_by_state,
            :p_filter_by_country,
            :p_filter_by_currency
        )';
        
        return $this->fetchAll($sql, [
            'p_filter_by_city'      => $p_filter_by_city,
            'p_filter_by_state'     => $p_filter_by_state,
            'p_filter_by_country'   => $p_filter_by_country,
            'p_filter_by_currency'  => $p_filter_by_currency
        ]);
    }

    public function generateCompanyOptions() {
        $sql = 'CALL generateCompanyOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}