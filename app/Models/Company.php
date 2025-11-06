<?php
namespace App\Models;

use App\Core\Model;

class Company extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveCompany(
        int $p_company_id,
        string $p_company_name,
        string $p_address,
        int $p_city_id,
        string $p_city_name,
        int $p_state_id,
        string $p_state_name,
        int $p_country_id,
        string $p_country_name,
        string $p_tax_id,
        int $p_currency_id,
        string $p_currency_name,
        int $p_phone,
        string $p_telephone,
        string $p_email,
        string $p_website,
        int $p_last_log_by
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
        int $p_company_id,
        string $p_company_logo,
        int $p_last_log_by
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
        int $p_company_id
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
        int $p_company_id
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
        int $p_company_id
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
        string $p_filter_by_city,
        string $p_filter_by_state,
        string $p_filter_by_country,
        string $p_filter_by_currency
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