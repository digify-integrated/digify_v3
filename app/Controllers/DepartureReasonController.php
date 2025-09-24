<?php
namespace App\Controllers;


session_start();

use App\Models\DepartureReason;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class DepartureReasonController
{
    protected DepartureReason $departureReason;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        DepartureReason $departureReason,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->departureReason  = $departureReason;
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
            'save departure reason'                 => $this->saveDepartureReason($lastLogBy),
            'delete departure reason'               => $this->deleteDepartureReason(),
            'delete multiple departure reason'      => $this->deleteMultipleDepartureReason(),
            'fetch departure reason details'        => $this->fetchDepartureReasonDetails(),
            'generate departure reason table'       => $this->generateDepartureReasonTable(),
            'generate departure reason options'     => $this->generateDepartureReasonOptions(),
            default                                 => $this->systemHelper::sendErrorResponse(
                                                            'Transaction Failed',
                                                            'We encountered an issue while processing your request.'
                                                        )
        };
    }

    public function saveDepartureReason($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'departure_reason_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $departureReasonId      = $_POST['departure_reason_id'] ?? null;
        $departureReasonName    = $_POST['departure_reason_name'] ?? null;

        $departureReasonId              = $this->departureReason->saveDepartureReason($departureReasonId, $departureReasonName, $lastLogBy);
        $encryptedDepartureReasonId     = $this->security->encryptData($departureReasonId);

        $this->systemHelper->sendSuccessResponse(
            'Save Departure Reason Success',
            'The departure reason has been saved successfully.',
            ['departure_reason_id' => $encryptedDepartureReasonId]
        );
    }

    public function deleteDepartureReason(){
        $departureReasonId = $_POST['departure_reason_id'] ?? null;

        $this->departureReason->deleteDepartureReason($departureReasonId);

        $this->systemHelper->sendSuccessResponse(
            'Delete Departure Reason Success',
            'The departure reason has been deleted successfully.'
        );
    }

    public function deleteMultipleDepartureReason(){
        $departureReasonIds = $_POST['departure_reason_id'] ?? null;

        foreach($departureReasonIds as $departureReasonId){
            $this->departureReason->deleteDepartureReason($departureReasonId);
        }

        $this->systemHelper->sendSuccessResponse(
            'Delete Multiple Departure Reasons Success',
            'The selected departure reasons have been deleted successfully.'
        );
    }

    public function fetchDepartureReasonDetails(){
        $departureReasonId          = $_POST['departure_reason_id'] ?? null;
        $checkDepartureReasonExist  = $this->departureReason->checkDepartureReasonExist($departureReasonId);
        $total                      = $checkDepartureReasonExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper->sendErrorResponse(
                'Get Departure Reason Details',
                'The departure reason does not exist',
                ['notExist' => true]
            );
        }

        $departureReasonDetails = $this->departureReason->fetchDepartureReason($departureReasonId);

        $response = [
            'success'               => true,
            'departureReasonName'   => $departureReasonDetails['departure_reason_name'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function generateDepartureReasonTable()
    {
        $pageLink   = $_POST['page_link'] ?? null;
        $response   = [];

        $departureReasons = $this->departureReason->generateDepartureReasonTable();

        foreach ($departureReasons as $row) {
            $departureReasonId      = $row['departure_reason_id'];
            $departureReasonName    = $row['departure_reason_name'];

            $departureReasonIdEncrypted = $this->security->encryptData($departureReasonId);

            $response[] = [
                'CHECK_BOX'                 => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                                    <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $departureReasonId .'">
                                                </div>',
                'DEPARTURE_REASON_NAME'     => $departureReasonName,
                'LINK'                      => $pageLink .'&id='. $departureReasonIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateDepartureReasonOptions()
    {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $departureReasons = $this->departureReason->generateDepartureReasonOptions();

        foreach ($departureReasons as $row) {
            $response[] = [
                'id'    => $row['departure_reason_id'],
                'text'  => $row['departure_reason_name']
            ];
        }

        echo json_encode($response);
    }
}

# Bootstrap the controller
$controller = new DepartureReasonController(
    new DepartureReason(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();
