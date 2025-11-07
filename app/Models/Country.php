<?php
namespace App\Models;

use App\Core\Model;

class Country extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveCountry(
        null|int $p_country_id,
        string $p_country_name,
        string $p_country_code,
        string $p_phone_code,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveCountry(
            :p_country_id,
            :p_country_name,
            :p_country_code,
            :p_phone_code,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_country_id'      => $p_country_id,
            'p_country_name'    => $p_country_name,
            'p_country_code'    => $p_country_code,
            'p_phone_code'      => $p_phone_code,
            'p_last_log_by'     => $p_last_log_by
        ]);

        return $row['new_country_id'] ?? null;
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

    public function fetchCountry(
        int $p_country_id
    ) {
        $sql = 'CALL fetchCountry(
            :p_country_id
        )';
        
        return $this->fetch($sql, [
            'p_country_id' => $p_country_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteCountry(
        int $p_country_id
    ) {
        $sql = 'CALL deleteCountry(
            :p_country_id
        )';
        
        return $this->query($sql, [
            'p_country_id' => $p_country_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkCountryExist(
        int $p_country_id
    ) {
        $sql = 'CALL checkCountryExist(
            :p_country_id
        )';
        
        return $this->fetch($sql, [
            'p_country_id' => $p_country_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateCountryTable() {
        $sql = 'CALL generateCountryTable()';
        
        return $this->fetchAll($sql);
    }

    public function generateCountryOptions() {
        $sql = 'CALL generateCountryOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}