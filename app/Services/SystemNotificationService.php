<?php
namespace App\Services;

use App\Core\Model;

/**
 * SystemNotification model
 *
 * Provides database access methods for system notifications.
 */
class SystemNotificationService extends Model
{
    # -------------------------------------------------------------
    #   Insert methods
    # -------------------------------------------------------------

    /**
     * Insert a new system notification for a user.
     *
     * @param int $p_user_account_id User account ID
     * @param string $p_title Notification title
     * @param string $p_message Notification message
     */
    public function insertSystemNotification($p_user_account_id, $p_title, $p_message) {
        $sql = 'CALL insertSystemNotification(:p_user_account_id, :p_title, :p_message)';

        return $this->query($sql, [
            'p_user_account_id'     => $p_user_account_id,
            'p_title'               => $p_title,
            'p_message'             => $p_message
        ]);
    }

    # -------------------------------------------------------------
    #   Fetch methods
    # -------------------------------------------------------------

    /**
     * Fetch all system notifications for a user.
     *
     * @param int $p_user_account_id User account ID
     * @return array List of notifications
     */
    public function fetchUserNotifications($p_user_account_id) {
        $sql = 'CALL fetchUserNotifications(:p_user_account_id)';

        return $this->fetchAll($sql, [
            'p_user_account_id' => $p_user_account_id
        ]);
    }

    # -------------------------------------------------------------
}
