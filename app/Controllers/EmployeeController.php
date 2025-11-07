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
use App\Models\Nationality;
use App\Models\Gender;
use App\Models\EmploymentType;
use App\Models\EmploymentLocationType;
use App\Models\WorkLocation;
use App\Models\Language;
use App\Models\LanguageProficiency;
use App\Models\Relationship;
use App\Models\EmployeeDocumentType;
use App\Models\DepartureReason;
use App\Models\Authentication;
use App\Models\UploadSetting;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class EmployeeController {
    protected Employee $employee;
    protected Company $company;
    protected Department $department;
    protected JobPosition $jobPosition;
    protected City $city;
    protected CivilStatus $civilStatus;
    protected Religion $religion;
    protected BloodType $bloodType;
    protected Nationality $nationality;
    protected Gender $gender;
    protected EmploymentType $employmentType;
    protected EmploymentLocationType $employmentLocationType;
    protected WorkLocation $workLocation;
    protected Language $language;
    protected LanguageProficiency $languageProficiency;
    protected Relationship $relationship;
    protected EmployeeDocumentType $employeeDocumentType;
    protected DepartureReason $departureReason;
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
        Nationality $nationality,
        Gender $gender,
        EmploymentType $employmentType,
        EmploymentLocationType $employmentLocationType,
        WorkLocation $workLocation,
        Language $language,
        LanguageProficiency $languageProficiency,
        Relationship $relationship,
        EmployeeDocumentType $employeeDocumentType,
        DepartureReason $departureReason,
        Authentication $authentication,
        UploadSetting $uploadSetting,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->employee                 = $employee;
        $this->company                  = $company;
        $this->department               = $department;
        $this->jobPosition              = $jobPosition;
        $this->city                     = $city;
        $this->civilStatus              = $civilStatus;
        $this->religion                 = $religion;
        $this->bloodType                = $bloodType;
        $this->nationality              = $nationality;
        $this->gender                   = $gender;
        $this->employmentType           = $employmentType;
        $this->employmentLocationType   = $employmentLocationType;
        $this->workLocation             = $workLocation;
        $this->language                 = $language;
        $this->languageProficiency      = $languageProficiency;
        $this->relationship             = $relationship;
        $this->employeeDocumentType     = $employeeDocumentType;
        $this->departureReason          = $departureReason;
        $this->authentication           = $authentication;
        $this->uploadSetting            = $uploadSetting;
        $this->security                 = $security;
        $this->systemHelper             = $systemHelper;
    }

    public function handleRequest() {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Only POST requests are allowed.'
            );
        }

        $transaction    = $_POST['transaction'] ?? null;
        $pageId         = $_POST['page_id'] ?? null;
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
            'save employee'                             => $this->saveEmployee($lastLogBy),
            'save employee language'                    => $this->saveEmployeeLanguage($lastLogBy),
            'save employee education'                   => $this->saveEmployeeEducation($lastLogBy),
            'save employee emergency contact'           => $this->saveEmployeeEmergencyContact($lastLogBy),
            'save employee license'                     => $this->saveEmployeeLicense($lastLogBy),
            'save employee experience'                  => $this->saveEmployeeExperience($lastLogBy),
            'insert employee document'                  => $this->insertEmployeeDocument($lastLogBy),
            'update employee personal details'          => $this->updateEmployeePersonalDetails($lastLogBy),
            'update employee pin code'                  => $this->updateEmployeePINCode($lastLogBy),
            'update employee badge id'                  => $this->updateEmployeeBadgeId($lastLogBy),
            'update employee private email'             => $this->updateEmployeePrivateEmail($lastLogBy),
            'update employee private phone'             => $this->updateEmployeePrivatePhone($lastLogBy),
            'update employee private telephone'         => $this->updateEmployeePrivateTelephone($lastLogBy),
            'update employee nationality'               => $this->updateEmployeeNationality($lastLogBy),
            'update employee gender'                    => $this->updateEmployeeGender($lastLogBy),
            'update employee birthday'                  => $this->updateEmployeeBirthday($lastLogBy),
            'update employee place of birth'            => $this->updateEmployeePlaceOfBirth($lastLogBy),
            'update employee company'                   => $this->updateEmployeeCompany($lastLogBy),
            'update employee department'                => $this->updateEmployeeDepartment($lastLogBy),
            'update employee job position'              => $this->updateEmployeeJobPosition($lastLogBy),
            'update employee manager'                   => $this->updateEmployeeManager($lastLogBy),
            'update employee time off approver'         => $this->updateEmployeeTimeOffApprover($lastLogBy),
            'update employee employment type'           => $this->updateEmployeeEmploymentType($lastLogBy),
            'update employee employment location type'  => $this->updateEmployeeEmploymentLocationType($lastLogBy),
            'update employee work location'             => $this->updateEmployeeWorkLocation($lastLogBy),
            'update employee on board date'             => $this->updateEmployeeOnBoardDate($lastLogBy),
            'update employee work email'                => $this->updateEmployeeWorkEmail($lastLogBy),
            'update employee work phone'                => $this->updateEmployeeWorkPhone($lastLogBy),
            'update employee work telephone'            => $this->updateEmployeeWorkTelephone($lastLogBy),
            'update employee image'                     => $this->updateEmployeeImage($lastLogBy),
            'update employee archive'                   => $this->updateEmployeeArchive($lastLogBy),
            'update employee unarchive'                 => $this->updateEmployeeUnarchive($lastLogBy),
            'delete employee'                           => $this->deleteEmployee(),
            'delete multiple employee'                  => $this->deleteMultipleEmployee(),
            'delete employee language'                  => $this->deleteEmployeeLanguage(),
            'delete employee education'                 => $this->deleteEmployeeEducation(),
            'delete employee emergency contact'         => $this->deleteEmployeeEmergencyContact(),
            'delete employee license'                   => $this->deleteEmployeeLicense(),
            'delete employee experience'                => $this->deleteEmployeeExperience(),
            'delete employee document'                  => $this->deleteEmployeeDocument(),
            'fetch employee details'                    => $this->fetchEmployeeDetails(),
            'fetch employee education details'          => $this->fetchEmployeeEducationDetails(),
            'fetch employee emergency contact details'  => $this->fetchEmployeeEmergencyContactDetails(),
            'fetch employee license details'            => $this->fetchEmployeeLicenseDetails(),
            'fetch employee experience details'         => $this->fetchEmployeeExperienceDetails(),
            'generate employee card'                    => $this->generateEmployeeCard(),
            'generate employee table'                   => $this->generateEmployeeTable(),
            'generate employee options'                 => $this->generateEmployeeOptions(),
            'generate employee language list'           => $this->generateEmployeeLanguageList($lastLogBy, $pageId),
            'generate employee education list'          => $this->generateEmployeeEducationList($lastLogBy, $pageId),
            'generate employee emergency contact list'  => $this->generateEmployeeEmergencyContactList($lastLogBy, $pageId),
            'generate employee license list'            => $this->generateEmployeeLicenseList($lastLogBy, $pageId),
            'generate employee experience list'         => $this->generateEmployeeExperienceList($lastLogBy, $pageId),
            'generate employee document table'          => $this->generateEmployeeDocumentTable($lastLogBy, $pageId),
            default                                     => $this->systemHelper::sendErrorResponse(
                                                                'Transaction Failed',
                                                                'We encountered an issue while processing your request.'
                                                            )
        };
    }

    /* =============================================================================================
        SECTION 1: SAVE METHOD
    ============================================================================================= */

    public function saveEmployee(
        int $lastLogBy
    ) {
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

        $employeeId = $this->employee->insertEmployee(
            $fullName,
            $firstName,
            $middleName,
            $lastName,
            $suffix,
            $companyId,
            $companyName,
            $departmentId,
            $departmentName,
            $jobPositionId,
            $jobPositionName,
            $lastLogBy
        );

        $encryptedemployeeId = $this->security->encryptData($employeeId);

        $this->systemHelper::sendSuccessResponse(
            'Save Employee Success',
            'The employee has been saved successfully.',
            ['employee_id' => $encryptedemployeeId]
        );
    }

    public function saveEmployeeLanguage(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'employee_language_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $employeeId             = $_POST['employee_id'] ?? null;
        $languageId             = $_POST['language_id'] ?? null;
        $languageProficiencyId  = $_POST['language_proficiency_id'] ?? null;

        $languageDetails    = $this->language->fetchLanguage($languageId);
        $languageName       = $languageDetails['language_name'] ?? null;

        $languageProficiency        = $this->languageProficiency->fetchLanguageProficiency($languageProficiencyId);
        $languageProficiencyname    = $languageProficiency['language_proficiency_name'] ?? null;

        $this->employee->saveEmployeeLanguage(
            $employeeId,
            $languageId,
            $languageName,
            $languageProficiencyId,
            $languageProficiencyname,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Save Employee Language Success',
            'The employee language has been saved successfully.'
        );
    }

    public function saveEmployeeEducation(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'employee_education_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $employeeId             = $_POST['employee_id'] ?? null;
        $employeeEducationId    = $_POST['employee_education_id'] ?? null;
        $school                 = $_POST['school'] ?? null;
        $degree                 = $_POST['degree'] ?? null;
        $fieldOfStudy           = $_POST['field_of_study'] ?? null;
        $startMonth             = $_POST['start_month'] ?? null;
        $startYear              = $_POST['start_year'] ?? null;
        $endMonth               = $_POST['end_month'] ?? null;
        $endYear                = $_POST['end_year'] ?? null;
        $activitiesSocieties    = $_POST['activities_societies'] ?? null;
        $educationDescription   = $_POST['education_description'] ?? null;

        $this->employee->saveEmployeeEducation(
            $employeeEducationId,
            $employeeId,
            $school,
            $degree,
            $fieldOfStudy,
            $startMonth,
            $startYear,
            $endMonth,
            $endYear,
            $activitiesSocieties,
            $educationDescription,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Save Employee Educational Background Success',
            'The employee educational background has been saved successfully.'
        );
    }

    public function saveEmployeeEmergencyContact(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'employee_emergency_contact_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $employeeId                     = $_POST['employee_id'] ?? null;
        $employeeEmergencyContactId     = $_POST['employee_emergency_contact_id'] ?? null;
        $emergencyContactName           = $_POST['emergency_contact_name'] ?? null;
        $relationshipId                 = $_POST['relationship_id'] ?? null;
        $telephone                      = $_POST['emergency_contact_telephone'] ?? null;
        $mobile                         = $_POST['emergency_contact_mobile'] ?? null;
        $email                          = $_POST['emergency_contact_email'] ?? null;

        $relationshipDetails    = $this->relationship->fetchRelationship($relationshipId);
        $relationshipName       = $relationshipDetails['relationship_name'] ?? null;

        $this->employee->saveEmployeeEmergencyContact(
            $employeeEmergencyContactId,
            $employeeId,
            $emergencyContactName,
            $relationshipId,
            $relationshipName,
            $telephone,
            $mobile,
            $email,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Save Employee Emergency Contact Success',
            'The employee emergency contact has been saved successfully.'
        );
    }

    public function saveEmployeeLicense(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'employee_license_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $employeeId             = $_POST['employee_id'] ?? null;
        $employeeLicenseId      = $_POST['employee_license_id'] ?? null;
        $licensedProfession     = $_POST['licensed_profession'] ?? null;
        $licensingBody          = $_POST['licensing_body'] ?? null;
        $licenseNumber          = $_POST['license_number'] ?? null;
        $issueDate              = $this->systemHelper->checkDate('empty', $_POST['issue_date'], '', 'Y-m-d', '');
        $expirationDate         = $this->systemHelper->checkDate('empty', $_POST['expiration_date'], '', 'Y-m-d', '');

        $this->employee->saveEmployeeLicense(
            $employeeLicenseId,
            $employeeId,
            $licensedProfession,
            $licensingBody,
            $licenseNumber,
            $issueDate,
            $expirationDate,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Save Employee License Success',
            'The employee license has been saved successfully.'
        );
    }

    public function saveEmployeeExperience(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'employee_experience_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $employeeId             = $_POST['employee_id'] ?? null;
        $employeeExperienceId   = $_POST['employee_experience_id'] ?? null;
        $jobTitle               = $_POST['job_title'] ?? null;
        $employmentTypeId       = $_POST['employee_experience_employment_type_id'] ?? null;
        $companyName            = $_POST['company_name'] ?? null;
        $location               = $_POST['location'] ?? null;
        $startMonth             = $_POST['employee_experience_start_month'] ?? null;
        $startYear              = $_POST['employee_experience_start_year'] ?? null;
        $endMonth               = $_POST['employee_experience_end_month'] ?? null;
        $endYear                = $_POST['employee_experience_end_year'] ?? null;
        $jobDescription         = $_POST['job_description'] ?? null;

        $employmentTypeDetails  = $this->employmentType->fetchEmploymentType($employmentTypeId);
        $employmentTypeName     = $employmentTypeDetails['employment_type_name'] ?? null;

        $this->employee->saveEmployeeExperience(
            $employeeExperienceId,
            $employeeId,
            $jobTitle,
            $employmentTypeId,
            $employmentTypeName,
            $companyName,
            $location,
            $startMonth,
            $startYear,
            $endMonth,
            $endYear,
            $jobDescription,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Save Employee Work Experience Success',
            'The employee work experience has been saved successfully.'
        );
    }

    /* =============================================================================================
        SECTION 2: INSERT METHOD
    ============================================================================================= */

    public function insertEmployeeDocument(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'employee_document_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $employeeId                 = $_POST['employee_id'] ?? null;
        $documentName               = $_POST['document_name'] ?? null;
        $employeeDocumentTypeId     = $_POST['employee_document_type_id'] ?? null;

        if (!isset($_FILES['document_file'])) {
            $this->systemHelper::sendErrorResponse(
                'Save Employee Document Error', 
                'No document file was uploaded.'
            );
        }
       
        $documentFileFileName               = $_FILES['document_file']['name'];
        $documentFileFileSize               = $_FILES['document_file']['size'];
        $documentFileFileError              = $_FILES['document_file']['error'];
        $documentFileTempName               = $_FILES['document_file']['tmp_name'];
        $documentFileFileExtension          = explode('.', $documentFileFileName);
        $documentFileActualFileExtension    = strtolower(end($documentFileFileExtension));

        $uploadSetting  = $this->uploadSetting->fetchUploadSetting(7);
        $maxFileSize    = $uploadSetting['max_file_size'];

        $uploadSettingFileExtension     = $this->uploadSetting->fetchUploadSettingFileExtension(7);
        $allowedFileExtensions          = [];

        foreach ($uploadSettingFileExtension as $row) {
            $allowedFileExtensions[] = $row['file_extension'];
        }

        if (!in_array($documentFileActualFileExtension, $allowedFileExtensions)) {              
            $this->systemHelper::sendErrorResponse(
                'Save Employee Document Error', 
                'The file uploaded is not supported.'
            );
        }
                
        if(empty($documentFileTempName)){
            $this->systemHelper::sendErrorResponse(
                'Save Employee Document Error', 
                'Please choose the employee document.'
            );
        }
                
        if($documentFileFileError){                
            $this->systemHelper::sendErrorResponse(
                'Save Employee Document Error', 
                'An error occurred while uploading the file.'
            );
        }
                
        if($documentFileFileSize > ($maxFileSize * 1024)){
            $this->systemHelper::sendErrorResponse(
                'Save Employee Document Error', 
                'The employee document exceeds the maximum allowed size of ' . $maxFileSize . ' mb.'
            );
        }

        $fileName   = $this->security->generateFileName();
        $fileNew    = $fileName . '.' . $documentFileActualFileExtension;
                
        define('PROJECT_BASE_DIR', dirname(__DIR__, 2));

        $uploadsDir         = PROJECT_BASE_DIR . '/storage/uploads/';
        $directory          = $uploadsDir . 'employee/' . $employeeId . '/document/';
        $fileDestination    = $directory . $fileNew;
        $filePath           = 'storage/uploads/employee/' . $employeeId . '/document/' . $fileNew;

        $directoryChecker = $this->security->directoryChecker($directory);

        if ($directoryChecker !== true) {
            $this->systemHelper::sendErrorResponse(
                'Save Employee Document Error',
                $directoryChecker
            );
        }

        if(!move_uploaded_file($documentFileTempName, $fileDestination)){
            $this->systemHelper::sendErrorResponse(
                'Save Employee Document Error', 
                'The employee document cannot be uploaded due to an error'
            );
        }

        $employeeDocumentTypeDetails    = $this->employeeDocumentType->fetchEmployeeDocumentType($employeeDocumentTypeId);
        $employeeDocumentTypeName       = $employeeDocumentTypeDetails['employee_document_type_name'] ?? null;

        $this->employee->insertEmployeeDocument(
            $employeeId,
            $documentName,
            $filePath,
            $employeeDocumentTypeId,
            $employeeDocumentTypeName,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Save Employee Document Success',
            'The employee document has been saved successfully.'
        );
    }

    /* =============================================================================================
        SECTION 3: UPDATE METHOD
    ============================================================================================= */

    public function updateEmployeePersonalDetails(
        int $lastLogBy
    ) {
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
        $homeWorkDistance       = $_POST['home_work_distance'] ?? 0;
        $height                 = $_POST['height'] ?? 0;
        $weight                 = $_POST['weight'] ?? 0;

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
        $religionName       = $religionDetails['religion_name'] ?? '';

        $bloodTypeDetails   = $this->bloodType->fetchBloodType(p_blood_type_id: $bloodTypeId);
        $bloodTypeName      = $bloodTypeDetails['blood_type_name'] ?? '';

        $this->employee->updateEmployeePersonalDetails(
            $employeeId,
            $fullName,
            $firstName,
            $middleName,
            $lastName,
            $suffix,
            $nickname,
            $privateAddress,
            $privateAddressCityId,
            $privateAddressCityName,
            $privateAddressStateId,
            $privateAddressStateName,
            $privateAddressCountryId,
            $privateAddressCountryName,
            $civilStatusId,
            $civilStatusName,
            $dependents,
            $religionId,
            $religionName,
            $bloodTypeId,
            $bloodTypeName,
            $homeWorkDistance,
            $height,
            $weight,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Save Employee Personal Details Success',
            'The employee personal details has been saved successfully.'
        );
    }

    public function updateEmployeePINCode(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_pin_code_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $employeeId     = $_POST['employee_id'] ?? null;
        $pinCode        = $_POST['pin_code'] ?? null;
        $hashedPINCode  = password_hash($pinCode, PASSWORD_BCRYPT);

        $this->employee->updateEmployeePINCode(
            $employeeId,
            $hashedPINCode,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Save Employee PIN Code Success',
            'The employee pin code has been saved successfully.'
        );
    }

    public function updateEmployeeBadgeId(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_badge_id_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $employeeId     = $_POST['employee_id'] ?? null;
        $badgeId        = $_POST['badge_id'] ?? null;

        $this->employee->updateEmployeeBadgeId(
            $employeeId,
            $badgeId,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Save Employee Badge ID Success',
            'The employee badge ID has been saved successfully.'
        );
    }

    public function updateEmployeePrivateEmail(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_private_email_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $employeeId     = $_POST['employee_id'] ?? null;
        $privateEmail   = $_POST['private_email'] ?? null;

        $this->employee->updateEmployeePrivateEmail(
            $employeeId,
            $privateEmail,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Save Employee Private Email Success',
            'The employee private email has been saved successfully.'
        );
    }

    public function updateEmployeePrivatePhone(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_private_phone_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $employeeId     = $_POST['employee_id'] ?? null;
        $privatePhone   = $_POST['private_phone'] ?? null;

        $this->employee->updateEmployeePrivatePhone(
            $employeeId,
            $privatePhone,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Save Employee Private Phone Success',
            'The employee private phone has been saved successfully.'
        );
    }

    public function updateEmployeePrivateTelephone(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_private_telephone_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $employeeId         = $_POST['employee_id'] ?? null;
        $privateTelephone   = $_POST['private_telephone'] ?? null;

        $this->employee->updateEmployeePrivateTelephone(
            $employeeId,
            $privateTelephone,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Save Employee Private Telephone Success',
            'The employee private telephone has been saved successfully.'
        );
    }

    public function updateEmployeeNationality(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_nationality_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $employeeId     = $_POST['employee_id'] ?? null;
        $nationalityId  = $_POST['nationality_id'] ?? null;

        $nationalityDetails = $this->nationality->fetchNationality($nationalityId);
        $nationalityName = $nationalityDetails['nationality_name'] ?? null;

        $this->employee->updateEmployeeNationality(
            $employeeId,
            $nationalityId,
            $nationalityName,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Save Employee Nationality Success',
            'The employee nationality has been saved successfully.'
        );
    }

    public function updateEmployeeGender(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_gender_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $employeeId     = $_POST['employee_id'] ?? null;
        $genderId       = $_POST['gender_id'] ?? null;

        $genderDetails  = $this->gender->fetchGender($genderId);
        $genderName     = $genderDetails['gender_name'] ?? null;

        $this->employee->updateEmployeeGender(
            $employeeId,
            $genderId,
            $genderName,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Save Employee Gender Success',
            'The employee gender has been saved successfully.'
        );
    }

    public function updateEmployeeBirthday(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_birthday_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $employeeId     = $_POST['employee_id'] ?? null;
        $birthday       = $this->systemHelper->checkDate('empty', $_POST['birthday'], '', 'Y-m-d', '');

        $this->employee->updateEmployeeBirthday(
            $employeeId,
            $birthday,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Save Employee Date of Birth Success',
            'The employee date of birth has been saved successfully.'
        );
    }

    public function updateEmployeePlaceOfBirth(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_place_of_birth_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $employeeId     = $_POST['employee_id'] ?? null;
        $placeOfBirth   = $_POST['place_of_birth'] ?? null;

        $this->employee->updateEmployeePlaceOfBirth(
            $employeeId,
            $placeOfBirth,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Save Employee Place of Birth Success',
            'The employee place of birth has been saved successfully.'
        );
    }

    public function updateEmployeeCompany(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_company_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $employeeId     = $_POST['employee_id'] ?? null;
        $companyId      = $_POST['company_id'] ?? null;

        $companyDetails     = $this->company->fetchCompany($companyId);
        $companyName        = $companyDetails['company_name'] ?? null;

        $this->employee->updateEmployeeCompany(
            $employeeId,
            $companyId,
            $companyName,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Save Employee Company Success',
            'The employee company has been saved successfully.'
        );
    }

    public function updateEmployeeDepartment(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_department_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $employeeId     = $_POST['employee_id'] ?? null;
        $departmentId   = $_POST['department_id'] ?? null;

        $departmentDetails  = $this->department->fetchDepartment($departmentId);
        $departmentName     = $departmentDetails['department_name'] ?? null;

        $this->employee->updateEmployeeDepartment(
            $employeeId,
            $departmentId,
            $departmentName,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Save Employee Department Success',
            'The employee department has been saved successfully.'
        );
    }

    public function updateEmployeeJobPosition(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_job_position_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $employeeId     = $_POST['employee_id'] ?? null;
        $jobPositionId  = $_POST['job_position_id'] ?? null;

        $jobPositionDetails     = $this->jobPosition->fetchJobPosition($jobPositionId);
        $jobPositionName        = $jobPositionDetails['job_position_name'] ?? null;

        $this->employee->updateEmployeeJobPosition(
            $employeeId,
            $jobPositionId,
            $jobPositionName,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Save Employee Job Position Success',
            'The employee job position has been saved successfully.'
        );
    }

    public function updateEmployeeManager(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_manager_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $employeeId     = $_POST['employee_id'] ?? null;
        $managerId      = $_POST['manager_id'] ?? null;

        $manageDetails  = $this->employee->fetchEmployee($managerId);
        $manageName     = $manageDetails['full_name'] ?? null;

        $this->employee->updateEmployeeManager(
            $employeeId,
            $managerId,
            $manageName,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Save Employee Manager Success',
            'The employee manager has been saved successfully.'
        );
    }

    public function updateEmployeeTimeOffApprover(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_time_off_approver_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $employeeId         = $_POST['employee_id'] ?? null;
        $timeOffApproverId  = $_POST['time_off_approver_id'] ?? null;

        $timeOffApproverDetails     = $this->employee->fetchEmployee($timeOffApproverId);
        $timeOffApproverName        = $timeOffApproverDetails['full_name'] ?? null;

        $this->employee->updateEmployeeTimeOffApprover(
            $employeeId,
            $timeOffApproverId,
            $timeOffApproverName,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Save Employee Time Off Approver Success',
            'The employee time off approver has been saved successfully.'
        );
    }

    public function updateEmployeeEmploymentType(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_employment_type_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $employeeId         = $_POST['employee_id'] ?? null;
        $employmentTypeId   = $_POST['employment_type_id'] ?? null;

        $employmentTypeDetails  = $this->employmentType->fetchEmploymentType($employmentTypeId);
        $employmentTypeName     = $employmentTypeDetails['employment_type_name'] ?? null;

        $this->employee->updateEmployeeEmploymentType(
            $employeeId,
            $employmentTypeId,
            $employmentTypeName,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Save Employee Employment Type Success',
            'The employee employment type has been saved successfully.'
        );
    }

    public function updateEmployeeEmploymentLocationType(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_employment_location_type_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $employeeId                 = $_POST['employee_id'] ?? null;
        $employmentLocationTypeId   = $_POST['employment_location_type_id'] ?? null;

        $employmentTLocationypeDetails  = $this->employmentLocationType->fetchEmploymentLocationType($employmentLocationTypeId);
        $employmentLocationTypeName     = $employmentTLocationypeDetails['employment_location_type_name'] ?? null;

        $this->employee->updateEmployeeEmploymentLocationType(
            $employeeId,
            $employmentLocationTypeId,
            $employmentLocationTypeName,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Save Employee Employment Location Type Success',
            'The employee employment location type has been saved successfully.'
        );
    }

    public function updateEmployeeWorkLocation(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_work_location_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $employeeId     = $_POST['employee_id'] ?? null;
        $wokLocationId  = $_POST['work_location_id'] ?? null;

        $workLocationDetails    = $this->workLocation->fetchWorkLocation($wokLocationId);
        $workLocationName       = $workLocationDetails['work_location_name'] ?? null;

        $this->employee->updateEmployeeWorkLocation(
            $employeeId,
            $wokLocationId,
            $workLocationName,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Save Employee Work Location Success',
            'The employee work location has been saved successfully.'
        );
    }

    public function updateEmployeeOnBoardDate(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_on_board_date_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $employeeId     = $_POST['employee_id'] ?? null;
        $onBoardDate    = $this->systemHelper->checkDate('empty', $_POST['on_board_date'], '', 'Y-m-d', '');

        $this->employee->updateEmployeeOnBoardDate(
            $employeeId,
            $onBoardDate,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Save Employee On Board Date Success',
            'The employee on board date has been saved successfully.'
        );
    }

    public function updateEmployeeWorkEmail(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_work_email_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $employeeId     = $_POST['employee_id'] ?? null;
        $workEmail      = $_POST['work_email'] ?? null;

        $this->employee->updateEmployeeWorkEmail(
            $employeeId,
            $workEmail,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Save Employee Work Email Success',
            'The employee work email has been saved successfully.'
        );
    }

    public function updateEmployeeWorkPhone(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_work_phone_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $employeeId     = $_POST['employee_id'] ?? null;
        $workPhone      = $_POST['work_phone'] ?? null;

        $this->employee->updateEmployeeWorkPhone(
            $employeeId,
            $workPhone,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Save Employee Work Phone Success',
            'The employee work phone has been saved successfully.'
        );
    }

    public function updateEmployeeWorkTelephone(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_work_telephone_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $employeeId     = $_POST['employee_id'] ?? null;
        $workTelephone  = $_POST['work_telephone'] ?? null;

        $this->employee->updateEmployeeWorkTelephone(
            $employeeId,
            $workTelephone,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Save Employee Work Telephone Success',
            'The employee work telephone has been saved successfully.'
        );
    }

    public function updateEmployeeImage(
        int $lastLogBy
    ) {
        $employeeId   = $_POST['employee_id'] ?? null;
       
        $employeeImageFileName              = $_FILES['employee_image']['name'];
        $employeeImageFileSize              = $_FILES['employee_image']['size'];
        $employeeImageFileError             = $_FILES['employee_image']['error'];
        $employeeImageTempName              = $_FILES['employee_image']['tmp_name'];
        $employeeImageFileExtension         = explode('.', $employeeImageFileName);
        $employeeImageActualFileExtension   = strtolower(end($employeeImageFileExtension));

        $uploadSetting  = $this->uploadSetting->fetchUploadSetting(6);
        $maxFileSize    = $uploadSetting['max_file_size'];

        $uploadSettingFileExtension = $this->uploadSetting->fetchUploadSettingFileExtension(6);
        $allowedFileExtensions = [];

        foreach ($uploadSettingFileExtension as $row) {
            $allowedFileExtensions[] = $row['file_extension'];
        }

        if (!in_array($employeeImageActualFileExtension, $allowedFileExtensions)) {              
            $this->systemHelper::sendErrorResponse(
                'Update Employee Image Error', 
                'The file uploaded is not supported.'
            );
        }
            
        if(empty($employeeImageTempName)){
            $this->systemHelper::sendErrorResponse(
                'Update Employee Image Error', 
                'Please choose the employee image.'
            );
        }
            
        if($employeeImageFileError){                
            $this->systemHelper::sendErrorResponse(
                'Update Employee Image Error', 
                'An error occurred while uploading the file.'
            );
        }
            
        if($employeeImageFileSize > ($maxFileSize * 1024)){
            $this->systemHelper::sendErrorResponse(
                'Update Employee Image Error', 
                'The employee image exceeds the maximum allowed size of ' . $maxFileSize . ' mb.'
            );
        }

        $fileName   = $this->security->generateFileName();
        $fileNew    = $fileName . '.' . $employeeImageActualFileExtension;
            
        define('PROJECT_BASE_DIR', dirname(__DIR__, 2));

        $uploadsDir         = PROJECT_BASE_DIR . '/storage/uploads/';
        $directory          = $uploadsDir . 'employee/' . $employeeId . '/';
        $fileDestination    = $directory . $fileNew;
        $filePath           = 'storage/uploads/employee/' . $employeeId . '/' . $fileNew;

        $directoryChecker = $this->security->directoryChecker($directory);

        if ($directoryChecker !== true) {
            $this->systemHelper::sendErrorResponse(
                'Update Employee Image Error',
                $directoryChecker
            );
        }

        $employeeDetails    = $this->employee->fetchEmployee($employeeId);
        $employeeImage      = $employeeDetails['employee_image'] ?? null;
        
        $this->systemHelper->deleteFileIfExist($employeeImage);

        if(!move_uploaded_file($employeeImageTempName, $fileDestination)){
            $this->systemHelper::sendErrorResponse(
                'Update Employee Image Error', 
                'The employee image cannot be uploaded due to an error'
            );
        }

        $this->employee->updateEmployeeImage(
            $employeeId,
            $filePath,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Update Employee Image Success',
            'The employee image has been updated successfully.'
        );
    }

    public function updateEmployeeArchive(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'archive_employee_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $employeeId                 = $_POST['employee_id'] ?? null;
        $departureReasonId          = $_POST['departure_reason_id'] ?? null;
        $departureDate              = $this->systemHelper->checkDate('empty', $_POST['departure_date'], '', 'Y-m-d', '');
        $detailedDepartureReason    = $_POST['detailed_departure_reason'] ?? null;

        $departureReasonDetails     = $this->departureReason->fetchDepartureReason($departureReasonId);
        $departureReasonName        = $departureReasonDetails['departure_reason_name'] ?? null;

        $this->employee->updateEmployeeArchive(
            $employeeId,
            $departureReasonId,
            $departureReasonName,
            $detailedDepartureReason,
            $departureDate,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Employee Archive Success',
            'The employee has been archived successfully.'
        );
    }

    public function updateEmployeeUnarchive(
        int $lastLogBy
    ) {
        $employeeId = $_POST['employee_id'] ?? null;

        $this->employee->updateEmployeeUnarchive(
            $employeeId,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Employee Unarchive Success',
            'The employee has been unarchived successfully.'
        );
    }

    /* =============================================================================================
        SECTION 4: FETCH METHOD
    ============================================================================================= */

    public function fetchEmployeeDetails() {
        $employeeId             = $_POST['employee_id'] ?? null;
        $checkEmployeeExist     = $this->employee->checkEmployeeExist($employeeId);
        $total                  = $checkEmployeeExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get Employee Details',
                'The employee does not exist',
                ['notExist' => true]
            );
        }

        $employeeDetails        = $this->employee->fetchEmployee($employeeId);
        $employeeImage          = $this->systemHelper->checkImageExist($employeeDetails['employee_image'] ?? null, 'profile');
        $employmentStatus       = $employeeDetails['employment_status'] ?? 'Active';
        $badgeClass             = $employmentStatus == 'Active' ? 'success' : 'danger';
        $employmentStatusBadge  = '<div class="badge badge-lg badge-light-'. $badgeClass .'">'. $employmentStatus .'</div>';
        $addressParts           = [
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
            'success'                       => true,
            'fullName'                      => $employeeDetails['full_name'] ?? null,
            'firstName'                     => $employeeDetails['first_name'] ?? null,
            'middleName'                    => $employeeDetails['middle_name'] ?? null,
            'lastName'                      => $employeeDetails['last_name'] ?? null,
            'suffix'                        => $employeeDetails['suffix'] ?? null,
            'privateAddress'                => $employeeDetails['private_address'] ?? null,
            'privateAddressCityID'          => $employeeDetails['private_address_city_id'] ?? null,
            'civilStatusID'                 => $employeeDetails['civil_status_id'] ?? null,
            'religionID'                    => $employeeDetails['religion_id'] ?? null,
            'bloodTypeID'                   => $employeeDetails['blood_type_id'] ?? null,
            'height'                        => $employeeDetails['height'] ?? null,
            'weight'                        => $employeeDetails['weight'] ?? null,
            'nickname'                      => $employeeDetails['nickname'] ?? null,
            'dependents'                    => $employeeDetails['dependents'] ?? null,
            'homeWorkDistance'              => $employeeDetails['home_work_distance'] ?? null,
            'civilStatusName'               => $employeeDetails['civil_status_name'] ?? null,
            'religionName'                  => $employeeDetails['religion_name'] ?? null,
            'bloodTypeName'                 => $employeeDetails['blood_type_name'] ?? null,
            'badgeID'                       => $employeeDetails['badge_id'] ?? null,
            'privateEmail'                  => $employeeDetails['private_email'] ?? null,
            'privatePhone'                  => $employeeDetails['private_phone'] ?? null,
            'privateTelephone'              => $employeeDetails['private_telephone'] ?? null,
            'nationalityName'               => $employeeDetails['nationality_name'] ?? null,
            'genderName'                    => $employeeDetails['gender_name'] ?? null,
            'birthday'                      => $this->systemHelper->checkDate('summary', $employeeDetails['birthday'] ?? null, '', 'd M Y', ''),
            'placeOfBirth'                  => $employeeDetails['place_of_birth'] ?? null,
            'companyName'                   => $employeeDetails['company_name'] ?? null,
            'departmentName'                => $employeeDetails['department_name'] ?? null,
            'jobPositionName'               => $employeeDetails['job_position_name'] ?? null,
            'managerName'                   => $employeeDetails['manager_name'] ?? null,
            'timeOffApproverName'           => $employeeDetails['time_off_approver_name'] ?? null,
            'employmentTypeName'            => $employeeDetails['employment_type_name'] ?? null,
            'employmentLocationTypeName'    => $employeeDetails['employment_location_type_name'] ?? null,
            'workLocationName'              => $employeeDetails['work_location_name'] ?? null,
            'onBoardDate'                   => $this->systemHelper->checkDate('summary', $employeeDetails['on_board_date'] ?? null, '', 'd M Y', ''),
            'workEmail'                     => $employeeDetails['work_email'] ?? null,
            'workPhone'                     => $employeeDetails['work_phone'] ?? null,
            'workTelephone'                 => $employeeDetails['work_telephone'] ?? null,
            'departureReasonName'           => $employeeDetails['departure_reason_name'] ?? null,
            'detailedDepartureReason'       => $employeeDetails['detailed_departure_reason'] ?? null,
            'departureDate'                 => $this->systemHelper->checkDate('summary', $employeeDetails['departure_date'] ?? null, '', 'd M Y', ''),
            'employmentStatus'              => $employmentStatusBadge,
            'employeeAddress'               => $employeeAddress,
            'employeeImage'                 => $employeeImage
        ];

        echo json_encode($response);
        exit;
    }

    public function fetchEmployeeEducationDetails() {
        $employeeEducationId = $_POST['employee_education_id'] ?? null;

        $employeeEducationDetails = $this->employee->fetchEmployeeEducation($employeeEducationId);

        $response = [
            'success'               => true,
            'school'                => $employeeEducationDetails['school'] ?? null,
            'degree'                => $employeeEducationDetails['degree'] ?? null,
            'fieldOfStudy'          => $employeeEducationDetails['field_of_study'] ?? null,
            'startMonth'            => $employeeEducationDetails['start_month'] ?? null,
            'startYear'             => $employeeEducationDetails['start_year'] ?? null,
            'endMonth'              => $employeeEducationDetails['end_month'] ?? null,
            'endYear'               => $employeeEducationDetails['end_year'] ?? null,
            'activitiesSocieties'   => $employeeEducationDetails['activities_societies'] ?? null,
            'educationDescription'  => $employeeEducationDetails['education_description'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function fetchEmployeeEmergencyContactDetails() {
        $employeeEmergencyContactId = $_POST['employee_emergency_contact_id'] ?? null;

        $employeeEmergencyContactDetails = $this->employee->fetchEmployeeEmergencyContact($employeeEmergencyContactId);

        $response = [
            'success'               => true,
            'emergencyContactName'  => $employeeEmergencyContactDetails['emergency_contact_name'] ?? null,
            'relationshipId'        => $employeeEmergencyContactDetails['relationship_id'] ?? null,
            'telephone'             => $employeeEmergencyContactDetails['telephone'] ?? null,
            'mobile'                => $employeeEmergencyContactDetails['mobile'] ?? null,
            'email'                 => $employeeEmergencyContactDetails['email'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function fetchEmployeeLicenseDetails() {
        $employeeLicenseId = $_POST['employee_license_id'] ?? null;

        $employeeLicenseDetails = $this->employee->fetchEmployeeLicense($employeeLicenseId);

        $response = [
            'success'               => true,
            'licensedProfession'    => $employeeLicenseDetails['licensed_profession'] ?? null,
            'licensingBody'         => $employeeLicenseDetails['licensing_body'] ?? null,
            'licenseNumber'         => $employeeLicenseDetails['license_number'] ?? null,
            'issueDate'             => $this->systemHelper->checkDate('summary', $employeeLicenseDetails['issue_date'] ?? null, '', 'M d, Y', ''),
            'expirationDate'        => $this->systemHelper->checkDate('summary', $employeeLicenseDetails['expiration_date'] ?? null, '', 'M d, Y', '')
        ];

        echo json_encode($response);
        exit;
    }

    public function fetchEmployeeExperienceDetails() {
        $employeeExperienceId = $_POST['employee_experience_id'] ?? null;

        $employeeExperienceDetails = $this->employee->fetchEmployeeExperience($employeeExperienceId);

        $response = [
            'success'           => true,
            'jobTitle'          => $employeeExperienceDetails['job_title'] ?? null,
            'employmentTypeId'  => $employeeExperienceDetails['employment_type_id'] ?? null,
            'companyName'       => $employeeExperienceDetails['company_name'] ?? null,
            'location'          => $employeeExperienceDetails['location'] ?? null,
            'startMonth'        => $employeeExperienceDetails['start_month'] ?? null,
            'startYear'         => $employeeExperienceDetails['start_year'] ?? null,
            'endMonth'          => $employeeExperienceDetails['end_month'] ?? null,
            'endYear'           => $employeeExperienceDetails['end_year'] ?? null,
            'jobDescription'    => $employeeExperienceDetails['job_description'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    /* =============================================================================================
        SECTION 5: DELETE METHOD
    ============================================================================================= */

    public function deleteEmployee() {
        $employeeId         = $_POST['employee_id'] ?? null;
        $employeeDetails    = $this->employee->fetchEmployee($employeeId);
        $employeeImage      = $employeeDetails['employee_image'] ?? null;

        $this->systemHelper->deleteFileIfExist($employeeImage);

        $employeeDocuments = $this->employee->fetchAllEmployeeDocument($employeeId);

        foreach ($employeeDocuments as $row) {
            $documentFile = $row['document_file'] ?? null;

            $this->systemHelper->deleteFileIfExist($documentFile);
        }

        $this->employee->deleteEmployee($employeeId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Employee Success',
            'The employee has been deleted successfully.'
        );
    }

    public function deleteMultipleEmployee() {
        $employeeIds = $_POST['employee_id'] ?? null;

        foreach($employeeIds as $employeeId){
            $employeeDetails    = $this->employee->fetchEmployee($employeeId);
            $employeeImage      = $employeeDetails['employee_image'] ?? null;

            $this->systemHelper->deleteFileIfExist($employeeImage);

            $employeeDocuments = $this->employee->fetchAllEmployeeDocument($employeeId);

            foreach ($employeeDocuments as $row) {
                $documentFile = $row['document_file'] ?? null;

                $this->systemHelper->deleteFileIfExist($documentFile);
            }

            $this->employee->deleteEmployee($employeeId);
        }

        $this->systemHelper::sendSuccessResponse(
            'Delete Multiple Employees Success',
            'The selected employees have been deleted successfully.'
        );
    }

    public function deleteEmployeeLanguage() {
        $employeeLanguageId = $_POST['employee_language_id'] ?? null;

        $this->employee->deleteEmployeeLanguage($employeeLanguageId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Employee Language Success',
            'The employee language has been deleted successfully.'
        );
    }

    public function deleteEmployeeEducation() {
        $employeeEducationId = $_POST['employee_education_id'] ?? null;

        $this->employee->deleteEmployeeEducation($employeeEducationId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Employee Educational Background Success',
            'The employee educational background has been deleted successfully.'
        );
    }

    public function deleteEmployeeEmergencyContact() {
        $employeeEmergencyContactId = $_POST['employee_emergency_contact_id'] ?? null;

        $this->employee->deleteEmployeeEmergencyContact($employeeEmergencyContactId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Employee Emergency Contact Success',
            'The employee emergency contact has been deleted successfully.'
        );
    }

    public function deleteEmployeeLicense() {
        $employeeLicenseId = $_POST['employee_license_id'] ?? null;

        $this->employee->deleteEmployeeLicense($employeeLicenseId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Employee License Success',
            'The employee license has been deleted successfully.'
        );
    }

    public function deleteEmployeeExperience() {
        $employeeExperienceId = $_POST['employee_experience_id'] ?? null;

        $this->employee->deleteEmployeeExperience($employeeExperienceId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Employee Experience Success',
            'The employee experience has been deleted successfully.'
        );
    }

    public function deleteEmployeeDocument() {
        $employeeDocumentId = $_POST['employee_document_id'] ?? null;

        $employeeDocumentDetails    = $this->employee->fetchEmployeeDocument($employeeDocumentId);
        $documentFile               = $employeeDocumentDetails['document_file'] ?? null;
        
        $this->systemHelper->deleteFileIfExist($documentFile);

        $this->employee->deleteEmployeeDocument($employeeDocumentId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Employee Document Success',
            'The employee document has been deleted successfully.'
        );
    }

    /* =============================================================================================
        SECTION 6: CHECK METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 7: GENERATE METHOD
    ============================================================================================= */

    public function generateEmployeeCard() {
        $pageLink               = $_POST['page_link'] ?? null;
        $searchValue            = $_POST['search_value'] ?? null;
        $companyFilter          = $this->systemHelper->checkFilter($_POST['filter_by_company'] ?? null);
        $departmentFilter       = $this->systemHelper->checkFilter($_POST['filter_by_department'] ?? null);
        $jobPositionFilter      = $this->systemHelper->checkFilter($_POST['filter_by_job_position'] ?? null);
        $employeeStatusFilter   = $this->systemHelper->checkFilter($_POST['filter_by_employee_status'] ?? null);
        $workLocationFilter     = $this->systemHelper->checkFilter($_POST['filter_by_work_location'] ?? null);
        $employmentTypeFilter   = $this->systemHelper->checkFilter($_POST['filter_by_employment_type'] ?? null);
        $genderFilter           = $this->systemHelper->checkFilter($_POST['filter_by_gender'] ?? null);
        $limit                  = $_POST['limit'] ?? 16;
        $offset                 = $_POST['offset'] ?? 0;
        $response               = [];

        $employees = $this->employee->generateEmployeeCard(
            $searchValue,
            $companyFilter,
            $departmentFilter,
            $jobPositionFilter,
            $employeeStatusFilter,
            $workLocationFilter,
            $employmentTypeFilter,
            $genderFilter,
            $limit,
            $offset
        );

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

                                    <div class="fs-4 text-gray-800 fw-bold mb-0">'. $fullName .'</div>
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

    public function generateEmployeeTable() {
        $pageLink               = $_POST['page_link'] ?? null;
        $companyFilter          = $this->systemHelper->checkFilter($_POST['filter_by_company'] ?? null);
        $departmentFilter       = $this->systemHelper->checkFilter($_POST['filter_by_department'] ?? null);
        $jobPositionFilter      = $this->systemHelper->checkFilter($_POST['filter_by_job_position'] ?? null);
        $employeeStatusFilter   = $this->systemHelper->checkFilter($_POST['filter_by_employee_status'] ?? null);
        $workLocationFilter     = $this->systemHelper->checkFilter($_POST['filter_by_work_location'] ?? null);
        $employmentTypeFilter   = $this->systemHelper->checkFilter($_POST['filter_by_employment_type'] ?? null);
        $genderFilter           = $this->systemHelper->checkFilter($_POST['filter_by_gender'] ?? null);
        $response               = [];

        $employees = $this->employee->generateEmployeeTable(
            $companyFilter,
            $departmentFilter,
            $jobPositionFilter,
            $employeeStatusFilter,
            $workLocationFilter,
            $employmentTypeFilter,
            $genderFilter
        );

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
                                            <div class="symbol symbol-50px symbol-circle">
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
    
    public function generateEmployeeOptions() {
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
                'text'  => $row['full_name']
            ];
        }

        echo json_encode($response);
    }

    public function generateEmployeeLanguageList(
        int $lastLogBy,
        int $pageId
    ) {
        $employeeId         = $_POST['employee_id'] ?? null;
        $writeAccess        = $this->authentication->checkUserPermission($lastLogBy, $pageId, 'write')['total'] ?? 0;
        $logNotesAccess     = $this->authentication->checkUserPermission($lastLogBy, $pageId, 'log notes')['total'] ?? 0;
        $list               = '';

        $results = $this->employee->generateEmployeeLanguageList($employeeId);

        $lastRole = end($results);
        reset($results);

        foreach ($results as $row) {
            $employeeLanguageId         = $row['employee_language_id'];
            $languageName               = $row['language_name'];
            $languageProficiencyName    = $row['language_proficiency_name'];

            $deleteButton = '';
            if($writeAccess > 0){
                $deleteButton = '<button type="button" class="btn btn-icon btn-light btn-active-light-danger ms-auto delete-employee-language" data-employee-language-id="' . $employeeLanguageId . '">
                                        <i class="ki-outline ki-trash fs-3 m-0 fs-5"></i>
                                    </button>';
            }

            $logNotes = '';
            if($logNotesAccess > 0){
                $logNotes = '<button class="btn btn-icon btn-light btn-active-light-primary me-3 view-employee-language-log-notes" data-employee-language-id="' . $employeeLanguageId . '" data-bs-toggle="modal" data-bs-target="#log-notes-modal" title="View Log Notes">
                                    <i class="ki-outline ki-shield-search fs-3 m-0 fs-5"></i>
                                </button>';
            }

            $list .= '<div class="d-flex flex-stack">
                        <div class="d-flex flex-column">
                            <span class="fs-6">'. $languageName .'</span>
                            <span class="text-muted">'. $languageProficiencyName .'</span>
                        </div>

                        <div class="d-flex justify-content-end align-items-center">
                            '. $logNotes .'
                            '. $deleteButton .'
                        </div>
                    </div>';

            if ($row !== $lastRole) {
                $list .= '<div class="separator separator-dashed my-5"></div>';
            }
        }

       if(empty($list)){
            $list = '<div class="d-flex flex-stack">
                            <div class="d-flex align-items-center flex-row-fluid flex-wrap mb-4">
                                <div class="flex-grow-1 me-2">
                                    <div class="text-gray-800 fs-5 fw-bold">No language found</div>
                                </div>
                            </div>
                        </div>';
        }

        $response[] = [
            'LANGUAGE_LIST' => $list
        ];


        echo json_encode($response);
    }

    public function generateEmployeeEducationList(
        int $lastLogBy,
        int $pageId
    ) {
        $employeeId         = $_POST['employee_id'] ?? null;
        $writeAccess        = $this->authentication->checkUserPermission($lastLogBy, $pageId, 'write')['total'] ?? 0;
        $logNotesAccess     = $this->authentication->checkUserPermission($lastLogBy, $pageId, 'log notes')['total'] ?? 0;
        $list               = '';

        $results = $this->employee->generateEmployeeEducationList($employeeId);

        reset($results);

        foreach ($results as $row) {
            $employeeEducationId    = $row['employee_education_id'];
            $school                 = $row['school'];
            $degree                 = $row['degree'];
            $fieldOfStudy           = $row['field_of_study'];
            $startMonth             = $row['start_month'];
            $startYear              = $row['start_year'];
            $endMonth               = $row['end_month'];
            $endYear                = $row['end_year'];
            $activitiesSocieties    = $row['activities_societies'];
            $educationDescription   = $row['education_description'];

            $degreeFieldOfStudy     = (!empty($degree) || !empty($fieldOfStudy)) ? '<div class="fs-6 fw-semibold text-gray-600">' . trim($degree . (!empty($degree) && !empty($fieldOfStudy) ? ' · ' : '') . $fieldOfStudy) . '</div>' : '';
            $activitiesSocieties    = !empty($activitiesSocieties) ? '<div class="fs-6 fw-semibold text-gray-600">Activities and societies: ' . $activitiesSocieties . '</div>' : '';
            $educationDescription   = !empty($educationDescription) ? '<div class="fs-6 fw-semibold text-gray-600">' . $educationDescription . '</div>' : '';
            $startDate              = $startMonth . ' ' . $startYear;                
            $endDate                = (!empty($endMonth) && !empty($endYear)) ? $endMonth . ' ' . $endYear : 'Present';

            $button = '';
            if($writeAccess > 0){
                $button = '<button class="btn btn-icon btn-light btn-active-light-warning me-3 update-employee-education" data-bs-toggle="modal" data-bs-target="#employee_education_modal" data-employee-education-id="' . $employeeEducationId . '">
                                <i class="ki-outline ki-pencil fs-3 m-0 fs-5"></i>
                            </button>
                            <button class="btn btn-icon btn-light btn-active-light-danger delete-employee-education" data-employee-education-id="' . $employeeEducationId . '">
                                 <i class="ki-outline ki-trash fs-3 m-0 fs-5"></i>
                            </button>';
            }

            $logNotes = '';
            if($logNotesAccess > 0){
                $logNotes = '<button class="btn btn-icon btn-light btn-active-light-primary me-3 view-employee-education-log-notes" data-employee-education-id="' . $employeeEducationId . '" data-bs-toggle="modal" data-bs-target="#log-notes-modal" title="View Log Notes">
                                    <i class="ki-outline ki-shield-search fs-3 m-0 fs-5"></i>
                                </button>';
            }

            $list .= '<div class="col-xl-6">
                        <div class="card card-dashed h-xl-100 flex-row flex-stack flex-wrap p-6">
                            <div class="d-flex flex-column py-2">
                                <div class="d-flex align-items-center fs-5 fw-bold mb-5">
                                   '. $school .'
                                </div>
                                '. $degreeFieldOfStudy .'
                                <div class="fs-6 fw-semibold text-gray-600">'. $startDate .' - '. $endDate .'</div>
                                '. $activitiesSocieties .'
                                '. $educationDescription .'
                            </div>
                            <div class="d-flex align-items-center py-2">
                                '. $logNotes .'
                                '. $button .'
                            </div>
                        </div>
                    </div>';
        }

        if($writeAccess > 0){
            $contactCount = count($results);
            $colClass = ($contactCount === 0 || $contactCount % 2 === 0) ? 'col-xl-12' : 'col-xl-6';
            
            $list .= '<div class="'. $colClass .'">
                            <div class="notice d-flex bg-light-primary rounded border-primary border border-dashed flex-stack h-xl-100 mb-10 p-6">
                                <div class="d-flex flex-stack flex-grow-1 flex-wrap flex-md-nowrap">
                                    <div class="mb-3 mb-md-0 fw-semibold">
                                        <h4 class="text-gray-900 fw-bold">Add New Educational Background for Employee</h4>
                                        <div class="fs-6 text-gray-700 pe-7">Provide detailed information about the employee\'s educational background, including school, degree, and field of study.</div>
                                    </div>
                                    <button id="add-employee-education" class="btn btn-primary px-6 align-self-center text-nowrap" data-bs-toggle="modal" data-bs-target="#employee_education_modal">New Educational Background</button>
                                </div>
                            </div>
                        </div>';

        }

        $response[] = [
            'EDUCATION_LIST' => $list
        ];


        echo json_encode($response);
    }

    public function generateEmployeeEmergencyContactList(
        int $lastLogBy,
        int $pageId
    ) {
        $employeeId         = $_POST['employee_id'] ?? null;
        $writeAccess        = $this->authentication->checkUserPermission($lastLogBy, $pageId, 'write')['total'] ?? 0;
        $logNotesAccess     = $this->authentication->checkUserPermission($lastLogBy, $pageId, 'log notes')['total'] ?? 0;
        $list               = '';

        $results = $this->employee->generateEmployeeEmergencyContactList($employeeId);

        reset($results);

        foreach ($results as $row) {
            $employeeEmergencyContactId     = $row['employee_emergency_contact_id'];
            $emergencyContactName           = $row['emergency_contact_name'];
            $relationshipName               = $row['relationship_name'];
       
            $telephone  = (!empty($row['telephone'])) ? '<div class="fs-6 fw-semibold text-gray-600">Telephone: ' . $row['telephone'] . '</div>' : '';
            $mobile     = (!empty($row['mobile'])) ? '<div class="fs-6 fw-semibold text-gray-600">Mobile: ' . $row['mobile'] . '</div>' : '';
            $email      = (!empty($row['email'])) ? '<div class="fs-6 fw-semibold text-gray-600">Email: ' . $row['email'] . '</div>' : '';

            $button = '';
            if($writeAccess > 0){
                $button = '<button class="btn btn-icon btn-light btn-active-light-warning me-3 update-employee-emergency-contact" data-bs-toggle="modal" data-bs-target="#employee_emergency_contact_modal" data-employee-emergency-contact-id="' . $employeeEmergencyContactId . '">
                                <i class="ki-outline ki-pencil fs-3 m-0 fs-5"></i>
                            </button>
                            <button class="btn btn-icon btn-light btn-active-light-danger delete-employee-emergency-contact" data-employee-emergency-contact-id="' . $employeeEmergencyContactId . '">
                                 <i class="ki-outline ki-trash fs-3 m-0 fs-5"></i>
                            </button>';
            }

            $logNotes = '';
            if($logNotesAccess > 0){
                $logNotes = '<button class="btn btn-icon btn-light btn-active-light-primary me-3 view-employee-emergency-contact-log-notes" data-employee-emergency-contact-id="' . $employeeEmergencyContactId . '" data-bs-toggle="modal" data-bs-target="#log-notes-modal" title="View Log Notes">
                                    <i class="ki-outline ki-shield-search fs-3 m-0 fs-5"></i>
                                </button>';
            }

            $list .= '<div class="col-xl-6">
                        <div class="card card-dashed h-xl-100 flex-row flex-stack flex-wrap p-6">
                            <div class="d-flex flex-column py-2">
                                <div class="d-flex align-items-center fs-5 fw-bold mb-5">
                                   '. $emergencyContactName .'
                                </div>
                                <div class="fs-6 fw-semibold text-gray-600 mb-5">'. $relationshipName .'</div>
                                '. $email .'
                                '. $mobile .'
                                '. $telephone .'
                            </div>
                            <div class="d-flex align-items-center py-2">
                                '. $logNotes .'
                                '. $button .'
                            </div>
                        </div>
                    </div>';
        }

        if($writeAccess > 0){
            $contactCount = count($results);
            $colClass = ($contactCount === 0 || $contactCount % 2 === 0) ? 'col-xl-12' : 'col-xl-6';

            $list .= ' <div class="'. $colClass .'">
                            <div class="notice d-flex bg-light-primary rounded border-primary border border-dashed flex-stack h-xl-100 mb-10 p-6">
                                <div class="d-flex flex-stack flex-grow-1 flex-wrap flex-md-nowrap">
                                    <div class="mb-3 mb-md-0 fw-semibold">
                                        <h4 class="text-gray-900 fw-bold">Add New Emergency Contact for Employee</h4>
                                        <div class="fs-6 text-gray-700 pe-7">Provide detailed information about the employee\'s emergency contact, including the contact’s full name, relationship to the employee, mobile, telephone and email.</div>
                                    </div>
                                    <button id="add-employee-emergency-contact" class="btn btn-primary px-6 align-self-center text-nowrap" data-bs-toggle="modal" data-bs-target="#employee_emergency_contact_modal">New Emergency Contact</button>
                                </div>
                            </div>
                        </div>';

        }

        $response[] = [
            'EMERGENCY_CONTACT_LIST' => $list
        ];


        echo json_encode($response);
    }

    public function generateEmployeeLicenseList(
        int $lastLogBy,
        int $pageId
    ) {
        $employeeId         = $_POST['employee_id'] ?? null;
        $writeAccess        = $this->authentication->checkUserPermission($lastLogBy, $pageId, 'write')['total'] ?? 0;
        $logNotesAccess     = $this->authentication->checkUserPermission($lastLogBy, $pageId, 'log notes')['total'] ?? 0;
        $list               = '';

        $results = $this->employee->generateEmployeeLicenseList($employeeId);

        reset($results);

        foreach ($results as $row) {
            $employeeLicenseId      = $row['employee_license_id'];
            $licensedProfession     = $row['licensed_profession'];
            $licensingBody          = $row['licensing_body'];
            $licenseNumber          = $row['license_number'];
            $issueDate          = $this->systemHelper->checkDate('summary', $row['issue_date'] ?? null, '', 'd M Y', '');
       
            $expirationDate     = (!empty($row['expiration_date'])) ? '<div class="fs-6 fw-semibold text-gray-600">Expiring on: ' . $this->systemHelper->checkDate('summary', $row['expiration_date'] ?? null, '', 'd M Y', '') . '</div>' : '';

            $button = '';
            if($writeAccess > 0){
                $button = '<button class="btn btn-icon btn-light btn-active-light-warning me-3 update-employee-license" data-bs-toggle="modal" data-bs-target="#employee_license_modal" data-employee-license-id="' . $employeeLicenseId . '">
                                <i class="ki-outline ki-pencil fs-3 m-0 fs-5"></i>
                            </button>
                            <button class="btn btn-icon btn-light btn-active-light-danger delete-employee-license" data-employee-license-id="' . $employeeLicenseId . '">
                                 <i class="ki-outline ki-trash fs-3 m-0 fs-5"></i>
                            </button>';
            }

            $logNotes = '';
            if($logNotesAccess > 0){
                $logNotes = '<button class="btn btn-icon btn-light btn-active-light-primary me-3 view-employee-license-log-notes" data-employee-license-id="' . $employeeLicenseId . '" data-bs-toggle="modal" data-bs-target="#log-notes-modal" title="View Log Notes">
                                    <i class="ki-outline ki-shield-search fs-3 m-0 fs-5"></i>
                                </button>';
            }

            $list .= '<div class="col-xl-6">
                        <div class="card card-dashed h-xl-100 flex-row flex-stack flex-wrap p-6">
                            <div class="d-flex flex-column py-2">
                                <div class="d-flex align-items-center fs-5 fw-bold">
                                   '. $licensedProfession .'
                                </div>
                                <div class="fs-6 fw-bold mb-5">'. $licenseNumber .'</div>
                                <div class="fs-6 fw-semibold text-gray-600">'. $licensingBody .'</div>
                                <div class="fs-6 fw-semibold text-gray-600">Issued on : ' . $issueDate . '</div>
                                '. $expirationDate .'
                            </div>
                            <div class="d-flex align-items-center py-2">
                                '. $logNotes .'
                                '. $button .'
                            </div>
                        </div>
                    </div>';
        }

        if($writeAccess > 0){
            $contactCount = count($results);
            $colClass = ($contactCount === 0 || $contactCount % 2 === 0) ? 'col-xl-12' : 'col-xl-6';

            $list .= ' <div class="'. $colClass .'">
                            <div class="notice d-flex bg-light-primary rounded border-primary border border-dashed flex-stack h-xl-100 mb-10 p-6">
                                <div class="d-flex flex-stack flex-grow-1 flex-wrap flex-md-nowrap">
                                    <div class="mb-3 mb-md-0 fw-semibold">
                                        <h4 class="text-gray-900 fw-bold">Add New License for Employee</h4>
                                        <div class="fs-6 text-gray-700 pe-7">Provide detailed information about the employee\'s license, including the license profession, license number, licensing body, issuance date and expiry date.</div>
                                    </div>
                                    <button id="add-employee-emergency-contact" class="btn btn-primary px-6 align-self-center text-nowrap" data-bs-toggle="modal" data-bs-target="#employee_license_modal">New License</button>
                                </div>
                            </div>
                        </div>';

        }

        $response[] = [
            'LICENSE_LIST' => $list
        ];


        echo json_encode($response);
    }

    public function generateEmployeeExperienceList(
        int $lastLogBy,
        int $pageId
    ) {
        $employeeId         = $_POST['employee_id'] ?? null;
        $writeAccess        = $this->authentication->checkUserPermission($lastLogBy, $pageId, 'write')['total'] ?? 0;
        $logNotesAccess     = $this->authentication->checkUserPermission($lastLogBy, $pageId, 'log notes')['total'] ?? 0;
        $list               = '';

        $results = $this->employee->generateEmployeeExperienceList($employeeId);

        reset($results);

        foreach ($results as $row) {
            $employeeExperienceId   = $row['employee_experience_id'];
            $jobTitle               = $row['job_title'];
            $employmentTypeName     = $row['employment_type_name'];
            $companyName            = $row['company_name'];
            $startMonth             = $row['start_month'];
            $startYear              = $row['start_year'];
            $endMonth               = $row['end_month'];
            $endYear                = $row['end_year'];
            $jobDescription         = $row['job_description'];

            $employmentTypeName     = (!empty($row['employment_type_name'])) ? '<div class="fs-6 fw-semibold text-gray-600">Employment Type: ' . $row['employment_type_name'] . '</div>' : '';
            $location               = (!empty($row['location'])) ? '<div class="fs-6 fw-semibold text-gray-600">'. $row['location'] . '</div>' : '';
            $startDate              = $startMonth . ' ' . $startYear;                
            $endDate                = (!empty($endMonth) && !empty($endYear)) ? $endMonth . ' ' . $endYear : 'Present';

            $button = '';
            if($writeAccess > 0){
                $button = '<button class="btn btn-icon btn-light btn-active-light-warning me-3 update-employee-experience" data-bs-toggle="modal" data-bs-target="#employee_experience_modal" data-employee-experience-id="' . $employeeExperienceId . '">
                                <i class="ki-outline ki-pencil fs-3 m-0 fs-5"></i>
                            </button>
                            <button class="btn btn-icon btn-light btn-active-light-danger delete-employee-experience" data-employee-experience-id="' . $employeeExperienceId . '">
                                 <i class="ki-outline ki-trash fs-3 m-0 fs-5"></i>
                            </button>';
            }

            $logNotes = '';
            if($logNotesAccess > 0){
                $logNotes = '<button class="btn btn-icon btn-light btn-active-light-primary me-3 view-employee-experience-log-notes" data-employee-experience-id="' . $employeeExperienceId . '" data-bs-toggle="modal" data-bs-target="#log-notes-modal" title="View Log Notes">
                                    <i class="ki-outline ki-shield-search fs-3 m-0 fs-5"></i>
                                </button>';
            }

            $list .= '<div class="col-xl-12">
                        <div class="card card-dashed h-xl-100 flex-row flex-stack flex-wrap p-6">
                            <div class="d-flex flex-column py-2">
                                <div class="d-flex align-items-center fs-5 fw-bold mb-5">
                                   '. $jobTitle .'
                                </div>
                                '. $companyName .'
                                '. $location .'
                                <div class="fs-6 fw-semibold text-gray-600">'. $startDate .' - '. $endDate .'</div>
                                '. $employmentTypeName .'
                                <div class="fs-6 fw-semibold text-gray-600">'. $jobDescription .'</div>
                            </div>
                            <div class="d-flex align-items-center py-2">
                                '. $logNotes .'
                                '. $button .'
                            </div>
                        </div>
                    </div>';
        }

        if($writeAccess > 0){            
            $list .= '<div class="col-xl-12">
                            <div class="notice d-flex bg-light-primary rounded border-primary border border-dashed flex-stack h-xl-100 mb-10 p-6">
                                <div class="d-flex flex-stack flex-grow-1 flex-wrap flex-md-nowrap">
                                    <div class="mb-3 mb-md-0 fw-semibold">
                                        <h4 class="text-gray-900 fw-bold">Add New Work Experience for Employee</h4>
                                        <div class="fs-6 text-gray-700 pe-7">Provide detailed information about the employee\'s work experience, including company, job title, job description, degree, start month, start year, end month, end year, employment type, and work location.</div>
                                    </div>
                                    <button id="add-employee-experience" class="btn btn-primary px-6 align-self-center text-nowrap" data-bs-toggle="modal" data-bs-target="#employee_experience_modal">New Work Experience</button>
                                </div>
                            </div>
                        </div>';

        }

        $response[] = [
            'EXPERIENCE_LIST' => $list
        ];

        echo json_encode($response);
    }

    public function generateEmployeeDocumentTable(
        int $lastLogBy,
        int $pageId
    ) {
        $employeeId     = $_POST['employee_id'] ?? null;
        $response       = [];

        $writeAccess        = $this->authentication->checkUserPermission($lastLogBy, $pageId, 'write')['total'] ?? 0;
        $logNotesAccess     = $this->authentication->checkUserPermission($lastLogBy, $pageId, 'log notes')['total'] ?? 0;

        $menuItems = $this->employee->generateEmployeeDocumentTable($employeeId);

        foreach ($menuItems as $row) {
            $employeeDocumentId         = $row['employee_document_id'];
            $documentName               = $row['document_name'];
            $documentFile               = $row['document_file'];
            $employeeDocumentTypeName   = $row['employee_document_type_name'];
            $createdDate                = $this->systemHelper->checkDate('summary', $row['created_date'] ?? null, '', 'M d, Y h:i:s a', '');

            $documentFileDetails = $this->systemHelper->getFileDetails($documentFile, true);

            $button = '';
            if($writeAccess > 0){
                $button = '<button class="btn btn-icon btn-light btn-active-light-danger delete-employee-document" data-employee-document-id="' . $employeeDocumentId . '">
                                 <i class="ki-outline ki-trash fs-3 m-0 fs-5"></i>
                            </button>';
            }

            $logNotes = '';
            if($logNotesAccess > 0){
                $logNotes = '<button class="btn btn-icon btn-light btn-active-light-primary view-employee-document-log-notes" data-employee-document-id="' . $employeeDocumentId . '" data-bs-toggle="modal" data-bs-target="#log-notes-modal" title="View Log Notes">
                                    <i class="ki-outline ki-shield-search fs-3 m-0 fs-5"></i>
                                </button>';
            }

            $response[] = [
                'DOCUMENT'      => '<div class="d-flex align-items-center">
                                            <div class="symbol symbol-30px me-5">
                                                <img src="'. $documentFileDetails['icon'] .'" alt="'. $documentName .'">
                                            </div>
                                            <div class="d-flex flex-column">
                                                <span class="text-gray-800 fw-bold mb-1">'. $documentName .'</span>
                                                <small class="text-gray-600">'. $employeeDocumentTypeName .'</small>
                                            </div>
                                        </div>',
                'SIZE'          => $documentFileDetails['size'],
                'UPLOAD_DATE'   => $createdDate,
                'ACTION'        => '<div class="d-flex justify-content-end gap-3">
                                        '. $logNotes .'
                                        <a href="'. $documentFile .'" class="btn btn-icon btn-light btn-active-light-warning" download="'. $documentName .'" target="_blank">
                                            <i class="ki-outline ki-file-down fs-3 m-0 fs-5"></i>
                                        </a>
                                        '. $button .'
                                    </div>'
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

$controller = new EmployeeController(
    new Employee(),
    new Company(),
    new Department(),
    new JobPosition(),
    new City(),
    new CivilStatus(),
    new Religion(),
    new BloodType(),
    new Nationality(),
    new Gender(),
    new EmploymentType(),
    new EmploymentLocationType(),
    new WorkLocation(),
    new Language(),
    new LanguageProficiency(),
    new Relationship(),
    new EmployeeDocumentType(),
    new DepartureReason(),
    new Authentication(),
    new UploadSetting(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();