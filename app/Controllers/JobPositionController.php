<?php
namespace App\Controllers;


session_start();

use App\Models\JobPosition;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class JobPositionController
{
    protected JobPosition $jobPosition;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        JobPosition $jobPosition,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->jobPosition      = $jobPosition;
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
            'save job position'                 => $this->saveJobPosition($lastLogBy),
            'delete job position'               => $this->deleteJobPosition(),
            'delete multiple job position'      => $this->deleteMultipleJobPosition(),
            'fetch job position details'        => $this->fetchJobPositionDetails(),
            'generate job position table'       => $this->generateJobPositionTable(),
            'generate job position options'     => $this->generateJobPositionOptions(),
            default                             => $this->systemHelper::sendErrorResponse(
                                                        'Transaction Failed',
                                                        'We encountered an issue while processing your request.'
                                                    )
        };
    }

    public function saveJobPosition($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'job_position_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $jobPositionId      = $_POST['job_position_id'] ?? null;
        $jobPositionName    = $_POST['job_position_name'] ?? null;

        $jobPositionId              = $this->jobPosition->saveJobPosition($jobPositionId, $jobPositionName, $lastLogBy);
        $encryptedJobPositionId     = $this->security->encryptData($jobPositionId);

        $this->systemHelper->sendSuccessResponse(
            'Save Job Position Success',
            'The job position has been saved successfully.',
            ['job_position_id' => $encryptedJobPositionId]
        );
    }

    public function deleteJobPosition(){
        $jobPositionId = $_POST['job_position_id'] ?? null;

        $this->jobPosition->deleteJobPosition($jobPositionId);

        $this->systemHelper->sendSuccessResponse(
            'Delete Job Position Success',
            'The job position has been deleted successfully.'
        );
    }

    public function deleteMultipleJobPosition(){
        $jobPositionIds = $_POST['job_position_id'] ?? null;

        foreach($jobPositionIds as $jobPositionId){
            $this->jobPosition->deleteJobPosition($jobPositionId);
        }

        $this->systemHelper->sendSuccessResponse(
            'Delete Multiple Job Positions Success',
            'The selected job positions have been deleted successfully.'
        );
    }

    public function fetchJobPositionDetails(){
        $jobPositionId          = $_POST['job_position_id'] ?? null;
        $checkJobPositionExist  = $this->jobPosition->checkJobPositionExist($jobPositionId);
        $total                  = $checkJobPositionExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper->sendErrorResponse(
                'Get Job Position Details',
                'The job position does not exist',
                ['notExist' => true]
            );
        }

        $jobPositionDetails = $this->jobPosition->fetchJobPosition($jobPositionId);

        $response = [
            'success'           => true,
            'jobPositionName'   => $jobPositionDetails['job_position_name'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function generateJobPositionTable()
    {
        $pageLink   = $_POST['page_link'] ?? null;
        $response   = [];

        $jobPositions = $this->jobPosition->generateJobPositionTable();

        foreach ($jobPositions as $row) {
            $jobPositionId      = $row['job_position_id'];
            $jobPositionName    = $row['job_position_name'];

            $jobPositionIdEncrypted = $this->security->encryptData($jobPositionId);

            $response[] = [
                'CHECK_BOX'             => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                                <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $jobPositionId .'">
                                            </div>',
                'JOB_POSITION_NAME'     => $jobPositionName,
                'LINK'                  => $pageLink .'&id='. $jobPositionIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateJobPositionOptions()
    {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $jobPositions = $this->jobPosition->generateJobPositionOptions();

        foreach ($jobPositions as $row) {
            $response[] = [
                'id'    => $row['job_position_id'],
                'text'  => $row['job_position_name']
            ];
        }

        echo json_encode($response);
    }
}

# Bootstrap the controller
$controller = new JobPositionController(
    new JobPosition(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();
