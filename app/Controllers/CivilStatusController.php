<?php
namespace App\Controllers;


session_start();

use App\Models\CivilStatus;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class CivilStatusController
{
    protected CivilStatus $civilStatus;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        CivilStatus $civilStatus,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->civilStatus      = $civilStatus;
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
            'save civil status'                 => $this->saveCivilStatus($lastLogBy),
            'delete civil status'               => $this->deleteCivilStatus(),
            'delete multiple civil status'      => $this->deleteMultipleCivilStatus(),
            'fetch civil status details'        => $this->fetchCivilStatusDetails(),
            'generate civil status table'       => $this->generateCivilStatusTable(),
            'generate civil status options'     => $this->generateCivilStatusOptions(),
            default                             => $this->systemHelper::sendErrorResponse(
                                                        'Transaction Failed',
                                                        'We encountered an issue while processing your request.'
                                                    )
        };
    }

    public function saveCivilStatus($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'civil_status_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $civilStatusId      = $_POST['civil_status_id'] ?? null;
        $civilStatusName    = $_POST['civil_status_name'] ?? null;

        $civilStatusId              = $this->civilStatus->saveCivilStatus($civilStatusId, $civilStatusName, $lastLogBy);
        $encryptedCivilStatusId     = $this->security->encryptData($civilStatusId);

        $this->systemHelper->sendSuccessResponse(
            'Save Civil Status Success',
            'The civil status has been saved successfully.',
            ['civil_status_id' => $encryptedCivilStatusId]
        );
    }

    public function deleteCivilStatus(){
        $civilStatusId = $_POST['civil_status_id'] ?? null;

        $this->civilStatus->deleteCivilStatus($civilStatusId);

        $this->systemHelper->sendSuccessResponse(
            'Delete Civil Status Success',
            'The civil status has been deleted successfully.'
        );
    }

    public function deleteMultipleCivilStatus(){
        $civilStatusIds = $_POST['civil_status_id'] ?? null;

        foreach($civilStatusIds as $civilStatusId){
            $this->civilStatus->deleteCivilStatus($civilStatusId);
        }

        $this->systemHelper->sendSuccessResponse(
            'Delete Multiple Civil Status Success',
            'The selected civil status have been deleted successfully.'
        );
    }

    public function fetchCivilStatusDetails(){
        $civilStatusId             = $_POST['civil_status_id'] ?? null;
        $checkCivilStatusExist     = $this->civilStatus->checkCivilStatusExist($civilStatusId);
        $total                     = $checkCivilStatusExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper->sendErrorResponse(
                'Get Civil Status Details',
                'The civil status does not exist',
                ['notExist' => true]
            );
        }

        $civilStatusDetails = $this->civilStatus->fetchCivilStatus($civilStatusId);

        $response = [
            'success'           => true,
            'civilStatusName'   => $civilStatusDetails['civil_status_name'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function generateCivilStatusTable()
    {
        $pageLink   = $_POST['page_link'] ?? null;
        $response   = [];

        $countries = $this->civilStatus->generateCivilStatusTable();

        foreach ($countries as $row) {
            $civilStatusId      = $row['civil_status_id'];
            $civilStatusName    = $row['civil_status_name'];

            $civilStatusIdEncrypted = $this->security->encryptData($civilStatusId);

            $response[] = [
                'CHECK_BOX'             => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                                <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $civilStatusId .'">
                                            </div>',
                'CIVIL_STATUS_NAME'     => $civilStatusName,
                'LINK'                  => $pageLink .'&id='. $civilStatusIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateCivilStatusOptions()
    {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $countries = $this->civilStatus->generateCivilStatusOptions();

        foreach ($countries as $row) {
            $response[] = [
                'id'    => $row['civil_status_id'],
                'text'  => $row['civil_status_name']
            ];
        }

        echo json_encode($response);
    }
}

# Bootstrap the controller
$controller = new CivilStatusController(
    new CivilStatus(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();
