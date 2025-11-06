<?php
namespace App\Models;

use App\Core\Model;

class SystemAction extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveSystemAction(
        int $p_system_action_id,
        string $p_system_action_name,
        string $p_system_action_description,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveSystemAction(
            :p_system_action_id,
            :p_system_action_name,
            :p_system_action_description,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_system_action_id'            => $p_system_action_id,
            'p_system_action_name'          => $p_system_action_name,
            'p_system_action_description'   => $p_system_action_description,
            'p_last_log_by'                 => $p_last_log_by
        ]);

        return $row['new_system_action_id'] ?? null;
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

    public function fetchSystemAction(
        int $p_system_action_id
    ) {
        $sql = 'CALL fetchSystemAction(
            :p_system_action_id
        )';
        
        return $this->fetch($sql, [
            'p_system_action_id' => $p_system_action_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteSystemAction(
        int $p_system_action_id
    ) {
        $sql = 'CALL deleteSystemAction(
            :p_system_action_id
        )';
        
        return $this->query($sql, [
            'p_system_action_id' => $p_system_action_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkSystemActionExist(
        int $p_system_action_id
    ) {
        $sql = 'CALL checkSystemActionExist(
            :p_system_action_id
        )';
        
        return $this->fetch($sql, [
            'p_system_action_id' => $p_system_action_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateSystemActionTable() {
        $sql = 'CALL generateSystemActionTable()';
        
        return $this->fetchAll($sql);
    }

    public function generateSystemActionOptions() {
        $sql = 'CALL generateSystemActionOptions()';
        
        return $this->fetchAll($sql);
    }

    public function generateSystemActionAssignedRoleTable(
        int $p_system_action_id
    ) {
        $sql = 'CALL generateSystemActionAssignedRoleTable(
            :p_system_action_id
        )';
        
        return $this->fetchAll($sql, [
            'p_system_action_id' => $p_system_action_id
        ]);
    }

    public function generateSystemActionRoleDualListBoxOptions(
        int $p_system_action_id
    ) {
        $sql = 'CALL generateSystemActionRoleDualListBoxOptions(
            :p_system_action_id
        )';
        
        return $this->fetchAll($sql, [
            'p_system_action_id' => $p_system_action_id
        ]);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}