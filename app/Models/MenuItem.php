<?php
namespace App\Models;

use App\Core\Model;

class MenuItem extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveMenuItem(
        $p_menu_item_id,
        $p_menu_item_name,
        $p_menu_item_url,
        $p_menu_item_icon,
        $p_app_module_id,
        $p_app_module_name,
        $p_parent_id,
        $p_parent_name,
        $p_table_name,
        $p_order_sequence,
        $p_last_log_by
    )    {
        $sql = 'CALL saveMenuItem(
            :p_menu_item_id,
            :p_menu_item_name,
            :p_menu_item_url,
            :p_menu_item_icon,
            :p_app_module_id,
            :p_app_module_name,
            :p_parent_id,
            :p_parent_name,
            :p_table_name,
            :p_order_sequence,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_menu_item_id'         => $p_menu_item_id,
            'p_menu_item_name'      => $p_menu_item_name,
            'p_menu_item_url'       => $p_menu_item_url,
            'p_menu_item_icon'      => $p_menu_item_icon,
            'p_app_module_id'       => $p_app_module_id,
            'p_app_module_name'     => $p_app_module_name,
            'p_parent_id'           => $p_parent_id,
            'p_parent_name'         => $p_parent_name,
            'p_table_name'          => $p_table_name,
            'p_order_sequence'      => $p_order_sequence,
            'p_last_log_by'         => $p_last_log_by
        ]);

        return $row['new_menu_item_id'] ?? null;
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

    public function fetchMenuItem(
        $p_menu_item_id
    ) {
        $sql = 'CALL fetchMenuItem(
            :p_menu_item_id
        )';
        
        return $this->fetch($sql, [
            'p_menu_item_id' => $p_menu_item_id
        ]);
    }

    public function fetchBreadcrumb(
        $p_page_id
    ) {
        $sql = 'CALL fetchBreadcrumb(
            :p_page_id
        )';
        
        return $this->fetchAll($sql, [
            'p_page_id' => $p_page_id
        ]);
    }

    public function fetchNavBar(
        $p_user_account_id,
        $p_app_module_id
    ) {
        $sql = 'CALL fetchNavBar(
            :p_user_account_id,
            :p_app_module_id
        )';
        
        return $this->fetchAll($sql, [
            'p_user_account_id' => $p_user_account_id,
            'p_app_module_id' => $p_app_module_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteMenuItem(
        $p_menu_item_id
    ) {
        $sql = 'CALL deleteMenuItem(
            :p_menu_item_id
        )';
        
        return $this->query($sql, [
            'p_menu_item_id' => $p_menu_item_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkMenuItemExist(
        $p_menu_item_id
    ) {
        $sql = 'CALL checkMenuItemExist(
            :p_menu_item_id
        )';
        
        return $this->fetch($sql, [
            'p_menu_item_id' => $p_menu_item_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateMenuItemOptions(
        $p_menu_item_id
    ) {
        $sql = 'CALL generateMenuItemOptions(
            :p_menu_item_id
        )';
        
        return $this->fetchAll($sql, [
            'p_menu_item_id' => $p_menu_item_id
        ]);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}