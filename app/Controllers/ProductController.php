<?php
namespace App\Controllers;


session_start();

use App\Models\Product;
use App\Models\ProductCategory;
use App\Models\ProductType;
use App\Models\Authentication;
use App\Models\UploadSetting;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class ProductController
{
    protected Product $product;
    protected ProductCategory $productCategory;
    protected ProductType $productType;
    protected Authentication $authentication;
    protected UploadSetting $uploadSetting;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        Product $product,
        ProductCategory $productCategory,
        ProductType $productType,
        Authentication $authentication,
        UploadSetting $uploadSetting,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->product                  = $product;
        $this->productCategory          = $productCategory;
        $this->productType              = $productType;
        $this->authentication           = $authentication;
        $this->uploadSetting            = $uploadSetting;
        $this->security                 = $security;
        $this->systemHelper             = $systemHelper;
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
                    'invalid_session' => true,
                    'redirect_link' => 'imageut.php?imageut'
                ]
            );
        }

        $transaction = strtolower(trim($transaction));

        match ($transaction) {
            'save product'              => $this->saveProduct($lastLogBy),
            'update product image'      => $this->updateProductImage($lastLogBy),
            'update product archive'    => $this->updateProductArchive($lastLogBy),
            'update product unarchive'  => $this->updateProductUnarchive($lastLogBy),
            'delete product'            => $this->deleteProduct(),
            'delete multiple product'   => $this->deleteMultipleProduct(),
            'fetch product details'     => $this->fetchProductDetails(),
            'generate product card'     => $this->generateProductCard(),
            'generate product table'    => $this->generateProductTable(),
            'generate product options'  => $this->generateProductOptions(),
            default                     => $this->systemHelper::sendErrorResponse(
                                                'Transaction Failed',
                                                 'We encountered an issue while processing your request.'
                                            )
        };
    }

    public function saveProduct($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'product_form')) {
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

        $productId = $this->product->insertProduct($fullName, $firstName, $middleName, $lastName, $suffix, $companyId, $companyName, $departmentId, $departmentName, $jobPositionId, $jobPositionName, $lastLogBy);

        $encryptedproductId = $this->security->encryptData($productId);

        $this->systemHelper->sendSuccessResponse(
            'Save Product Success',
            'The product has been saved successfully.',
            ['product_id' => $encryptedproductId]
        );
    }

    public function saveProductLanguage($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'product_language_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productId             = $_POST['product_id'] ?? null;
        $languageId             = $_POST['language_id'] ?? null;
        $languageProficiencyId  = $_POST['language_proficiency_id'] ?? null;

        $languageDetails    = $this->language->fetchLanguage($languageId);
        $languageName       = $languageDetails['language_name'] ?? null;

        $languageProficiency        = $this->languageProficiency->fetchLanguageProficiency($languageProficiencyId);
        $languageProficiencyname    = $languageProficiency['language_proficiency_name'] ?? null;

        $this->product->saveProductLanguage( $productId, $languageId, $languageName, $languageProficiencyId, $languageProficiencyname, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Save Product Language Success',
            'The product language has been saved successfully.'
        );
    }

    public function saveProductEducation($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'product_education_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productId             = $_POST['product_id'] ?? null;
        $productEducationId    = $_POST['product_education_id'] ?? null;
        $school                 = $_POST['school'] ?? null;
        $degree                 = $_POST['degree'] ?? null;
        $fieldOfStudy           = $_POST['field_of_study'] ?? null;
        $startMonth             = $_POST['start_month'] ?? null;
        $startYear              = $_POST['start_year'] ?? null;
        $endMonth               = $_POST['end_month'] ?? null;
        $endYear                = $_POST['end_year'] ?? null;
        $activitiesSocieties    = $_POST['activities_societies'] ?? null;
        $educationDescription   = $_POST['education_description'] ?? null;

        $this->product->saveProductEducation($productEducationId, $productId, $school, $degree, $fieldOfStudy, $startMonth, $startYear, $endMonth, $endYear, $activitiesSocieties, $educationDescription, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Save Product Educational Background Success',
            'The product educational background has been saved successfully.'
        );
    }

    public function saveProductEmergencyContact($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'product_emergency_contact_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productId                     = $_POST['product_id'] ?? null;
        $productEmergencyContactId     = $_POST['product_emergency_contact_id'] ?? null;
        $emergencyContactName           = $_POST['emergency_contact_name'] ?? null;
        $relationshipId                 = $_POST['relationship_id'] ?? null;
        $telephone                      = $_POST['emergency_contact_telephone'] ?? null;
        $mobile                         = $_POST['emergency_contact_mobile'] ?? null;
        $email                          = $_POST['emergency_contact_email'] ?? null;

        $relationshipDetails = $this->relationship->fetchRelationship($relationshipId);
        $relationshipName = $relationshipDetails['relationship_name'] ?? null;

        $this->product->saveProductEmergencyContact($productEmergencyContactId, $productId, $emergencyContactName, $relationshipId, $relationshipName, $telephone, $mobile, $email, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Save Product Emergency Contact Success',
            'The product emergency contact has been saved successfully.'
        );
    }

    public function saveProductLicense($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'product_license_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productId             = $_POST['product_id'] ?? null;
        $productLicenseId      = $_POST['product_license_id'] ?? null;
        $licensedProfession     = $_POST['licensed_profession'] ?? null;
        $licensingBody          = $_POST['licensing_body'] ?? null;
        $licenseNumber          = $_POST['license_number'] ?? null;
        $issueDate              = $this->systemHelper->checkDate('empty', $_POST['issue_date'], '', 'Y-m-d', '');
        $expirationDate         = $this->systemHelper->checkDate('empty', $_POST['expiration_date'], '', 'Y-m-d', '');

        $this->product->saveProductLicense($productLicenseId, $productId, $licensedProfession, $licensingBody, $licenseNumber, $issueDate, $expirationDate, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Save Product License Success',
            'The product license has been saved successfully.'
        );
    }

    public function saveProductExperience($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'product_experience_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productId             = $_POST['product_id'] ?? null;
        $productExperienceId   = $_POST['product_experience_id'] ?? null;
        $jobTitle               = $_POST['job_title'] ?? null;
        $employmentTypeId       = $_POST['product_experience_employment_type_id'] ?? null;
        $companyName            = $_POST['company_name'] ?? null;
        $location               = $_POST['location'] ?? null;
        $startMonth             = $_POST['product_experience_start_month'] ?? null;
        $startYear              = $_POST['product_experience_start_year'] ?? null;
        $endMonth               = $_POST['product_experience_end_month'] ?? null;
        $endYear                = $_POST['product_experience_end_year'] ?? null;
        $jobDescription         = $_POST['job_description'] ?? null;

        $employmentTypeDetails  = $this->employmentType->fetchEmploymentType($employmentTypeId);
        $employmentTypeName     = $employmentTypeDetails['employment_type_name'] ?? null;

        $this->product->saveProductExperience($productExperienceId, $productId, $jobTitle, $employmentTypeId, $employmentTypeName, $companyName, $location, $startMonth, $startYear, $endMonth, $endYear, $jobDescription, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Save Product Work Experience Success',
            'The product work experience has been saved successfully.'
        );
    }

    public function insertProductDocument($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'product_document_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productId                 = $_POST['product_id'] ?? null;
        $documentName               = $_POST['document_name'] ?? null;
        $productDocumentTypeId     = $_POST['product_document_type_id'] ?? null;

        if (!isset($_FILES['document_file'])) {
            $this->systemHelper::sendErrorResponse(
                'Save Product Document Error', 
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
                'Save Product Document Error', 
                'The file uploaded is not supported.'
            );
        }
                
        if(empty($documentFileTempName)){
            $this->systemHelper::sendErrorResponse(
                'Save Product Document Error', 
                'Please choose the product document.'
            );
        }
                
        if($documentFileFileError){                
            $this->systemHelper::sendErrorResponse(
                'Save Product Document Error', 
                'An error occurred while uploading the file.'
            );
        }
                
        if($documentFileFileSize > ($maxFileSize * 1024)){
            $this->systemHelper::sendErrorResponse(
                'Save Product Document Error', 
                'The product document exceeds the maximum allowed size of ' . $maxFileSize . ' mb.'
            );
        }

        $fileName   = $this->security->generateFileName();
        $fileNew    = $fileName . '.' . $documentFileActualFileExtension;
                
        define('PROJECT_BASE_DIR', dirname(__DIR__, 2));

        $uploadsDir         = PROJECT_BASE_DIR . '/storage/uploads/';
        $directory          = $uploadsDir . 'product/' . $productId . '/document/';
        $fileDestination    = $directory . $fileNew;
        $filePath           = 'storage/uploads/product/' . $productId . '/document/' . $fileNew;

        $directoryChecker = $this->security->directoryChecker($directory);

        if ($directoryChecker !== true) {
            $this->systemHelper::sendErrorResponse(
                'Save Product Document Error',
                $directoryChecker
            );
        }

        if(!move_uploaded_file($documentFileTempName, $fileDestination)){
            $this->systemHelper::sendErrorResponse(
                'Save Product Document Error', 
                'The product document cannot be uploaded due to an error'
            );
        }

        $productDocumentTypeDetails    = $this->productDocumentType->fetchProductDocumentType($productDocumentTypeId);
        $productDocumentTypeName       = $productDocumentTypeDetails['product_document_type_name'] ?? null;

        $this->product->insertProductDocument($productId, $documentName, $filePath, $productDocumentTypeId, $productDocumentTypeName, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Save Product Document Success',
            'The product document has been saved successfully.'
        );
    }

    public function updateProductPersonalDetails($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'personal_details_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productId             = $_POST['product_id'] ?? null;
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

        $this->product->updateProductPersonalDetails($productId, $fullName, $firstName, $middleName, $lastName, $suffix, $nickname, $privateAddress, $privateAddressCityId, $privateAddressCityName, $privateAddressStateId, $privateAddressStateName, $privateAddressCountryId, $privateAddressCountryName, $civilStatusId, $civilStatusName, $dependents, $religionId, $religionName, $bloodTypeId, $bloodTypeName, $homeWorkDistance, $height, $weight, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Save Product Personal Details Success',
            'The product personal details has been saved successfully.'
        );
    }

    public function updateProductPINCode($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_pin_code_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productId     = $_POST['product_id'] ?? null;
        $pinCode        = $_POST['pin_code'] ?? null;
        $hashedPINCode  = password_hash($pinCode, PASSWORD_BCRYPT);

        $this->product->updateProductPINCode($productId, $hashedPINCode, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Save Product PIN Code Success',
            'The product PIN code has been saved successfully.'
        );
    }

    public function updateProductBadgeId($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_badge_id_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productId     = $_POST['product_id'] ?? null;
        $badgeId        = $_POST['badge_id'] ?? null;

        $this->product->updateProductBadgeId($productId, $badgeId, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Save Product Badge ID Success',
            'The product badge ID has been saved successfully.'
        );
    }

    public function updateProductPrivateEmail($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_private_email_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productId     = $_POST['product_id'] ?? null;
        $privateEmail   = $_POST['private_email'] ?? null;

        $this->product->updateProductPrivateEmail($productId, $privateEmail, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Save Product Private Email Success',
            'The product private email has been saved successfully.'
        );
    }

    public function updateProductPrivatePhone($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_private_phone_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productId     = $_POST['product_id'] ?? null;
        $privatePhone   = $_POST['private_phone'] ?? null;

        $this->product->updateProductPrivatePhone($productId, $privatePhone, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Save Product Private Phone Success',
            'The product private phone has been saved successfully.'
        );
    }

    public function updateProductPrivateTelephone($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_private_telephone_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productId         = $_POST['product_id'] ?? null;
        $privateTelephone   = $_POST['private_telephone'] ?? null;

        $this->product->updateProductPrivateTelephone($productId, $privateTelephone, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Save Product Private Telephone Success',
            'The product private telephone has been saved successfully.'
        );
    }

    public function updateProductNationality($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_nationality_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productId     = $_POST['product_id'] ?? null;
        $nationalityId  = $_POST['nationality_id'] ?? null;

        $nationalityDetails = $this->nationality->fetchNationality($nationalityId);
        $nationalityName = $nationalityDetails['nationality_name'] ?? null;

        $this->product->updateProductNationality($productId, $nationalityId, $nationalityName, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Save Product Nationality Success',
            'The product nationality has been saved successfully.'
        );
    }

    public function updateProductGender($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_gender_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productId     = $_POST['product_id'] ?? null;
        $genderId       = $_POST['gender_id'] ?? null;

        $genderDetails = $this->gender->fetchGender($genderId);
        $genderName = $genderDetails['gender_name'] ?? null;

        $this->product->updateProductGender($productId, $genderId, $genderName, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Save Product Gender Success',
            'The product gender has been saved successfully.'
        );
    }

    public function updateProductBirthday($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_birthday_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productId     = $_POST['product_id'] ?? null;
        $birthday       = $this->systemHelper->checkDate('empty', $_POST['birthday'], '', 'Y-m-d', '');

        $this->product->updateProductBirthday($productId, $birthday, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Save Product Date of Birth Success',
            'The product date of birth has been saved successfully.'
        );
    }

    public function updateProductPlaceOfBirth($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_place_of_birth_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productId     = $_POST['product_id'] ?? null;
        $placeOfBirth   = $_POST['place_of_birth'] ?? null;

        $this->product->updateProductPlaceOfBirth($productId, $placeOfBirth, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Save Product Place of Birth Success',
            'The product place of birth has been saved successfully.'
        );
    }

    public function updateProductCompany($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_company_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productId     = $_POST['product_id'] ?? null;
        $companyId      = $_POST['company_id'] ?? null;

        $companyDetails     = $this->company->fetchCompany($companyId);
        $companyName        = $companyDetails['company_name'] ?? null;

        $this->product->updateProductCompany($productId, $companyId, $companyName, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Save Product Company Success',
            'The product company has been saved successfully.'
        );
    }

    public function updateProductDepartment($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_department_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productId     = $_POST['product_id'] ?? null;
        $departmentId   = $_POST['department_id'] ?? null;

        $departmentDetails  = $this->department->fetchDepartment($departmentId);
        $departmentName     = $departmentDetails['department_name'] ?? null;

        $this->product->updateProductDepartment($productId, $departmentId, $departmentName, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Save Product Department Success',
            'The product department has been saved successfully.'
        );
    }

    public function updateProductJobPosition($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_job_position_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productId     = $_POST['product_id'] ?? null;
        $jobPositionId  = $_POST['job_position_id'] ?? null;

        $jobPositionDetails     = $this->jobPosition->fetchJobPosition($jobPositionId);
        $jobPositionName        = $jobPositionDetails['job_position_name'] ?? null;

        $this->product->updateProductJobPosition($productId, $jobPositionId, $jobPositionName, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Save Product Job Position Success',
            'The product job position has been saved successfully.'
        );
    }

    public function updateProductManager($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_manager_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productId     = $_POST['product_id'] ?? null;
        $managerId      = $_POST['manager_id'] ?? null;

        $manageDetails  = $this->product->fetchProduct($managerId);
        $manageName     = $manageDetails['full_name'] ?? null;

        $this->product->updateProductManager($productId, $managerId, $manageName, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Save Product Manager Success',
            'The product manager has been saved successfully.'
        );
    }

    public function updateProductTimeOffApprover($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_time_off_approver_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productId         = $_POST['product_id'] ?? null;
        $timeOffApproverId  = $_POST['time_off_approver_id'] ?? null;

        $timeOffApproverDetails     = $this->product->fetchProduct($timeOffApproverId);
        $timeOffApproverName        = $timeOffApproverDetails['full_name'] ?? null;

        $this->product->updateProductTimeOffApprover($productId, $timeOffApproverId, $timeOffApproverName, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Save Product Time Off Approver Success',
            'The product time off approver has been saved successfully.'
        );
    }

    public function updateProductEmploymentType($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_employment_type_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productId         = $_POST['product_id'] ?? null;
        $employmentTypeId   = $_POST['employment_type_id'] ?? null;

        $employmentTypeDetails  = $this->employmentType->fetchEmploymentType($employmentTypeId);
        $employmentTypeName     = $employmentTypeDetails['employment_type_name'] ?? null;

        $this->product->updateProductEmploymentType($productId, $employmentTypeId, $employmentTypeName, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Save Product Employment Type Success',
            'The product employment type has been saved successfully.'
        );
    }

    public function updateProductEmploymentLocationType($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_employment_location_type_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productId                 = $_POST['product_id'] ?? null;
        $employmentLocationTypeId   = $_POST['employment_location_type_id'] ?? null;

        $employmentTLocationypeDetails  = $this->employmentLocationType->fetchEmploymentLocationType($employmentLocationTypeId);
        $employmentLocationTypeName     = $employmentTLocationypeDetails['employment_location_type_name'] ?? null;

        $this->product->updateProductEmploymentLocationType($productId, $employmentLocationTypeId, $employmentLocationTypeName, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Save Product Employment Location Type Success',
            'The product employment location type has been saved successfully.'
        );
    }

    public function updateProductWorkLocation($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_work_location_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productId     = $_POST['product_id'] ?? null;
        $wokLocationId  = $_POST['work_location_id'] ?? null;

        $workLocationDetails    = $this->workLocation->fetchWorkLocation($wokLocationId);
        $workLocationName       = $workLocationDetails['work_location_name'] ?? null;

        $this->product->updateProductWorkLocation($productId, $wokLocationId, $workLocationName, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Save Product Work Location Success',
            'The product work location has been saved successfully.'
        );
    }

    public function updateProductOnBoardDate($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_on_board_date_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productId     = $_POST['product_id'] ?? null;
        $onBoardDate    = $this->systemHelper->checkDate('empty', $_POST['on_board_date'], '', 'Y-m-d', '');

        $this->product->updateProductOnBoardDate($productId, $onBoardDate, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Save Product On Board Date Success',
            'The product on board date has been saved successfully.'
        );
    }

    public function updateProductWorkEmail($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_work_email_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productId     = $_POST['product_id'] ?? null;
        $workEmail      = $_POST['work_email'] ?? null;

        $this->product->updateProductWorkEmail($productId, $workEmail, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Save Product Work Email Success',
            'The product work email has been saved successfully.'
        );
    }

    public function updateProductWorkPhone($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_work_phone_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productId     = $_POST['product_id'] ?? null;
        $workPhone      = $_POST['work_phone'] ?? null;

        $this->product->updateProductWorkPhone($productId, $workPhone, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Save Product Work Phone Success',
            'The product work phone has been saved successfully.'
        );
    }

    public function updateProductWorkTelephone($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'update_work_telephone_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productId     = $_POST['product_id'] ?? null;
        $workTelephone  = $_POST['work_telephone'] ?? null;

        $this->product->updateProductWorkTelephone($productId, $workTelephone, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Save Product Work Telephone Success',
            'The product work telephone has been saved successfully.'
        );
    }

    public function updateProductImage($lastLogBy){
        $productId   = $_POST['product_id'] ?? null;
       
        $productImageFileName              = $_FILES['product_image']['name'];
        $productImageFileSize              = $_FILES['product_image']['size'];
        $productImageFileError             = $_FILES['product_image']['error'];
        $productImageTempName              = $_FILES['product_image']['tmp_name'];
        $productImageFileExtension         = explode('.', $productImageFileName);
        $productImageActualFileExtension   = strtolower(end($productImageFileExtension));

        $uploadSetting  = $this->uploadSetting->fetchUploadSetting(6);
        $maxFileSize    = $uploadSetting['max_file_size'];

        $uploadSettingFileExtension = $this->uploadSetting->fetchUploadSettingFileExtension(6);
        $allowedFileExtensions = [];

        foreach ($uploadSettingFileExtension as $row) {
            $allowedFileExtensions[] = $row['file_extension'];
        }

        if (!in_array($productImageActualFileExtension, $allowedFileExtensions)) {              
            $this->systemHelper::sendErrorResponse(
                'Update Product Image Error', 
                'The file uploaded is not supported.'
            );
        }
            
        if(empty($productImageTempName)){
            $this->systemHelper::sendErrorResponse(
                'Update Product Image Error', 
                'Please choose the product image.'
            );
        }
            
        if($productImageFileError){                
            $this->systemHelper::sendErrorResponse(
                'Update Product Image Error', 
                'An error occurred while uploading the file.'
            );
        }
            
        if($productImageFileSize > ($maxFileSize * 1024)){
            $this->systemHelper::sendErrorResponse(
                'Update Product Image Error', 
                'The product image exceeds the maximum allowed size of ' . $maxFileSize . ' mb.'
            );
        }

        $fileName   = $this->security->generateFileName();
        $fileNew    = $fileName . '.' . $productImageActualFileExtension;
            
        define('PROJECT_BASE_DIR', dirname(__DIR__, 2));

        $uploadsDir         = PROJECT_BASE_DIR . '/storage/uploads/';
        $directory          = $uploadsDir . 'product/' . $productId . '/';
        $fileDestination    = $directory . $fileNew;
        $filePath           = 'storage/uploads/product/' . $productId . '/' . $fileNew;

        $directoryChecker = $this->security->directoryChecker($directory);

        if ($directoryChecker !== true) {
            $this->systemHelper::sendErrorResponse(
                'Update Product Image Error',
                $directoryChecker
            );
        }

        $productDetails    = $this->product->fetchProduct($productId);
        $productImage      = $productDetails['product_image'] ?? null;
        
        $this->systemHelper->deleteFileIfExist($productImage);

        if(!move_uploaded_file($productImageTempName, $fileDestination)){
            $this->systemHelper::sendErrorResponse(
                'Update Product Image Error', 
                'The product image cannot be uploaded due to an error'
            );
        }

        $this->product->updateProductImage($productId, $filePath, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Update Product Image Success',
            'The product image has been updated successfully.'
        );
    }

    public function updateProductArchive($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'archive_product_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $productId                 = $_POST['product_id'] ?? null;
        $departureReasonId          = $_POST['departure_reason_id'] ?? null;
        $departureDate              = $this->systemHelper->checkDate('empty', $_POST['departure_date'], '', 'Y-m-d', '');
        $detailedDepartureReason    = $_POST['detailed_departure_reason'] ?? null;

        $departureReasonDetails     = $this->departureReason->fetchDepartureReason($departureReasonId);
        $departureReasonName        = $departureReasonDetails['departure_reason_name'] ?? null;

        $this->product->updateProductArchive($productId, $departureReasonId, $departureReasonName, $detailedDepartureReason, $departureDate, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Product Archive Success',
            'The product has been archived successfully.'
        );
    }

    public function updateProductUnarchive($lastLogBy){
        $productId = $_POST['product_id'] ?? null;

        $this->product->updateProductUnarchive($productId, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Product Unarchive Success',
            'The product has been unarchived successfully.'
        );
    }

    public function deleteProduct(){
        $productId         = $_POST['product_id'] ?? null;
        $productDetails    = $this->product->fetchProduct($productId);
        $productImage      = $productDetails['product_image'] ?? null;

        $this->systemHelper->deleteFileIfExist($productImage);

        $productDocuments = $this->product->fetchAllProductDocument($productId);

        foreach ($productDocuments as $row) {
            $documentFile = $row['document_file'] ?? null;

            $this->systemHelper->deleteFileIfExist($documentFile);
        }

        $this->product->deleteProduct($productId);

        $this->systemHelper->sendSuccessResponse(
            'Delete Product Success',
            'The product has been deleted successfully.'
        );
    }

    public function deleteMultipleProduct(){
        $productIds = $_POST['product_id'] ?? null;

        foreach($productIds as $productId){
            $productDetails    = $this->product->fetchProduct($productId);
            $productImage      = $productDetails['product_image'] ?? null;

            $this->systemHelper->deleteFileIfExist($productImage);

            $productDocuments = $this->product->fetchAllProductDocument($productId);

            foreach ($productDocuments as $row) {
                $documentFile = $row['document_file'] ?? null;

                $this->systemHelper->deleteFileIfExist($documentFile);
            }

            $this->product->deleteProduct($productId);
        }

        $this->systemHelper->sendSuccessResponse(
            'Delete Multiple Products Success',
            'The selected products have been deleted successfully.'
        );
    }

    public function deleteProductLanguage(){
        $productLanguageId = $_POST['product_language_id'] ?? null;

        $this->product->deleteProductLanguage($productLanguageId);

        $this->systemHelper->sendSuccessResponse(
            'Delete Product Language Success',
            'The product language has been deleted successfully.'
        );
    }

    public function deleteProductEducation(){
        $productEducationId = $_POST['product_education_id'] ?? null;

        $this->product->deleteProductEducation($productEducationId);

        $this->systemHelper->sendSuccessResponse(
            'Delete Product Educational Background Success',
            'The product educational background has been deleted successfully.'
        );
    }

    public function deleteProductEmergencyContact(){
        $productEmergencyContactId = $_POST['product_emergency_contact_id'] ?? null;

        $this->product->deleteProductEmergencyContact($productEmergencyContactId);

        $this->systemHelper->sendSuccessResponse(
            'Delete Product Emergency Contact Success',
            'The product emergency contact has been deleted successfully.'
        );
    }

    public function deleteProductLicense(){
        $productLicenseId = $_POST['product_license_id'] ?? null;

        $this->product->deleteProductLicense($productLicenseId);

        $this->systemHelper->sendSuccessResponse(
            'Delete Product License Success',
            'The product license has been deleted successfully.'
        );
    }

    public function deleteProductExperience(){
        $productExperienceId = $_POST['product_experience_id'] ?? null;

        $this->product->deleteProductExperience($productExperienceId);

        $this->systemHelper->sendSuccessResponse(
            'Delete Product Experience Success',
            'The product experience has been deleted successfully.'
        );
    }

    public function deleteProductDocument(){
        $productDocumentId = $_POST['product_document_id'] ?? null;

        $productDocumentDetails    = $this->product->fetchProductDocument($productDocumentId);
        $documentFile               = $productDocumentDetails['document_file'] ?? null;
        
        $this->systemHelper->deleteFileIfExist($documentFile);

        $this->product->deleteProductDocument($productDocumentId);

        $this->systemHelper->sendSuccessResponse(
            'Delete Product Document Success',
            'The product document has been deleted successfully.'
        );
    }

    public function fetchProductDetails(){
        $productId             = $_POST['product_id'] ?? null;
        $checkProductExist     = $this->product->checkProductExist($productId);
        $total                  = $checkProductExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper->sendErrorResponse(
                'Get Product Details',
                'The product does not exist',
                ['notExist' => true]
            );
        }

        $productDetails        = $this->product->fetchProduct($productId);
        $productImage          = $this->systemHelper->checkImageExist($productDetails['product_image'] ?? null, 'profile');
        $employmentStatus       = $productDetails['employment_status'] ?? 'Active';
        $badgeClass             = $employmentStatus == 'Active' ? 'success' : 'danger';
        $employmentStatusBadge  = '<div class="badge badge-lg badge-light-'. $badgeClass .'">'. $employmentStatus .'</div>';
        $addressParts           = [
                                    $productDetails['private_address'],
                                    $productDetails['private_address_city_name'],
                                    $productDetails['private_address_state_name'],
                                    $productDetails['private_address_country_name']
                                ];

        $addressParts = array_filter($addressParts, function($part) {
            return !empty($part);
        });

        $productAddress = !empty($addressParts) ? implode(', ', $addressParts) : '--';

        $response = [
            'success'                       => true,
            'fullName'                      => $productDetails['full_name'] ?? null,
            'firstName'                     => $productDetails['first_name'] ?? null,
            'middleName'                    => $productDetails['middle_name'] ?? null,
            'lastName'                      => $productDetails['last_name'] ?? null,
            'suffix'                        => $productDetails['suffix'] ?? null,
            'privateAddress'                => $productDetails['private_address'] ?? null,
            'privateAddressCityID'          => $productDetails['private_address_city_id'] ?? null,
            'civilStatusID'                 => $productDetails['civil_status_id'] ?? null,
            'religionID'                    => $productDetails['religion_id'] ?? null,
            'bloodTypeID'                   => $productDetails['blood_type_id'] ?? null,
            'height'                        => $productDetails['height'] ?? null,
            'weight'                        => $productDetails['weight'] ?? null,
            'nickname'                      => $productDetails['nickname'] ?? null,
            'dependents'                    => $productDetails['dependents'] ?? null,
            'homeWorkDistance'              => $productDetails['home_work_distance'] ?? null,
            'civilStatusName'               => $productDetails['civil_status_name'] ?? null,
            'religionName'                  => $productDetails['religion_name'] ?? null,
            'bloodTypeName'                 => $productDetails['blood_type_name'] ?? null,
            'badgeID'                       => $productDetails['badge_id'] ?? null,
            'privateEmail'                  => $productDetails['private_email'] ?? null,
            'privatePhone'                  => $productDetails['private_phone'] ?? null,
            'privateTelephone'              => $productDetails['private_telephone'] ?? null,
            'nationalityName'               => $productDetails['nationality_name'] ?? null,
            'genderName'                    => $productDetails['gender_name'] ?? null,
            'birthday'                      => $this->systemHelper->checkDate('summary', $productDetails['birthday'] ?? null, '', 'd M Y', ''),
            'placeOfBirth'                  => $productDetails['place_of_birth'] ?? null,
            'companyName'                   => $productDetails['company_name'] ?? null,
            'departmentName'                => $productDetails['department_name'] ?? null,
            'jobPositionName'               => $productDetails['job_position_name'] ?? null,
            'managerName'                   => $productDetails['manager_name'] ?? null,
            'timeOffApproverName'           => $productDetails['time_off_approver_name'] ?? null,
            'employmentTypeName'            => $productDetails['employment_type_name'] ?? null,
            'employmentLocationTypeName'    => $productDetails['employment_location_type_name'] ?? null,
            'workLocationName'              => $productDetails['work_location_name'] ?? null,
            'onBoardDate'                   => $this->systemHelper->checkDate('summary', $productDetails['on_board_date'] ?? null, '', 'd M Y', ''),
            'workEmail'                     => $productDetails['work_email'] ?? null,
            'workPhone'                     => $productDetails['work_phone'] ?? null,
            'workTelephone'                 => $productDetails['work_telephone'] ?? null,
            'departureReasonName'           => $productDetails['departure_reason_name'] ?? null,
            'detailedDepartureReason'       => $productDetails['detailed_departure_reason'] ?? null,
            'departureDate'                 => $this->systemHelper->checkDate('summary', $productDetails['departure_date'] ?? null, '', 'd M Y', ''),
            'employmentStatus'              => $employmentStatusBadge,
            'productAddress'               => $productAddress,
            'productImage'                 => $productImage
        ];

        echo json_encode($response);
        exit;
    }

    public function fetchProductEducationDetails(){
        $productEducationId = $_POST['product_education_id'] ?? null;

        $productEducationDetails = $this->product->fetchProductEducation($productEducationId);

        $response = [
            'success'               => true,
            'school'                => $productEducationDetails['school'] ?? null,
            'degree'                => $productEducationDetails['degree'] ?? null,
            'fieldOfStudy'          => $productEducationDetails['field_of_study'] ?? null,
            'startMonth'            => $productEducationDetails['start_month'] ?? null,
            'startYear'             => $productEducationDetails['start_year'] ?? null,
            'endMonth'              => $productEducationDetails['end_month'] ?? null,
            'endYear'               => $productEducationDetails['end_year'] ?? null,
            'activitiesSocieties'   => $productEducationDetails['activities_societies'] ?? null,
            'educationDescription'  => $productEducationDetails['education_description'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function fetchProductEmergencyContactDetails(){
        $productEmergencyContactId = $_POST['product_emergency_contact_id'] ?? null;

        $productEmergencyContactDetails = $this->product->fetchProductEmergencyContact($productEmergencyContactId);

        $response = [
            'success'               => true,
            'emergencyContactName'  => $productEmergencyContactDetails['emergency_contact_name'] ?? null,
            'relationshipId'        => $productEmergencyContactDetails['relationship_id'] ?? null,
            'telephone'             => $productEmergencyContactDetails['telephone'] ?? null,
            'mobile'                => $productEmergencyContactDetails['mobile'] ?? null,
            'email'                 => $productEmergencyContactDetails['email'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function fetchProductLicenseDetails(){
        $productLicenseId = $_POST['product_license_id'] ?? null;

        $productLicenseDetails = $this->product->fetchProductLicense($productLicenseId);

        $response = [
            'success'               => true,
            'licensedProfession'    => $productLicenseDetails['licensed_profession'] ?? null,
            'licensingBody'         => $productLicenseDetails['licensing_body'] ?? null,
            'licenseNumber'         => $productLicenseDetails['license_number'] ?? null,
            'issueDate'             => $this->systemHelper->checkDate('summary', $productLicenseDetails['issue_date'] ?? null, '', 'M d, Y', ''),
            'expirationDate'        => $this->systemHelper->checkDate('summary', $productLicenseDetails['expiration_date'] ?? null, '', 'M d, Y', '')
        ];

        echo json_encode($response);
        exit;
    }

    public function fetchProductExperienceDetails(){
        $productExperienceId = $_POST['product_experience_id'] ?? null;

        $productExperienceDetails = $this->product->fetchProductExperience($productExperienceId);

        $response = [
            'success'           => true,
            'jobTitle'          => $productExperienceDetails['job_title'] ?? null,
            'employmentTypeId'  => $productExperienceDetails['employment_type_id'] ?? null,
            'companyName'       => $productExperienceDetails['company_name'] ?? null,
            'location'          => $productExperienceDetails['location'] ?? null,
            'startMonth'        => $productExperienceDetails['start_month'] ?? null,
            'startYear'         => $productExperienceDetails['start_year'] ?? null,
            'endMonth'          => $productExperienceDetails['end_month'] ?? null,
            'endYear'           => $productExperienceDetails['end_year'] ?? null,
            'jobDescription'    => $productExperienceDetails['job_description'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function generateProductCard()
    {
        $pageLink               = $_POST['page_link'] ?? null;
        $searchValue            = $_POST['search_value'] ?? null;
        $companyFilter          = $this->systemHelper->checkFilter($_POST['filter_by_company'] ?? null);
        $departmentFilter       = $this->systemHelper->checkFilter($_POST['filter_by_department'] ?? null);
        $jobPositionFilter      = $this->systemHelper->checkFilter($_POST['filter_by_job_position'] ?? null);
        $productStatusFilter   = $this->systemHelper->checkFilter($_POST['filter_by_product_status'] ?? null);
        $workLocationFilter     = $this->systemHelper->checkFilter($_POST['filter_by_work_location'] ?? null);
        $employmentTypeFilter   = $this->systemHelper->checkFilter($_POST['filter_by_employment_type'] ?? null);
        $genderFilter           = $this->systemHelper->checkFilter($_POST['filter_by_gender'] ?? null);
        $limit                  = $_POST['limit'] ?? null;
        $offset                 = $_POST['offset'] ?? null;
        $response               = [];

        $products = $this->product->generateProductCard($searchValue, $companyFilter, $departmentFilter, $jobPositionFilter, $productStatusFilter, $workLocationFilter, $employmentTypeFilter, $genderFilter, $limit, $offset);

        foreach ($products as $row) {
            $productId         = $row['product_id'];
            $fullName           = $row['full_name'];
            $departmentName     = $row['department_name'];
            $jobPositionName    = $row['job_position_name'];
            $employmentStatus   = $row['employment_status'];
            $productImage      = $this->systemHelper->checkImageExist($row['product_image'] ?? null, 'profile');

            $badgeClass             = $employmentStatus == 'Active' ? 'bg-success' : 'bg-danger';
            $employmentStatusBadge  = '<div class="'. $badgeClass .' position-absolute border border-4 border-body h-15px w-15px rounded-circle translate-middle start-100 top-100 ms-n3 mt-n3"></div>';

            $productIdEncrypted = $this->security->encryptData($productId);

            $card = '<div class="col-md-3">
                        <a href="'. $pageLink .'&id='. $productIdEncrypted .'" class="cursor-pointer" target="_blank">
                            <div class="card">
                                <div class="card-body d-flex flex-center flex-column pt-12 p-9">
                                    <div class="symbol symbol-65px symbol-circle mb-5">
                                        <img src="'. $productImage .'" alt="image">
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

    public function generateProductTable()
    {
        $pageLink               = $_POST['page_link'] ?? null;
        $companyFilter          = $this->systemHelper->checkFilter($_POST['filter_by_company'] ?? null);
        $departmentFilter       = $this->systemHelper->checkFilter($_POST['filter_by_department'] ?? null);
        $jobPositionFilter      = $this->systemHelper->checkFilter($_POST['filter_by_job_position'] ?? null);
        $productStatusFilter   = $this->systemHelper->checkFilter($_POST['filter_by_product_status'] ?? null);
        $workLocationFilter     = $this->systemHelper->checkFilter($_POST['filter_by_work_location'] ?? null);
        $employmentTypeFilter   = $this->systemHelper->checkFilter($_POST['filter_by_employment_type'] ?? null);
        $genderFilter           = $this->systemHelper->checkFilter($_POST['filter_by_gender'] ?? null);
        $response               = [];

        $products = $this->product->generateProductTable($companyFilter, $departmentFilter, $jobPositionFilter, $productStatusFilter, $workLocationFilter, $employmentTypeFilter, $genderFilter);

        foreach ($products as $row) {
            $productId         = $row['product_id'];
            $fullName           = $row['full_name'];
            $departmentName     = $row['department_name'];
            $jobPositionName    = $row['job_position_name'];
            $employmentStatus   = $row['employment_status'];
            $productImage      = $this->systemHelper->checkImageExist($row['product_image'] ?? null, 'profile');

            $badgeClass             = $employmentStatus == 'Active' ? 'bg-success' : 'bg-danger';
            $employmentStatusBadge  = '<div class="'. $badgeClass .' position-absolute border border-4 border-body h-15px w-15px rounded-circle translate-middle start-100 top-100 ms-n3 mt-n3"></div>';

            $productIdEncrypted = $this->security->encryptData($productId);

            $response[] = [
                'CHECK_BOX'     => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                        <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $productId .'">
                                    </div>',
                'EMPLOYEE'      => '<div class="d-flex align-items-center">
                                        <div class="me-4">
                                            <div class="symbol symbol-50px symbol-circle">
                                                <img src="'. $productImage .'" alt="image">
                                                '. $employmentStatusBadge .'
                                            </div>
                                        </div>
                                        <div class="d-flex flex-column">
                                            <span class="text-gray-800 mb-1">'. $fullName .'</span>
                                            <span class="text-gray-600">'. $jobPositionName .'</span>
                                        </div>
                                    </div>',
                'DEPARTMENT'    => $departmentName,
                'LINK'          => $pageLink .'&id='. $productIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateProductOptions()
    {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $products = $this->product->generateProductOptions();

        foreach ($products as $row) {
            $response[] = [
                'id'    => $row['product_id'],
                'text'  => $row['full_name']
            ];
        }

        echo json_encode($response);
    }

    public function generateProductLanguageList($lastLogBy, $pageId)
    {
        $productId     = $_POST['product_id'] ?? null;
        $writeAccess    = $this->authentication->checkUserPermission($lastLogBy, $pageId, 'write')['total'] ?? 0;
        $logNotesAccess     = $this->authentication->checkUserPermission($lastLogBy, $pageId, 'log notes')['total'] ?? 0;
        $list           = '';

        $results = $this->product->generateProductLanguageList($productId);

        $lastRole = end($results);
        reset($results);

        foreach ($results as $row) {
            $productLanguageId         = $row['product_language_id'];
            $languageName               = $row['language_name'];
            $languageProficiencyName    = $row['language_proficiency_name'];

            $deleteButton = '';
            if($writeAccess > 0){
                $deleteButton = '<button type="button" class="btn btn-icon btn-light btn-active-light-danger ms-auto delete-product-language" data-product-language-id="' . $productLanguageId . '">
                                        <i class="ki-outline ki-trash fs-3 m-0 fs-5"></i>
                                    </button>';
            }

            $logNotes = '';
            if($logNotesAccess > 0){
                $logNotes = '<button class="btn btn-icon btn-light btn-active-light-primary me-3 view-product-language-log-notes" data-product-language-id="' . $productLanguageId . '" data-bs-toggle="modal" data-bs-target="#log-notes-modal" title="View Log Notes">
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

    public function generateProductEducationList($lastLogBy, $pageId)
    {
        $productId         = $_POST['product_id'] ?? null;
        $writeAccess        = $this->authentication->checkUserPermission($lastLogBy, $pageId, 'write')['total'] ?? 0;
        $logNotesAccess     = $this->authentication->checkUserPermission($lastLogBy, $pageId, 'log notes')['total'] ?? 0;
        $list               = '';

        $results = $this->product->generateProductEducationList($productId);

        reset($results);

        foreach ($results as $row) {
            $productEducationId    = $row['product_education_id'];
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
                $button = '<button class="btn btn-icon btn-light btn-active-light-warning me-3 update-product-education" data-bs-toggle="modal" data-bs-target="#product_education_modal" data-product-education-id="' . $productEducationId . '">
                                <i class="ki-outline ki-pencil fs-3 m-0 fs-5"></i>
                            </button>
                            <button class="btn btn-icon btn-light btn-active-light-danger delete-product-education" data-product-education-id="' . $productEducationId . '">
                                 <i class="ki-outline ki-trash fs-3 m-0 fs-5"></i>
                            </button>';
            }

            $logNotes = '';
            if($logNotesAccess > 0){
                $logNotes = '<button class="btn btn-icon btn-light btn-active-light-primary me-3 view-product-education-log-notes" data-product-education-id="' . $productEducationId . '" data-bs-toggle="modal" data-bs-target="#log-notes-modal" title="View Log Notes">
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
                                        <h4 class="text-gray-900 fw-bold">Add New Educational Background for Product</h4>
                                        <div class="fs-6 text-gray-700 pe-7">Provide detailed information about the product\'s educational background, including school, degree, and field of study.</div>
                                    </div>
                                    <a href="javascript:void(0);" id="add-product-education" class="btn btn-primary px-6 align-self-center text-nowrap" data-bs-toggle="modal" data-bs-target="#product_education_modal"> New Educational Background</a>
                                </div>
                            </div>
                        </div>';

        }

        $response[] = [
            'EDUCATION_LIST' => $list
        ];


        echo json_encode($response);
    }

    public function generateProductEmergencyContactList($lastLogBy, $pageId)
    {
        $productId         = $_POST['product_id'] ?? null;
        $writeAccess        = $this->authentication->checkUserPermission($lastLogBy, $pageId, 'write')['total'] ?? 0;
        $logNotesAccess     = $this->authentication->checkUserPermission($lastLogBy, $pageId, 'log notes')['total'] ?? 0;
        $list               = '';

        $results = $this->product->generateProductEmergencyContactList($productId);

        reset($results);

        foreach ($results as $row) {
            $productEmergencyContactId     = $row['product_emergency_contact_id'];
            $emergencyContactName           = $row['emergency_contact_name'];
            $relationshipName               = $row['relationship_name'];
       
            $telephone  = (!empty($row['telephone'])) ? '<div class="fs-6 fw-semibold text-gray-600">Telephone: ' . $row['telephone'] . '</div>' : '';
            $mobile     = (!empty($row['mobile'])) ? '<div class="fs-6 fw-semibold text-gray-600">Mobile: ' . $row['mobile'] . '</div>' : '';
            $email      = (!empty($row['email'])) ? '<div class="fs-6 fw-semibold text-gray-600">Email: ' . $row['email'] . '</div>' : '';

            $button = '';
            if($writeAccess > 0){
                $button = '<button class="btn btn-icon btn-light btn-active-light-warning me-3 update-product-emergency-contact" data-bs-toggle="modal" data-bs-target="#product_emergency_contact_modal" data-product-emergency-contact-id="' . $productEmergencyContactId . '">
                                <i class="ki-outline ki-pencil fs-3 m-0 fs-5"></i>
                            </button>
                            <button class="btn btn-icon btn-light btn-active-light-danger delete-product-emergency-contact" data-product-emergency-contact-id="' . $productEmergencyContactId . '">
                                 <i class="ki-outline ki-trash fs-3 m-0 fs-5"></i>
                            </button>';
            }

            $logNotes = '';
            if($logNotesAccess > 0){
                $logNotes = '<button class="btn btn-icon btn-light btn-active-light-primary me-3 view-product-emergency-contact-log-notes" data-product-emergency-contact-id="' . $productEmergencyContactId . '" data-bs-toggle="modal" data-bs-target="#log-notes-modal" title="View Log Notes">
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
                                        <h4 class="text-gray-900 fw-bold">Add New Emergency Contact for Product</h4>
                                        <div class="fs-6 text-gray-700 pe-7">Provide detailed information about the product\'s emergency contact, including the contact’s full name, relationship to the product, mobile, telephone and email.</div>
                                    </div>
                                    <a href="javascript:void(0);" id="add-product-emergency-contact" class="btn btn-primary px-6 align-self-center text-nowrap" data-bs-toggle="modal" data-bs-target="#product_emergency_contact_modal"> New Emergency Contact</a>
                                </div>
                            </div>
                        </div>';

        }

        $response[] = [
            'EMERGENCY_CONTACT_LIST' => $list
        ];


        echo json_encode($response);
    }

    public function generateProductLicenseList($lastLogBy, $pageId)
    {
        $productId         = $_POST['product_id'] ?? null;
        $writeAccess        = $this->authentication->checkUserPermission($lastLogBy, $pageId, 'write')['total'] ?? 0;
        $logNotesAccess     = $this->authentication->checkUserPermission($lastLogBy, $pageId, 'log notes')['total'] ?? 0;
        $list               = '';

        $results = $this->product->generateProductLicenseList($productId);

        reset($results);

        foreach ($results as $row) {
            $productLicenseId      = $row['product_license_id'];
            $licensedProfession     = $row['licensed_profession'];
            $licensingBody          = $row['licensing_body'];
            $licenseNumber          = $row['license_number'];
            $issueDate          = $this->systemHelper->checkDate('summary', $row['issue_date'] ?? null, '', 'd M Y', '');
       
            $expirationDate     = (!empty($row['expiration_date'])) ? '<div class="fs-6 fw-semibold text-gray-600">Expiring on: ' . $this->systemHelper->checkDate('summary', $row['expiration_date'] ?? null, '', 'd M Y', '') . '</div>' : '';

            $button = '';
            if($writeAccess > 0){
                $button = '<button class="btn btn-icon btn-light btn-active-light-warning me-3 update-product-license" data-bs-toggle="modal" data-bs-target="#product_license_modal" data-product-license-id="' . $productLicenseId . '">
                                <i class="ki-outline ki-pencil fs-3 m-0 fs-5"></i>
                            </button>
                            <button class="btn btn-icon btn-light btn-active-light-danger delete-product-license" data-product-license-id="' . $productLicenseId . '">
                                 <i class="ki-outline ki-trash fs-3 m-0 fs-5"></i>
                            </button>';
            }

            $logNotes = '';
            if($logNotesAccess > 0){
                $logNotes = '<button class="btn btn-icon btn-light btn-active-light-primary me-3 view-product-license-log-notes" data-product-license-id="' . $productLicenseId . '" data-bs-toggle="modal" data-bs-target="#log-notes-modal" title="View Log Notes">
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
                                        <h4 class="text-gray-900 fw-bold">Add New License for Product</h4>
                                        <div class="fs-6 text-gray-700 pe-7">Provide detailed information about the product\'s license, including the license profession, license number, licensing body, issuance date and expiry date.</div>
                                    </div>
                                    <a href="javascript:void(0);" id="add-product-emergency-contact" class="btn btn-primary px-6 align-self-center text-nowrap" data-bs-toggle="modal" data-bs-target="#product_license_modal"> New License</a>
                                </div>
                            </div>
                        </div>';

        }

        $response[] = [
            'LICENSE_LIST' => $list
        ];


        echo json_encode($response);
    }

    public function generateProductExperienceList($lastLogBy, $pageId)
    {
        $productId         = $_POST['product_id'] ?? null;
        $writeAccess        = $this->authentication->checkUserPermission($lastLogBy, $pageId, 'write')['total'] ?? 0;
        $logNotesAccess     = $this->authentication->checkUserPermission($lastLogBy, $pageId, 'log notes')['total'] ?? 0;
        $list               = '';

        $results = $this->product->generateProductExperienceList($productId);

        reset($results);

        foreach ($results as $row) {
            $productExperienceId   = $row['product_experience_id'];
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
                $button = '<button class="btn btn-icon btn-light btn-active-light-warning me-3 update-product-experience" data-bs-toggle="modal" data-bs-target="#product_experience_modal" data-product-experience-id="' . $productExperienceId . '">
                                <i class="ki-outline ki-pencil fs-3 m-0 fs-5"></i>
                            </button>
                            <button class="btn btn-icon btn-light btn-active-light-danger delete-product-experience" data-product-experience-id="' . $productExperienceId . '">
                                 <i class="ki-outline ki-trash fs-3 m-0 fs-5"></i>
                            </button>';
            }

            $logNotes = '';
            if($logNotesAccess > 0){
                $logNotes = '<button class="btn btn-icon btn-light btn-active-light-primary me-3 view-product-experience-log-notes" data-product-experience-id="' . $productExperienceId . '" data-bs-toggle="modal" data-bs-target="#log-notes-modal" title="View Log Notes">
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
                                        <h4 class="text-gray-900 fw-bold">Add New Work Experience for Product</h4>
                                        <div class="fs-6 text-gray-700 pe-7">Provide detailed information about the product\'s work experience, including company, job title, job description, degree, start month, start year, end month, end year, employment type, and work location.</div>
                                    </div>
                                    <a href="javascript:void(0);" id="add-product-experience" class="btn btn-primary px-6 align-self-center text-nowrap" data-bs-toggle="modal" data-bs-target="#product_experience_modal"> New Work Experience</a>
                                </div>
                            </div>
                        </div>';

        }

        $response[] = [
            'EXPERIENCE_LIST' => $list
        ];


        echo json_encode($response);
    }

    public function generateProductDocumentTable($lastLogBy, $pageId)
    {
        $productId     = $_POST['product_id'] ?? null;
        $response       = [];

        $writeAccess        = $this->authentication->checkUserPermission($lastLogBy, $pageId, 'write')['total'] ?? 0;
        $logNotesAccess     = $this->authentication->checkUserPermission($lastLogBy, $pageId, 'log notes')['total'] ?? 0;

        $menuItems = $this->product->generateProductDocumentTable($productId);

        foreach ($menuItems as $row) {
            $productDocumentId         = $row['product_document_id'];
            $documentName               = $row['document_name'];
            $documentFile               = $row['document_file'];
            $productDocumentTypeName   = $row['product_document_type_name'];
            $createdDate                = $this->systemHelper->checkDate('summary', $row['created_date'] ?? null, '', 'M d, Y h:i:s a', '');

            $documentFileDetails = $this->systemHelper->getFileDetails($documentFile, true);

            $button = '';
            if($writeAccess > 0){
                $button = '<button class="btn btn-icon btn-light btn-active-light-danger delete-product-document" data-product-document-id="' . $productDocumentId . '">
                                 <i class="ki-outline ki-trash fs-3 m-0 fs-5"></i>
                            </button>';
            }

            $logNotes = '';
            if($logNotesAccess > 0){
                $logNotes = '<button class="btn btn-icon btn-light btn-active-light-primary view-product-document-log-notes" data-product-document-id="' . $productDocumentId . '" data-bs-toggle="modal" data-bs-target="#log-notes-modal" title="View Log Notes">
                                    <i class="ki-outline ki-shield-search fs-3 m-0 fs-5"></i>
                                </button>';
            }

            $response[] = [
                'DOCUMENT'         => '<div class="d-flex align-items-center">
                                            <div class="symbol symbol-30px me-5">
                                                <img src="'. $documentFileDetails['icon'] .'" alt="'. $documentName .'">
                                            </div>
                                            <div class="d-flex flex-column">
                                                <span class="text-gray-800 fw-bold mb-1">'. $documentName .'</span>
                                                <small class="text-gray-600">'. $productDocumentTypeName .'</small>
                                            </div>
                                        </div>',
                'SIZE'              => $documentFileDetails['size'],
                'UPLOAD_DATE'       => $createdDate,
                'ACTION'            => '<div class="d-flex justify-content-end gap-3">
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
}

# Bootstrap the controller
$controller = new ProductController(
    new Product(),
    new ProductCategory(),
    new ProductType(),
    new Authentication(),
    new UploadSetting(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();
