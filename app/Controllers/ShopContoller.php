<?php
namespace App\Controllers;

session_start();

use App\Models\Shop;
use App\Models\Company;
use App\Models\ShopType;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';
class ShopController {
    protected Shop $shop;
    protected Company $company;
    protected ShopType $shopType;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        Shop $shop,
        Company $company,
        ShopType $shopType,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->shop             = $shop;
        $this->company          = $company;
        $this->shopType         = $shopType;
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
        $pageId         = $_POST['page_id'] ?? null;
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
            'save shop'                                => $this->saveShop($lastLogBy),
            'save shop role permission'                => $this->saveShopRolePermission($lastLogBy),
            'update shop role permission'              => $this->updateShopRolePermission($lastLogBy),
            'delete shop'                              => $this->deleteShop(),
            'delete multiple shop'                     => $this->deleteMultipleShop(),
            'delete shop role permission'              => $this->deleteShopRolePermission(),
            'fetch shop details'                       => $this->fetchShopDetails(),
            'generate shop table'                      => $this->generateShopTable(),
            'generate shop assigned role table'        => $this->generateShopAssignedRoleTable($lastLogBy, $pageId),
            'generate shop options'                    => $this->generateShopOptions(),
            'generate shop role dual listbox options'  => $this->generateShopRoleDualListBoxOptions(),
            default                                         => $this->systemHelper::sendErrorResponse(
                                                                    'Transaction Failed',
                                                                    'We encountered an issue while processing your request.'
                                                                )
        };
    }

    /* =============================================================================================
        SECTION 1: SAVE METHOD
    ============================================================================================= */

    public function saveShop(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'shop_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $shopId         = $_POST['shop_id'] ?? null;
        $shopName       = $_POST['shop_name'] ?? null;
        $companyId      = $_POST['company_id'] ?? null;
        $shopTypeId     = $_POST['shop_type_id'] ?? null;

        $companyDetails     = $this->company->fetchCompany($companyId);
        $companyName        = $companyDetails['company_name'] ?? null;

        $shopTypeDetails    = $this->shopType->fetchShopType($shopTypeId);
        $shopTypeName       = $shopTypeDetails['shop_type_name'] ?? null;

        $shopId = $this->shop->saveShop(
            $shopId,
            $shopName,
            $companyId,
            $companyName,
            $shopTypeId,
            $shopTypeName,
            $lastLogBy
        );
        
        $encryptedshopId = $this->security->encryptData($shopId);

        $this->systemHelper::sendSuccessResponse(
            'Save Shop Success',
            'The shop has been saved successfully.',
            ['shop_id' => $encryptedshopId]
        );
    }

    /* =============================================================================================
        SECTION 2: INSERT METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 3: UPDATE METHOD
    ============================================================================================= */

    public function updateShopRolePermission(
        int $lastLogBy
    ) {
        $rolePermissionId   = $_POST['role_permission_id'] ?? null;
        $accessType         = $_POST['access_type'] ?? null;
        $access             = $_POST['access'] ?? null;

        $checkShopRolePermissionExist   = $this->role->checkRolePermissionExist($rolePermissionId);
        $total                              = $checkShopRolePermissionExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Update Role Permission Error',
                'The role permission does not exist.'
            );
        }

        $this->role->updateRolePermission(
            $rolePermissionId,
            $accessType,
            $access, 
            $lastLogBy
        );
        
        $this->systemHelper::sendSuccessResponse(
            'Update Role Permission Success',
            'The role permission has been updated successfully.'
        );
    }

    /* =============================================================================================
        SECTION 4: FETCH METHOD
    ============================================================================================= */

    public function fetchShopDetails() {
        $shopId             = $_POST['shop_id'] ?? null;
        $checkShopExist     = $this->shop->checkShopExist($shopId);
        $total                  = $checkShopExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get Shop Details',
                'The shop does not exist'
            );
        }

        $shopDetails   = $this->shop->fetchShop($shopId);
        $parentId          = $shopDetails['parent_id'] == 0 ? '' : $shopDetails['parent_id'];

        $response = [
            'success'           => true,
            'shopName'      => $shopDetails['shop_name'] ?? null,
            'shopURL'       => $shopDetails['shop_url'] ?? null,
            'shopIcon'      => $shopDetails['shop_icon'] ?? null,
            'appModuleID'       => $shopDetails['app_module_id'] ?? null,
            'parentID'          => $parentId,
            'tableName'         => $shopDetails['table_name'] ?? null,
            'orderSequence'     => $shopDetails['order_sequence'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    /* =============================================================================================
        SECTION 5: DELETE METHOD
    ============================================================================================= */

    public function deleteShop() {
        $shopId = $_POST['shop_id'] ?? null;

        $this->shop->deleteShop($shopId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Shop Success',
            'The shop has been deleted successfully.'
        );
    }

    public function deleteMultipleShop() {
        $shopIds = $_POST['shop_id'] ?? null;

        foreach($shopIds as $shopId){
            $this->shop->deleteShop($shopId);
        }

        $this->systemHelper::sendSuccessResponse(
            'Delete Multiple Shops Success',
            'The selected shops have been deleted successfully.'
        );
    }

    public function deleteShopRolePermission() {
        $rolePermissionId = $_POST['role_permission_id'] ?? null;

        $this->role->deleteRolePermission($rolePermissionId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Role Permission Success',
            'The role permission has been deleted successfully.'
        );
    }

    /* =============================================================================================
        SECTION 6: CHECK METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 7: GENERATE METHOD
    ============================================================================================= */

    public function generateShopTable() {
        $filterAppModule    = $this->systemHelper->checkFilter($_POST['filter_by_app_module'] ?? null);
        $filterParentId     = $this->systemHelper->checkFilter($_POST['filter_by_parent_menu'] ?? null);
        $pageLink           = $_POST['page_link'] ?? null;
        $response           = [];

        $shops = $this->shop->generateShopTable(
            $filterAppModule,
            $filterParentId
        );

        foreach ($shops as $row) {
            $shopId     = $row['shop_id'];
            $shopName   = $row['shop_name'];
            $appModuleName  = $row['app_module_name'];
            $parentName     = !empty($row['parent_name']) ? $row['parent_name'] : '-';
            $orderSequence  = $row['order_sequence'];

            $shopIdEncrypted = $this->security->encryptData($shopId);

            $response[] = [
                'CHECK_BOX'         => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                            <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $shopId .'">
                                        </div>',
                'MENU_ITEM_NAME'    => $shopName,
                'APP_MODULE_NAME'   => $appModuleName,
                'PARENT_NAME'       => $parentName,
                'ORDER_SEQUENCE'    => $orderSequence,
                'LINK'              => $pageLink .'&id='. $shopIdEncrypted
            ];
        }

        echo json_encode($response);
    }

    public function generateShopAssignedRoleTable(
        int $userId,
        int $pageId
    ) {
        $shopId     = $_POST['shop_id'] ?? null;
        $response       = [];

        $updateRoleAccess   = $this->authentication->checkUserSystemActionPermission($userId, 6)['total'] ?? 0;
        $deleteRoleAccess   = $this->authentication->checkUserSystemActionPermission($userId, 7)['total'] ?? 0;
        $logNotesAccess     = $this->authentication->checkUserPermission($userId, $pageId, 'log notes')['total'] ?? 0;
        $disabled           = ($updateRoleAccess == 0) ? 'disabled' : '';
        
        $shops = $this->shop->generateShopAssignedRoleTable($shopId);

        foreach ($shops as $row) {
            $rolePermissionId       = $row['role_permission_id'];
            $roleName               = $row['role_name'];
            $readAccessRights       = $row['read_access'];
            $writeAccessRights      = $row['write_access'];
            $createAccessRights     = $row['create_access'];
            $deleteAccessRights     = $row['delete_access'];
            $importAccessRights     = $row['import_access'];
            $exportAccessRights     = $row['export_access'];
            $logNotesAccessRights   = $row['log_notes_access'];

            $readAccessChecked      = $readAccessRights ? 'checked' : '';
            $writeAccessChecked     = $writeAccessRights ? 'checked' : '';
            $createAccessChecked    = $createAccessRights ? 'checked' : '';
            $deleteAccessChecked    = $deleteAccessRights ? 'checked' : '';
            $importAccessChecked    = $importAccessRights ? 'checked' : '';
            $exportAccessChecked    = $exportAccessRights ? 'checked' : '';
            $logNotesAccessChecked  = $logNotesAccessRights ? 'checked' : '';

            $deleteButton = '';
            if($deleteRoleAccess > 0){
                $deleteButton = '<button class="btn btn-icon btn-light btn-active-light-danger delete-role-permission" data-role-permission-id="' . $rolePermissionId . '" title="Delete Role Permission">
                                    <i class="ki-outline ki-trash fs-3 m-0 fs-5"></i>
                                </button>';
            }

            $logNotes = '';
            if($logNotesAccess > 0){
                $logNotes = '<button class="btn btn-icon btn-light btn-active-light-primary view-role-permission-log-notes" data-role-permission-id="' . $rolePermissionId . '" data-bs-toggle="modal" data-bs-target="#log-notes-modal" title="View Log Notes">
                                <i class="ki-outline ki-shield-search fs-3 m-0 fs-5"></i>
                            </button>';
            }

            $readAccessButton = '<div class="form-check form-switch form-switch-sm form-check-custom form-check-solid">
                                    <input class="form-check-input update-role-permission" type="checkbox" data-role-permission-id="' . $rolePermissionId . '" data-access-type="read" ' . $readAccessChecked . ' '. $disabled .' />
                                </div>';

            $writeAccessButton = '<div class="form-check form-switch form-switch-sm form-check-custom form-check-solid">
                                    <input class="form-check-input update-role-permission" type="checkbox" data-role-permission-id="' . $rolePermissionId . '" data-access-type="write" ' . $writeAccessChecked . ' '. $disabled .' />
                                </div>';

            $createAccessButton = '<div class="form-check form-switch form-switch-sm form-check-custom form-check-solid">
                                    <input class="form-check-input update-role-permission" type="checkbox" data-role-permission-id="' . $rolePermissionId . '" data-access-type="create" ' . $createAccessChecked . ' '. $disabled .' />
                                </div>';

            $deleteAccessButton = '<div class="form-check form-switch form-switch-sm form-check-custom form-check-solid">
                                    <input class="form-check-input update-role-permission" type="checkbox" data-role-permission-id="' . $rolePermissionId . '" data-access-type="delete" ' . $deleteAccessChecked . ' '. $disabled .' />
                                </div>';

            $importAccessButton = '<div class="form-check form-switch form-switch-sm form-check-custom form-check-solid">
                                    <input class="form-check-input update-role-permission" type="checkbox" data-role-permission-id="' . $rolePermissionId . '" data-access-type="import" ' . $importAccessChecked . ' '. $disabled .' />
                                </div>';

            $exportAccessButton = '<div class="form-check form-switch form-switch-sm form-check-custom form-check-solid">
                                    <input class="form-check-input update-role-permission" type="checkbox" data-role-permission-id="' . $rolePermissionId . '" data-access-type="export" ' . $exportAccessChecked . ' '. $disabled .' />
                                </div>';

            $logNotesAccessButton = '<div class="form-check form-switch form-switch-sm form-check-custom form-check-solid">
                                    <input class="form-check-input update-role-permission" type="checkbox" data-role-permission-id="' . $rolePermissionId . '" data-access-type="log notes" ' . $logNotesAccessChecked . ' '. $disabled .' />
                                </div>';

            $response[] = [
                'ROLE_NAME'         => $roleName,
                'READ_ACCESS'       => $readAccessButton,
                'WRITE_ACCESS'      => $writeAccessButton,
                'CREATE_ACCESS'     => $createAccessButton,
                'DELETE_ACCESS'     => $deleteAccessButton,
                'IMPORT_ACCESS'     => $importAccessButton,
                'EXPORT_ACCESS'     => $exportAccessButton,
                'LOG_NOTES_ACCESS'  => $logNotesAccessButton,
                'ACTION'            => '<div class="d-flex justify-content-end gap-3">
                                            '. $logNotes .'
                                            '. $deleteButton .'
                                        </div>'
            ];
        }

        echo json_encode($response);
    }

    public function generateShopOptions() {
        $multiple       = $_POST['multiple'] ?? false;
        $shopId     = $_POST['shop_id'] ?? null;
        $response       = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $shops = $this->shop->generateShopOptions($shopId);

        foreach ($shops as $row) {
            $response[] = [
                'id'    => $row['shop_id'],
                'text'  => $row['shop_name']
            ];
        }

        echo json_encode($response);
    }

    public function generateShopRoleDualListBoxOptions() {
        $shopId     = $_POST['shop_id'] ?? null;
        $response       = [];
        $shops      = $this->shop->generateShopRoleDualListBoxOptions($shopId);

        foreach ($shops as $row) {
            $response[] = [
                'id'    => $row['role_id'],
                'text'  => $row['role_name']
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

$controller = new ShopController(
    new Shop(),
    new Company(),
    new ShopType(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();