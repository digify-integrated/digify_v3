<?php
namespace App\Controllers;


session_start();

use App\Models\Employee;
use App\Models\City;
use App\Models\Currency;
use App\Models\Authentication;
use App\Models\UploadSetting;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class EmployeeController
{
    protected Employee $employee;
    protected City $city;
    protected Currency $currency;
    protected Authentication $authentication;
    protected UploadSetting $uploadSetting;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        Employee $employee,
        City $city,
        Currency $currency,
        Authentication $authentication,
        UploadSetting $uploadSetting,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->employee          = $employee;
        $this->city             = $city;
        $this->currency         = $currency;
        $this->authentication   = $authentication;
        $this->uploadSetting    = $uploadSetting;
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
            'save employee'               => $this->saveEmployee($lastLogBy),
            'update employee logo'        => $this->updateEmployeeLogo($lastLogBy),
            'delete employee'             => $this->deleteEmployee(),
            'delete multiple employee'    => $this->deleteMultipleEmployee(),
            'fetch employee details'      => $this->fetchEmployeeDetails(),
            'generate employee table'     => $this->generateEmployeeTable(),
            'generate employee options'   => $this->generateEmployeeOptions(),
            default                      => $this->systemHelper::sendErrorResponse(
                                                'Transaction Failed',
                                                'We encountered an issue while processing your request.'
                                            )
        };
    }

    public function saveEmployee($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'employee_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $firstName      = $_POST['first_name'] ?? null;
        $middleName     = $_POST['middle_name'] ?? null;
        $lastName       = $_POST['last_name'] ?? null;
        $suffix         = $_POST['suffix'] ?? null;

        $fullName = $firstName . ' ' . $middleName . ' ' . $lastName . ' ' . $suffix;

        $employeeId = $this->employee->insertEmployee($fullName, $firstName, $middleName, $lastName, $suffix, $lastLogBy);

        $encryptedemployeeId = $this->security->encryptData($employeeId);

        $this->systemHelper->sendSuccessResponse(
            'Save Employee Success',
            'The employee has been saved successfully.',
            ['employee_id' => $encryptedemployeeId]
        );
    }

    public function updateEmployeeLogo($lastLogBy){

        $employeeId   = $_POST['employee_id'] ?? null;
       
        $employeeLogoFileName               = $_FILES['employee_logo']['name'];
        $employeeLogoFileSize               = $_FILES['employee_logo']['size'];
        $employeeLogoFileError              = $_FILES['employee_logo']['error'];
        $employeeLogoTempName               = $_FILES['employee_logo']['tmp_name'];
        $employeeLogoFileExtension          = explode('.', $employeeLogoFileName);
        $employeeLogoActualFileExtension    = strtolower(end($employeeLogoFileExtension));

        $uploadSetting  = $this->uploadSetting->fetchUploadSetting(5);
        $maxFileSize    = $uploadSetting['max_file_size'];

        $uploadSettingFileExtension = $this->uploadSetting->fetchUploadSettingFileExtension(5);
        $allowedFileExtensions = [];

        foreach ($uploadSettingFileExtension as $row) {
            $allowedFileExtensions[] = $row['file_extension'];
        }

        if (!in_array($employeeLogoActualFileExtension, $allowedFileExtensions)) {              
            $this->systemHelper::sendErrorResponse(
                'Update Employee Logo Error', 
                'The file uploaded is not supported.'
            );
        }
            
        if(empty($employeeLogoTempName)){
            $this->systemHelper::sendErrorResponse(
                'Update Employee Logo Error', 
                'Please choose the app logo.'
            );
        }
            
        if($employeeLogoFileError){                
            $this->systemHelper::sendErrorResponse(
                'Update Employee Logo Error', 
                'An error occurred while uploading the file.'
            );
        }
            
        if($employeeLogoFileSize > ($maxFileSize * 1024)){
            $this->systemHelper::sendErrorResponse(
                'Update Employee Logo Error', 
                'The employee logo exceeds the maximum allowed size of ' . $maxFileSize . ' mb.'
            );
        }

        $fileName   = $this->security->generateFileName();
        $fileNew    = $fileName . '.' . $employeeLogoActualFileExtension;
            
        define('PROJECT_BASE_DIR', dirname(__DIR__, 2));

        $uploadsDir         = PROJECT_BASE_DIR . '/storage/uploads/';
        $directory          = $uploadsDir . 'employee/' . $employeeId . '/';
        $fileDestination    = $directory . $fileNew;
        $filePath           = 'storage/uploads/employee/' . $employeeId . '/' . $fileNew;

        $directoryChecker = $this->security->directoryChecker($directory);

        if ($directoryChecker !== true) {
            $this->systemHelper::sendErrorResponse(
                'Update Employee Logo Error',
                $directoryChecker
            );
        }

        $employeeDetails     = $this->employee->fetchEmployee($employeeId);
        $employeeLogo        = $this->systemHelper->checkImageExist($employeeDetails['employee_logo'] ?? null, 'null');
        $deleteImageFile    = $this->systemHelper->deleteFileIfExist($employeeLogo);

        if(!$deleteImageFile){
            $this->systemHelper::sendErrorResponse(
                'Update Employee Logo Error', 
                'The employee logo cannot be deleted due to an error'
            );
        }

        if(!move_uploaded_file($employeeLogoTempName, $fileDestination)){
            $this->systemHelper::sendErrorResponse(
                'Update Employee Logo Error', 
                'The employee logo cannot be uploaded due to an error'
            );
        }

        $this->employee->updateEmployeeLogo($employeeId, $filePath, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Update Employee Logo Success',
            'The employee logo has been updated successfully.'
        );
    }

    public function deleteEmployee(){
        $employeeId         = $_POST['employee_id'] ?? null;
        $employeeDetails    = $this->employee->fetchEmployee($employeeId);
        $employeeLogo       = $this->systemHelper->checkImageExist($employeeDetails['employee_logo'] ?? null, 'null');

        $deleteImageFile = $this->systemHelper->deleteFileIfExist($employeeLogo);

        if(!$deleteImageFile){
            $this->systemHelper::sendErrorResponse(
                'Delete Employee Error', 
                'The app logo cannot be deleted due to an error'
            );
        }

        $this->employee->deleteEmployee($employeeId);

        $this->systemHelper->sendSuccessResponse(
            'Delete Employee Success',
            'The employee has been deleted successfully.'
        );
    }

    public function deleteMultipleEmployee(){
        $employeeIds = $_POST['employee_id'] ?? null;

        foreach($employeeIds as $employeeId){
            $employeeDetails    = $this->employee->fetchEmployee($employeeId);
            $employeeLogo       = $this->systemHelper->checkImageExist($employeeDetails['employee_logo'] ?? null, 'null');

            $this->systemHelper->deleteFileIfExist($employeeLogo);

            $this->employee->deleteEmployee($employeeId);
        }

        $this->systemHelper->sendSuccessResponse(
            'Delete Multiple Companies Success',
            'The selected companies have been deleted successfully.'
        );
    }

    public function fetchEmployeeDetails(){
        $employeeId             = $_POST['employee_id'] ?? null;
        $checkEmployeeExist     = $this->employee->checkEmployeeExist($employeeId);
        $total                  = $checkEmployeeExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper->sendErrorResponse(
                'Get Employee Details',
                'The employee does not exist',
                ['notExist' => true]
            );
        }

        $employeeDetails     = $this->employee->fetchEmployee($employeeId);
        $employeeLogo        = $this->systemHelper->checkImageExist($employeeDetails['employee_logo'] ?? null, 'employee logo');

        $response = [
            'success'       => true,
            'employeeName'  => $employeeDetails['employee_name'] ?? null,
            'address'       => $employeeDetails['address'] ?? null,
            'cityID'        => $employeeDetails['city_id'] ?? null,
            'taxID'         => $employeeDetails['tax_id'] ?? null,
            'currencyID'    => $employeeDetails['currency_id'] ?? null,
            'phone'         => $employeeDetails['phone'] ?? null,
            'telephone'     => $employeeDetails['telephone'] ?? null,
            'email'         => $employeeDetails['email'] ?? null,
            'website'       => $employeeDetails['website'] ?? null,
            'employeeLogo'  => $employeeLogo
        ];

        echo json_encode($response);
        exit;
    }

    public function generateEmployeeTable()
    {
        $pageLink           = $_POST['page_link'] ?? null;
        $cityFilter         = $this->systemHelper->checkFilter($_POST['city_filter'] ?? null);
        $stateFilter        = $this->systemHelper->checkFilter($_POST['state_filter'] ?? null);
        $countryFilter      = $this->systemHelper->checkFilter($_POST['country_filter'] ?? null);
        $currencyFilter     = $this->systemHelper->checkFilter($_POST['currency_filter'] ?? null);
        $response   = [];

        $employees = $this->employee->generateEmployeeTable($cityFilter, $stateFilter, $countryFilter, $currencyFilter);

        foreach ($employees as $row) {
            $employeeId             = $row['employee_id'];
            $employeeName           = $row['employee_name'];
            $address                = $row['address'];
            $cityName               = $row['city_name'];
            $stateName              = $row['state_name'];
            $countryName            = $row['country_name'];
            $employeeAddress        = $address . ', ' . $cityName . ', ' . $stateName . ', ' . $countryName;
            $employeeLogo           = $this->systemHelper->checkImageExist($row['employee_logo'] ?? null, 'employee logo');
            $employeeIdEncrypted    = $this->security->encryptData($employeeId);

            $response[] = [
                'CHECK_BOX'     => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                        <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $employeeId .'">
                                    </div>',
                'COMPANY_NAME'  => '<div class="d-flex align-items-center">
                                        <div class="symbol symbol-circle symbol-50px overflow-hidden me-3">
                                            <div class="symbol-label">
                                                <img src="'. $employeeLogo .'" alt="'. $employeeName .'" class="w-100">
                                            </div>
                                        </div>
                                        <div class="d-flex flex-column">
                                            <span class="text-gray-800 fw-bold mb-1">'. $employeeName .'</span>
                                            <small class="text-gray-600">'. $employeeAddress .'</small>
                                        </div>
                                    </div>',
                'LINK'          => $pageLink .'&id='. $employeeIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateEmployeeOptions()
    {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $employees = $this->employee->generateEmployeeOptions();

        foreach ($employees as $row) {
            $response[] = [
                'id'    => $row['employee_id'],
                'text'  => $row['employee_name']
            ];
        }

        echo json_encode($response);
    }
}

# Bootstrap the controller
$controller = new EmployeeController(
    new Employee(),
    new City(),
    new Currency(),
    new Authentication(),
    new UploadSetting(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();
