<?php
namespace App\Models;

use App\Core\Model;

class DepartureReason extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveDepartureReason(
        null|int $p_departure_reason_id,
        string $p_departure_reason_name,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveDepartureReason(
            :p_departure_reason_id,
            :p_departure_reason_name,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_departure_reason_id'     => $p_departure_reason_id,
            'p_departure_reason_name'   => $p_departure_reason_name,
            'p_last_log_by'             => $p_last_log_by
        ]);

        return $row['new_departure_reason_id'] ?? null;
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

    public function fetchDepartureReason(
        int $p_departure_reason_id
    ) {
        $sql = 'CALL fetchDepartureReason(
            :p_departure_reason_id
        )';
        
        return $this->fetch($sql, [
            'p_departure_reason_id' => $p_departure_reason_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteDepartureReason(
        int $p_departure_reason_id
    ) {
        $sql = 'CALL deleteDepartureReason(
            :p_departure_reason_id
        )';
        
        return $this->query($sql, [
            'p_departure_reason_id' => $p_departure_reason_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkDepartureReasonExist(
        int $p_departure_reason_id
    ) {
        $sql = 'CALL checkDepartureReasonExist(
            :p_departure_reason_id
        )';
        
        return $this->fetch($sql, [
            'p_departure_reason_id' => $p_departure_reason_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateDepartureReasonTable() {
        $sql = 'CALL generateDepartureReasonTable()';
        
        return $this->fetchAll($sql);
    }

    public function generateDepartureReasonOptions() {
        $sql = 'CALL generateDepartureReasonOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}