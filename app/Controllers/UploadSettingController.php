<?php
namespace App\Controllers;

session_start();

use App\Models\UploadSetting;
use App\Models\FileExtension;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class UploadSettingController
{
    protected UploadSetting $uploadSetting;
    protected FileExtension $fileExtension;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        UploadSetting $uploadSetting,
        FileExtension $fileExtension,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->uploadSetting    = $uploadSetting;
        $this->fileExtension    = $fileExtension;
        $this->authentication   = $authentication;
        $this->security         = $security;
        $this->systemHelper     = $systemHelper;
    }

    public function handleRequest(): void
    {
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
                    'invalid_session' => true,
                    'redirect_link' => 'logout.php?logout'
                ]
            );
        }

        $transaction = strtolower(trim($transaction));

        match ($transaction) {
            'save upload setting'                           => $this->saveUploadSetting($lastLogBy),
            'save upload setting file extension'            => $this->saveUploadSettingFileExtension($lastLogBy),
            'delete upload setting'                         => $this->deleteUploadSetting(),
            'delete multiple upload setting'                => $this->deleteMultipleUploadSetting(),
            'fetch upload setting details'                  => $this->fetchUploadSettingDetails(),
            'fetch upload setting file extension details'   => $this->fetchUploadSettingFileExtensionDetails(),
            'generate upload setting table'                 => $this->generateUploadSettingTable(),
            default                                         => $this->systemHelper::sendErrorResponse(
                                                                    'Transaction Failed',
                                                                    'We encountered an issue while processing your request.'
                                                                )
        };
    }

    public function saveUploadSetting($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'upload_setting_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $uploadSettingId            = $_POST['upload_setting_id'] ?? null;
        $uploadSettingName          = $_POST['upload_setting_name'] ?? null;
        $uploadSettingDescription   = $_POST['upload_setting_description'] ?? null;
        $maxFileSize                = $_POST['max_file_size'] ?? null;

        $uploadSettingId            = $this->uploadSetting->saveUploadSetting($uploadSettingId, $uploadSettingName, $uploadSettingDescription, $maxFileSize, $lastLogBy);
        $encryptedUploadSettingId   = $this->security->encryptData($uploadSettingId);

        $this->systemHelper->sendSuccessResponse(
            'Save Upload Setting Success',
            'The upload setting has been saved successfully.',
            ['upload_setting_id' => $encryptedUploadSettingId]
        );
    }

    public function saveUploadSettingFileExtension($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'upload_setting_file_extension_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $uploadSettingId    = $_POST['upload_setting_id'] ?? null;
        $fileExtensionIds   = $_POST['file_extension_id'] ?? [];

        if(empty($fileExtensionIds)){
            $this->systemHelper::sendErrorResponse(
                'Assign File Extension Error',
                'Please select the file extension(s) you wish to assign to the upload setting.'
            );
        }

        $this->uploadSetting->deleteUploadSettingFileExtension($uploadSettingId);

        $uploadSettingDetails   = $this->uploadSetting->fetchUploadSetting($uploadSettingId);
        $uploadSettingName      = $uploadSettingDetails['upload_setting_name'] ?? '';

        foreach ($fileExtensionIds as $fileExtensionId) {
            $fileExtensionDetails   = $this->fileExtension->fetchFileExtension($fileExtensionId);
            $fileExtensionName      = $fileExtensionDetails['file_extension_name'] ?? null;
            $fileExtension          = $fileExtensionDetails['file_extension'] ?? null;

            $this->uploadSetting->insertUploadSettingFileExtension($uploadSettingId, $uploadSettingName, $fileExtensionId, $fileExtensionName, $fileExtension, $lastLogBy);
        }

        $this->systemHelper->sendSuccessResponse(
            'Assign File Extension Success',
            'The file extension has been assigned successfully.'
        );
    }

    public function deleteUploadSetting(){
        $uploadSettingId = $_POST['upload_setting_id'] ?? null;

        $this->uploadSetting->deleteUploadSetting($uploadSettingId);

        $this->systemHelper->sendSuccessResponse(
            'Delete Upload Setting Success',
            'The upload setting has been deleted successfully.'
        );
    }

    public function deleteMultipleUploadSetting(){
        $uploadSettingIds = $_POST['upload_setting_id'] ?? null;

        foreach($uploadSettingIds as $uploadSettingId){
            $this->uploadSetting->deleteUploadSetting($uploadSettingId);
        }

        $this->systemHelper->sendSuccessResponse(
            'Delete Multiple Upload Settings Success',
            'The selected upload settings have been deleted successfully.'
        );
    }

    public function fetchUploadSettingDetails(){
        $uploadSettingId            = $_POST['upload_setting_id'] ?? null;
        $checkUploadSettingExist    = $this->uploadSetting->checkUploadSettingExist($uploadSettingId);
        $total                      = $checkUploadSettingExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper->sendErrorResponse(
                'Get Upload Setting Details',
                'The upload setting does not exist',
                ['notExist' => true]
            );
        }

        $uploadSettingDetails = $this->uploadSetting->fetchUploadSetting($uploadSettingId);

        $response = [
            'success'                   => true,
            'uploadSettingName'         => $uploadSettingDetails['upload_setting_name'] ?? null,
            'uploadSettingDescription'  => $uploadSettingDetails['upload_setting_description'] ?? null,
            'maxFileSize'               => $uploadSettingDetails['max_file_size'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function fetchUploadSettingFileExtensionDetails(){
        $uploadSettingId            = $_POST['upload_setting_id'] ?? null;
        $checkUploadSettingExist    = $this->uploadSetting->checkUploadSettingExist($uploadSettingId);
        $total                      = $checkUploadSettingExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper->sendErrorResponse(
                'Get Upload Setting Details',
                'The upload setting does not exist',
                ['notExist' => true]
            );
        }

        $uploadSettingDetails = $this->uploadSetting->fetchUploadSettingFileExtension($uploadSettingId);

        $fileExtensions = [];
        foreach ($uploadSettingDetails as $row) {
            $fileExtensions[] = $row['file_extension_id'];
        }

        $response = [
            'success'               => true,
            'allowedFileExtension'  => $fileExtensions
        ];

        echo json_encode($response);
        exit;
    }

    public function generateUploadSettingTable()
    {
        $pageLink   = $_POST['page_link'] ?? null;
        $response   = [];

        $uploadSettings = $this->uploadSetting->generateUploadSettingTable();

        foreach ($uploadSettings as $row) {
            $uploadSettingId            = $row['upload_setting_id'];
            $uploadSettingName          = $row['upload_setting_name'];
            $uploadSettingDescription   = $row['upload_setting_description'];
            $maxFileSize                = $row['max_file_size'];

            $uploadSettingIdEncrypted = $this->security->encryptData($uploadSettingId);

            $response[] = [
                'CHECK_BOX'             => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                                <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $uploadSettingId .'">
                                            </div>',
                'UPLOAD_SETTING_NAME'   => '<div class="d-flex flex-column">
                                                <a href="#" class="fs-5 text-gray-900 fw-bold">'. $uploadSettingName .'</a>
                                                <div class="fs-7 text-gray-500">'. $uploadSettingDescription .'</div>
                                            </div>',
                'MAX_FILE_SIZE'         => $maxFileSize . ' kb',
                'LINK'                  => $pageLink .'&id='. $uploadSettingIdEncrypted
            ];
        }

        echo json_encode($response);
    }
}

# Bootstrap the controller
$controller = new UploadSettingController(
    new UploadSetting(),
    new FileExtension(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();
