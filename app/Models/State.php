<?php
namespace App\Models;

use App\Core\Model;

class State extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveState(
        int $p_state_id,
        string $p_state_name,
        int $p_country_id,
        string $p_country_name,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveState(
            :p_state_id,
            :p_state_name,
            :p_country_id,
            :p_country_name,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_state_id'        => $p_state_id,
            'p_state_name'      => $p_state_name,
            'p_country_id'      => $p_country_id,
            'p_country_name'    => $p_country_name,
            'p_last_log_by'     => $p_last_log_by
        ]);

        return $row['new_state_id'] ?? null;
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

    public function fetchState(
        int $p_state_id
    ) {
        $sql = 'CALL fetchState(
            :p_state_id
        )';
        
        return $this->fetch($sql, [
            'p_state_id' => $p_state_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteState(
        int $p_state_id
    ) {
        $sql = 'CALL deleteState(
            :p_state_id
        )';
        
        return $this->query($sql, [
            'p_state_id' => $p_state_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkStateExist(
        int $p_state_id
    ) {
        $sql = 'CALL checkStateExist(
            :p_state_id
        )';
        
        return $this->fetch($sql, [
            'p_state_id' => $p_state_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateStateTable(
        string $p_filter_by_country
    ) {
        $sql = 'CALL generateStateTable(
            :p_filter_by_country
        )';
        
        return $this->fetchAll($sql, [
            'p_filter_by_country' => $p_filter_by_country
        ]);
    }

    public function generateStateOptions() {
        $sql = 'CALL generateStateOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}