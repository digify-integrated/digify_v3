<?php
namespace App\Models;

use App\Core\Model;

class FileExtension extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveFileExtension(
        $p_file_extension_id,
        $p_file_extension_name,
        $p_file_extension,
        $p_file_type_id,
        $p_file_type_name,
        $p_last_log_by
    )    {
        $sql = 'CALL saveFileExtension(
            :p_file_extension_id,
            :p_file_extension_name,
            :p_file_extension,
            :p_file_type_id,
            :p_file_type_name,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_file_extension_id'       => $p_file_extension_id,
            'p_file_extension_name'     => $p_file_extension_name,
            'p_file_extension'          => $p_file_extension,
            'p_file_type_id'            => $p_file_type_id,
            'p_file_type_name'          => $p_file_type_name,
            'p_last_log_by'             => $p_last_log_by
        ]);

        return $row['new_app_module_id'] ?? null;
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

    public function fetchFileExtension(
        $p_file_extension_id
    ) {
        $sql = 'CALL fetchFileExtension(
            :p_file_extension_id
        )';
        
        return $this->fetch($sql, [
            'p_file_extension_id' => $p_file_extension_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteFileExtension(
        $p_file_extension_id
    ) {
        $sql = 'CALL deleteFileExtension(
            :p_file_extension_id
        )';
        
        return $this->query($sql, [
            'p_file_extension_id' => $p_file_extension_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkFileExtensionExist(
        $p_file_extension_id
    ) {
        $sql = 'CALL checkFileExtensionExist(
            :p_file_extension_id
        )';
        
        return $this->fetch($sql, [
            'p_file_extension_id' => $p_file_extension_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateFileExtensionTable() {
        $sql = 'CALL generateFileExtensionTable()';
        
        return $this->fetchAll($sql);
    }

    public function generateFileExtensionOptions() {
        $sql = 'CALL generateFileExtensionOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}