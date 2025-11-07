<?php
namespace App\Models;

use App\Core\Model;

class WorkLocation extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveWorkLocation(
        null|int $p_work_location_id,
        string $p_work_location_name,
        string $p_address,
        int $p_city_id,
        string $p_city_name,
        int $p_state_id,
        string $p_state_name,
        int $p_country_id,
        string $p_country_name,
        string $p_phone,
        string $p_telephone,
        string $p_email,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveWorkLocation(
            :p_work_location_id,
            :p_work_location_name,
            :p_address,
            :p_city_id,
            :p_city_name,
            :p_state_id,
            :p_state_name,
            :p_country_id,
            :p_country_name,
            :p_phone,
            :p_telephone,
            :p_email,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_work_location_id'    => $p_work_location_id,
            'p_work_location_name'  => $p_work_location_name,
            'p_address'             => $p_address,
            'p_city_id'             => $p_city_id,
            'p_city_name'           => $p_city_name,
            'p_state_id'            => $p_state_id,
            'p_state_name'          => $p_state_name,
            'p_country_id'          => $p_country_id,
            'p_country_name'        => $p_country_name,
            'p_phone'               => $p_phone,
            'p_telephone'           => $p_telephone,
            'p_email'               => $p_email,
            'p_last_log_by'         => $p_last_log_by
        ]);

        return $row['new_work_location_id'] ?? null;
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

    public function fetchWorkLocation(
        int $p_work_location_id
    ) {
        $sql = 'CALL fetchWorkLocation(
            :p_work_location_id
        )';
        
        return $this->fetch($sql, [
            'p_work_location_id' => $p_work_location_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteWorkLocation(
        int $p_work_location_id
    ) {
        $sql = 'CALL deleteWorkLocation(
            :p_work_location_id
        )';
        
        return $this->query($sql, [
            'p_work_location_id' => $p_work_location_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkWorkLocationExist(
        int $p_work_location_id
    ) {
        $sql = 'CALL checkWorkLocationExist(
            :p_work_location_id
        )';
        
        return $this->fetch($sql, [
            'p_work_location_id' => $p_work_location_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateWorkLocationTable(
        null|string $p_filter_by_city,
        null|string $p_filter_by_state,
        null|string $p_filter_by_country
    ) {
        $sql = 'CALL generateWorkLocationTable(
            :p_filter_by_city,
            :p_filter_by_state,
            :p_filter_by_country
        )';
        
        return $this->fetchAll($sql, [
            'p_filter_by_city'      => $p_filter_by_city,
            'p_filter_by_state'     => $p_filter_by_state,
            'p_filter_by_country'   => $p_filter_by_country
        ]);
    }

    public function generateWorkLocationOptions() {
        $sql = 'CALL generateWorkLocationOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}