<?php
namespace App\Controllers;


session_start();

use App\Models\Currency;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class CurrencyController
{
    protected Currency $currency;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        Currency $currency,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->currency         = $currency;
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
            'save currency'             => $this->saveCurrency($lastLogBy),
            'delete currency'           => $this->deleteCurrency(),
            'delete multiple currency'  => $this->deleteMultipleCurrency(),
            'fetch currency details'    => $this->fetchCurrencyDetails(),
            'generate currency table'   => $this->generateCurrencyTable(),
            'generate currency options' => $this->generateCurrencyOptions(),
            default                     => $this->systemHelper::sendErrorResponse(
                                                'Transaction Failed',
                                                'We encountered an issue while processing your request.'
                                            )
        };
    }

    public function saveCurrency($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'currency_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $currencyId     = $_POST['currency_id'] ?? null;
        $currencyName   = $_POST['currency_name'] ?? null;
        $symbol         = $_POST['symbol'] ?? null;
        $shorthand      = $_POST['shorthand'] ?? null;

        $currencyId             = $this->currency->saveCurrency($currencyId, $currencyName, $symbol, $shorthand, $lastLogBy);
        $encryptedcurrencyId    = $this->security->encryptData($currencyId);

        $this->systemHelper->sendSuccessResponse(
            'Save Currency Success',
            'The currency has been saved successfully.',
            ['currency_id' => $encryptedcurrencyId]
        );
    }

    public function deleteCurrency(){
        $currencyId = $_POST['currency_id'] ?? null;

        $this->currency->deleteCurrency($currencyId);

        $this->systemHelper->sendSuccessResponse(
            'Delete Currency Success',
            'The currency has been deleted successfully.'
        );
    }

    public function deleteMultipleCurrency(){
        $currencyIds = $_POST['currency_id'] ?? null;

        foreach($currencyIds as $currencyId){
            $this->currency->deleteCurrency($currencyId);
        }

        $this->systemHelper->sendSuccessResponse(
            'Delete Multiple Currencies Success',
            'The selected currencies have been deleted successfully.'
        );
    }

    public function fetchCurrencyDetails(){
        $currencyId             = $_POST['currency_id'] ?? null;
        $checkCurrencyExist     = $this->currency->checkCurrencyExist($currencyId);
        $total                  = $checkCurrencyExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper->sendErrorResponse(
                'Get Currency Details',
                'The currency does not exist',
                ['notExist' => true]
            );
        }

        $currencyDetails = $this->currency->fetchCurrency($currencyId);

        $response = [
            'success'       => true,
            'currencyName'  => $currencyDetails['currency_name'] ?? null,
            'symbol'        => $currencyDetails['symbol'] ?? null,
            'shorthand'     => $currencyDetails['shorthand'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function generateCurrencyTable()
    {
        $pageLink   = $_POST['page_link'] ?? null;
        $response   = [];

        $currencies = $this->currency->generateCurrencyTable();

        foreach ($currencies as $row) {
            $currencyId     = $row['currency_id'];
            $currencyName   = $row['currency_name'];
            $symbol         = $row['symbol'];
            $shorthand      = $row['shorthand'];

            $currencyIdEncrypted = $this->security->encryptData($currencyId);

            $response[] = [
                'CHECK_BOX'         => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                            <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $currencyId .'">
                                        </div>',
                'CURRENCY_NAME'     => $currencyName,
                'SYMBOL'            => $symbol,
                'SHORTHAND'         => $shorthand,
                'LINK'              => $pageLink .'&id='. $currencyIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateCurrencyOptions()
    {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $currencies = $this->currency->generateCurrencyOptions();

        foreach ($currencies as $row) {
            $response[] = [
                'id'    => $row['currency_id'],
                'text'  => $row['currency_name']
            ];
        }

        echo json_encode($response);
    }
}

# Bootstrap the controller
$controller = new CurrencyController(
    new Currency(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();
