<?php
namespace App\Models;

use App\Core\Model;

class City extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveCity(
        $p_city_id,
        $p_city_name,
        $p_state_id,
        $p_state_name,
        $p_country_id,
        $p_country_name,
        $p_last_log_by
    )    {
        $sql = 'CALL saveCity(
            :p_city_id,
            :p_city_name,
            :p_state_id,
            :p_state_name,
            :p_country_id,
            :p_country_name,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_city_id'         => $p_city_id,
            'p_city_name'       => $p_city_name,
            'p_state_id'        => $p_state_id,
            'p_state_name'      => $p_state_name,
            'p_country_id'      => $p_country_id,
            'p_country_name'    => $p_country_name,
            'p_last_log_by'     => $p_last_log_by
        ]);

        return $row['new_city_id'] ?? null;
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

    public function fetchCity(
        $p_city_id
    ) {
        $sql = 'CALL fetchCity(
            :p_city_id
        )';
        
        return $this->fetch($sql, [
            'p_city_id' => $p_city_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteCity(
        $p_city_id
    ) {
        $sql = 'CALL deleteCity(
            :p_city_id
        )';
        
        return $this->query($sql, [
            'p_city_id' => $p_city_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkCityExist(
        $p_city_id
    ) {
        $sql = 'CALL checkCityExist(
            :p_city_id
        )';
        
        return $this->fetch($sql, [
            'p_city_id' => $p_city_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateCityTable(
        $p_filter_by_state,
        $p_filter_by_country
    ) {
        $sql = 'CALL generateCityTable(
            :p_filter_by_state,
            :p_filter_by_country
        )';
        
        return $this->fetchAll($sql, [
            'p_filter_by_state'     => $p_filter_by_state,
            'p_filter_by_country'   => $p_filter_by_country
        ]);
    }

    public function generateCityOptions() {
        $sql = 'CALL generateCityOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}