<?php
namespace App\Core;

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

/**
 * Core Email utility
 * Centralized email sending via PHPMailer + database-configured SMTP.
 */
class Email {

    protected $emailSetting;
    protected $security;

    public function __construct($emailSetting, $security) {
        $this->emailSetting = $emailSetting;
        $this->security     = $security;
    }

    /**
     * Central send email function.
     *
     * @param int         $emailSettingID Email setting ID for SMTP config
     * @param string      $toEmail        Recipient email address
     * @param string      $subject        Email subject
     * @param string      $body           Email body content (HTML/plain)
     * @param array       $cc             CC email addresses
     * @param array       $bcc            BCC email addresses
     *
     * @return bool|string True if sent, or error message if failed
     */
    public function sendEmail(
        int $emailSettingID = 1,
        $toEmail,
        string $subject,
        string $body,
        array $cc = [],
        array $bcc = []
    ) {
        $mailer = new PHPMailer(true);

        try {
            // Apply DB-based SMTP settings
            $this->configureSMTP($emailSettingID, $mailer, true);

            // FROM
            $emailSetting = $this->emailSetting->getEmailSetting($emailSettingID);
            $mailer->setFrom(
                $fromEmail ?? ($emailSetting['mail_from_email'] ?? 'no-reply@example.com'),
                $fromName  ?? ($emailSetting['mail_from_name']  ?? 'System')
            );

            // TO
            if (is_array($toEmail)) {
                foreach ($toEmail as $email) {
                    $mailer->addAddress($email);
                }
            } else {
                $mailer->addAddress($toEmail);
            }

            // CC
            foreach ($cc as $email) {
                $mailer->addCC($email);
            }

            // BCC
            foreach ($bcc as $email) {
                $mailer->addBCC($email);
            }

            // SUBJECT & BODY
            $mailer->Subject = $subject;

            $defaultTemplatePath = __DIR__ . '/template/email-template.html';

            if (file_exists($defaultTemplatePath)) {
                $template = file_get_contents($defaultTemplatePath);
                $template = str_replace('{EMAIL_SUBJECT}', $subject, $template);
                $template = str_replace('{EMAIL_CONTENT}', $body, $template);
                $mailer->Body = $template;
            } else {
                $mailer->Body = $body;
            }

            return $mailer->send();
        } catch (Exception $e) {
            return 'Failed to send email. Error: ' . $mailer->ErrorInfo;
        }
    }

    /**
     * Configure PHPMailer SMTP settings from DB or fallback constants.
     */
    private function configureSMTP($emailSettingID = 1, $mailer, $isHTML = true) {
        $emailSetting = $this->emailSetting->fetchEmailSetting($emailSettingID);

        $mailer->isSMTP();
        $mailer->isHTML($isHTML);
        $mailer->Host       = $emailSetting['mail_host']                ?? MAIL_SMTP_SERVER;
        $mailer->SMTPAuth   = !empty($emailSetting['smtp_auth']);
        $mailer->Username   = $emailSetting['mail_username']            ?? MAIL_USERNAME;
        $mailer->Password   = !empty($emailSetting['mail_password'])    ? $this->security->decryptData($emailSetting['mail_password']) : MAIL_PASSWORD;
        $mailer->SMTPSecure = $emailSetting['mail_encryption']          ?? MAIL_SMTP_SECURE;
        $mailer->Port       = $emailSetting['port']                     ?? MAIL_SMTP_PORT;
    }
}