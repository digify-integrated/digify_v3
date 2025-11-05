<?php
namespace App\Controllers;


session_start();

use App\Models\Religion;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class ReligionController
{
    protected Religion $religion;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        Religion $religion,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->religion         = $religion;
        $this->authentication   = $authentication;
        $this->security         = $security;
        $this->systemHelper     = $systemHelper;
    }

    public function handleRequest() 
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
            'save religion'                 => $this->saveReligion($lastLogBy),
            'delete religion'               => $this->deleteReligion(),
            'delete multiple religion'      => $this->deleteMultipleReligion(),
            'fetch religion details'        => $this->fetchReligionDetails(),
            'generate religion table'       => $this->generateReligionTable(),
            'generate religion options'     => $this->generateReligionOptions(),
            default                         => $this->systemHelper::sendErrorResponse(
                                                    'Transaction Failed',
                                                    'We encountered an issue while processing your request.'
                                                )
        };
    }

    public function saveReligion($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'religion_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $religionId     = $_POST['religion_id'] ?? null;
        $religionName   = $_POST['religion_name'] ?? null;

        $religionId             = $this->religion->saveReligion($religionId, $religionName, $lastLogBy);
        $encryptedReligionId    = $this->security->encryptData($religionId);

        $this->systemHelper->sendSuccessResponse(
            'Save Religion Success',
            'The religion has been saved successfully.',
            ['religion_id' => $encryptedReligionId]
        );
    }

    public function deleteReligion(){
        $religionId = $_POST['religion_id'] ?? null;

        $this->religion->deleteReligion($religionId);

        $this->systemHelper->sendSuccessResponse(
            'Delete Religion Success',
            'The religion has been deleted successfully.'
        );
    }

    public function deleteMultipleReligion(){
        $religionIds  = $_POST['religion_id'] ?? null;

        foreach($religionIds as $religionId){
            $this->religion->deleteReligion($religionId);
        }

        $this->systemHelper->sendSuccessResponse(
            'Delete Multiple Religions Success',
            'The selected religions have been deleted successfully.'
        );
    }

    public function fetchReligionDetails(){
        $religionId             = $_POST['religion_id'] ?? null;
        $checkReligionyExist    = $this->religion->checkReligionExist($religionId);
        $total                  = $checkReligionyExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper->sendErrorResponse(
                'Get Religion Details',
                'The religion does not exist',
                ['notExist' => true]
            );
        }

        $religionDetails = $this->religion->fetchReligion($religionId);

        $response = [
            'success'       => true,
            'religionName'  => $religionDetails['religion_name'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function generateReligionTable()
    {
        $pageLink   = $_POST['page_link'] ?? null;
        $response   = [];

        $religions = $this->religion->generateReligionTable();

        foreach ($religions as $row) {
            $religionId     = $row['religion_id'];
            $religionName   = $row['religion_name'];

            $religionIdEncrypted = $this->security->encryptData($religionId);

            $response[] = [
                'CHECK_BOX'         => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                            <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $religionId .'">
                                        </div>',
                'RELIGION_NAME'     => $religionName,
                'LINK'              => $pageLink .'&id='. $religionIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateReligionOptions()
    {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $religions = $this->religion->generateReligionOptions();

        foreach ($religions as $row) {
            $response[] = [
                'id'    => $row['religion_id'],
                'text'  => $row['religion_name']
            ];
        }

        echo json_encode($response);
    }
}

# Bootstrap the controller
$controller = new ReligionController(
    new Religion(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();
