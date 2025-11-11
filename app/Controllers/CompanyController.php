<?php
namespace App\Controllers;

session_start();

use App\Models\Company;
use App\Models\City;
use App\Models\Currency;
use App\Models\Authentication;
use App\Models\UploadSetting;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class CompanyController {
    protected Company $company;
    protected City $city;
    protected Currency $currency;
    protected Authentication $authentication;
    protected UploadSetting $uploadSetting;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        Company $company,
        City $city,
        Currency $currency,
        Authentication $authentication,
        UploadSetting $uploadSetting,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->company          = $company;
        $this->city             = $city;
        $this->currency         = $currency;
        $this->authentication   = $authentication;
        $this->uploadSetting    = $uploadSetting;
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
            'save company'              => $this->saveCompany($lastLogBy),
            'update company logo'       => $this->updateCompanyLogo($lastLogBy),
            'delete company'            => $this->deleteCompany(),
            'delete multiple company'   => $this->deleteMultipleCompany(),
            'fetch company details'     => $this->fetchCompanyDetails(),
            'generate company table'    => $this->generateCompanyTable(),
            'generate company options'  => $this->generateCompanyOptions(),
            default                     => $this->systemHelper::sendErrorResponse(
                                                'Transaction Failed',
                                                'We encountered an issue while processing your request.'
                                            )
        };
    }

    /* =============================================================================================
        SECTION 1: SAVE METHOD
    ============================================================================================= */

    public function saveCompany(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'company_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $companyId      = $_POST['company_id'] ?? null;
        $companyName    = $_POST['company_name'] ?? null;
        $address        = $_POST['address'] ?? null;
        $cityId         = $_POST['city_id'] ?? null;
        $taxId          = $_POST['tax_id'] ?? null;
        $currencyId     = $_POST['currency_id'] ?? null;
        $phone          = $_POST['phone'] ?? null;
        $telephone      = $_POST['telephone'] ?? null;
        $email          = $_POST['email'] ?? null;
        $website        = $_POST['website'] ?? null;

        $cityDetails    = $this->city->fetchCity($cityId);
        $cityName       = $cityDetails['city_name'] ?? null;
        $stateId        = $cityDetails['state_id'] ?? null;
        $stateName      = $cityDetails['state_name'] ?? null;
        $countryId      = $cityDetails['country_id'] ?? null;
        $countryName    = $cityDetails['country_name'] ?? null;

        $currencyDetails    = $this->currency->fetchCurrency($currencyId);
        $currencyName       = $currencyDetails['currency_name'] ?? null;

        $companyId = $this->company->saveCompany(
            $companyId,
            $companyName,
            $address,
            $cityId,
            $cityName,
            $stateId,
            $stateName,
            $countryId,
            $countryName,
            $taxId,
            $currencyId,
            $currencyName,
            $phone,
            $telephone,
            $email,
            $website,
            $lastLogBy
        );

        $encryptedcompanyId = $this->security->encryptData($companyId);

        $this->systemHelper::sendSuccessResponse(
            'Save Company Success',
            'The company has been saved successfully.',
            ['company_id' => $encryptedcompanyId]
        );
    }

    /* =============================================================================================
        SECTION 2: INSERT METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 3: UPDATE METHOD
    ============================================================================================= */

    public function updateCompanyLogo(
        int $lastLogBy
    ) {
        $companyId                          = $_POST['company_id'] ?? null;       
        $companyLogoFileName                = $_FILES['company_logo']['name'];
        $companyLogoFileSize                = $_FILES['company_logo']['size'];
        $companyLogoFileError               = $_FILES['company_logo']['error'];
        $companyLogoTempName                = $_FILES['company_logo']['tmp_name'];
        $companyLogoFileExtension           = explode('.', $companyLogoFileName);
        $companyLogoActualFileExtension     = strtolower(end($companyLogoFileExtension));

        $uploadSetting  = $this->uploadSetting->fetchUploadSetting(5);
        $maxFileSize    = $uploadSetting['max_file_size'];

        $uploadSettingFileExtension     = $this->uploadSetting->fetchUploadSettingFileExtension(5);
        $allowedFileExtensions          = [];

        foreach ($uploadSettingFileExtension as $row) {
            $allowedFileExtensions[] = $row['file_extension'];
        }

        if (!in_array($companyLogoActualFileExtension, $allowedFileExtensions)) {              
            $this->systemHelper::sendErrorResponse(
                'Update Company Logo Error', 
                'The file uploaded is not supported.'
            );
        }
            
        if(empty($companyLogoTempName)){
            $this->systemHelper::sendErrorResponse(
                'Update Company Logo Error', 
                'Please choose the app logo.'
            );
        }
            
        if($companyLogoFileError){                
            $this->systemHelper::sendErrorResponse(
                'Update Company Logo Error', 
                'An error occurred while uploading the file.'
            );
        }
            
        if($companyLogoFileSize > ($maxFileSize * 1024)){
            $this->systemHelper::sendErrorResponse(
                'Update Company Logo Error', 
                'The company logo exceeds the maximum allowed size of ' . $maxFileSize . ' mb.'
            );
        }

        $fileName   = $this->security->generateFileName();
        $fileNew    = $fileName . '.' . $companyLogoActualFileExtension;
            
        define('PROJECT_BASE_DIR', dirname(__DIR__, 2));

        $uploadsDir         = PROJECT_BASE_DIR . '/storage/uploads/';
        $directory          = $uploadsDir . 'company/' . $companyId . '/';
        $fileDestination    = $directory . $fileNew;
        $filePath           = 'storage/uploads/company/' . $companyId . '/' . $fileNew;

        $directoryChecker = $this->security->directoryChecker($directory);

        if ($directoryChecker !== true) {
            $this->systemHelper::sendErrorResponse(
                'Update Company Logo Error',
                $directoryChecker
            );
        }

        $companyDetails     = $this->company->fetchCompany($companyId);
        $companyLogo        = $companyDetails['company_logo'] ?? null;
        
        $this->systemHelper->deleteFileIfExist($companyLogo);

        if(!move_uploaded_file($companyLogoTempName, $fileDestination)){
            $this->systemHelper::sendErrorResponse(
                'Update Company Logo Error', 
                'The company logo cannot be uploaded due to an error'
            );
        }

        $this->company->updateCompanyLogo(
            $companyId,
            $filePath,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Update Company Logo Success',
            'The company logo has been updated successfully.'
        );
    }

    /* =============================================================================================
        SECTION 4: FETCH METHOD
    ============================================================================================= */

    public function fetchCompanyDetails() {
        $companyId          = $_POST['company_id'] ?? null;
        $checkCompanyExist  = $this->company->checkCompanyExist($companyId);
        $total              = $checkCompanyExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get Company Details',
                'The company does not exist',
                ['notExist' => true]
            );
        }

        $companyDetails     = $this->company->fetchCompany($companyId);
        $companyLogo        = $this->systemHelper->checkImageExist($companyDetails['company_logo'] ?? null, 'company logo');

        $response = [
            'success'       => true,
            'companyName'   => $companyDetails['company_name'] ?? null,
            'address'       => $companyDetails['address'] ?? null,
            'cityID'        => $companyDetails['city_id'] ?? null,
            'taxID'         => $companyDetails['tax_id'] ?? null,
            'currencyID'    => $companyDetails['currency_id'] ?? null,
            'phone'         => $companyDetails['phone'] ?? null,
            'telephone'     => $companyDetails['telephone'] ?? null,
            'email'         => $companyDetails['email'] ?? null,
            'website'       => $companyDetails['website'] ?? null,
            'companyLogo'   => $companyLogo
        ];

        echo json_encode($response);
        exit;
    }

    public function generateCompanyTable() {
        $pageLink           = $_POST['page_link'] ?? null;
        $cityFilter         = $this->systemHelper->checkFilter($_POST['filter_by_city'] ?? null);
        $stateFilter        = $this->systemHelper->checkFilter($_POST['filter_by_state'] ?? null);
        $countryFilter      = $this->systemHelper->checkFilter($_POST['filter_by_country'] ?? null);
        $currencyFilter     = $this->systemHelper->checkFilter($_POST['filter_by_currency'] ?? null);
        $response           = [];

        $companies = $this->company->generateCompanyTable(
            $cityFilter,
            $stateFilter,
            $countryFilter,
            $currencyFilter
        );

        foreach ($companies as $row) {
            $companyId              = $row['company_id'];
            $companyName            = $row['company_name'];
            $address                = $row['address'];
            $cityName               = $row['city_name'];
            $stateName              = $row['state_name'];
            $countryName            = $row['country_name'];
            $companyAddress         = $address . ', ' . $cityName . ', ' . $stateName . ', ' . $countryName;
            $companyLogo            = $this->systemHelper->checkImageExist($row['company_logo'] ?? null, 'company logo');
            $companyIdEncrypted     = $this->security->encryptData($companyId);

            $response[] = [
                'CHECK_BOX'     => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                        <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $companyId .'">
                                    </div>',
                'COMPANY_NAME'  => '<div class="d-flex align-items-center">
                                        <div class="symbol symbol-circle symbol-50px overflow-hidden me-3">
                                            <div class="symbol-label">
                                                <img src="'. $companyLogo .'" alt="'. $companyName .'" class="w-100">
                                            </div>
                                        </div>
                                        <div class="d-flex flex-column">
                                            <span class="text-gray-800 fw-bold mb-1">'. $companyName .'</span>
                                            <small class="text-gray-600">'. $companyAddress .'</small>
                                        </div>
                                    </div>',
                'LINK'          => $pageLink .'&id='. $companyIdEncrypted
            ];
        }

        echo json_encode($response);
    }

    /* =============================================================================================
        SECTION 5: DELETE METHOD
    ============================================================================================= */

    public function deleteCompany() {
        $companyId          = $_POST['company_id'] ?? null;
        $companyDetails     = $this->company->fetchCompany($companyId);
        $companyLogo        = $companyDetails['company_logo'] ?? null;

        $this->systemHelper->deleteFileIfExist($companyLogo);

        $this->company->deleteCompany($companyId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Company Success',
            'The company has been deleted successfully.'
        );
    }

    public function deleteMultipleCompany() {
        $companyIds = $_POST['company_id'] ?? null;

        foreach($companyIds as $companyId){
            $companyDetails     = $this->company->fetchCompany($companyId);
            $companyLogo        = $companyDetails['company_logo'] ?? null;

            $this->systemHelper->deleteFileIfExist($companyLogo);

            $this->company->deleteCompany($companyId);
        }

        $this->systemHelper::sendSuccessResponse(
            'Delete Multiple Companies Success',
            'The selected companies have been deleted successfully.'
        );
    }
    
    /* =============================================================================================
        SECTION 6: CHECK METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 7: GENERATE METHOD
    ============================================================================================= */

    public function generateCompanyOptions() {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $companies = $this->company->generateCompanyOptions();

        foreach ($companies as $row) {
            $response[] = [
                'id'    => $row['company_id'],
                'text'  => $row['company_name']
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

$controller = new CompanyController(
    new Company(),
    new City(),
    new Currency(),
    new Authentication(),
    new UploadSetting(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();