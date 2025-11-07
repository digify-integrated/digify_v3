<?php
namespace App\Models;

use App\Core\Model;

class FileExtension extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveFileExtension(
        null|int $p_file_extension_id,
        string $p_file_extension_name,
        string $p_file_extension,
        int $p_file_type_id,
        string $p_file_type_name,
        int $p_last_log_by
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

        return $row['new_file_extension_id'] ?? null;
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
        int $p_file_extension_id
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
        int $p_file_extension_id
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
        int $p_file_extension_id
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

    public function generateFileExtensionTable(
        null|string $p_filter_by_file_type
    ) {
        $sql = 'CALL generateFileExtensionTable(
            :p_filter_by_file_type
        )';
        
        return $this->fetchAll($sql, [
            'p_filter_by_file_type' => $p_filter_by_file_type
        ]);
    }

    public function generateFileExtensionOptions() {
        $sql = 'CALL generateFileExtensionOptions()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}