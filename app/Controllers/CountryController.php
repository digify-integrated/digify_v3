<?php
namespace App\Controllers;


session_start();

use App\Models\Country;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class CountryController
{
    protected Country $country;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        Country $country,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->country          = $country;
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
            'save country'               => $this->saveCountry($lastLogBy),
            'delete country'             => $this->deleteCountry(),
            'delete multiple country'    => $this->deleteMultipleCountry(),
            'fetch country details'      => $this->fetchCountryDetails(),
            'generate country table'     => $this->generateCountryTable(),
            'generate country options'   => $this->generateCountryOptions(),
            default                      => $this->systemHelper::sendErrorResponse(
                                                    'Transaction Failed',
                                                    'We encountered an issue while processing your request.'
                                                )
        };
    }

    public function saveCountry($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'country_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $countryId      = $_POST['country_id'] ?? null;
        $countryName    = $_POST['country_name'] ?? null;
        $countryCode    = $_POST['country_code'] ?? null;
        $phoneCode      = $_POST['phone_code'] ?? null;

        $countryId              = $this->country->saveCountry($countryId, $countryName, $countryCode, $phoneCode, $lastLogBy);
        $encryptedcountryId     = $this->security->encryptData($countryId);

        $this->systemHelper->sendSuccessResponse(
            'Save Country Success',
            'The country has been saved successfully.',
            ['country_id' => $encryptedcountryId]
        );
    }

    public function deleteCountry(){
        $countryId = $_POST['country_id'] ?? null;

        $this->country->deleteCountry($countryId);

        $this->systemHelper->sendSuccessResponse(
            'Delete Country Success',
            'The country has been deleted successfully.'
        );
    }

    public function deleteMultipleCountry(){
        $countryIds  = $_POST['country_id'] ?? null;

        foreach($countryIds as $countryId){
            $this->country->deleteCountry($countryId);
        }

        $this->systemHelper->sendSuccessResponse(
            'Delete Multiple Countries Success',
            'The selected countries have been deleted successfully.'
        );
    }

    public function fetchCountryDetails(){
        $countryId          = $_POST['country_id'] ?? null;
        $checkCountryExist  = $this->country->checkCountryExist($countryId);
        $total              = $checkCountryExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper->sendErrorResponse(
                'Get Country Details',
                'The country does not exist'
            );
        }

        $countryDetails   = $this->country->fetchCountry($countryId);

        $response = [
            'success'       => true,
            'countryName'   => $countryDetails['country_name'] ?? null,
            'countryCode'   => $countryDetails['country_code'] ?? null,
            'phoneCode'     => $countryDetails['phone_code'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function generateCountryTable()
    {
        $pageLink   = $_POST['page_link'] ?? null;
        $response   = [];

        $countries = $this->country->generateCountryTable();

        foreach ($countries as $row) {
            $countryId      = $row['country_id'];
            $countryName    = $row['country_name'];
            $countryCode    = $row['country_code'];
            $phoneCode      = $row['phone_code'];

            $countryIdEncrypted = $this->security->encryptData($countryId);

            $response[] = [
                'CHECK_BOX'     => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                        <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $countryId .'">
                                    </div>',
                'COUNTRY_NAME'  => $countryName,
                'COUNTRY_CODE'  => $countryCode,
                'PHONE_CODE'    => $phoneCode,
                'LINK'          => $pageLink .'&id='. $countryIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateCountryOptions()
    {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $countries = $this->country->generateCountryOptions();

        foreach ($countries as $row) {
            $response[] = [
                'id'    => $row['country_id'],
                'text'  => $row['country_name']
            ];
        }

        echo json_encode($response);
    }
}

# Bootstrap the controller
$controller = new CountryController(
    new Country(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();
