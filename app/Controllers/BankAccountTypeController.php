<?php
namespace App\Controllers;

session_start();

use App\Models\BankAccountType;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class BankAccountTypeController {
    protected BankAccountType $bankAccountType;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        BankAccountType $bankAccountType,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->bankAccountType  = $bankAccountType;
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
            'save bank account type'                => $this->saveBankAccountType($lastLogBy),
            'delete bank account type'              => $this->deleteBankAccountType(),
            'delete multiple bank account type'     => $this->deleteMultipleBankAccountType(),
            'fetch bank account type details'       => $this->fetchBankAccountTypeDetails(),
            'generate bank account type table'      => $this->generateBankAccountTypeTable(),
            'generate bank account type options'    => $this->generateBankAccountTypeOptions(),
            default                                 => $this->systemHelper::sendErrorResponse(
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

    public function saveBankAccountType(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'bank_account_type_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $bankAccountTypeId      = $_POST['bank_account_type_id'] ?? null;
        $bankAccountTypeName    = $_POST['bank_account_type_name'] ?? null;

        $bankAccountTypeId = $this->bankAccountType->saveBankAccountType(
            $bankAccountTypeId,
            $bankAccountTypeName,
            $lastLogBy
        );

        $encryptedBankAccountTypeId = $this->security->encryptData($bankAccountTypeId);

        $this->systemHelper::sendSuccessResponse(
            'Save Bank Account Type Success',
            'The bank account type has been saved successfully.',
            ['bank_account_type_id' => $encryptedBankAccountTypeId]
        );
    }

    public function deleteBankAccountType() {
        $bankAccountTypeId = $_POST['bank_account_type_id'] ?? null;

        $this->bankAccountType->deleteBankAccountType($bankAccountTypeId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Bank Account Type Success',
            'The bank account type has been deleted successfully.'
        );
    }

    public function deleteMultipleBankAccountType() {
        $bankAccountTypeIds = $_POST['bank_account_type_id'] ?? null;

        foreach($bankAccountTypeIds as $bankAccountTypeId){
            $this->bankAccountType->deleteBankAccountType($bankAccountTypeId);
        }

        $this->systemHelper::sendSuccessResponse(
            'Delete Multiple Bank Account Types Success',
            'The selected bank account types have been deleted successfully.'
        );
    }

    public function fetchBankAccountTypeDetails() {
        $bankAccountTypeId          = $_POST['bank_account_type_id'] ?? null;
        $checkBankAccountTypeExist  = $this->bankAccountType->checkBankAccountTypeExist($bankAccountTypeId);
        $total                      = $checkBankAccountTypeExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get Bank Account Type Details',
                'The bank account type does not exist',
                ['notExist' => true]
            );
        }

        $bankAccountTypeDetails = $this->bankAccountType->fetchBankAccountType($bankAccountTypeId);

        $response = [
            'success'               => true,
            'bankAccountTypeName'   => $bankAccountTypeDetails['bank_account_type_name'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function generateBankAccountTypeTable() {
        $pageLink   = $_POST['page_link'] ?? null;
        $response   = [];

        $bankAccountTypes = $this->bankAccountType->generateBankAccountTypeTable();

        foreach ($bankAccountTypes as $row) {
            $bankAccountTypeId      = $row['bank_account_type_id'];
            $bankAccountTypeName    = $row['bank_account_type_name'];

            $bankAccountTypeIdEncrypted = $this->security->encryptData($bankAccountTypeId);

            $response[] = [
                'CHECK_BOX'                 => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                                    <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $bankAccountTypeId .'">
                                                </div>',
                'BANK_ACCOUNT_TYPE_NAME'    => $bankAccountTypeName,
                'LINK'                      => $pageLink .'&id='. $bankAccountTypeIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateBankAccountTypeOptions() {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $bankAccountTypes = $this->bankAccountType->generateBankAccountTypeOptions();

        foreach ($bankAccountTypes as $row) {
            $response[] = [
                'id'    => $row['bank_account_type_id'],
                'text'  => $row['bank_account_type_name']
            ];
        }

        echo json_encode($response);
    }
}

$controller = new BankAccountTypeController(
    new BankAccountType(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();