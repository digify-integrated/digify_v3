<?php
namespace App\Models;

use App\Core\Model;

class NotificationSetting extends Model {

    /* =============================================================================================
        SECTION 1: SAVE METHODS
    ============================================================================================= */

    public function saveNotificationSetting(
        int $p_notification_setting_id,
        string $p_notification_setting_name,
        string $p_notification_setting_description,
        int $p_last_log_by
    ) {
        $sql = 'CALL saveNotificationSetting(
            :p_notification_setting_id,
            :p_notification_setting_name,
            :p_notification_setting_description, 
            :p_last_log_by
        )';
        
        $row = $this->fetch($sql, [
            'p_notification_setting_id'             => $p_notification_setting_id,
            'p_notification_setting_name'           => $p_notification_setting_name,
            'p_notification_setting_description'    => $p_notification_setting_description,
            'p_last_log_by'                         => $p_last_log_by
        ]);
        
        return $row['new_notification_setting_id'] ?? null;
    }

    public function saveSystemNotificationTemplate(
        int $p_notification_setting_id,
        string $p_system_notification_title,
        string $p_system_notification_message,
        int $p_last_log_by
    ) {
        $sql = 'CALL saveSystemNotificationTemplate(
            :p_notification_setting_id,
            :p_system_notification_title,
            :p_system_notification_message,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_notification_setting_id'         => $p_notification_setting_id,
            'p_system_notification_title'       => $p_system_notification_title,
            'p_system_notification_message'     => $p_system_notification_message,
            'p_last_log_by'                     => $p_last_log_by
        ]);
    }

    public function saveEmailNotificationTemplate(
        int $p_notification_setting_id,
        string $p_email_notification_subject,
        string $p_email_notification_body,
        int $p_last_log_by
    ) {
        $sql = 'CALL saveEmailNotificationTemplate(
            :p_notification_setting_id,
            :p_email_notification_subject,
            :p_email_notification_body,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_notification_setting_id'     => $p_notification_setting_id,
            'p_email_notification_subject'  => $p_email_notification_subject,
            'p_email_notification_body'     => $p_email_notification_body,
            'p_last_log_by'                 => $p_last_log_by
        ]);
    }

    public function saveSMSNotificationTemplate(
        int $p_notification_setting_id,
        string $p_sms_notification_message,
        int $p_last_log_by
    ) {
        $sql = 'CALL saveSMSNotificationTemplate(
            :p_notification_setting_id,
            :p_sms_notification_message,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_notification_setting_id'     => $p_notification_setting_id,
            'p_sms_notification_message'    => $p_sms_notification_message,
            'p_last_log_by'                 => $p_last_log_by
        ]);
    }
    
    /* =============================================================================================
        SECTION 2: INSERT METHODS
    ============================================================================================= */

    /* =============================================================================================
        SECTION 3: UPDATE METHODS
    =============================================================================================  */

    public function updateNotificationChannel(
        int $p_notification_setting_id,
        string $p_notification_channel,
        string $p_notification_channel_value,
        int $p_last_log_by
    ) {
        $sql = 'CALL updateNotificationChannel(
            :p_notification_setting_id,
            :p_notification_channel,
            :p_notification_channel_value,
            :p_last_log_by
        )';
        
        return $this->query($sql, [
            'p_notification_setting_id'     => $p_notification_setting_id,
            'p_notification_channel'        => $p_notification_channel,
            'p_notification_channel_value'  => $p_notification_channel_value,
            'p_last_log_by'                 => $p_last_log_by
        ]);
    }

    /* =============================================================================================
        SECTION 4: FETCH METHODS
    ============================================================================================= */

    public function fetchNotificationSetting(
        int $p_notification_setting_id
    ) {
        $sql = 'CALL fetchNotificationSetting(
            :p_notification_setting_id
        )';
        
        return $this->fetch($sql, [
            'p_notification_setting_id' => $p_notification_setting_id
        ]);
    }

    public function fetchEmailNotificationTemplate(
        int $p_notification_setting_id
    ) {
        $sql = 'CALL fetchEmailNotificationTemplate(
            :p_notification_setting_id
        )';
        
        return $this->fetch($sql, [
            'p_notification_setting_id' => $p_notification_setting_id
        ]);
    }

    public function fetchSystemNotificationTemplate(
        int $p_notification_setting_id
    ) {
        $sql = 'CALL fetchSystemNotificationTemplate(
            :p_notification_setting_id
        )';
        
        return $this->fetch($sql, [
            'p_notification_setting_id' => $p_notification_setting_id
        ]);
    }

    public function fetchSmsNotificationTemplate($p_notification_setting_id) {
        $sql = 'CALL fetchSmsNotificationTemplate(
            :p_notification_setting_id
        )';

        return $this->fetch($sql, [
            'p_notification_setting_id' => $p_notification_setting_id
        ]);
    }

    /* =============================================================================================
        SECTION 5: DELETE METHODS
    ============================================================================================= */

    public function deleteNotificationSetting(
        int $p_notification_setting_id
    ) {
        $sql = 'CALL deleteNotificationSetting(
            :p_notification_setting_id
        )';
        
        return $this->query($sql, [
            'p_notification_setting_id' => $p_notification_setting_id
        ]);
    }

    /* =============================================================================================
        SECTION 6: CHECK METHODS
    ============================================================================================= */

    public function checkNotificationSettingExist(
        int $p_notification_setting_id
    ) {
        $sql = 'CALL checkNotificationSettingExist(
            :p_notification_setting_id
        )';
        
        return $this->fetch($sql, [
            'p_notification_setting_id' => $p_notification_setting_id
        ]);
    }

    /* =============================================================================================
        SECTION 7: GENERATE METHODS
    ============================================================================================= */

    public function generateNotificationSettingTable() {
        $sql = 'CALL generateNotificationSettingTable()';
        
        return $this->fetchAll($sql);
    }

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
}