<?php
namespace App\Controllers;


session_start();

use App\Models\Tax;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class TaxController
{
    protected Tax $tax;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        Tax $tax,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->tax              = $tax;
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
            'save tax'                 => $this->saveTax($lastLogBy),
            'update tax archive'       => $this->updateTaxArchive($lastLogBy),
            'update tax unarchive'     => $this->updateTaxUnarchive($lastLogBy),
            'delete tax'               => $this->deleteTax(),
            'delete multiple tax'      => $this->deleteMultipleTax(),
            'fetch tax details'        => $this->fetchTaxDetails(),
            'generate tax table'       => $this->generateTaxTable(),
            'generate tax options'     => $this->generateTaxOptions(),
            default                         => $this->systemHelper::sendErrorResponse(
                                                    'Transaction Failed',
                                                    'We encountered an issue while processing your request.'
                                                )
        };
    }

    public function saveTax($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'tax_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $taxId     = $_POST['tax_id'] ?? null;
        $taxName   = $_POST['tax_name'] ?? null;
        $contactPerson  = $_POST['contact_person'] ?? null;
        $address        = $_POST['address'] ?? null;
        $cityId         = $_POST['city_id'] ?? null;
        $phone          = $_POST['phone'] ?? null;
        $telephone      = $_POST['telephone'] ?? null;
        $email          = $_POST['email'] ?? null;
        $taxIdNumber    = $_POST['tax_id_number'] ?? null;

        $taxId = $this->tax->saveTax($taxId, $taxName, $contactPerson, $phone, $telephone, $email, $address, $lastLogBy);

        $encryptedtaxId = $this->security->encryptData($taxId);

        $this->systemHelper->sendSuccessResponse(
            'Save Tax Success',
            'The tax has been saved successfully.',
            ['tax_id' => $encryptedtaxId]
        );
    }

    public function updateTaxArchive($lastLogBy){
        $taxId = $_POST['tax_id'] ?? null;

        $this->tax->updateTaxArchive($taxId, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Tax Archive Success',
            'The tax has been archived successfully.'
        );
    }

    public function updateTaxUnarchive($lastLogBy){
        $taxId = $_POST['tax_id'] ?? null;

        $this->tax->updateTaxUnarchive($taxId, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Tax Unarchive Success',
            'The tax has been unarchived successfully.'
        );
    }

    public function deleteTax(){
        $taxId = $_POST['tax_id'] ?? null;

        $this->tax->deleteTax($taxId);

        $this->systemHelper->sendSuccessResponse(
            'Delete Tax Success',
            'The tax has been deleted successfully.'
        );
    }

    public function deleteMultipleTax(){
        $taxIds = $_POST['tax_id'] ?? null;

        foreach($taxIds as $taxId){
            $this->tax->deleteTax($taxId);
        }

        $this->systemHelper->sendSuccessResponse(
            'Delete Multiple Taxs Success',
            'The selected taxs have been deleted successfully.'
        );
    }

    public function fetchTaxDetails(){
        $taxId             = $_POST['tax_id'] ?? null;
        $checkTaxExist     = $this->tax->checkTaxExist($taxId);
        $total                  = $checkTaxExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper->sendErrorResponse(
                'Get Tax Details',
                'The tax does not exist',
                ['notExist' => true]
            );
        }

        $taxDetails     = $this->tax->fetchTax($taxId);

        $response = [
            'success'           => true,
            'taxName'      => $taxDetails['tax_name'] ?? null,
            'contactPerson'     => $taxDetails['contact_person'] ?? null,
            'address'           => $taxDetails['address'] ?? null,
            'cityID'            => $taxDetails['city_id'] ?? null,
            'taxIdNumber'       => $taxDetails['tax_id_number'] ?? null,
            'phone'             => $taxDetails['phone'] ?? null,
            'telephone'         => $taxDetails['telephone'] ?? null,
            'email'             => $taxDetails['email'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function generateTaxTable()
    {
        $pageLink               = $_POST['page_link'] ?? null;
        $cityFilter             = $this->systemHelper->checkFilter($_POST['city_filter'] ?? null);
        $stateFilter            = $this->systemHelper->checkFilter($_POST['state_filter'] ?? null);
        $countryFilter          = $this->systemHelper->checkFilter($_POST['country_filter'] ?? null);
        $taxStatusFilter   = $this->systemHelper->checkFilter($_POST['tax_status_filter'] ?? null);
        $response               = [];

        $taxs = $this->tax->generateTaxTable($cityFilter, $stateFilter, $countryFilter, $taxStatusFilter);

        foreach ($taxs as $row) {
            $taxId             = $row['tax_id'];
            $taxName           = $row['tax_name'];
            $address                = $row['address'];
            $cityName               = $row['city_name'];
            $stateName              = $row['state_name'];
            $countryName            = $row['country_name'];
            $taxAddress        = $address . ', ' . $cityName . ', ' . $stateName . ', ' . $countryName;
            $taxIdEncrypted    = $this->security->encryptData($taxId);

            $response[] = [
                'CHECK_BOX'     => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                        <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $taxId .'">
                                    </div>',
                'SUPPLIER_NAME'  => '<div class="d-flex flex-column">
                                        <span class="text-gray-800 fw-bold mb-1">'. $taxName .'</span>
                                        <small class="text-gray-600">'. $taxAddress .'</small>
                                    </div>',
                'LINK'          => $pageLink .'&id='. $taxIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateTaxOptions()
    {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $taxs = $this->tax->generateTaxOptions();

        foreach ($taxs as $row) {
            $response[] = [
                'id'    => $row['tax_id'],
                'text'  => $row['tax_name']
            ];
        }

        echo json_encode($response);
    }
}

# Bootstrap the controller
$controller = new TaxController(
    new Tax(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();
