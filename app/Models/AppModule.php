<?php
namespace App\Models;

use App\Core\Model;

class AppModule extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveAppModule(
        $p_app_module_id,
        $p_app_module_name,
        $p_app_module_description,
        $p_menu_item_id,
        $p_menu_item_name,
        $p_order_sequence,
        $p_last_log_by
    )    {
        $sql = 'CALL saveAppModule(
            :p_app_module_id,
            :p_app_module_name,
            :p_app_module_description,
            :p_menu_item_id,
            :p_menu_item_name,
            :p_order_sequence,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_app_module_id'               => $p_app_module_id,
            'p_app_module_name'             => $p_app_module_name,
            'p_app_module_description'      => $p_app_module_description,
            'p_menu_item_id'                => $p_menu_item_id,
            'p_menu_item_name'              => $p_menu_item_name,
            'p_order_sequence'              => $p_order_sequence,
            'p_last_log_by'                 => $p_last_log_by
        ]);

        return $row['new_app_module_id'] ?? null;
    }
    
    /* =============================================================================================
        SECTION 2: INSERT METHODS
    ============================================================================================= */

    /* =============================================================================================
        SECTION 3: UPDATE METHODS
    =============================================================================================  */

    public function updateAppLogo(
        $p_app_module_id,
        $p_app_logo,
        $p_last_log_by
    ) {
        $sql = 'CALL updateAppLogo(
            :p_app_module_id,
            :p_app_logo,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_app_module_id'       => $p_app_module_id,
            'p_app_logo'            => $p_app_logo,
            'p_last_log_by'         => $p_last_log_by
        ]);
    }

    /* =============================================================================================
        SECTION 4: FETCH METHODS
    ============================================================================================= */

    public function fetchAppModule(
        $p_app_module_id
    ) {
        $sql = 'CALL fetchAppModule(
            :p_app_module_id
        )';
        
        return $this->fetch($sql, [
            'p_app_module_id' => $p_app_module_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteAppModule(
        $p_app_module_id
    ) {
        $sql = 'CALL deleteAppModule(
            :p_app_module_id
        )';
        
        return $this->query($sql, [
            'p_app_module_id' => $p_app_module_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkAppModuleExist(
        $p_app_module_id
    ) {
        $sql = 'CALL checkAppModuleExist(
            :p_app_module_id
        )';
        
        return $this->fetch($sql, [
            'p_app_module_id' => $p_app_module_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateAppModuleTable() {
        $sql = 'CALL generateAppModuleTable()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}