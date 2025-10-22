<?php
namespace App\Controllers;


session_start();

use App\Models\Supplier;
use App\Models\City;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class SupplierController
{
    protected Supplier $supplier;
    protected City $city;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        Supplier $supplier,
        City $city,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->supplier         = $supplier;
        $this->city             = $city;
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
            'save supplier'                 => $this->saveSupplier($lastLogBy),
            'update supplier archive'       => $this->updateSupplierArchive($lastLogBy),
            'update supplier unarchive'     => $this->updateSupplierUnarchive($lastLogBy),
            'delete supplier'               => $this->deleteSupplier(),
            'delete multiple supplier'      => $this->deleteMultipleSupplier(),
            'fetch supplier details'        => $this->fetchSupplierDetails(),
            'generate supplier table'       => $this->generateSupplierTable(),
            'generate supplier options'     => $this->generateSupplierOptions(),
            default                         => $this->systemHelper::sendErrorResponse(
                                                    'Transaction Failed',
                                                    'We encountered an issue while processing your request.'
                                                )
        };
    }

    public function saveSupplier($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'supplier_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $supplierId     = $_POST['supplier_id'] ?? null;
        $supplierName   = $_POST['supplier_name'] ?? null;
        $contactPerson  = $_POST['contact_person'] ?? null;
        $address        = $_POST['address'] ?? null;
        $cityId         = $_POST['city_id'] ?? null;
        $phone          = $_POST['phone'] ?? null;
        $telephone      = $_POST['telephone'] ?? null;
        $email          = $_POST['email'] ?? null;
        $taxIdNumber    = $_POST['tax_id_number'] ?? null;

        $cityDetails    = $this->city->fetchCity($cityId);
        $cityName       = $cityDetails['city_name'] ?? null;
        $stateId        = $cityDetails['state_id'] ?? null;
        $stateName      = $cityDetails['state_name'] ?? null;
        $countryId      = $cityDetails['country_id'] ?? null;
        $countryName    = $cityDetails['country_name'] ?? null;

        $supplierId = $this->supplier->saveSupplier($supplierId, $supplierName, $contactPerson, $phone, $telephone, $email, $address, $cityId, $cityName, $stateId, $stateName, $countryId, $countryName, $taxIdNumber, $lastLogBy);

        $encryptedsupplierId = $this->security->encryptData($supplierId);

        $this->systemHelper->sendSuccessResponse(
            'Save Supplier Success',
            'The supplier has been saved successfully.',
            ['supplier_id' => $encryptedsupplierId]
        );
    }

    public function updateSupplierArchive($lastLogBy){
        $supplierId = $_POST['supplier_id'] ?? null;

        $this->supplier->updateSupplierArchive($supplierId, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Supplier Archive Success',
            'The supplier has been archived successfully.'
        );
    }

    public function updateSupplierUnarchive($lastLogBy){
        $supplierId = $_POST['supplier_id'] ?? null;

        $this->supplier->updateSupplierUnarchive($supplierId, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Supplier Unarchive Success',
            'The supplier has been unarchived successfully.'
        );
    }

    public function deleteSupplier(){
        $supplierId = $_POST['supplier_id'] ?? null;

        $this->supplier->deleteSupplier($supplierId);

        $this->systemHelper->sendSuccessResponse(
            'Delete Supplier Success',
            'The supplier has been deleted successfully.'
        );
    }

    public function deleteMultipleSupplier(){
        $supplierIds = $_POST['supplier_id'] ?? null;

        foreach($supplierIds as $supplierId){
            $this->supplier->deleteSupplier($supplierId);
        }

        $this->systemHelper->sendSuccessResponse(
            'Delete Multiple Suppliers Success',
            'The selected suppliers have been deleted successfully.'
        );
    }

    public function fetchSupplierDetails(){
        $supplierId             = $_POST['supplier_id'] ?? null;
        $checkSupplierExist     = $this->supplier->checkSupplierExist($supplierId);
        $total                  = $checkSupplierExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper->sendErrorResponse(
                'Get Supplier Details',
                'The supplier does not exist',
                ['notExist' => true]
            );
        }

        $supplierDetails     = $this->supplier->fetchSupplier($supplierId);

        $response = [
            'success'           => true,
            'supplierName'      => $supplierDetails['supplier_name'] ?? null,
            'contactPerson'     => $supplierDetails['contact_person'] ?? null,
            'address'           => $supplierDetails['address'] ?? null,
            'cityID'            => $supplierDetails['city_id'] ?? null,
            'taxIdNumber'       => $supplierDetails['tax_id_number'] ?? null,
            'phone'             => $supplierDetails['phone'] ?? null,
            'telephone'         => $supplierDetails['telephone'] ?? null,
            'email'             => $supplierDetails['email'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function generateSupplierTable()
    {
        $pageLink               = $_POST['page_link'] ?? null;
        $cityFilter             = $this->systemHelper->checkFilter($_POST['city_filter'] ?? null);
        $stateFilter            = $this->systemHelper->checkFilter($_POST['state_filter'] ?? null);
        $countryFilter          = $this->systemHelper->checkFilter($_POST['country_filter'] ?? null);
        $supplierStatusFilter   = $this->systemHelper->checkFilter($_POST['supplier_status_filter'] ?? null);
        $response               = [];

        $suppliers = $this->supplier->generateSupplierTable($cityFilter, $stateFilter, $countryFilter, $supplierStatusFilter);

        foreach ($suppliers as $row) {
            $supplierId             = $row['supplier_id'];
            $supplierName           = $row['supplier_name'];
            $address                = $row['address'];
            $cityName               = $row['city_name'];
            $stateName              = $row['state_name'];
            $countryName            = $row['country_name'];
            $supplierAddress        = $address . ', ' . $cityName . ', ' . $stateName . ', ' . $countryName;
            $supplierIdEncrypted    = $this->security->encryptData($supplierId);

            $response[] = [
                'CHECK_BOX'     => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                        <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $supplierId .'">
                                    </div>',
                'SUPPLIER_NAME'  => '<div class="d-flex flex-column">
                                        <span class="text-gray-800 fw-bold mb-1">'. $supplierName .'</span>
                                        <small class="text-gray-600">'. $supplierAddress .'</small>
                                    </div>',
                'LINK'          => $pageLink .'&id='. $supplierIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateSupplierOptions()
    {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $suppliers = $this->supplier->generateSupplierOptions();

        foreach ($suppliers as $row) {
            $response[] = [
                'id'    => $row['supplier_id'],
                'text'  => $row['supplier_name']
            ];
        }

        echo json_encode($response);
    }
}

# Bootstrap the controller
$controller = new SupplierController(
    new Supplier(),
    new City(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();
