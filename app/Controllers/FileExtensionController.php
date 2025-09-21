<?php
namespace App\Controllers;


session_start();

use App\Models\FileExtension;
use App\Models\FileType;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class FileExtensionController
{
    protected FileExtension $fileExtension;
    protected FileType $fileType;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        FileExtension $fileExtension,
        FileType $fileType,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->fileExtension    = $fileExtension;
        $this->fileType         = $fileType;
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
            'save file extension'                   => $this->saveFileExtension($lastLogBy),
            'delete file extension'                 => $this->deleteFileExtension(),
            'delete multiple file extension'        => $this->deleteMultipleFileExtension(),
            'fetch file extension details'          => $this->fetchFileExtensionDetails(),
            'generate file extension table'         => $this->generateFileExtensionTable(),
            'generate file extension options'       => $this->generateFileExtensionOptions(),
            default                                 => $this->systemHelper::sendErrorResponse(
                                                            'Transaction Failed',
                                                            'We encountered an issue while processing your request.'
                                                        )
        };
    }

    public function saveFileExtension($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'file_extension_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $fileExtensionId    = $_POST['file_extension_id'] ?? null;
        $fileExtensionName  = $_POST['file_extension_name'] ?? null;
        $fileExtension      = $_POST['file_extension'] ?? null;
        $fileTypeId         = $_POST['file_type_id'] ?? null;

        $fileTypeDetails     = $this->fileType->fetchFileType($fileTypeId);
        $fileTypeName        = $fileTypeDetails['file_type_name'] ?? '';

        $fileExtensionId              = $this->fileExtension->saveFileExtension($fileExtensionId, $fileExtensionName, $fileExtension, $fileTypeId, $fileTypeName, $lastLogBy);
        $encryptedfileExtensionId     = $this->security->encryptData($fileExtensionId);

        $this->systemHelper->sendSuccessResponse(
            'Save File Extension Success',
            'The file extension has been saved successfully.',
            ['file_extension_id' => $encryptedfileExtensionId]
        );
    }

    public function deleteFileExtension(){
        $fileExtensionId = $_POST['file_extension_id'] ?? null;

        $this->fileExtension->deleteFileExtension($fileExtensionId);

        $this->systemHelper->sendSuccessResponse(
            'Delete File Extension Success',
            'The file extension has been deleted successfully.'
        );
    }

    public function deleteMultipleFileExtension(){
        $fileExtensionIds  = $_POST['file_extension_id'] ?? null;

        foreach($fileExtensionIds as $fileExtensionId){
            $this->fileExtension->deleteFileExtension($fileExtensionId);
        }

        $this->systemHelper->sendSuccessResponse(
            'Delete Multiple File Extensions Success',
            'The selected file extensions have been deleted successfully.'
        );
    }

    public function fetchFileExtensionDetails(){
        $fileExtensionId            = $_POST['file_extension_id'] ?? null;
        $checkFileExtensionExist    = $this->fileExtension->checkFileExtensionExist($fileExtensionId);
        $total                      = $checkFileExtensionExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper->sendErrorResponse(
                'Get File Extension Details',
                'The file extension does not exist'
            );
        }

        $stateDetails   = $this->fileExtension->fetchFileExtension($fileExtensionId);

        $response = [
            'success'               => true,
            'fileExtensionName'     => $stateDetails['file_extension_name'] ?? null,
            'fileExtension'         => $stateDetails['file_extension'] ?? null,
            'fileTypeID'            => $stateDetails['file_type_id'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function generateFileExtensionTable()
    {
        $pageLink       = $_POST['page_link'] ?? null;
        $fileTypeFilter  = $this->systemHelper->checkFilter($_POST['file_type_filter'] ?? null);
        $response       = [];

        $states = $this->fileExtension->generateFileExtensionTable($fileTypeFilter);

        foreach ($states as $row) {
            $fileExtensionId    = $row['file_extension_id'];
            $fileExtensionName  = $row['file_extension_name'];
            $fileExtension      = $row['file_extension'];
            $fileTypeName       = $row['file_type_name'];

            $fileExtensionIdEncrypted = $this->security->encryptData($fileExtensionId);

            $response[] = [
                'CHECK_BOX'     => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                        <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $fileExtensionId .'">
                                    </div>',
                'FILE_EXTENSION_NAME'    => $fileExtensionName . ' (.' . $fileExtension . ')',
                'FILE_TYPE_NAME'  => $fileTypeName,
                'LINK'          => $pageLink .'&id='. $fileExtensionIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateFileExtensionOptions()
    {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $states = $this->fileExtension->generateFileExtensionOptions();

        foreach ($states as $row) {
            $response[] = [
                'id'    => $row['file_extension_id'],
                'text'  => $row['file_extensionname']
            ];
        }

        echo json_encode($response);
    }
}

# Bootstrap the controller
$controller = new FileExtensionController(
    new FileExtension(),
    new FileType(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();
