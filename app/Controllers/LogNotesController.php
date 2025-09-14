<?php
namespace App\Controllers;

session_start();

use App\Models\LogNotes;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class LogNotesController
{
    protected LogNotes $logNotes;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        LogNotes $logNotes,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->logNotes         = $logNotes;
        $this->authentication         = $authentication;
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
            'fetch log notes'    => $this->fetchLogNotes(),
            default              => $this->systemHelper::sendErrorResponse(
                                    'Transaction Failed',
                                    'We encountered an issue while processing your request.'
                                        )
        };
    }
    public function fetchLogNotes()
    {
        $databaseTable  = $_POST['database_table'] ?? null;
        $referenceID    = $_POST['reference_id'] ?? null;
        $logNote        = '';

        $logNotesList   = $this->logNotes->fetchLogNotes($databaseTable, $referenceID);
        $count          = count($logNotesList);

        foreach ($logNotesList as $index => $row) {
            $log            = $row['log'];
            $changedBy      = $row['changed_by'];
            $timeElapsed    = $this->systemHelper->timeElapsedString($row['changed_at']);
                
            $userDetails        = $this->authentication->fetchLoginCredentials($changedBy);
            $fileAs             = $userDetails['file_as'] ?? '';
            $profilePicture     = $this->systemHelper->checkImageExist($userDetails['profile_picture'] ?? null, 'profile');
                
            $marginClass = ($index === $count - 1) ? 'mb-0' : 'mb-9';

            $logNote .= '<div class="timeline-item">
                                    <div class="timeline-line"></div>
                                        <div class="timeline-icon">
                                            <i class="ki-outline ki-message-text-2 fs-2 text-gray-500"></i>
                                        </div>
                                        <div class="timeline-content '. $marginClass .' mt-n1">
                                            <div class="pe-3 mb-5">
                                                <div class="fs-6 fw-semibold mb-2">
                                                    '. $log .'
                                                 </div>
                                                <div class="d-flex align-items-center mt-1 fs-6">
                                                    <div class="text-muted me-2 fs-7">
                                                        Logged: '. $timeElapsed .' by
                                                    </div>
                                                    <div class="symbol symbol-circle symbol-25px me-2">
                                                        <img src="'. $profilePicture .'" alt="img" />
                                                    </div>
                                                    <span class="text-primary fw-bold me-1 fs-7">'. $fileAs .'</span>
                                                 </div>
                                            </div>
                                        </div>
                                    </div>';
        }

        if(empty($logNote)){
                    $logNote = '<div class="mb-0">
                                    <div class="card card-bordered w-100">   
                                        <div class="card-body">    
                                            <p class="fw-normal fs-6 text-gray-700 m-0">
                                                No log notes found.
                                            </p>   
                                        </div>
                                    </div>
                                </div>';
        }


        
        $response = [
            'success'       => true,
            'log_notes'     => $logNote
        ];

        echo json_encode($response);
    }
}

# Bootstrap the controller
$controller = new LogNotesController(
    new LogNotes(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();
