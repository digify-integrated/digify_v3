<?php
namespace App\Controllers;


session_start();

use App\Models\LanguageProficiency;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class LanguageProficiencyController
{
    protected LanguageProficiency $languageProficiency;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        LanguageProficiency $languageProficiency,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->languageProficiency  = $languageProficiency;
        $this->authentication       = $authentication;
        $this->security             = $security;
        $this->systemHelper         = $systemHelper;
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
            'save language proficiency'                 => $this->saveLanguageProficiency($lastLogBy),
            'delete language proficiency'               => $this->deleteLanguageProficiency(),
            'delete multiple language proficiency'      => $this->deleteMultipleLanguageProficiency(),
            'fetch language proficiency details'        => $this->fetchLanguageProficiencyDetails(),
            'generate language proficiency table'       => $this->generateLanguageProficiencyTable(),
            'generate language proficiency options'     => $this->generateLanguageProficiencyOptions(),
            default                                     => $this->systemHelper::sendErrorResponse(
                                                                'Transaction Failed',
                                                                'We encountered an issue while processing your request.'
                                                            )
        };
    }

    public function saveLanguageProficiency($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'language_proficiency_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $languageProficiencyId              = $_POST['language_proficiency_id'] ?? null;
        $languageProficiencyName            = $_POST['language_proficiency_name'] ?? null;
        $languageProficiencyDescription     = $_POST['language_proficiency_description'] ?? null;

        $languageProficiencyId              = $this->languageProficiency->saveLanguageProficiency($languageProficiencyId, $languageProficiencyName, $languageProficiencyDescription, $lastLogBy);
        $encryptedLanguageProficiencyId     = $this->security->encryptData($languageProficiencyId);

        $this->systemHelper->sendSuccessResponse(
            'Save Language Proficiency Success',
            'The language proficiency has been saved successfully.',
            ['language_proficiency_id' => $encryptedLanguageProficiencyId]
        );
    }

    public function deleteLanguageProficiency(){
        $languageProficiencyId = $_POST['language_proficiency_id'] ?? null;

        $this->languageProficiency->deleteLanguageProficiency($languageProficiencyId);

        $this->systemHelper->sendSuccessResponse(
            'Delete Language Proficiency Success',
            'The language proficiency has been deleted successfully.'
        );
    }

    public function deleteMultipleLanguageProficiency(){
        $languageProficiencyIds  = $_POST['language_proficiency_id'] ?? null;

        foreach($languageProficiencyIds as $languageProficiencyId){
            $this->languageProficiency->deleteLanguageProficiency($languageProficiencyId);
        }

        $this->systemHelper->sendSuccessResponse(
            'Delete Multiple Language Proficiencys Success',
            'The selected language proficiencys have been deleted successfully.'
        );
    }

    public function fetchLanguageProficiencyDetails(){
        $languageProficiencyId          = $_POST['language_proficiency_id'] ?? null;
        $checkLanguageProficiencyExist  = $this->languageProficiency->checkLanguageProficiencyExist($languageProficiencyId);
        $total                          = $checkLanguageProficiencyExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper->sendErrorResponse(
                'Get Language Proficiency Details',
                'The language proficiency does not exist'
            );
        }

        $languageProficiencyDetails   = $this->languageProficiency->fetchLanguageProficiency($languageProficiencyId);

        $response = [
            'success'                           => true,
            'languageProficiencyName'           => $languageProficiencyDetails['language_proficiency_name'] ?? null,
            'languageProficiencyDescription'    => $languageProficiencyDetails['language_proficiency_description'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function generateLanguageProficiencyTable()
    {
        $pageLink   = $_POST['page_link'] ?? null;
        $response   = [];

        $countries = $this->languageProficiency->generateLanguageProficiencyTable();

        foreach ($countries as $row) {
            $languageProficiencyId              = $row['language_proficiency_id'];
            $languageProficiencyName            = $row['language_proficiency_name'];
            $languageProficiencyDescription     = $row['language_proficiency_description'];

            $languageProficiencyIdEncrypted = $this->security->encryptData($languageProficiencyId);

            $response[] = [
                'CHECK_BOX'                     => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                                        <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $languageProficiencyId .'">
                                                    </div>',
                'LANGUAGE_PROFICIENCY_NAME'     => '<div class="d-flex flex-column">
                                                        <a href="#" class="fs-5 text-gray-900 fw-bold">'. $languageProficiencyName .'</a>
                                                        <div class="fs-7 text-gray-500">'. $languageProficiencyDescription .'</div>
                                                    </div>',
                'LINK'                          => $pageLink .'&id='. $languageProficiencyIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateLanguageProficiencyOptions()
    {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $countries = $this->languageProficiency->generateLanguageProficiencyOptions();

        foreach ($countries as $row) {
            $response[] = [
                'id'    => $row['language_proficiency_id'],
                'text'  => $row['language_proficiency_name']
            ];
        }

        echo json_encode($response);
    }
}

# Bootstrap the controller
$controller = new LanguageProficiencyController(
    new LanguageProficiency(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();
