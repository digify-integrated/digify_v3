<?php
namespace App\Controllers;

session_start();

use App\Models\WorkLocation;
use App\Models\City;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class WorkLocationController {
    protected WorkLocation $workLocation;
    protected City $city;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        WorkLocation $workLocation,
        City $city,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->workLocation     = $workLocation;
        $this->city             = $city;
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
            'save work location'                => $this->saveWorkLocation($lastLogBy),
            'delete work location'              => $this->deleteWorkLocation(),
            'delete multiple work location'     => $this->deleteMultipleWorkLocation(),
            'fetch work location details'       => $this->fetchWorkLocationDetails(),
            'generate work location table'      => $this->generateWorkLocationTable(),
            'generate work location options'    => $this->generateWorkLocationOptions(),
            default                             => $this->systemHelper::sendErrorResponse(
                                                        'Transaction Failed',
                                                        'We encountered an issue while processing your request.'
                                                    )
        };
    }

    /* =============================================================================================
        SECTION 1: SAVE METHOD
    ============================================================================================= */

    public function saveWorkLocation(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'work_location_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $workLocationId     = $_POST['work_location_id'] ?? null;
        $workLocationName   = $_POST['work_location_name'] ?? null;
        $address            = $_POST['address'] ?? null;
        $cityId             = $_POST['city_id'] ?? null;
        $phone              = $_POST['phone'] ?? null;
        $telephone          = $_POST['telephone'] ?? null;
        $email              = $_POST['email'] ?? null;

        $cityDetails    = $this->city->fetchCity($cityId);
        $cityName       = $cityDetails['city_name'] ?? null;
        $stateId        = $cityDetails['state_id'] ?? null;
        $stateName      = $cityDetails['state_name'] ?? null;
        $countryId      = $cityDetails['country_id'] ?? null;
        $countryName    = $cityDetails['country_name'] ?? null;

        $workLocationId = $this->workLocation->saveWorkLocation(
            $workLocationId,
            $workLocationName,
            $address,
            $cityId,
            $cityName,
            $stateId,
            $stateName,
            $countryId,
            $countryName,
            $phone,
            $telephone,
            $email,
            $lastLogBy
        );
        
        $encryptedWorkLocationId = $this->security->encryptData($workLocationId);

        $this->systemHelper::sendSuccessResponse(
            'Save Work Location Success',
            'The work location has been saved successfully.',
            ['work_location_id' => $encryptedWorkLocationId]
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

    public function fetchWorkLocationDetails() {
        $workLocationId             = $_POST['work_location_id'] ?? null;
        $checkWorkLocationExist     = $this->workLocation->checkWorkLocationExist($workLocationId);
        $total                      = $checkWorkLocationExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get Work Location Details',
                'The work location does not exist',
                ['notExist' => true]
            );
        }

        $workLocationDetails = $this->workLocation->fetchWorkLocation($workLocationId);

        $response = [
            'success'           => true,
            'workLocationName'  => $workLocationDetails['work_location_name'] ?? null,
            'address'           => $workLocationDetails['address'] ?? null,
            'cityID'            => $workLocationDetails['city_id'] ?? null,
            'phone'             => $workLocationDetails['phone'] ?? null,
            'telephone'         => $workLocationDetails['telephone'] ?? null,
            'email'             => $workLocationDetails['email'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    /* =============================================================================================
        SECTION 5: DELETE METHOD
    ============================================================================================= */

    public function deleteWorkLocation() {
        $workLocationId = $_POST['work_location_id'] ?? null;

        $this->workLocation->deleteWorkLocation($workLocationId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Work Location Success',
            'The work location has been deleted successfully.'
        );
    }

    public function deleteMultipleWorkLocation() {
        $workLocationIds = $_POST['work_location_id'] ?? null;

        foreach($workLocationIds as $workLocationId){
            $this->workLocation->deleteWorkLocation($workLocationId);
        }

        $this->systemHelper::sendSuccessResponse(
            'Delete Multiple Work Locations Success',
            'The selected work locations have been deleted successfully.'
        );
    }

    /* =============================================================================================
        SECTION 6: CHECK METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 7: GENERATE METHOD
    ============================================================================================= */

    public function generateWorkLocationTable() {
        $cityFilter     = $this->systemHelper->checkFilter($_POST['city_filter'] ?? null);
        $stateFilter    = $this->systemHelper->checkFilter($_POST['state_filter'] ?? null);
        $countryFilter  = $this->systemHelper->checkFilter($_POST['country_filter'] ?? null);
        $pageLink       = $_POST['page_link'] ?? null;
        $response       = [];

        $workLocations = $this->workLocation->generateWorkLocationTable(
            $cityFilter,
            $stateFilter,
            $countryFilter
        );

        foreach ($workLocations as $row) {
            $workLocationId     = $row['work_location_id'];
            $workLocationName   = $row['work_location_name'];
            $address            = $row['address'];
            $cityName           = $row['city_name'];
            $stateName          = $row['state_name'];
            $countryName        = $row['country_name'];

            $parts          = [$address, $cityName, $stateName, $countryName];
            $fullAddress    = implode(', ', array_filter($parts));

            $workLocationIdEncrypted = $this->security->encryptData($workLocationId);

            $response[] = [
                'CHECK_BOX'             => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                                <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $workLocationId .'">
                                            </div>',
                'WORK_LOCATION_NAME'    => '<div class="d-flex flex-column">
                                                <span class="text-gray-800 fw-bold mb-1">'. $workLocationName .'</span>
                                                <small class="text-gray-600">'. $fullAddress .'</small>
                                            </div>',
                'LINK'                  => $pageLink .'&id='. $workLocationIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateWorkLocationOptions() {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $workLocations = $this->workLocation->generateWorkLocationOptions();

        foreach ($workLocations as $row) {
            $response[] = [
                'id'    => $row['work_location_id'],
                'text'  => $row['work_location_name']
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

$controller = new WorkLocationController(
    new WorkLocation(),
    new City(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();