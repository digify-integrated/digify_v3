<?php
namespace App\Services;

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

/**
 * EmailService
 * Centralized email sending via PHPMailer + database-configured SMTP.
 */
class EmailService
{
    /**
     * Send an email using PHPMailer with optional CC/BCC and HTML template.
     *
     * @param string|array $toEmail Recipient email address(es)
     * @param string       $subject Email subject
     * @param string       $body    Email body content (HTML or plain text)
     * @param array        $cc      CC email addresses
     * @param array        $bcc     BCC email addresses
     *
     * @return bool|string True if sent successfully, or error message if failed
     */
    public function sendEmail(
        string|array $toEmail,
        string $subject,
        string $body,
        array $cc   = [],
        array $bcc  = []
    ): bool|string {
        $mailer = new PHPMailer(true);

        try {
            // Configure SMTP
            $this->configureSMTP($mailer);

            // Set From
            $mailer->setFrom(MAIL_FROM_EMAIL, MAIL_FROM_NAME);

            // Add Recipients
            foreach ((array) $toEmail as $email) {
                $mailer->addAddress($email);
            }

            foreach ($cc as $email) {
                $mailer->addCC($email);
            }

            foreach ($bcc as $email) {
                $mailer->addBCC($email);
            }

            // Subject & Body
            $mailer->Subject    = $subject;
            $mailer->Body       = $this->applyTemplate($subject, $body);

            return $mailer->send();
        } catch (Exception $e) {
            return 'Failed to send email. Error: ' . $e->getMessage();
        }
    }

    /**
     * Configure PHPMailer SMTP settings from constants (or DB).
     */
    private function configureSMTP(PHPMailer $mailer, bool $isHTML = true): void
    {
        $mailer->isSMTP();
        $mailer->isHTML($isHTML);
        $mailer->Host           = MAIL_SMTP_SERVER;
        $mailer->SMTPAuth       = MAIL_SMTP_AUTH;
        $mailer->Username       = MAIL_USERNAME;
        $mailer->Password       = MAIL_PASSWORD;
        $mailer->SMTPSecure     = MAIL_SMTP_SECURE;
        $mailer->Port           = MAIL_SMTP_PORT;
    }

    /**
     * Apply email template if available, otherwise return raw body.
     */
    private function applyTemplate(string $subject, string $body): string
    {
        $defaultTemplatePath = __DIR__ . '/template/email-template.html';

        if (file_exists($defaultTemplatePath)) {
            $template = file_get_contents($defaultTemplatePath);
            return str_replace(
                ['{EMAIL_SUBJECT}', '{EMAIL_CONTENT}'],
                [$subject, $body],
                $template
            );
        }

        return $body;
    }
}
