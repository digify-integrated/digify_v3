<?php
namespace App\Controllers;


session_start();

use App\Models\Employee;
use App\Models\Company;
use App\Models\Department;
use App\Models\JobPosition;
use App\Models\City;
use App\Models\CivilStatus;
use App\Models\Religion;
use App\Models\BloodType;
use App\Models\Authentication;
use App\Models\UploadSetting;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class EmployeeController
{
    protected Employee $employee;
    protected Company $company;
    protected Department $department;
    protected JobPosition $jobPosition;
    protected City $city;
    protected CivilStatus $civilStatus;
    protected Religion $religion;
    protected BloodType $bloodType;
    protected Authentication $authentication;
    protected UploadSetting $uploadSetting;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        Employee $employee,
        Company $company,
        Department $department,
        JobPosition $jobPosition,
        City $city,
        CivilStatus $civilStatus,
        Religion $religion,
        BloodType $bloodType,
        Authentication $authentication,
        UploadSetting $uploadSetting,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->employee         = $employee;
        $this->company          = $company;
        $this->department       = $department;
        $this->jobPosition      = $jobPosition;
        $this->city             = $city;
        $this->civilStatus      = $civilStatus;
        $this->religion         = $religion;
        $this->bloodType        = $bloodType;
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
            'save employee'                     => $this->saveEmployee($lastLogBy),
            'update employee personal details'  => $this->updateEmployeePersonalDetails($lastLogBy),
            'update employee logo'              => $this->updateEmployeeLogo($lastLogBy),
            'delete employee'                   => $this->deleteEmployee(),
            'delete multiple employee'          => $this->deleteMultipleEmployee(),
            'fetch employee details'            => $this->fetchEmployeeDetails(),
            'generate employee card'            => $this->generateEmployeeCard(),
            'generate employee table'           => $this->generateEmployeeTable(),
            'generate employee options'         => $this->generateEmployeeOptions(),
            default                             => $this->systemHelper::sendErrorResponse(
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
        $companyId      = $_POST['company_id'] ?? null;
        $departmentId   = $_POST['department_id'] ?? null;
        $jobPositionId  = $_POST['job_position_id'] ?? null;

        $fullName = trim("{$firstName} {$middleName} {$lastName} {$suffix}");

        $companyDetails     = $this->company->fetchCompany($companyId);
        $companyName        = $companyDetails['company_name'] ?? null;

        $departmentDetails  = $this->department->fetchDepartment($departmentId);
        $departmentName     = $departmentDetails['department_name'] ?? null;

        $jobPositionDetails     = $this->jobPosition->fetchJobPosition($jobPositionId);
        $jobPositionName        = $jobPositionDetails['job_position_name'] ?? null;

        $employeeId = $this->employee->insertEmployee($fullName, $firstName, $middleName, $lastName, $suffix, $companyId, $companyName, $departmentId, $departmentName, $jobPositionId, $jobPositionName, $lastLogBy);

        $encryptedemployeeId = $this->security->encryptData($employeeId);

        $this->systemHelper->sendSuccessResponse(
            'Save Employee Success',
            'The employee has been saved successfully.',
            ['employee_id' => $encryptedemployeeId]
        );
    }

    public function updateEmployeePersonalDetails($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'personal_details_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $employeeId             = $_POST['employee_id'] ?? null;
        $firstName              = $_POST['first_name'] ?? null;
        $middleName             = $_POST['middle_name'] ?? null;
        $lastName               = $_POST['last_name'] ?? null;
        $suffix                 = $_POST['suffix'] ?? null;
        $privateAddress         = $_POST['private_address'] ?? null;
        $privateAddressCityId   = $_POST['private_address_city_id'] ?? null;
        $nickname               = $_POST['nickname'] ?? null;
        $civilStatusId          = $_POST['civil_status_id'] ?? null;
        $dependents             = $_POST['dependents'] ?? null;
        $religionId             = $_POST['religion_id'] ?? null;
        $bloodTypeId            = $_POST['blood_type_id'] ?? null;
        $homeWorkDistance       = $_POST['home_work_distance'] ?? null;
        $height                 = $_POST['height'] ?? null;
        $weight                 = $_POST['weight'] ?? null;

        $fullName = trim("{$firstName} {$middleName} {$lastName} {$suffix}");

        $privateAddressCityDetails  = $this->city->fetchCity($privateAddressCityId);
        $privateAddressCityName     = $privateAddressCityDetails['city_name'] ?? null;
        $privateAddressStateId      = $privateAddressCityDetails['state_id'] ?? null;
        $privateAddressStateName    = $privateAddressCityDetails['state_name'] ?? null;
        $privateAddressCountryId    = $privateAddressCityDetails['country_id'] ?? null;
        $privateAddressCountryName  = $privateAddressCityDetails['country_name'] ?? null;

        $civilStatusDetails     = $this->civilStatus->fetchCivilStatus($civilStatusId);
        $civilStatusName        = $civilStatusDetails['civil_status_name'] ?? null;

        $religionDetails    = $this->religion->fetchReligion($religionId);
        $religionName       = $religionDetails['religion_name'] ?? null;

        $bloodTypeDetails   = $this->bloodType->fetchBloodType($bloodTypeId);
        $bloodTypeName      = $bloodTypeDetails['blood_type_name'] ?? null;

        $this->employee->updateEmployeePersonalDetails($employeeId, $fullName, $firstName, $middleName, $lastName, $suffix, $nickname, $privateAddress, $privateAddressCityId, $privateAddressCityName, $privateAddressStateId, $privateAddressStateName, $privateAddressCountryId, $privateAddressCountryName, $civilStatusId, $civilStatusName, $dependents, $religionId, $religionName, $bloodTypeId, $bloodTypeName, $homeWorkDistance, $height, $weight, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Save Employee Personal Details Success',
            'The employee personal details has been saved successfully.'
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
            'Delete Multiple Employees Success',
            'The selected employees have been deleted successfully.'
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

        $employeeDetails    = $this->employee->fetchEmployee($employeeId);
        $employeeImage      = $this->systemHelper->checkImageExist($employeeDetails['employee_image'] ?? null, 'profile');
        $addressParts       = [
                                $employeeDetails['private_address'],
                                $employeeDetails['private_address_city_name'],
                                $employeeDetails['private_address_state_name'],
                                $employeeDetails['private_address_country_name']
                            ];

        $addressParts = array_filter($addressParts, function($part) {
            return !empty($part);
        });

        $employeeAddress = !empty($addressParts) ? implode(', ', $addressParts) : '--';

        $response = [
            'success'               => true,
            'fullName'              => $employeeDetails['full_name'] ?? null,
            'firstName'             => $employeeDetails['first_name'] ?? null,
            'middleName'            => $employeeDetails['middle_name'] ?? null,
            'lastName'              => $employeeDetails['last_name'] ?? null,
            'suffix'                => $employeeDetails['suffix'] ?? null,
            'privateAddress'        => $employeeDetails['private_address'] ?? null,
            'privateAddressCityID'  => $employeeDetails['private_address_city_id'] ?? null,
            'civilStatusID'         => $employeeDetails['civil_status_id'] ?? null,
            'religionID'            => $employeeDetails['religion_id'] ?? null,
            'bloodTypeID'           => $employeeDetails['blood_type_id'] ?? null,
            'height'                => $employeeDetails['height'] ?? null,
            'weight'                => $employeeDetails['weight'] ?? null,
            'nickname'              => $employeeDetails['nickname'] ?? null,
            'dependents'            => $employeeDetails['dependents'] ?? null,
            'homeWorkDistance'      => $employeeDetails['home_work_distance'] ?? null,
            'civilStatusName'       => $employeeDetails['civil_status_name'] ?? null,
            'religionName'          => $employeeDetails['religion_name'] ?? null,
            'bloodTypeName'         => $employeeDetails['blood_type_name'] ?? null,
            'badgeID'               => $employeeDetails['badge_id'] ?? null,
            'privateEmail'          => $employeeDetails['private_email'] ?? null,
            'privatePhone'          => $employeeDetails['private_phone'] ?? null,
            'privateTelephone'      => $employeeDetails['private_telephone'] ?? null,
            'nationalityName'       => $employeeDetails['nationality_name'] ?? null,
            'genderName'            => $employeeDetails['gender_name'] ?? null,
            'birthday'              => $this->systemHelper->checkDate('summary', $employeeDetails['birthday'] ?? null, '', 'd M Y h:i a', ''),
            'placeOfBirth'          => $employeeDetails['place_of_birth'] ?? null,
            'companyName'           => $employeeDetails['company_name'] ?? null,
            'departmentName'        => $employeeDetails['department_name'] ?? null,
            'jobPositionName'       => $employeeDetails['job_position_name'] ?? null,
            'managerName'           => $employeeDetails['manager_name'] ?? null,
            'timeOffApproverName'   => $employeeDetails['time_off_approver_name'] ?? null,
            'workLocationName'      => $employeeDetails['work_location_name'] ?? null,
            'onBoardDate'           => $this->systemHelper->checkDate('summary', $employeeDetails['on_board_date'] ?? null, '', 'd M Y h:i a', ''),
            'workEmail'             => $employeeDetails['work_email'] ?? null,
            'workPhone'             => $employeeDetails['work_phone'] ?? null,
            'workTelephone'         => $employeeDetails['work_telephone'] ?? null,
            'employeeAddress'       => $employeeAddress,
            'employeeImage'         => $employeeImage
        ];

        echo json_encode($response);
        exit;
    }

    public function generateEmployeeCard()
    {
        $pageLink               = $_POST['page_link'] ?? null;
        $searchValue            = $_POST['search_value'] ?? null;
        $companyFilter          = $this->systemHelper->checkFilter($_POST['filter_by_company'] ?? null);
        $departmentFilter       = $this->systemHelper->checkFilter($_POST['filter_by_department'] ?? null);
        $jobPositionFilter      = $this->systemHelper->checkFilter($_POST['filter_by_job_position'] ?? null);
        $employeeStatusFilter   = $this->systemHelper->checkFilter($_POST['filter_by_employee_status'] ?? null);
        $workLocationFilter     = $this->systemHelper->checkFilter($_POST['filter_by_work_location'] ?? null);
        $employmentTypeFilter   = $this->systemHelper->checkFilter($_POST['filter_by_employment_type'] ?? null);
        $genderFilter           = $this->systemHelper->checkFilter($_POST['filter_by_gender'] ?? null);
        $limit                  = $_POST['limit'] ?? null;
        $offset                 = $_POST['offset'] ?? null;
        $response               = [];

        $employees = $this->employee->generateEmployeeCard($searchValue, $companyFilter, $departmentFilter, $jobPositionFilter, $employeeStatusFilter, $workLocationFilter, $employmentTypeFilter, $genderFilter, $limit, $offset);

        foreach ($employees as $row) {
            $employeeId         = $row['employee_id'];
            $fullName           = $row['full_name'];
            $departmentName     = $row['department_name'];
            $jobPositionName    = $row['job_position_name'];
            $employmentStatus   = $row['employment_status'];
            $employeeImage      = $this->systemHelper->checkImageExist($row['employee_image'] ?? null, 'profile');

            $badgeClass             = $employmentStatus == 'Active' ? 'bg-success' : 'bg-danger';
            $employmentStatusBadge  = '<div class="'. $badgeClass .' position-absolute border border-4 border-body h-15px w-15px rounded-circle translate-middle start-100 top-100 ms-n3 mt-n3"></div>';

            $employeeIdEncrypted = $this->security->encryptData($employeeId);

            $card = '<div class="col-md-3">
                        <a href="'. $pageLink .'&id='. $employeeIdEncrypted .'" class="cursor-pointer" target="_blank">
                            <div class="card">
                                <div class="card-body d-flex flex-center flex-column pt-12 p-9">
                                    <div class="symbol symbol-65px symbol-circle mb-5">
                                        <img src="'. $employeeImage .'" alt="image">
                                        '. $employmentStatusBadge .'
                                    </div>

                                    <div class="fs-4 text-gray-800 fw-bold mb-0" target="_blank">'. $fullName .'</div>
                                    <div class="fw-semibold text-gray-500">'. $jobPositionName .'</div>
                                    <div class="fw-semibold text-gray-500">'. $departmentName .'</div>
                                </div>
                            </div>
                        </a>
                    </div>';

            $response[] = ['EMPLOYEE_CARD' => $card];
        }

        echo json_encode($response);
    }

    public function generateEmployeeTable()
    {
        $pageLink               = $_POST['page_link'] ?? null;
        $companyFilter          = $this->systemHelper->checkFilter($_POST['filter_by_company'] ?? null);
        $departmentFilter       = $this->systemHelper->checkFilter($_POST['filter_by_department'] ?? null);
        $jobPositionFilter      = $this->systemHelper->checkFilter($_POST['filter_by_job_position'] ?? null);
        $employeeStatusFilter   = $this->systemHelper->checkFilter($_POST['filter_by_employee_status'] ?? null);
        $workLocationFilter     = $this->systemHelper->checkFilter($_POST['filter_by_work_location'] ?? null);
        $employmentTypeFilter   = $this->systemHelper->checkFilter($_POST['filter_by_employment_type'] ?? null);
        $genderFilter           = $this->systemHelper->checkFilter($_POST['filter_by_gender'] ?? null);
        $response               = [];

        $employees = $this->employee->generateEmployeeTable($companyFilter, $departmentFilter, $jobPositionFilter, $employeeStatusFilter, $workLocationFilter, $employmentTypeFilter, $genderFilter);

        foreach ($employees as $row) {
            $employeeId         = $row['employee_id'];
            $fullName           = $row['full_name'];
            $departmentName     = $row['department_name'];
            $jobPositionName    = $row['job_position_name'];
            $employmentStatus   = $row['employment_status'];
            $employeeImage      = $this->systemHelper->checkImageExist($row['employee_image'] ?? null, 'profile');

            $badgeClass             = $employmentStatus == 'Active' ? 'bg-success' : 'bg-danger';
            $employmentStatusBadge  = '<div class="'. $badgeClass .' position-absolute border border-4 border-body h-15px w-15px rounded-circle translate-middle start-100 top-100 ms-n3 mt-n3"></div>';

            $employeeIdEncrypted = $this->security->encryptData($employeeId);

            $response[] = [
                'CHECK_BOX'     => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                        <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $employeeId .'">
                                    </div>',
                'EMPLOYEE'      => '<div class="d-flex align-items-center">
                                        <div class="me-4">
                                            <div class="symbol symbol-50px symbol-circle mb-5">
                                                <img src="'. $employeeImage .'" alt="image">
                                                '. $employmentStatusBadge .'
                                            </div>
                                        </div>
                                        <div class="d-flex flex-column">
                                            <span class="text-gray-800 mb-1">'. $fullName .'</span>
                                            <span class="text-gray-600">'. $jobPositionName .'</span>
                                        </div>
                                    </div>',
                'DEPARTMENT'    => $departmentName,
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
    new Company(),
    new Department(),
    new JobPosition(),
    new City(),
    new CivilStatus(),
    new Religion(),
    new BloodType(),
    new Authentication(),
    new UploadSetting(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();
