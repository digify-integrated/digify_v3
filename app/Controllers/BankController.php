<?php
namespace App\Controllers;

session_start();

use App\Models\Bank;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class BankController {
    protected Bank $bank;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        Bank $bank,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->bank             = $bank;
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
            'save bank'                 => $this->saveBank($lastLogBy),
            'delete bank'               => $this->deleteBank(),
            'delete multiple bank'      => $this->deleteMultipleBank(),
            'fetch bank details'        => $this->fetchBankDetails(),
            'generate bank table'       => $this->generateBankTable(),
            'generate bank options'     => $this->generateBankOptions(),
            default                     => $this->systemHelper::sendErrorResponse(
                                                'Transaction Failed',
                                                'We encountered an issue while processing your request.'
                                            )
        };
    }

    /* =============================================================================================
        SECTION 1: SAVE METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 2: INSERT METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 3: UPDATE METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 4: FETCH METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 5: DELETE METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 6: CHECK METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 7: GENERATE METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 8: CUSTOM METHOD
    ============================================================================================= */

    public function saveBank(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'bank_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $bankId                 = $_POST['bank_id'] ?? null;
        $bankName               = $_POST['bank_name'] ?? null;
        $bankIdentifierCode     = $_POST['bank_identifier_code'] ?? null;

        $bankId = $this->bank->saveBank(
            $bankId,
            $bankName,
            $bankIdentifierCode,
            $lastLogBy
        );

        $encryptedBankId = $this->security->encryptData($bankId);

        $this->systemHelper::sendSuccessResponse(
            'Save Bank Success',
            'The bank has been saved successfully.',
            ['bank_id' => $encryptedBankId]
        );
    }

    public function deleteBank() {
        $bankId = $_POST['bank_id'] ?? null;

        $this->bank->deleteBank($bankId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Bank Success',
            'The bank has been deleted successfully.'
        );
    }

    public function deleteMultipleBank() {
        $bankIds = $_POST['bank_id'] ?? null;

        foreach($bankIds as $bankId){
            $this->bank->deleteBank($bankId);
        }

        $this->systemHelper::sendSuccessResponse(
            'Delete Multiple Banks Success',
            'The selected banks have been deleted successfully.'
        );
    }

    public function fetchBankDetails() {
        $bankId             = $_POST['bank_id'] ?? null;
        $checkBankyExist    = $this->bank->checkBankExist($bankId);
        $total              = $checkBankyExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get Bank Details',
                'The bank does not exist',
                ['notExist' => true]
            );
        }

        $bankDetails = $this->bank->fetchBank($bankId);

        $response = [
            'success'               => true,
            'bankName'              => $bankDetails['bank_name'] ?? null,
            'bankIdentifierCode'    => $bankDetails['bank_identifier_code'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function generateBankTable() {
        $pageLink   = $_POST['page_link'] ?? null;
        $response   = [];

        $banks = $this->bank->generateBankTable();

        foreach ($banks as $row) {
            $bankId                 = $row['bank_id'];
            $bankName               = $row['bank_name'];
            $bankIdentifierCode     = $row['bank_identifier_code'];

            $bankIdEncrypted = $this->security->encryptData($bankId);

            $response[] = [
                'CHECK_BOX'             => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                                <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $bankId .'">
                                            </div>',
                'BANK_NAME'             => $bankName,
                'BANK_IDENTIFIER_CODE'  => $bankIdentifierCode,
                'LINK'                  => $pageLink .'&id='. $bankIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateBankOptions() {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $banks = $this->bank->generateBankOptions();

        foreach ($banks as $row) {
            $response[] = [
                'id'    => $row['bank_id'],
                'text'  => $row['bank_name']
            ];
        }

        echo json_encode($response);
    }
}

$controller = new BankController(
    new Bank(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();