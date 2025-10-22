<?php
namespace App\Controllers;


session_start();

use App\Models\Warehouse;
use App\Models\WarehouseType;
use App\Models\City;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class WarehouseController
{
    protected Warehouse $warehouse;
    protected WarehouseType $warehouseType;
    protected City $city;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        Warehouse $warehouse,
        WarehouseType $warehouseType,
        City $city,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->warehouse        = $warehouse;
        $this->warehouseType    = $warehouseType;
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
            'save warehouse'                => $this->saveWarehouse($lastLogBy),
            'update warehouse archive'      => $this->updateWarehouseArchive($lastLogBy),
            'update warehouse unarchive'    => $this->updateWarehouseUnarchive($lastLogBy),
            'delete warehouse'              => $this->deleteWarehouse(),
            'delete multiple warehouse'     => $this->deleteMultipleWarehouse(),
            'fetch warehouse details'       => $this->fetchWarehouseDetails(),
            'generate warehouse table'      => $this->generateWarehouseTable(),
            'generate warehouse options'    => $this->generateWarehouseOptions(),
            default                         => $this->systemHelper::sendErrorResponse(
                                                    'Transaction Failed',
                                                    'We encountered an issue while processing your request.'
                                                )
        };
    }

    public function saveWarehouse($lastLogBy){
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'warehouse_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $warehouseId        = $_POST['warehouse_id'] ?? null;
        $warehouseName      = $_POST['warehouse_name'] ?? null;
        $shortName          = $_POST['short_name'] ?? null;
        $contactPerson      = $_POST['contact_person'] ?? null;
        $address            = $_POST['address'] ?? null;
        $cityId             = $_POST['city_id'] ?? null;
        $phone              = $_POST['phone'] ?? null;
        $telephone          = $_POST['telephone'] ?? null;
        $email              = $_POST['email'] ?? null;
        $warehouseTypeId    = $_POST['warehouse_type_id'] ?? null;

        $warehouseTypeDetails    = $this->warehouseType->fetchWarehouseType($warehouseTypeId);
        $warehouseTypeName       = $warehouseTypeDetails['warehouse_type_name'] ?? null;

        $cityDetails    = $this->city->fetchCity($cityId);
        $cityName       = $cityDetails['city_name'] ?? null;
        $stateId        = $cityDetails['state_id'] ?? null;
        $stateName      = $cityDetails['state_name'] ?? null;
        $countryId      = $cityDetails['country_id'] ?? null;
        $countryName    = $cityDetails['country_name'] ?? null;

        $warehouseId = $this->warehouse->saveWarehouse($warehouseId, $warehouseName, $shortName, $contactPerson, $phone, $telephone, $email, $address, $cityId, $cityName, $stateId, $stateName, $countryId, $countryName, $warehouseTypeId, $warehouseTypeName, $lastLogBy);

        $encryptedwarehouseId = $this->security->encryptData($warehouseId);

        $this->systemHelper->sendSuccessResponse(
            'Save Warehouse Success',
            'The warehouse has been saved successfully.',
            ['warehouse_id' => $encryptedwarehouseId]
        );
    }

    public function updateWarehouseArchive($lastLogBy){
        $warehouseId = $_POST['warehouse_id'] ?? null;

        $this->warehouse->updateWarehouseArchive($warehouseId, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Warehouse Archive Success',
            'The warehouse has been archived successfully.'
        );
    }

    public function updateWarehouseUnarchive($lastLogBy){
        $warehouseId = $_POST['warehouse_id'] ?? null;

        $this->warehouse->updateWarehouseUnarchive($warehouseId, $lastLogBy);

        $this->systemHelper->sendSuccessResponse(
            'Warehouse Unarchive Success',
            'The warehouse has been unarchived successfully.'
        );
    }

    public function deleteWarehouse(){
        $warehouseId = $_POST['warehouse_id'] ?? null;

        $this->warehouse->deleteWarehouse($warehouseId);

        $this->systemHelper->sendSuccessResponse(
            'Delete Warehouse Success',
            'The warehouse has been deleted successfully.'
        );
    }

    public function deleteMultipleWarehouse(){
        $warehouseIds = $_POST['warehouse_id'] ?? null;

        foreach($warehouseIds as $warehouseId){
            $this->warehouse->deleteWarehouse($warehouseId);
        }

        $this->systemHelper->sendSuccessResponse(
            'Delete Multiple Warehouses Success',
            'The selected warehouses have been deleted successfully.'
        );
    }

    public function fetchWarehouseDetails(){
        $warehouseId            = $_POST['warehouse_id'] ?? null;
        $checkWarehouseExist    = $this->warehouse->checkWarehouseExist($warehouseId);
        $total                  = $checkWarehouseExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper->sendErrorResponse(
                'Get Warehouse Details',
                'The warehouse does not exist',
                ['notExist' => true]
            );
        }

        $warehouseDetails     = $this->warehouse->fetchWarehouse($warehouseId);

        $response = [
            'success'           => true,
            'warehouseName'     => $warehouseDetails['warehouse_name'] ?? null,
            'shortName'         => $warehouseDetails['short_name'] ?? null,
            'contactPerson'     => $warehouseDetails['contact_person'] ?? null,
            'address'           => $warehouseDetails['address'] ?? null,
            'cityID'            => $warehouseDetails['city_id'] ?? null,
            'phone'             => $warehouseDetails['phone'] ?? null,
            'telephone'         => $warehouseDetails['telephone'] ?? null,
            'email'             => $warehouseDetails['email'] ?? null,
            'warehouseTypeId'  => $warehouseDetails['warehouse_type_id'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function generateWarehouseTable()
    {
        $pageLink               = $_POST['page_link'] ?? null;
        $cityFilter             = $this->systemHelper->checkFilter($_POST['city_filter'] ?? null);
        $stateFilter            = $this->systemHelper->checkFilter($_POST['state_filter'] ?? null);
        $countryFilter          = $this->systemHelper->checkFilter($_POST['country_filter'] ?? null);
        $warehouseTypeFilter   = $this->systemHelper->checkFilter($_POST['warehouse_type_filter'] ?? null);
        $warehouseStatusFilter   = $this->systemHelper->checkFilter($_POST['warehouse_status_filter'] ?? null);
        $response               = [];

        $warehouses = $this->warehouse->generateWarehouseTable($warehouseTypeFilter, $cityFilter, $stateFilter, $countryFilter, $warehouseStatusFilter);

        foreach ($warehouses as $row) {
            $warehouseId            = $row['warehouse_id'];
            $warehouseName          = $row['warehouse_name'];
            $address                = $row['address'];
            $cityName               = $row['city_name'];
            $stateName              = $row['state_name'];
            $countryName            = $row['country_name'];
            $warehouseAddress       = $address . ', ' . $cityName . ', ' . $stateName . ', ' . $countryName;
            $warehouseIdEncrypted   = $this->security->encryptData($warehouseId);

            $response[] = [
                'CHECK_BOX'     => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                        <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $warehouseId .'">
                                    </div>',
                'WAREHOUSE_NAME'  => '<div class="d-flex flex-column">
                                        <span class="text-gray-800 fw-bold mb-1">'. $warehouseName .'</span>
                                        <small class="text-gray-600">'. $warehouseAddress .'</small>
                                    </div>',
                'LINK'          => $pageLink .'&id='. $warehouseIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateWarehouseOptions()
    {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $warehouses = $this->warehouse->generateWarehouseOptions();

        foreach ($warehouses as $row) {
            $response[] = [
                'id'    => $row['warehouse_id'],
                'text'  => $row['warehouse_name']
            ];
        }

        echo json_encode($response);
    }
}

# Bootstrap the controller
$controller = new WarehouseController(
    new Warehouse(),
    new WarehouseType(),
    new City(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();
