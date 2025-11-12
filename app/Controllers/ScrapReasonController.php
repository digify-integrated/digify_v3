<?php
namespace App\Controllers;

session_start();

use App\Models\ScrapReason;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class ScrapReasonController {
    protected ScrapReason $scrapReason;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        ScrapReason $scrapReason,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->scrapReason      = $scrapReason;
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
            'save scrap reason'                 => $this->saveScrapReason($lastLogBy),
            'delete scrap reason'               => $this->deleteScrapReason(),
            'delete multiple scrap reason'      => $this->deleteMultipleScrapReason(),
            'fetch scrap reason details'        => $this->fetchScrapReasonDetails(),
            'generate scrap reason table'       => $this->generateScrapReasonTable(),
            'generate scrap reason options'     => $this->generateScrapReasonOptions(),
            default                             => $this->systemHelper::sendErrorResponse(
                                                        'Transaction Failed',
                                                        'We encountered an issue while processing your request.'
                                                    )
        };
    }

    /* =============================================================================================
        SECTION 1: SAVE METHOD
    ============================================================================================= */

    public function saveScrapReason(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'scrap_reason_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $scrapReasonId      = $_POST['scrap_reason_id'] ?? null;
        $scrapReasonName    = $_POST['scrap_reason_name'] ?? null;

        $scrapReasonId = $this->scrapReason->saveScrapReason(
            $scrapReasonId,
            $scrapReasonName,
            $lastLogBy
        );
        
        $encryptedScrapReasonId = $this->security->encryptData($scrapReasonId);

        $this->systemHelper::sendSuccessResponse(
            'Save Scrap Reason Success',
            'The scrap reason has been saved successfully.',
            ['scrap_reason_id' => $encryptedScrapReasonId]
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

    public function fetchScrapReasonDetails() {
        $scrapReasonId          = $_POST['scrap_reason_id'] ?? null;
        $checkScrapReasonExist  = $this->scrapReason->checkScrapReasonExist($scrapReasonId);
        $total                  = $checkScrapReasonExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get Scrap Reason Details',
                'The scrap reason does not exist',
                ['notExist' => true]
            );
        }

        $scrapReasonDetails = $this->scrapReason->fetchScrapReason($scrapReasonId);

        $response = [
            'success'           => true,
            'scrapReasonName'   => $scrapReasonDetails['scrap_reason_name'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    /* =============================================================================================
        SECTION 5: DELETE METHOD
    ============================================================================================= */

    public function deleteScrapReason() {
        $scrapReasonId = $_POST['scrap_reason_id'] ?? null;

        $this->scrapReason->deleteScrapReason($scrapReasonId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Scrap Reason Success',
            'The scrap reason has been deleted successfully.'
        );
    }

    public function deleteMultipleScrapReason() {
        $scrapReasonIds = $_POST['scrap_reason_id'] ?? null;

        foreach($scrapReasonIds as $scrapReasonId){
            $this->scrapReason->deleteScrapReason($scrapReasonId);
        }

        $this->systemHelper::sendSuccessResponse(
            'Delete Multiple Scrap Reasons Success',
            'The selected scrap reasons have been deleted successfully.'
        );
    }

    /* =============================================================================================
        SECTION 6: CHECK METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 7: GENERATE METHOD
    ============================================================================================= */

    public function generateScrapReasonTable() {
        $pageLink   = $_POST['page_link'] ?? null;
        $response   = [];

        $scrapReasons = $this->scrapReason->generateScrapReasonTable();

        foreach ($scrapReasons as $row) {
            $scrapReasonId      = $row['scrap_reason_id'];
            $scrapReasonName    = $row['scrap_reason_name'];

            $scrapReasonIdEncrypted = $this->security->encryptData($scrapReasonId);

            $response[] = [
                'CHECK_BOX'             => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                                <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $scrapReasonId .'">
                                            </div>',
                'SCRAP_REASON_NAME'     => $scrapReasonName,
                'LINK'                  => $pageLink .'&id='. $scrapReasonIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateScrapReasonOptions() {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $scrapReasons = $this->scrapReason->generateScrapReasonOptions();

        foreach ($scrapReasons as $row) {
            $response[] = [
                'id'    => $row['scrap_reason_id'],
                'text'  => $row['scrap_reason_name']
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

$controller = new ScrapReasonController(
    new ScrapReason(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();