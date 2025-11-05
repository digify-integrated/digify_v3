<?php
namespace App\Controllers;


session_start();

use App\Models\Import;
use App\Models\Authentication;
use App\Models\UploadSetting;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class ImportController
{
    protected Import $import;
    protected UploadSetting $uploadSetting;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        Import $import,
        UploadSetting $uploadSetting,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->import           = $import;
        $this->uploadSetting    = $uploadSetting;
        $this->authentication   = $authentication;
        $this->security         = $security;
        $this->systemHelper     = $systemHelper;
    }

    public function handleRequest() 
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
            'generate import data preview'  => $this->generateImportDataPreview(),
            'save import data'              => $this->saveImportData(),
            default                         => $this->systemHelper::sendErrorResponse(
                                                    'Transaction Failed',
                                                    'We encountered an issue while processing your request.'
                                                )
        };
    }

    public function generateImportDataPreview()
    {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'upload_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $importFileName             = $_FILES['import_file']['name'];
        $importFileSize             = $_FILES['import_file']['size'];
        $importTempName             = $_FILES['import_file']['tmp_name'];
        $importFileExtension        = explode('.', $importFileName);
        $importActualFileExtension  = strtolower(end($importFileExtension));

        $uploadSetting  = $this->uploadSetting->fetchUploadSetting(3);
        $maxFileSize    = $uploadSetting['max_file_size'];

        $uploadSettingFileExtension     = $this->uploadSetting->fetchUploadSettingFileExtension(3);
        $allowedFileExtensions          = [];

        foreach ($uploadSettingFileExtension as $row) {
            $allowedFileExtensions[] = $row['file_extension'];
        }

        if (!in_array($importActualFileExtension, $allowedFileExtensions)) {
            $this->systemHelper::sendErrorResponse(
                'Upload File',
                'The file uploaded is not supported.'
            );
        }

        if($importFileSize > ($maxFileSize * 1024)){
            $this->systemHelper::sendErrorResponse(
                'Upload File',
                'The file exceeds the maximum allowed size of ' . number_format($maxFileSize) . ' kb.'
            );
        }

        $file = fopen($importTempName, 'r');

        if ($file !== false) {
            $headers = fgetcsv($file);
    
            $data = [];

            while (($row = fgetcsv($file)) !== false) {
                $data[] = $row;
            }
    
            fclose($file);
    
            $html = '<thead class="text-center"><tr>';
            foreach ($headers as $header) {
                $html .= '<th class="fw-bold">' . htmlspecialchars($header) . '</th>';
            }
            $html .= '</tr></thead><tbody>';
    
            foreach ($data as $row) {
                $html .= '<tr>';
                foreach ($row as $cell) {
                     $html .= '<td>' . htmlspecialchars($cell) . '</td>';
                }
                $html .= '</tr>';
            }
    
            $html .= '</tbody>';

            $this->systemHelper->sendSuccessResponse(
                '',
                '',
                ['preview' => $html]
            );
        }
        else {

            $this->systemHelper::sendErrorResponse(
                'Upload File',
                'Failed to open file.'
            );
        }
    }

    public function saveImportData()
    {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'upload_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $importTableName            = $_POST['import_table_name'];
        $importFileName             = $_FILES['import_file']['name'];
        $importFileSize             = $_FILES['import_file']['size'];
        $importTempName             = $_FILES['import_file']['tmp_name'];
        $importFileExtension        = explode('.', $importFileName);
        $importActualFileExtension  = strtolower(end($importFileExtension));

        $uploadSetting  = $this->uploadSetting->fetchUploadSetting(3);
        $maxFileSize    = $uploadSetting['max_file_size'];

        $uploadSettingFileExtension     = $this->uploadSetting->fetchUploadSettingFileExtension(3);
        $allowedFileExtensions          = [];

        foreach ($uploadSettingFileExtension as $row) {
            $allowedFileExtensions[] = $row['file_extension'];
        }

        if (!in_array($importActualFileExtension, $allowedFileExtensions)) {
            $this->systemHelper::sendErrorResponse(
                'Upload File',
                'The file uploaded is not supported.'
            );
        }

        if($importFileSize > ($maxFileSize * 1024)){
            $this->systemHelper::sendErrorResponse(
                'Upload File',
                'The file exceeds the maximum allowed size of ' . number_format($maxFileSize) . ' kb.'
            );
        }

        $file = fopen($importTempName, 'r');
        if (!$file) {
            $this->systemHelper::sendErrorResponse('Upload File', 'Failed to open file.');
        }

        $headers = fgetcsv($file);
        if (!$headers) {
            $this->systemHelper::sendErrorResponse('Upload File', 'Invalid CSV file format.');                
        }

        $data = [];
        while (($row = fgetcsv($file)) !== false) {
            if (count($row) === count($headers)) {
                $data[] = $row;
            } else {
                fclose($file);
                $this->systemHelper::sendErrorResponse(
                    'Upload File',
                    'Row does not match header column count.'
                );
            }
        }
        fclose($file);

        // ✅ Build VALUES string manually here
        $allValues = [];
        foreach ($data as $row) {
            $escapedRow = array_map(function($value) {
                if ($value === null || $value === '') {
                    return 'NULL'; // Insert as NULL, not ''
                }
                return "'" . str_replace("'", "''", $value) . "'";
            }, $row);
            $allValues[] = '(' . implode(',', $escapedRow) . ')';
        }
        $valuesString = implode(',', $allValues);

        // Build other SQL parts
        $placeholders       = implode(',', array_fill(0, count($headers), '?')); 
        $columns            = implode(',', array_map(function($header) {
                                return "`" . addslashes($header) . "`";
                            }, $headers));
        $updateFields       = implode(',', array_map(function($header) {
                                return "`" . addslashes($header) . "` = VALUES(`" . addslashes($header) . "`)"; 
                            }, $headers));
        $saveImportData     = $this->import->saveImport($importTableName, $columns, $placeholders, $updateFields, $valuesString);

        // Normalize fetch() result
        if ($saveImportData === false) {
            $saveImportData = null; // success, no error
        }

        if ($saveImportData !== null && isset($saveImportData['error_message'])) {
            // Error returned by stored procedure
            $this->systemHelper->sendErrorResponse(
                'Import Data',
                'Import failed: ' . $saveImportData['error_message'] . '. Please check your file and try again.'
            );
        } else {
            // Success
            $this->systemHelper->sendSuccessResponse(
                'Import Data',
                'The data has been imported successfully.'
            );
        }
    }
}

# Bootstrap the controller
$controller = new ImportController(
    new Import(),
    new UploadSetting(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();
