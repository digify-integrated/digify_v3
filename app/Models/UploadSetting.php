<?php
namespace App\Models;

use App\Core\Model;

class UploadSetting extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveUploadSetting(
        int $p_upload_setting_id,
        string $p_upload_setting_name,
        string $p_upload_setting_description,
        string $p_max_file_size,
        int $p_last_log_by
    )    {
        $sql = 'CALL saveUploadSetting(
            :p_upload_setting_id,
            :p_upload_setting_name,
            :p_upload_setting_description,
            :p_max_file_size,
            :p_last_log_by
        )';

        $row = $this->fetch($sql, [
            'p_upload_setting_id'           => $p_upload_setting_id,
            'p_upload_setting_name'         => $p_upload_setting_name,
            'p_upload_setting_description'  => $p_upload_setting_description,
            'p_max_file_size'               => $p_max_file_size,
            'p_last_log_by'                 => $p_last_log_by
        ]);

        return $row['new_upload_setting_id'] ?? null;
    }
    
    /* =============================================================================================
        SECTION 2: INSERT METHODS
    ============================================================================================= */

    public function insertUploadSettingFileExtension(
        int $p_upload_setting_id,
        string $p_upload_setting_name,
        int $p_file_extension_id,
        string $p_file_extension_name,
        string $p_file_extension,
        int $p_last_log_by
    ) {
        $sql = 'CALL insertUploadSettingFileExtension(
            :p_upload_setting_id,
            :p_upload_setting_name,
            :p_file_extension_id,
            :p_file_extension_name,
            :p_file_extension,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_upload_setting_id'       => $p_upload_setting_id,
            'p_upload_setting_name'     => $p_upload_setting_name,
            'p_file_extension_id'       => $p_file_extension_id,
            'p_file_extension_name'     => $p_file_extension_name,
            'p_file_extension'          => $p_file_extension,
            'p_last_log_by'             => $p_last_log_by
        ]);
    }

    /* =============================================================================================
        SECTION 3: UPDATE METHODS
    =============================================================================================  */

    /* =============================================================================================
        SECTION 4: FETCH METHODS
    ============================================================================================= */

    public function fetchUploadSetting(
        int $p_upload_setting_id
    ) {
        $sql = 'CALL fetchUploadSetting(
            :p_upload_setting_id
        )';
        
        return $this->fetch($sql, [
            'p_upload_setting_id' => $p_upload_setting_id
        ]);
    }

    public function fetchUploadSettingFileExtension(
        int $p_upload_setting_id
    ) {
        $sql = 'CALL fetchUploadSettingFileExtension(
            :p_upload_setting_id
        )';
        
        return $this->fetchAll($sql, [
            'p_upload_setting_id' => $p_upload_setting_id
        ]);
    }
    
    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteUploadSetting(
        int $p_upload_setting_id
    ) {
        $sql = 'CALL deleteUploadSetting(
            :p_upload_setting_id
        )';
        
        return $this->query($sql, [
            'p_upload_setting_id' => $p_upload_setting_id
        ]);
    }

    public function deleteUploadSettingFileExtension(
       int  $p_upload_setting_id
    ) {
        $sql = 'CALL deleteUploadSettingFileExtension(
            :p_upload_setting_id
        )';
        
        return $this->query($sql, [
            'p_upload_setting_id' => $p_upload_setting_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkUploadSettingExist(
        int $p_upload_setting_id
    ) {
        $sql = 'CALL checkUploadSettingExist(
            :p_upload_setting_id
        )';
        
        return $this->fetch($sql, [
            'p_upload_setting_id' => $p_upload_setting_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateUploadSettingTable() {
        $sql = 'CALL generateUploadSettingTable()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
    
}