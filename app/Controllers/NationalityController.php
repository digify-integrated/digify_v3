<?php
namespace App\Controllers;

session_start();

use App\Models\Nationality;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class NationalityController {
    protected Nationality $nationality;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        Nationality $nationality,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->nationality      = $nationality;
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
            'save nationality'              => $this->saveNationality($lastLogBy),
            'delete nationality'            => $this->deleteNationality(),
            'delete multiple nationality'   => $this->deleteMultipleNationality(),
            'fetch nationality details'     => $this->fetchNationalityDetails(),
            'generate nationality table'    => $this->generateNationalityTable(),
            'generate nationality options'  => $this->generateNationalityOptions(),
            default                         => $this->systemHelper::sendErrorResponse(
                                                    'Transaction Failed',
                                                    'We encountered an issue while processing your request.'
                                                )
        };
    }

    /* =============================================================================================
        SECTION 1: SAVE METHOD
    ============================================================================================= */

    public function saveNationality(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'nationality_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $nationalityId      = $_POST['nationality_id'] ?? null;
        $nationalityName    = $_POST['nationality_name'] ?? null;

        $nationalityId = $this->nationality->saveNationality(
            $nationalityId,
            $nationalityName,
            $lastLogBy
        );
        
        $encryptedNationalityId = $this->security->encryptData($nationalityId);

        $this->systemHelper::sendSuccessResponse(
            'Save Nationality Success',
            'The nationality has been saved successfully.',
            ['nationality_id' => $encryptedNationalityId]
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

    public function fetchNationalityDetails() {
        $nationalityId          = $_POST['nationality_id'] ?? null;
        $checkNationalityExist  = $this->nationality->checkNationalityExist($nationalityId);
        $total                  = $checkNationalityExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get Nationality Details',
                'The nationality does not exist',
                ['notExist' => true]
            );
        }

        $nationalityDetails = $this->nationality->fetchNationality($nationalityId);

        $response = [
            'success'           => true,
            'nationalityName'   => $nationalityDetails['nationality_name'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    /* =============================================================================================
        SECTION 5: DELETE METHOD
    ============================================================================================= */

    public function deleteNationality() {
        $nationalityId = $_POST['nationality_id'] ?? null;

        $this->nationality->deleteNationality($nationalityId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Nationality Success',
            'The nationality has been deleted successfully.'
        );
    }

    public function deleteMultipleNationality() {
        $nationalityIds = $_POST['nationality_id'] ?? null;

        foreach($nationalityIds as $nationalityId){
            $this->nationality->deleteNationality($nationalityId);
        }

        $this->systemHelper::sendSuccessResponse(
            'Delete Multiple Nationalities Success',
            'The selected Nationalities have been deleted successfully.'
        );
    }

    /* =============================================================================================
        SECTION 6: CHECK METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 7: GENERATE METHOD
    ============================================================================================= */

    public function generateNationalityTable() {
        $pageLink   = $_POST['page_link'] ?? null;
        $response   = [];

        $nationalities = $this->nationality->generateNationalityTable();

        foreach ($nationalities as $row) {
            $nationalityId      = $row['nationality_id'];
            $nationalityName    = $row['nationality_name'];

            $nationalityIdEncrypted = $this->security->encryptData($nationalityId);

            $response[] = [
                'CHECK_BOX'         => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                            <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $nationalityId .'">
                                        </div>',
                'NATIONALITY_NAME'  => $nationalityName,
                'LINK'              => $pageLink .'&id='. $nationalityIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateNationalityOptions() {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $nationalities = $this->nationality->generateNationalityOptions();

        foreach ($nationalities as $row) {
            $response[] = [
                'id'    => $row['nationality_id'],
                'text'  => $row['nationality_name']
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

$controller = new NationalityController(
    new Nationality(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();