<?php
namespace App\Controllers;


session_start();

use App\Models\Language;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class LanguageController
{
    protected Language $language;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        Language $language,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->language        = $language;
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
            'save language'                 => $this->saveLanguage($lastLogBy),
            'delete language'               => $this->deleteLanguage(),
            'delete multiple language'      => $this->deleteMultipleLanguage(),
            'fetch language details'        => $this->fetchLanguageDetails(),
            'generate language table'       => $this->generateLanguageTable(),
            'generate language options'     => $this->generateLanguageOptions(),
            default                         => $this->systemHelper::sendErrorResponse(
                                                    'Transaction Failed',
                                                    'We encountered an issue while processing your request.'
                                                )
        };
    }

    public function saveLanguage($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'language_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $languageId     = $_POST['language_id'] ?? null;
        $languageName   = $_POST['language_name'] ?? null;

        $languageId             = $this->language->saveLanguage($languageId, $languageName, $lastLogBy);
        $encryptedLanguageId    = $this->security->encryptData($languageId);

        $this->systemHelper->sendSuccessResponse(
            'Save Language Success',
            'The language has been saved successfully.',
            ['language_id' => $encryptedLanguageId]
        );
    }

    public function deleteLanguage(){
        $languageId = $_POST['language_id'] ?? null;

        $this->language->deleteLanguage($languageId);

        $this->systemHelper->sendSuccessResponse(
            'Delete Language Success',
            'The language has been deleted successfully.'
        );
    }

    public function deleteMultipleLanguage(){
        $languageIds = $_POST['language_id'] ?? null;

        foreach($languageIds as $languageId){
            $this->language->deleteLanguage($languageId);
        }

        $this->systemHelper->sendSuccessResponse(
            'Delete Multiple Languages Success',
            'The selected languages have been deleted successfully.'
        );
    }

    public function fetchLanguageDetails(){
        $languageId             = $_POST['language_id'] ?? null;
        $checkLanguageyExist    = $this->language->checkLanguageExist($languageId);
        $total                  = $checkLanguageyExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper->sendErrorResponse(
                'Get Language Details',
                'The language does not exist',
                ['notExist' => true]
            );
        }

        $languageDetails = $this->language->fetchLanguage($languageId);

        $response = [
            'success'       => true,
            'languageName'  => $languageDetails['language_name'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function generateLanguageTable()
    {
        $pageLink   = $_POST['page_link'] ?? null;
        $response   = [];

        $countries = $this->language->generateLanguageTable();

        foreach ($countries as $row) {
            $languageId     = $row['language_id'];
            $languageName   = $row['language_name'];

            $languageIdEncrypted = $this->security->encryptData($languageId);

            $response[] = [
                'CHECK_BOX'         => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                            <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $languageId .'">
                                        </div>',
                'LANGUAGE_NAME'     => $languageName,
                'LINK'              => $pageLink .'&id='. $languageIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateLanguageOptions()
    {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $countries = $this->language->generateLanguageOptions();

        foreach ($countries as $row) {
            $response[] = [
                'id'    => $row['language_id'],
                'text'  => $row['language_name']
            ];
        }

        echo json_encode($response);
    }
}

# Bootstrap the controller
$controller = new LanguageController(
    new Language(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();
