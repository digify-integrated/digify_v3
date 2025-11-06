<?php
namespace App\Controllers;

session_start();

use App\Models\FileType;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class FileTypeController {
    protected FileType $fileType;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        FileType $fileType,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->fileType         = $fileType;
        $this->authentication   = $authentication;
        $this->security         = $security;
        $this->systemHelper     = $systemHelper;
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
            'save file type'                => $this->saveFileType($lastLogBy),
            'delete file type'              => $this->deleteFileType(),
            'delete multiple file type'     => $this->deleteMultipleFileType(),
            'fetch file type details'       => $this->fetchFileTypeDetails(),
            'generate file type table'      => $this->generateFileTypeTable(),
            'generate file type options'    => $this->generateFileTypeOptions(),
            default                         => $this->systemHelper::sendErrorResponse(
                                                    'Transaction Failed',
                                                    'We encountered an issue while processing your request.'
                                                )
        };
    }

    /* =============================================================================================
        SECTION 1: SAVE METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 2: INSERT METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 3: UPDATE METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 4: FETCH METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 5: DELETE METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 6: CHECK METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 7: GENERATE METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 8: CUSTOM METHOD
    ============================================================================================= */

    public function saveFileType(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'file_type_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $fileTypeId     = $_POST['file_type_id'] ?? null;
        $fileTypeName   = $_POST['file_type_name'] ?? null;

        $fileTypeId = $this->fileType->saveFileType(
            $fileTypeId,
            $fileTypeName,
            $lastLogBy
        );

        $encryptedFileTypeId = $this->security->encryptData($fileTypeId);

        $this->systemHelper::sendSuccessResponse(
            'Save File Type Success',
            'The file type has been saved successfully.',
            ['file_type_id' => $encryptedFileTypeId]
        );
    }

    public function deleteFileType() {
        $fileTypeId = $_POST['file_type_id'] ?? null;

        $this->fileType->deleteFileType($fileTypeId);

        $this->systemHelper::sendSuccessResponse(
            'Delete File Type Success',
            'The file type has been deleted successfully.'
        );
    }

    public function deleteMultipleFileType() {
        $fileTypeIds = $_POST['file_type_id'] ?? null;

        foreach($fileTypeIds as $fileTypeId){
            $this->fileType->deleteFileType($fileTypeId);
        }

        $this->systemHelper::sendSuccessResponse(
            'Delete Multiple File Types Success',
            'The selected file types have been deleted successfully.'
        );
    }

    public function fetchFileTypeDetails() {
        $fileTypeId             = $_POST['file_type_id'] ?? null;
        $checkFileTypeExist     = $this->fileType->checkFileTypeExist($fileTypeId);
        $total                  = $checkFileTypeExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get File Type Details',
                'The file type does not exist',
                ['notExist' => true]
            );
        }

        $fileTypeDetails = $this->fileType->fetchFileType($fileTypeId);

        $response = [
            'success'       => true,
            'fileTypeName'  => $fileTypeDetails['file_type_name'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function generateFileTypeTable() {
        $pageLink   = $_POST['page_link'] ?? null;
        $response   = [];

        $countries = $this->fileType->generateFileTypeTable();

        foreach ($countries as $row) {
            $fileTypeId     = $row['file_type_id'];
            $fileTypeName   = $row['file_type_name'];

            $fileTypeIdEncrypted = $this->security->encryptData($fileTypeId);

            $response[] = [
                'CHECK_BOX'         => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                            <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $fileTypeId .'">
                                        </div>',
                'FILE_TYPE_NAME'    => $fileTypeName,
                'LINK'              => $pageLink .'&id='. $fileTypeIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateFileTypeOptions() {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $countries = $this->fileType->generateFileTypeOptions();

        foreach ($countries as $row) {
            $response[] = [
                'id'    => $row['file_type_id'],
                'text'  => $row['file_type_name']
            ];
        }

        echo json_encode($response);
    }
}

$controller = new FileTypeController(
    new FileType(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();