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
        $this->uploadSetting        = $uploadSetting;
        $this->fileExtension        = $fileExtension;
        $this->authentication       = $authentication;
        $this->security             = $security;
        $this->systemHelper         = $systemHelper;
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
            'delete upload setting'                         => $this->deleteUploadSetting(),
            'delete multiple upload setting'                => $this->deleteMultipleUploadSetting(),
            'fetch upload setting details'                  => $this->fetchUploadSettingDetails(),
            'generate upload setting table'                 => $this->generateUploadSettingTable(),
            'generate assigned file extension list'         => $this->generateAssignedFileExtensionList($lastLogBy),
            'generate file extension dual listbox options'  => $this->generateFileExtensionDualListBoxOptions(),
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

        $uploadSettingId                = $_POST['upload_setting_id'] ?? null;
        $uploadSettingName              = $_POST['upload_setting_name'] ?? null;
        $uploadSettingDescription       = $_POST['upload_setting_description'] ?? null;
        $maxFileSize                    = $_POST['max_file_size'] ?? null;

        $uploadSettingId              = $this->uploadSetting->saveUploadSetting($uploadSettingId, $uploadSettingName, $uploadSettingDescription, $maxFileSize, $lastLogBy);
        $encryptedUploadSettingId     = $this->security->encryptData($uploadSettingId);

        $this->systemHelper->sendSuccessResponse(
            'Save Upload Setting Success',
            'The upload setting has been saved successfully.',
            ['upload_setting_id' => $encryptedUploadSettingId]
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
        $uploadSettingIds  = $_POST['upload_setting_id'] ?? null;

        foreach($uploadSettingIds as $uploadSettingId){
            $this->uploadSetting->deleteUploadSetting($uploadSettingId);
        }

        $this->systemHelper->sendSuccessResponse(
            'Delete Multiple Upload Settings Success',
            'The selected upload settings have been deleted successfully.'
        );
    }

    public function fetchUploadSettingDetails(){
        $uploadSettingId          = $_POST['upload_setting_id'] ?? null;
        $checkUploadSettingExist  = $this->uploadSetting->checkUploadSettingExist($uploadSettingId);
        $total                          = $checkUploadSettingExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper->sendErrorResponse(
                'Get Upload Setting Details',
                'The upload setting does not exist'
            );
        }

        $uploadSettingDetails   = $this->uploadSetting->fetchUploadSetting($uploadSettingId);

        $response = [
            'success'                       => true,
            'uploadSettingName'             => $uploadSettingDetails['upload_setting_name'] ?? null,
            'uploadSettingDescription'      => $uploadSettingDetails['upload_setting_description'] ?? null,
            'maxFileSize'                   => $uploadSettingDetails['max_file_size'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function generateUploadSettingTable()
    {
        $pageLink   = $_POST['page_link'] ?? null;
        $response   = [];

        $countries = $this->uploadSetting->generateUploadSettingTable();

        foreach ($countries as $row) {
            $uploadSettingId                = $row['upload_setting_id'];
            $uploadSettingName              = $row['upload_setting_name'];
            $uploadSettingDescription       = $row['upload_setting_description'];
            $maxFileSize                    = $row['max_file_size'];

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

    public function generateAssignedFileExtensionList()
    {
        $uploadSettingId    = $_POST['upload_setting_id'] ?? null;
        $list               = '';

        $fileExtensions = $this->uploadSetting->generateUploadSettingFileExtensionList($uploadSettingId);

        foreach ($fileExtensions as $row) {
            $roleUserAccountID  = $row['role_user_account_id'];
            $roleName           = $row['role_name'];
            $assignmentDate     = $this->systemHelper->checkDate('empty', $row['date_assigned'], '', 'd M Y h:i a', '');

            $deleteButton = '';
            if($deleteRoleUserAccount['total'] > 0){
                $deleteButton = '<button class="btn btn-sm btn-danger btn-active-light-danger me-3 delete-role-user-account" data-role-user-account-id="' . $roleUserAccountID . '">Delete</button>';
            }

            $list .= '<div class="d-flex flex-stack">
                        <div class="d-flex align-items-center flex-row-fluid flex-wrap">
                            <div class="flex-grow-1 me-2">
                                <div class="text-gray-800 fs-4 fw-bold">'. $roleName .'</div>
                                                    
                                <span class="text-gray-500 fw-semibold d-block fs-7">Date Assigned : '. $assignmentDate .'</span>
                            </div>
                            '. $deleteButton .'
                        </div>
                    </div>';
        }

        if(empty($list)){
            $list = '<div class="d-flex flex-stack">
                        <div class="d-flex align-items-center flex-row-fluid flex-wrap">
                            <div class="flex-grow-1 me-2">
                                <div class="text-gray-800 fs-4 fw-bold">No allowed file extension found</div>
                            </div>
                        </div>
                    </div>';
        }

        $response[] = [
            'ROLE_USER_ACCOUNT' => $list
        ];


        echo json_encode($response);
    }

    public function generateFileExtensionDualListBoxOptions()
    {
        $uploadSettingId    = $_POST['upload_setting_id'] ?? null;
        $response           = [];
        $roles              = $this->fileExtension->generateFileExtensionDualListBoxOptions($uploadSettingId);

        foreach ($roles as $row) {
            $response[] = [
                'id'    => $row['file_extension_id'],
                'text'  => $row['file_extension_name'] . ' (.' . $row['file_extension'] . ')'
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
