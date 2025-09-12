<?php
namespace App\Models;

use App\Core\Model;

class FileType extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveFileType(
        $p_file_type_id,
        $p_file_type_name,
        $p_last_log_by
    )    {
        $sql = 'CALL saveFileType(
            :p_file_type_id,
            :p_file_type_name,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_file_type_id'    => $p_file_type_id,
            'p_file_type_name'  => $p_file_type_name,
            'p_last_log_by'     => $p_last_log_by
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

    public function fetchFileType(
        $p_file_type_id
    ) {
        $sql = 'CALL fetchFileType(
            :p_file_type_id
        )';
        
        return $this->fetch($sql, [
            'p_file_type_id' => $p_file_type_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteFileType(
        $p_file_type_id
    ) {
        $sql = 'CALL deleteFileType(
            :p_file_type_id
        )';
        
        return $this->query($sql, [
            'p_file_type_id' => $p_file_type_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkFileTypeExist(
        $p_file_type_id
    ) {
        $sql = 'CALL checkFileTypeExist(
            :p_file_type_id
        )';
        
        return $this->fetch($sql, [
            'p_file_type_id' => $p_file_type_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateFileTypeTable() {
        $sql = 'CALL generateFileTypeTable()';
        
        return $this->fetchAll($sql);
    }

    public function generateFileTypeOptions() {
        $sql = 'CALL generateFileTypeOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}