<?php
namespace App\Controllers;


session_start();

use App\Models\EducationalStage;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class EducationalStageController
{
    protected EducationalStage $educationalStage;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        EducationalStage $educationalStage,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->educationalStage     = $educationalStage;
        $this->authentication       = $authentication;
        $this->security             = $security;
        $this->systemHelper         = $systemHelper;
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
            'save educational stage'                => $this->saveEducationalStage($lastLogBy),
            'delete educational stage'              => $this->deleteEducationalStage(),
            'delete multiple educational stage'     => $this->deleteMultipleEducationalStage(),
            'fetch educational stage details'       => $this->fetchEducationalStageDetails(),
            'generate educational stage table'      => $this->generateEducationalStageTable(),
            'generate educational stage options'    => $this->generateEducationalStageOptions(),
            default                                 => $this->systemHelper::sendErrorResponse(
                                                            'Transaction Failed',
                                                            'We encountered an issue while processing your request.'
                                                        )
        };
    }

    public function saveEducationalStage($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'educational_stage_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $educationalStageId     = $_POST['educational_stage_id'] ?? null;
        $educationalStageName   = $_POST['educational_stage_name'] ?? null;

        $educationalStageId             = $this->educationalStage->saveEducationalStage($educationalStageId, $educationalStageName, $lastLogBy);
        $encryptedEducationalStageId    = $this->security->encryptData($educationalStageId);

        $this->systemHelper->sendSuccessResponse(
            'Save Educational Stage Success',
            'The educational stage has been saved successfully.',
            ['educational_stage_id' => $encryptedEducationalStageId]
        );
    }

    public function deleteEducationalStage(){
        $educationalStageId = $_POST['educational_stage_id'] ?? null;

        $this->educationalStage->deleteEducationalStage($educationalStageId);

        $this->systemHelper->sendSuccessResponse(
            'Delete Educational Stage Success',
            'The educational stage has been deleted successfully.'
        );
    }

    public function deleteMultipleEducationalStage(){
        $educationalStageIds = $_POST['educational_stage_id'] ?? null;

        foreach($educationalStageIds as $educationalStageId){
            $this->educationalStage->deleteEducationalStage($educationalStageId);
        }

        $this->systemHelper->sendSuccessResponse(
            'Delete Multiple Educational Stages Success',
            'The selected educational stages have been deleted successfully.'
        );
    }

    public function fetchEducationalStageDetails(){
        $educationalStageId             = $_POST['educational_stage_id'] ?? null;
        $checkEducationalStageExist     = $this->educationalStage->checkEducationalStageExist($educationalStageId);
        $total                          = $checkEducationalStageExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper->sendErrorResponse(
                'Get Educational Stage Details',
                'The educational stage does not exist',
                ['notExist' => true]
            );
        }

        $educationalStageDetails = $this->educationalStage->fetchEducationalStage($educationalStageId);

        $response = [
            'success'               => true,
            'educationalStageName'  => $educationalStageDetails['educational_stage_name'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function generateEducationalStageTable()
    {
        $pageLink   = $_POST['page_link'] ?? null;
        $response   = [];

        $educationalStages = $this->educationalStage->generateEducationalStageTable();

        foreach ($educationalStages as $row) {
            $educationalStageId     = $row['educational_stage_id'];
            $educationalStageName   = $row['educational_stage_name'];

            $educationalStageIdEncrypted = $this->security->encryptData($educationalStageId);

            $response[] = [
                'CHECK_BOX'                 => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                                    <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $educationalStageId .'">
                                                </div>',
                'EDUCATIONAL_STAGE_NAME'    => $educationalStageName,
                'LINK'                      => $pageLink .'&id='. $educationalStageIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateEducationalStageOptions()
    {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $educationalStages = $this->educationalStage->generateEducationalStageOptions();

        foreach ($educationalStages as $row) {
            $response[] = [
                'id'    => $row['educational_stage_id'],
                'text'  => $row['educational_stage_name']
            ];
        }

        echo json_encode($response);
    }
}

# Bootstrap the controller
$controller = new EducationalStageController(
    new EducationalStage(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();
