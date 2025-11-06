<?php
namespace App\Controllers;

session_start();

use App\Models\City;
use App\Models\State;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class CityController {
    protected City $city;
    protected State $state;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        City $city,
        State $state,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->city             = $city;
        $this->state            = $state;
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
            'save city'                     => $this->saveCity($lastLogBy),
            'delete city'                   => $this->deleteCity(),
            'delete multiple city'          => $this->deleteMultipleCity(),
            'fetch city details'            => $this->fetchCityDetails(),
            'generate city table'           => $this->generateCityTable(),
            'generate city options'         => $this->generateCityOptions(false),
            'generate filter city options'  => $this->generateCityOptions(true),
            default                         => $this->systemHelper::sendErrorResponse(
                                                    'Transaction Failed',
                                                    'We encountered an issue while processing your request.'
                                                )
        };
    }

    /* =============================================================================================
        SECTION 1: SAVE METHOD
    ============================================================================================= */

    public function saveCity(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'city_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $cityId     = $_POST['city_id'] ?? null;
        $cityName   = $_POST['city_name'] ?? null;
        $stateId    = $_POST['state_id'] ?? null;

        $stateDetails   = $this->state->fetchState($stateId);
        $stateName      = $stateDetails['state_name'] ?? '';
        $countryId      = $stateDetails['country_id'] ?? '';
        $countryName    = $stateDetails['country_name'] ?? '';

        $cityId = $this->city->saveCity(
            $cityId,
            $cityName,
            $stateId,
            $stateName,
            $countryId,
            $countryName,
            $lastLogBy
        );
        
        $encryptedCityId = $this->security->encryptData($cityId);

        $this->systemHelper::sendSuccessResponse(
            'Save City Success',
            'The city has been saved successfully.',
            ['city_id' => $encryptedCityId]
        );
    }

    /* =============================================================================================
        SECTION 2: INSERT METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 3: UPDATE METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 4: FETCH METHOD
    ============================================================================================= */

    public function fetchCityDetails() {
        $cityId             = $_POST['city_id'] ?? null;
        $checkCityExist     = $this->city->checkCityExist($cityId);
        $total              = $checkCityExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get City Details',
                'The city does not exist',
                ['notExist' => true]
            );
        }

        $cityDetails = $this->city->fetchCity($cityId);

        $response = [
            'success'   => true,
            'cityName'  => $cityDetails['city_name'] ?? null,
            'stateID'   => $cityDetails['state_id'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    /* =============================================================================================
        SECTION 5: DELETE METHOD
    ============================================================================================= */

    public function deleteCity() {
        $cityId = $_POST['city_id'] ?? null;

        $this->city->deleteCity($cityId);

        $this->systemHelper::sendSuccessResponse(
            'Delete City Success',
            'The city has been deleted successfully.'
        );
    }

    public function deleteMultipleCity() {
        $cityIds = $_POST['city_id'] ?? null;

        foreach($cityIds as $cityId){
            $this->city->deleteCity($cityId);
        }

        $this->systemHelper::sendSuccessResponse(
            'Delete Multiple Cities Success',
            'The selected cities have been deleted successfully.'
        );
    }

    /* =============================================================================================
        SECTION 6: CHECK METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 7: GENERATE METHOD
    ============================================================================================= */

    public function generateCityTable() {
        $pageLink       = $_POST['page_link'] ?? null;
        $stateFilter    = $this->systemHelper->checkFilter($_POST['state_filter'] ?? null);
        $countryFilter  = $this->systemHelper->checkFilter($_POST['country_filter'] ?? null);
        $response       = [];

        $citys = $this->city->generateCityTable(
            $stateFilter,
            $countryFilter
        );

        foreach ($citys as $row) {
            $cityId         = $row['city_id'];
            $cityName       = $row['city_name'];
            $stateName      = $row['state_name'];
            $countryName    = $row['country_name'];

            $cityIdEncrypted = $this->security->encryptData($cityId);

            $response[] = [
                'CHECK_BOX'     => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                        <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $cityId .'">
                                    </div>',
                'CITY_NAME'     => $cityName,
                'STATE_NAME'    => $stateName,
                'COUNTRY_NAME'  => $countryName,
                'LINK'          => $pageLink .'&id='. $cityIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateCityOptions(
        bool $isFilter = false
    ) {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $citys = $this->city->generateCityOptions();

        foreach ($citys as $row) {
            $text = !$isFilter ? "{$row['city_name']}, {$row['state_name']}, {$row['country_name']}" : $row['city_name'];

            $response[] = [
                'id'    => $row['city_id'],
                'text'  => $text
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

$controller = new CityController(
    new City(),
    new State(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();