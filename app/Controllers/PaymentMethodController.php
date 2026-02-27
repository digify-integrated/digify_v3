<?php
namespace App\Controllers;

session_start();

use App\Models\PaymentMethod;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class PaymentMethodController {
    protected PaymentMethod $paymentMethod;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        PaymentMethod $paymentMethod,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->paymentMethod    = $paymentMethod;
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
            'save payment method'               => $this->savePaymentMethod($lastLogBy),
            'delete payment method'             => $this->deletePaymentMethod(),
            'delete multiple payment method'    => $this->deleteMultiplePaymentMethod(),
            'fetch payment method details'      => $this->fetchPaymentMethodDetails(),
            'generate payment method table'     => $this->generatePaymentMethodTable(),
            'generate payment method options'   => $this->generatePaymentMethodOptions(),
            default                             => $this->systemHelper::sendErrorResponse(
                                                        'Transaction Failed',
                                                        'We encountered an issue while processing your request.'
                                                    )
        };
    }

    /* =============================================================================================
        SECTION 1: SAVE METHOD
    ============================================================================================= */

    public function savePaymentMethod(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'payment_method_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $paymentMethodId      = $_POST['payment_method_id'] ?? null;
        $paymentMethodName    = $_POST['payment_method_name'] ?? null;

        $paymentMethodId = $this->paymentMethod->savePaymentMethod(
            $paymentMethodId,
            $paymentMethodName,
            $lastLogBy
        );
        
        $encryptedPaymentMethodId = $this->security->encryptData($paymentMethodId);

        $this->systemHelper::sendSuccessResponse(
            'Save Payment Method Success',
            'The payment method has been saved successfully.',
            ['payment_method_id' => $encryptedPaymentMethodId]
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

    public function fetchPaymentMethodDetails() {
        $paymentMethodId            = $_POST['payment_method_id'] ?? null;
        $checkPaymentMethodExist    = $this->paymentMethod->checkPaymentMethodExist($paymentMethodId);
        $total                      = $checkPaymentMethodExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get Payment Method Details',
                'The payment method does not exist',
                ['notExist' => true]
            );
        }

        $paymentMethodDetails = $this->paymentMethod->fetchPaymentMethod($paymentMethodId);

        $response = [
            'success'           => true,
            'paymentMethodName' => $paymentMethodDetails['payment_method_name'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    /* =============================================================================================
        SECTION 5: DELETE METHOD
    ============================================================================================= */

    public function deletePaymentMethod() {
        $paymentMethodId = $_POST['payment_method_id'] ?? null;

        $this->paymentMethod->deletePaymentMethod($paymentMethodId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Payment Method Success',
            'The payment method has been deleted successfully.'
        );
    }

    public function deleteMultiplePaymentMethod() {
        $paymentMethodIds = $_POST['payment_method_id'] ?? null;

        foreach($paymentMethodIds as $paymentMethodId){
            $this->paymentMethod->deletePaymentMethod($paymentMethodId);
        }

        $this->systemHelper::sendSuccessResponse(
            'Delete Multiple Payment Methods Success',
            'The selected payment methods have been deleted successfully.'
        );
    }

    /* =============================================================================================
        SECTION 6: CHECK METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 7: GENERATE METHOD
    ============================================================================================= */

    public function generatePaymentMethodTable() {
        $pageLink   = $_POST['page_link'] ?? null;
        $response   = [];

        $paymentMethods = $this->paymentMethod->generatePaymentMethodTable();

        foreach ($paymentMethods as $row) {
            $paymentMethodId    = $row['payment_method_id'];
            $paymentMethodName  = $row['payment_method_name'];

            $paymentMethodIdEncrypted = $this->security->encryptData($paymentMethodId);

            $response[] = [
                'CHECK_BOX'             => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                                <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $paymentMethodId .'">
                                            </div>',
                'PAYMENT_METHOD_NAME'   => $paymentMethodName,
                'LINK'                  => $pageLink .'&id='. $paymentMethodIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generatePaymentMethodOptions() {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $paymentMethods = $this->paymentMethod->generatePaymentMethodOptions();

        foreach ($paymentMethods as $row) {
            $response[] = [
                'id'    => $row['payment_method_id'],
                'text'  => $row['payment_method_name']
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

$controller = new PaymentMethodController(
    new PaymentMethod(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();