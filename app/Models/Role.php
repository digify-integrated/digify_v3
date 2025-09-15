<?php
namespace App\Models;

use App\Core\Model;

class Role extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveRole(
        $p_role_id,
        $p_role_name,
        $p_role_description,
        $p_last_log_by
    )    {
        $sql = 'CALL saveRole(
            :p_role_id,
            :p_role_name,
            :p_role_description,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_role_id'               => $p_role_id,
            'p_role_name'             => $p_role_name,
            'p_role_description'      => $p_role_description,
            'p_last_log_by'           => $p_last_log_by
        ]);

        return $row['new_role_id'] ?? null;
    }
    
    /* =============================================================================================
        SECTION 2: INSERT METHODS
    ============================================================================================= */

    public function insertRolePermission(
        $p_role_id,
        $p_role_name,
        $p_menu_item_id,
        $p_menu_item_name,
        $p_last_log_by
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
        $p_role_id,
        $p_role_name,
        $p_system_action_id,
        $p_system_action_name,
        $p_last_log_by
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
        $p_role_id,
        $p_role_name,
        $p_user_account_id,
        $p_file_as,
        $p_last_log_by
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
        $p_role_permission_id,
        $p_access_type,
        $p_access,
        $p_last_log_by
    ) {
        $sql = 'CALL updateRolePermission(
            :p_role_permission_id,
            :p_access_type,
            :p_access,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_role_permission_id'      => $p_role_permission_id,
            'p_access_type'             => $p_access_type,
            'p_access'                  => $p_access,
            'p_last_log_by'             => $p_last_log_by
        ]);
    }

    public function updateRoleSystemActionPermission(
        $p_role_permission_id,
        $p_system_action_access,
        $p_last_log_by
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
        $p_role_id
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
        $p_role_id
    ) {
        $sql = 'CALL deleteRole(
            :p_role_id
        )';
        
        return $this->query($sql, [
            'p_role_id' => $p_role_id
        ]);
    }

    public function deleteRolePermission(
        $p_role_permission_id
    ) {
        $sql = 'CALL deleteRolePermission(
            :p_role_permission_id
        )';
        
        return $this->query($sql, [
            'p_role_permission_id' => $p_role_permission_id
        ]);
    }

    public function deleteRoleSystemActionPermission(
        $p_role_system_action_permission_id
    ) {
        $sql = 'CALL deleteRoleSystemActionPermission(
            :p_role_system_action_permission_id
        )';
        
        return $this->query($sql, [
            'p_role_system_action_permission_id' => $p_role_system_action_permission_id
        ]);
    }

    public function deleteRoleUserAccount(
        $p_role_user_account_id
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
        $p_role_id
    ) {
        $sql = 'CALL checkRoleExist(
            :p_role_id
        )';
        
        return $this->fetch($sql, [
            'p_role_id' => $p_role_id
        ]);
    }

    public function checkRolePermissionExist(
        $p_role_permission_id
    ) {
        $sql = 'CALL checkRolePermissionExist(
            :p_role_permission_id
        )';
        
        return $this->fetch($sql, [
            'p_role_permission_id' => $p_role_permission_id
        ]);
    }

    public function checkRoleSystemActionPermissionExist(
        $p_role_system_action_permission_id
    ) {
        $sql = 'CALL checkRoleSystemActionPermissionExist(
            :p_role_system_action_permission_id
        )';
        
        return $this->fetch($sql, [
            'p_role_system_action_permission_id' => $p_role_system_action_permission_id
        ]);
    }

    public function checkRoleUserAccountExist(
        $p_role_user_account_id
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
        $p_role_id
    ) {
        $sql = 'CALL generateRoleMenuItemPermissionTable(
            :p_role_id
        )';
        
        return $this->fetchAll($sql, [
            'p_role_id' => $p_role_id
        ]);
    }

    public function generateRoleSystemActionPermissionTable(
        $p_role_id
    ) {
        $sql = 'CALL generateRoleSystemActionPermissionTable(
            :p_role_id
        )';
        
        return $this->fetchAll($sql, [
            'p_role_id' => $p_role_id
        ]);
    }

    public function generateRoleUserAccountTable(
        $p_role_id
    ) {
        $sql = 'CALL generateRoleUserAccountTable(
            :p_role_id
        )';
        
        return $this->fetchAll($sql, [
            'p_role_id' => $p_role_id
        ]);
    }

    public function generateUserAccountRoleList(
        $p_user_account_id
    ) {
        $sql = 'CALL generateUserAccountRoleList(
            :p_user_account_id
        )';
        
        return $this->fetchAll($sql, [
            'p_user_account_id' => $p_user_account_id
        ]);
    }

    public function generateRoleAssignedMenuItemTable(
        $p_role_id
    ) {
        $sql = 'CALL generateRoleAssignedMenuItemTable(
            :p_role_id
        )';
        
        return $this->fetchAll($sql, [
            'p_role_id' => $p_role_id
        ]);
    }

    public function generateRoleAssignedSystemActionTable(
        $p_role_id
    ) {
        $sql = 'CALL generateRoleAssignedSystemActionTable(
            :p_role_id
        )';
        
        return $this->fetchAll($sql, [
            'p_role_id' => $p_role_id
        ]);
    }

    public function generateUserAccountRoleDualListBoxOptions(
        $p_user_account_id
    ) {
        $sql = 'CALL generateUserAccountRoleDualListBoxOptions(
            :p_user_account_id
        )';
        
        return $this->fetchAll($sql, [
            'p_user_account_id' => $p_user_account_id
        ]);
    }

    public function generateRoleMenuItemDualListBoxOptions(
        $p_role_id
    ) {
        $sql = 'CALL generateRoleMenuItemDualListBoxOptions(
            :p_role_id
        )';
        
        return $this->fetchAll($sql, [
            'p_role_id' => $p_role_id
        ]);
    }

    public function generateRoleSystemActionDualListBoxOptions(
        $p_role_id
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