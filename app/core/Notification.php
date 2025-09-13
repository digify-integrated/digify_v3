<?php
namespace App\Core;

/**
 * Class Notification
 *
 * Handles sending notifications through different channels:
 * - System notifications (in-app messages).
 * - Email notifications (via EmailService).
 * - SMS notifications (via SmsService).
 *
 * This class centralizes notification dispatch logic by pulling templates
 * from the notification settings and replacing placeholders with actual values.
 *
 * @package App\Core
 */
class Notification
{
    /**
     * @var object Provides access to notification settings (templates and configs).
     */
    private $notificationSetting;

    /**
     * @var object Email service used to send email notifications.
     */
    private $email;

    /**
     * @var object SMS service used to send SMS notifications.
     */
    private $sms;

    /**
     * @var object System notification service used to send in-app notifications.
     */
    private $systemNotification;

    /**
     * Notification constructor.
     *
     * @param object $notificationSetting       Service/repository to fetch notification settings.
     * @param object $emailService              Email service (implements sendEmail).
     * @param object $smsService                SMS service (implements sendSms).
     * @param object $systemNotificationService System notification service (implements send).
     */
    public function __construct(
        $notificationSetting,
        $emailService,
        $smsService,
        $systemNotificationService
    ) {
        $this->notificationSetting   = $notificationSetting;
        $this->email                 = $emailService;
        $this->sms                   = $smsService;
        $this->systemNotification    = $systemNotificationService;
    }

    /**
     * Send a notification through configured channels (system, email, SMS).
     *
     * Flow:
     * 1. Fetch the notification setting (templates + enabled channels).
     * 2. Replace placeholders (e.g., #{USERNAME}, #{OTP_CODE}) in templates.
     * 3. Send via system, email, or SMS based on configuration.
     *
     * A notification is considered successful if at least one channel
     * is sent successfully.
     *
     * @param int               $notificationSettingId ID of the notification setting to use.
     * @param array|string|null $recipientEmails       Email recipient(s).
     * @param array|string|null $recipientPhones       Phone number(s) for SMS.
     * @param array|int|null    $recipientUserIds      User ID(s) for system notifications.
     * @param array             $placeholders          Key-value pairs for template placeholders.
     * @param array             $ccEmails              CC recipients for email.
     * @param array             $bccEmails             BCC recipients for email.
     *
     * @return bool True if at least one channel succeeds, false otherwise.
     */
    public function sendNotification(
        int $notificationSettingId,
        array|string|null $recipientEmails,
        array|string|null $recipientPhones,
        array|int|null $recipientUserIds,
        array $placeholders = [],
        array $ccEmails = [],
        array $bccEmails = []
    ): bool {
        $success = false;

        // Normalize recipients into arrays
        $recipientEmails   = $recipientEmails   ? (array) $recipientEmails   : [];
        $recipientPhones   = $recipientPhones   ? (array) $recipientPhones   : [];
        $recipientUserIds  = $recipientUserIds  ? (array) $recipientUserIds  : [];

        // 1. Fetch notification settings
        $setting = $this->notificationSetting->fetchNotificationSetting($notificationSettingId);
        if (!$setting) {
            return false;
        }

        // 2. Placeholder replacement helper
        $replacePlaceholders = function (string $template, array $placeholders): string {
            foreach ($placeholders as $key => $value) {
                $template = str_replace('#{' . $key . '}', $value, $template);
            }
            return $template;
        };

        // 3. System Notifications
        if ((int)$setting['system_notification'] === 1 && !empty($recipientUserIds)) {
            $systemTemplate = $this->notificationSetting->fetchSystemNotificationTemplate($notificationSettingId);
            if ($systemTemplate) {
                $title      = $replacePlaceholders($systemTemplate['system_notification_title'], $placeholders);
                $message    = $replacePlaceholders($systemTemplate['system_notification_message'], $placeholders);

                foreach ($recipientUserIds as $userId) {
                    if ($this->systemNotification->send($userId, $title, $message)) {
                        $success = true;
                    }
                }
            }
        }

        // 4. Email Notifications
        if ((int)$setting['email_notification'] === 1 && !empty($recipientEmails)) {
            $emailTemplate = $this->notificationSetting->fetchEmailNotificationTemplate($notificationSettingId);
            if ($emailTemplate) {
                $subject    = $replacePlaceholders($emailTemplate['email_notification_subject'], $placeholders);
                $body       = $replacePlaceholders($emailTemplate['email_notification_body'], $placeholders);

                $emailResult = $this->email->sendEmail(
                    $recipientEmails,
                    $subject,
                    $body,
                    $ccEmails,
                    $bccEmails
                );

                if ($emailResult === true) {
                    $success = true;
                }
            }
        }

        // 5. SMS Notifications
        if ((int)$setting['sms_notification'] === 1 && !empty($recipientPhones)) {
            $smsTemplate = $this->notificationSetting->fetchSmsNotificationTemplate($notificationSettingId);
            if ($smsTemplate) {
                $message = $replacePlaceholders($smsTemplate['sms_notification_message'], $placeholders);

                foreach ($recipientPhones as $phone) {
                    if ($this->sms->sendSms($phone, $message)) {
                        $success = true;
                    }
                }
            }
        }

        return $success;
    }
}
