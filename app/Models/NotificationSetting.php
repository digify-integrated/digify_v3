<?php
namespace App\Models;

use App\Core\Model;

class NotificationSetting extends Model {

    # -------------------------------------------------------------
    #   Fetch methods
    # -------------------------------------------------------------

    public function fetchNotificationSetting($p_notification_setting_id) {
        $sql = 'CALL fetchNotificationSetting(:p_notification_setting_id)';
        
        return $this->fetch($sql, [
            'p_notification_setting_id' => $p_notification_setting_id
        ]);
    }

    public function fetchEmailNotificationTemplate($p_notification_setting_id) {
        $sql = 'CALL fetchEmailNotificationTemplate(:p_notification_setting_id)';
        
        return $this->fetch($sql, [
            'p_notification_setting_id' => $p_notification_setting_id
        ]);
    }

    public function fetchSystemNotificationTemplate($p_notification_setting_id) {
        $sql = 'CALL fetchSystemNotificationTemplate(:p_notification_setting_id)';
        
        return $this->fetch($sql, [
            'p_notification_setting_id' => $p_notification_setting_id
        ]);
    }

    public function fetchSmsNotificationTemplate($p_notification_setting_id) {
        $sql = 'CALL fetchSmsNotificationTemplate(:p_notification_setting_id)';

        return $this->fetch($sql, [
            'p_notification_setting_id' => $p_notification_setting_id
        ]);
    }

    # -------------------------------------------------------------

    # -------------------------------------------------------------
    #   Check exist methods
    # -------------------------------------------------------------

    public function checkNotificationSettingExist($p_notification_setting_id) {
        $sql = 'CALL checkNotificationSettingExist(:p_notification_setting_id)';
        
        return $this->fetch($sql, [
            'p_notification_setting_id' => $p_notification_setting_id
        ]);
    }

    # -------------------------------------------------------------

    # -------------------------------------------------------------
    #   Save methods
    # -------------------------------------------------------------

    public function saveNotificationSetting($p_notification_setting_id, $p_notification_setting_name, $p_notification_setting_description, $p_last_log_by) {
        $sql = 'CALL saveNotificationSetting(:p_notification_setting_id, :p_notification_setting_name, :p_notification_setting_description, :p_last_log_by, @p_new_notification_setting_id)';
        
        $this->query($sql, [
            'p_notification_setting_id' => $p_notification_setting_id,
            'p_notification_setting_name' => $p_notification_setting_name,
            'p_notification_setting_description' => $p_notification_setting_description,
            'p_last_log_by' => $p_last_log_by
        ]);
        
        $result = $this->fetch('SELECT @p_new_notification_setting_id AS notification_setting_id');

        return $result['notification_setting_id'] ?? null;
    }

    public function saveSystemNotificationTemplate($p_notification_setting_id, $p_system_notification_title, $p_system_notification_message, $p_last_log_by) {
        $sql = 'CALL saveSystemNotificationTemplate(:p_notification_setting_id, :p_system_notification_title, :p_system_notification_message, :p_last_log_by)';
        
        return $this->query($sql, [
            'p_notification_setting_id' => $p_notification_setting_id,
            'p_system_notification_title' => $p_system_notification_title,
            'p_system_notification_message' => $p_system_notification_message,
            'p_last_log_by' => $p_last_log_by
        ]);
    }

    public function saveEmailNotificationTemplate($p_notification_setting_id, $p_email_notification_subject, $p_email_notification_body, $p_email_setting_id, $p_email_setting_name, $p_last_log_by) {
        $sql = 'CALL saveEmailNotificationTemplate(:p_notification_setting_id, :p_email_notification_subject, :p_email_notification_body, :p_email_setting_id, :p_email_setting_name, :p_last_log_by)';
        
        return $this->query($sql, [
            'p_notification_setting_id' => $p_notification_setting_id,
            'p_email_notification_subject' => $p_email_notification_subject,
            'p_email_notification_body' => $p_email_notification_body,
            'p_email_setting_id' => $p_email_setting_id,
            'p_email_setting_name' => $p_email_setting_name,
            'p_last_log_by' => $p_last_log_by
        ]);
    }

    public function saveSMSNotificationTemplate($p_notification_setting_id, $p_sms_notification_message, $p_last_log_by) {
        $sql = 'CALL saveSMSNotificationTemplate(:p_notification_setting_id, :p_sms_notification_message, :p_last_log_by)';
        
        return $this->query($sql, [
            'p_notification_setting_id' => $p_notification_setting_id,
            'p_sms_notification_message' => $p_sms_notification_message,
            'p_last_log_by' => $p_last_log_by
        ]);
    }
    
    # -------------------------------------------------------------

    # -------------------------------------------------------------
    #   Updated methods
    # -------------------------------------------------------------

    public function updateNotificationChannel($p_notification_setting_id, $p_notification_channel, $p_notification_channel_value, $p_last_log_by) {
        $sql = 'CALL updateNotificationChannel(:p_notification_setting_id, :p_notification_channel, :p_notification_channel_value, :p_last_log_by)';
        
        return $this->query($sql, [
            'p_notification_setting_id' => $p_notification_setting_id,
            'p_notification_channel' => $p_notification_channel,
            'p_notification_channel_value' => $p_notification_channel_value,
            'p_last_log_by' => $p_last_log_by
        ]);
    }
    
    # -------------------------------------------------------------

    # -------------------------------------------------------------
    #   Delete methods
    # -------------------------------------------------------------

    public function deleteNotificationSetting($p_notification_setting_id) {
        $sql = 'CALL deleteNotificationSetting(:p_notification_setting_id)';
        
        return $this->query($sql, [
            'p_notification_setting_id' => $p_notification_setting_id
        ]);
    }
    
    # -------------------------------------------------------------
}
?>