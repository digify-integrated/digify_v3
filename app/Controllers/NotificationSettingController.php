<?php
namespace App\Controllers;

session_start();

use App\Models\NotificationSetting;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class NotificationSettingController {
    protected NotificationSetting $notificationSetting;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        NotificationSetting $notificationSetting,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->notificationSetting  = $notificationSetting;
        $this->authentication       = $authentication;
        $this->security             = $security;
        $this->systemHelper         = $systemHelper;
    }

    public function handleRequest() {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Only POST requests are allowed.'
            );
        }

        $transaction    = $_POST['transaction'] ?? null;
        $lastLogBy      = $_SESSION['user_account_id'];

        if (!$transaction) {
            $this->systemHelper::sendErrorResponse(
                'Missing Transaction',
                'No transaction type was provided.'
            );
        }

        $loginCredentialsDetails    = $this->authentication->fetchLoginCredentials($lastLogBy);       
        $multipleSession            = $loginCredentialsDetails['multiple_session'] ?? 'No';
        $isActive                   = $loginCredentialsDetails['active'] ?? 'No';

        $sessionTokenDetails    = $this->authentication->fetchSession($lastLogBy);
        $sessionToken           = $sessionTokenDetails['session_token'] ?? '';

        if ($isActive === 'No' || (!$this->security->verifyToken($_SESSION['session_token'], $sessionToken) && $multipleSession === 'No')) {
            $this->systemHelper::sendErrorResponse(
                'Session Expired', 
                'Your session has expired. Please log in again to continue.',
                [
                    'invalid_session'   => true,
                    'redirect_link'     => 'logout.php?logout'
                ]
            );
        }

        $transaction = strtolower(trim($transaction));

        match ($transaction) {
            'save notification setting'                     => $this->saveNotificationSetting($lastLogBy),
            'save system notification template'             => $this->saveSystemNotificationTemplate($lastLogBy),
            'save email notification template'              => $this->saveEmailNotificationTemplate($lastLogBy),
            'save sms notification template'                => $this->saveSMSNotificationTemplate($lastLogBy),
            'update notification setting channel'           => $this->updateNotificationSettingChannel($lastLogBy),
            'delete notification setting'                   => $this->deleteNotificationSetting(),
            'delete multiple notification setting'          => $this->deleteMultipleNotificationSetting(),
            'fetch notification setting details'            => $this->fetchNotificationSettingDetails(),
            'fetch system notification template details'    => $this->fetchSystemNotificationTemplateDetails(),
            'fetch email notification template details'     => $this->fetchEmailNotificationTemplateDetails(),
            'fetch sms notification template details'       => $this->fetchSMSNotificationTemplateDetails(),
            'generate notification setting table'           => $this->generateNotificationSettingTable(),
            default                                         => $this->systemHelper::sendErrorResponse(
                                                                    'Transaction Failed',
                                                                    'We encountered an issue while processing your request.'
                                                                )
        };
    }

    /* =============================================================================================
        SECTION 1: SAVE METHOD
    ============================================================================================= */

    public function saveNotificationSetting(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'notification_setting_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $notificationSettingId              = $_POST['notification_setting_id'] ?? null;
        $notificationSettingName            = $_POST['notification_setting_name'] ?? null;
        $notificationSettingDescription     = $_POST['notification_setting_description'] ?? null;

        $notificationSettingId = $this->notificationSetting->saveNotificationSetting(
            $notificationSettingId,
            $notificationSettingName,
            $notificationSettingDescription,
            $lastLogBy
        );
        
        $encryptedNotificationSettingId = $this->security->encryptData($notificationSettingId);

        $this->systemHelper::sendSuccessResponse(
            'Save Notification Setting Success',
            'The notification setting has been saved successfully.',
            ['notification_setting_id' => $encryptedNotificationSettingId]
        );
    }

    public function saveSystemNotificationTemplate(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_system_notification_template_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $notificationSettingId      = $_POST['notification_setting_id'] ?? null;
        $systemNotificationTitle    = $_POST['system_notification_title'] ?? null;
        $systemNotificationMessage  = $_POST['system_notification_message'] ?? null;

        $this->notificationSetting->saveSystemNotificationTemplate(
            $notificationSettingId, 
            $systemNotificationTitle, 
            $systemNotificationMessage, 
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Save System Notification Template Success',
            'The system notification template has been saved successfully.'
        );
    }

    public function saveEmailNotificationTemplate(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_email_notification_template_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $notificationSettingId      = $_POST['notification_setting_id'] ?? null;
        $emailNotificationSubject   = $_POST['email_notification_subject'] ?? null;
        $emailNotificationBody      = $_POST['email_notification_body'] ?? null;

        $this->notificationSetting->saveEmailNotificationTemplate(
            $notificationSettingId,
            $emailNotificationSubject,
            $emailNotificationBody,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Save System Notification Template Success',
            'The system notification template has been saved successfully.'
        );
    }

    public function saveSMSNotificationTemplate(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_sms_notification_template_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $notificationSettingId      = $_POST['notification_setting_id'] ?? null;
        $smsNotificationMessage     = $_POST['sms_notification_message'] ?? null;

        $this->notificationSetting->saveSMSNotificationTemplate(
            $notificationSettingId,
            $smsNotificationMessage,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Save System Notification Template Success',
            'The system notification template has been saved successfully.'
        );
    }

    /* =============================================================================================
        SECTION 2: INSERT METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 3: UPDATE METHOD
    ============================================================================================= */

    public function updateNotificationSettingChannel(
        int $lastLogBy
    ) {
        $notificationSettingId  = $_POST['notification_setting_id'] ?? null;
        $channel                = $_POST['channel'] ?? null;
        $status                 = $_POST['status'] ?? null;

        $this->notificationSetting->updateNotificationChannel(
            $notificationSettingId,
            $channel,
            $status,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Save System Notification Template Success',
            'The system notification template has been saved successfully.'
        );
    }

    /* =============================================================================================
        SECTION 4: FETCH METHOD
    ============================================================================================= */

    public function fetchNotificationSettingDetails() {
        $notificationSettingId          = $_POST['notification_setting_id'] ?? null;
        $checkNotificationSettingExist  = $this->notificationSetting->checkNotificationSettingExist($notificationSettingId);
        $total                          = $checkNotificationSettingExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get Notification Setting Details',
                'The notification setting does not exist'
            );
        }

        $notificationSettingDetails = $this->notificationSetting->fetchNotificationSetting($notificationSettingId);

        $response = [
            'success'                           => true,
            'notificationSettingName'           => $notificationSettingDetails['notification_setting_name'] ?? null,
            'notificationSettingDescription'    => $notificationSettingDetails['notification_setting_description'] ?? null,
            'systemNotification'                => $notificationSettingDetails['system_notification'] ?? 1,
            'emailNotification'                 => $notificationSettingDetails['email_notification'] ?? 0,
            'smsNotification'                   => $notificationSettingDetails['sms_notification'] ?? 0
        ];

        echo json_encode($response);
        exit;
    }

    public function fetchSystemNotificationTemplateDetails() {
        $notificationSettingId          = $_POST['notification_setting_id'] ?? null;
        $checkNotificationSettingExist  = $this->notificationSetting->checkNotificationSettingExist($notificationSettingId);
        $total                          = $checkNotificationSettingExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get Notification Setting Details',
                'The notification setting does not exist'
            );
        }

        $systemNotificationTemplategDetails = $this->notificationSetting->fetchSystemNotificationTemplate($notificationSettingId);

        $response = [
            'success'                       => true,
            'systemNotificationTitle'       => $systemNotificationTemplategDetails['system_notification_title'] ?? null,
            'systemNotificationMessage'     => $systemNotificationTemplategDetails['system_notification_message'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function fetchEmailNotificationTemplateDetails() {
        $notificationSettingId          = $_POST['notification_setting_id'] ?? null;
        $checkNotificationSettingExist  = $this->notificationSetting->checkNotificationSettingExist($notificationSettingId);
        $total                          = $checkNotificationSettingExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get Notification Setting Details',
                'The notification setting does not exist'
            );
        }

        $emailNotificationTemplategDetails = $this->notificationSetting->fetchEmailNotificationTemplate($notificationSettingId); 

        $response = [
            'success'                   => true,
            'emailNotificationSubject'  => $emailNotificationTemplategDetails['email_notification_subject'] ?? null,
            'emailNotificationBody'     => $emailNotificationTemplategDetails['email_notification_body'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function fetchSMSNotificationTemplateDetails() {
        $notificationSettingId          = $_POST['notification_setting_id'] ?? null;
        $checkNotificationSettingExist  = $this->notificationSetting->checkNotificationSettingExist($notificationSettingId);
        $total                          = $checkNotificationSettingExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get Notification Setting Details',
                'The notification setting does not exist',
                ['notExist' => true]
            );
        }

        $smsNotificationTemplategDetails = $this->notificationSetting->fetchSmsNotificationTemplate($notificationSettingId);

        $response = [
            'success'                   => true,
            'smsNotificationMessage'    => $smsNotificationTemplategDetails['sms_notification_message'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    /* =============================================================================================
        SECTION 5: DELETE METHOD
    ============================================================================================= */

    public function deleteNotificationSetting() {
        $notificationSettingId = $_POST['notification_setting_id'] ?? null;

        $this->notificationSetting->deleteNotificationSetting($notificationSettingId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Notification Setting Success',
            'The notification setting has been deleted successfully.'
        );
    }

    public function deleteMultipleNotificationSetting() {
        $notificationSettingIds = $_POST['notification_setting_id'] ?? null;

        foreach($notificationSettingIds as $notificationSettingId){
            $this->notificationSetting->deleteNotificationSetting($notificationSettingId);
        }

        $this->systemHelper::sendSuccessResponse(
            'Delete Multiple Notification Settings Success',
            'The selected notification settings have been deleted successfully.'
        );
    }

    /* =============================================================================================
        SECTION 6: CHECK METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 7: GENERATE METHOD
    ============================================================================================= */

    public function generateNotificationSettingTable() {
        $pageLink   = $_POST['page_link'] ?? null;
        $response   = [];

        $countries = $this->notificationSetting->generateNotificationSettingTable();

        foreach ($countries as $row) {
            $notificationSettingId              = $row['notification_setting_id'];
            $notificationSettingName            = $row['notification_setting_name'];
            $notificationSettingDescription     = $row['notification_setting_description'];

            $notificationSettingIdEncrypted = $this->security->encryptData($notificationSettingId);

            $response[] = [
                'CHECK_BOX'                     => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                                        <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $notificationSettingId .'">
                                                    </div>',
                'NOTIFICATION_SETTING_NAME'     => '<div class="d-flex flex-column">
                                                        <div class="fs-5 text-gray-900 fw-bold">'. $notificationSettingName .'</div>
                                                        <div class="fs-7 text-gray-500">'. $notificationSettingDescription .'</div>
                                                    </div>',
                'LINK'                          => $pageLink .'&id='. $notificationSettingIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    /* =============================================================================================
        SECTION 8: CUSTOM METHOD
    ============================================================================================= */

    /* =============================================================================================
        END OF METHODS
    ============================================================================================= */
}

$controller = new NotificationSettingController(
    new NotificationSetting(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();