<?php
namespace App\Controllers;

session_start();

use App\Models\State;
use App\Models\Country;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class StateController {
    protected State $state;
    protected Country $country;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        State $state,
        Country $country,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->state            = $state;
        $this->country          = $country;
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
            'save state'                => $this->saveState($lastLogBy),
            'delete state'              => $this->deleteState(),
            'delete multiple state'     => $this->deleteMultipleState(),
            'fetch state details'       => $this->fetchStateDetails(),
            'generate state table'      => $this->generateStateTable(),
            'generate state options'    => $this->generateStateOptions(),
            default                     => $this->systemHelper::sendErrorResponse(
                                                'Transaction Failed',
                                                'We encountered an issue while processing your request.'
                                            )
        };
    }

    /* =============================================================================================
        SECTION 1: SAVE METHOD
    ============================================================================================= */

    public function saveState(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'state_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $stateId    = $_POST['state_id'] ?? null;
        $stateName  = $_POST['state_name'] ?? null;
        $countryId  = $_POST['country_id'] ?? null;

        $countryDetails     = $this->country->fetchCountry($countryId);
        $countryName        = $countryDetails['country_name'] ?? '';

        $stateId = $this->state->saveState(
            $stateId,
            $stateName,
            $countryId,
            $countryName,
            $lastLogBy
        );
        
        $encryptedstateId = $this->security->encryptData($stateId);

        $this->systemHelper::sendSuccessResponse(
            'Save State Success',
            'The state has been saved successfully.',
            ['state_id' => $encryptedstateId]
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

    public function fetchStateDetails() {
        $stateId            = $_POST['state_id'] ?? null;
        $checkStateExist    = $this->state->checkStateExist($stateId);
        $total              = $checkStateExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get State Details',
                'The state does not exist',
                ['notExist' => true]
            );
        }

        $stateDetails   = $this->state->fetchState($stateId);

        $response = [
            'success'       => true,
            'stateName'     => $stateDetails['state_name'] ?? null,
            'countryID'     => $stateDetails['country_id'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    /* =============================================================================================
        SECTION 5: DELETE METHOD
    ============================================================================================= */

    public function deleteState() {
        $stateId = $_POST['state_id'] ?? null;

        $this->state->deleteState($stateId);

        $this->systemHelper::sendSuccessResponse(
            'Delete State Success',
            'The state has been deleted successfully.'
        );
    }

    public function deleteMultipleState() {
        $stateIds  = $_POST['state_id'] ?? null;

        foreach($stateIds as $stateId){
            $this->state->deleteState($stateId);
        }

        $this->systemHelper::sendSuccessResponse(
            'Delete Multiple States Success',
            'The selected states have been deleted successfully.'
        );
    }

    /* =============================================================================================
        SECTION 6: CHECK METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 7: GENERATE METHOD
    ============================================================================================= */

    public function generateStateTable() {
        $pageLink       = $_POST['page_link'] ?? null;
        $countryFilter  = $this->systemHelper->checkFilter($_POST['country_filter'] ?? null);
        $response       = [];

        $states = $this->state->generateStateTable($countryFilter);

        foreach ($states as $row) {
            $stateId        = $row['state_id'];
            $stateName      = $row['state_name'];
            $countryName    = $row['country_name'];

            $stateIdEncrypted = $this->security->encryptData($stateId);

            $response[] = [
                'CHECK_BOX'     => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                        <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $stateId .'">
                                    </div>',
                'STATE_NAME'    => $stateName,
                'COUNTRY_NAME'  => $countryName,
                'LINK'          => $pageLink .'&id='. $stateIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateStateOptions() {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $states = $this->state->generateStateOptions();

        foreach ($states as $row) {
            $response[] = [
                'id'    => $row['state_id'],
                'text'  => $row['state_name']
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

$controller = new StateController(
    new State(),
    new Country(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();