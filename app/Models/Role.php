<?php
namespace App\Models;

use App\Core\Model;

class Role extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveRole(
        null|int $p_role_id,
        string $p_role_name,
        string $p_role_description,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveRole(
            :p_role_id,
            :p_role_name,
            :p_role_description,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_role_id'             => $p_role_id,
            'p_role_name'           => $p_role_name,
            'p_role_description'    => $p_role_description,
            'p_last_log_by'         => $p_last_log_by
        ]);

        return $row['new_role_id'] ?? null;
    }
    
    /* =============================================================================================
        SECTION 2: INSERT METHODS
    ============================================================================================= */

    public function insertRolePermission(
        int $p_role_id,
        string $p_role_name,
        int $p_menu_item_id,
        string $p_menu_item_name,
        int $p_last_log_by
    ) {
        $sql = 'CALL insertRolePermission(
            :p_role_id,
            :p_role_name,
            :p_menu_item_id,
            :p_menu_item_name,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_role_id'         => $p_role_id,
            'p_role_name'       => $p_role_name,
            'p_menu_item_id'    => $p_menu_item_id,
            'p_menu_item_name'  => $p_menu_item_name,
            'p_last_log_by'     => $p_last_log_by
        ]);
    }

    public function insertRoleSystemActionPermission(
        int $p_role_id,
        string $p_role_name,
        int $p_system_action_id,
        string $p_system_action_name,
        int $p_last_log_by
    ) {
        $sql = 'CALL insertRoleSystemActionPermission(
            :p_role_id,
            :p_role_name,
            :p_system_action_id,
            :p_system_action_name,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_role_id'             => $p_role_id,
            'p_role_name'           => $p_role_name,
            'p_system_action_id'    => $p_system_action_id,
            'p_system_action_name'  => $p_system_action_name,
            'p_last_log_by'         => $p_last_log_by
        ]);
    }

    public function insertRoleUserAccount(
        int $p_role_id,
        string $p_role_name,
        int $p_user_account_id,
        string $p_file_as,
        int $p_last_log_by
    ) {
        $sql = 'CALL insertRoleUserAccount(
            :p_role_id,
            :p_role_name,
            :p_user_account_id,
            :p_file_as,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_role_id'             => $p_role_id,
            'p_role_name'           => $p_role_name,
            'p_user_account_id'     => $p_user_account_id,
            'p_file_as'             => $p_file_as,
            'p_last_log_by'         => $p_last_log_by
        ]);
    }

    /* =============================================================================================
        SECTION 3: UPDATE METHODS
    =============================================================================================  */

    public function updateRolePermission(
        int $p_role_permission_id,
        string $p_access_type,
        int $p_access,
        int $p_last_log_by
    ) {
        $sql = 'CALL updateRolePermission(
            :p_role_permission_id,
            :p_access_type,
            :p_access,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_role_permission_id'  => $p_role_permission_id,
            'p_access_type'         => $p_access_type,
            'p_access'              => $p_access,
            'p_last_log_by'         => $p_last_log_by
        ]);
    }

    public function updateRoleSystemActionPermission(
        int $p_role_permission_id,
        int $p_system_action_access,
        int $p_last_log_by
    ) {
        $sql = 'CALL updateRoleSystemActionPermission(
            :p_role_permission_id,
            :p_system_action_access,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_role_permission_id'      => $p_role_permission_id,
            'p_system_action_access'    => $p_system_action_access,
            'p_last_log_by'             => $p_last_log_by
        ]);
    }

    /* =============================================================================================
        SECTION 4: FETCH METHODS
    ============================================================================================= */

    public function fetchRole(
        int $p_role_id
    ) {
        $sql = 'CALL fetchRole(
            :p_role_id
        )';
        
        return $this->fetch($sql, [
            'p_role_id' => $p_role_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteRole(
        int $p_role_id
    ) {
        $sql = 'CALL deleteRole(
            :p_role_id
        )';
        
        return $this->query($sql, [
            'p_role_id' => $p_role_id
        ]);
    }

    public function deleteRolePermission(
        int $p_role_permission_id
    ) {
        $sql = 'CALL deleteRolePermission(
            :p_role_permission_id
        )';
        
        return $this->query($sql, [
            'p_role_permission_id' => $p_role_permission_id
        ]);
    }

    public function deleteRoleSystemActionPermission(
        int $p_role_system_action_permission_id
    ) {
        $sql = 'CALL deleteRoleSystemActionPermission(
            :p_role_system_action_permission_id
        )';
        
        return $this->query($sql, [
            'p_role_system_action_permission_id' => $p_role_system_action_permission_id
        ]);
    }

    public function deleteRoleUserAccount(
        int $p_role_user_account_id
    ) {
        $sql = 'CALL deleteRoleUserAccount(
            :p_role_user_account_id
        )';
        
        return $this->query($sql, [
            'p_role_user_account_id' => $p_role_user_account_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkRoleExist(
        int $p_role_id
    ) {
        $sql = 'CALL checkRoleExist(
            :p_role_id
        )';
        
        return $this->fetch($sql, [
            'p_role_id' => $p_role_id
        ]);
    }

    public function checkRolePermissionExist(
        int $p_role_permission_id
    ) {
        $sql = 'CALL checkRolePermissionExist(
            :p_role_permission_id
        )';
        
        return $this->fetch($sql, [
            'p_role_permission_id' => $p_role_permission_id
        ]);
    }

    public function checkRoleSystemActionPermissionExist(
        int $p_role_system_action_permission_id
    ) {
        $sql = 'CALL checkRoleSystemActionPermissionExist(
            :p_role_system_action_permission_id
        )';
        
        return $this->fetch($sql, [
            'p_role_system_action_permission_id' => $p_role_system_action_permission_id
        ]);
    }

    public function checkRoleUserAccountExist(
        int $p_role_user_account_id
    ) {
        $sql = 'CALL checkRoleUserAccountExist(
            :p_role_user_account_id
        )';
        
        return $this->fetch($sql, [
            'p_role_user_account_id' => $p_role_user_account_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateRoleTable() {
        $sql = 'CALL generateRoleTable()';
        
        return $this->fetchAll($sql);
    }

    public function generateRoleMenuItemPermissionTable(
        int $p_role_id
    ) {
        $sql = 'CALL generateRoleMenuItemPermissionTable(
            :p_role_id
        )';
        
        return $this->fetchAll($sql, [
            'p_role_id' => $p_role_id
        ]);
    }

    public function generateRoleSystemActionPermissionTable(
        int $p_role_id
    ) {
        $sql = 'CALL generateRoleSystemActionPermissionTable(
            :p_role_id
        )';
        
        return $this->fetchAll($sql, [
            'p_role_id' => $p_role_id
        ]);
    }

    public function generateRoleUserAccountTable(
        int $p_role_id
    ) {
        $sql = 'CALL generateRoleUserAccountTable(
            :p_role_id
        )';
        
        return $this->fetchAll($sql, [
            'p_role_id' => $p_role_id
        ]);
    }

    public function generateRoleAssignedMenuItemTable(
        int $p_role_id
    ) {
        $sql = 'CALL generateRoleAssignedMenuItemTable(
            :p_role_id
        )';
        
        return $this->fetchAll($sql, [
            'p_role_id' => $p_role_id
        ]);
    }

    public function generateRoleAssignedSystemActionTable(
        int $p_role_id
    ) {
        $sql = 'CALL generateRoleAssignedSystemActionTable(
            :p_role_id
        )';
        
        return $this->fetchAll($sql, [
            'p_role_id' => $p_role_id
        ]);
    }

    public function generateUserAccountRoleDualListBoxOptions(
        int $p_user_account_id
    ) {
        $sql = 'CALL generateUserAccountRoleDualListBoxOptions(
            :p_user_account_id
        )';
        
        return $this->fetchAll($sql, [
            'p_user_account_id' => $p_user_account_id
        ]);
    }

    public function generateRoleMenuItemDualListBoxOptions(
        int $p_role_id
    ) {
        $sql = 'CALL generateRoleMenuItemDualListBoxOptions(
            :p_role_id
        )';
        
        return $this->fetchAll($sql, [
            'p_role_id' => $p_role_id
        ]);
    }

    public function generateRoleSystemActionDualListBoxOptions(
        int $p_role_id
    ) {
        $sql = 'CALL generateRoleSystemActionDualListBoxOptions(
            :p_role_id
        )';
        
        return $this->fetchAll($sql, [
            'p_role_id' => $p_role_id
        ]);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}