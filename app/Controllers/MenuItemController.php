<?php
namespace App\Controllers;

session_start();

use App\Models\MenuItem;
use App\Models\AppModule;
use App\Models\Role;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';
class MenuItemController {
    protected MenuItem $menuItem;
    protected AppModule $appModule;
    protected Role $role;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        MenuItem $menuItem,
        AppModule $appModule,
        Role $role,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->menuItem         = $menuItem;
        $this->appModule        = $appModule;
        $this->role             = $role;
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
            'save menu item'                                => $this->saveMenuItem($lastLogBy),
            'save menu item role permission'                => $this->saveMenuItemRolePermission($lastLogBy),
            'update menu item role permission'              => $this->updateMenuItemRolePermission($lastLogBy),
            'delete menu item'                              => $this->deleteMenuItem(),
            'delete multiple menu item'                     => $this->deleteMultipleMenuItem(),
            'delete menu item role permission'              => $this->deleteMenuItemRolePermission(),
            'fetch menu item details'                       => $this->fetchMenuItemDetails(),
            'generate menu item table'                      => $this->generateMenuItemTable(),
            'generate menu item assigned role table'        => $this->generateMenuItemAssignedRoleTable($lastLogBy, $pageId),
            'generate menu item options'                    => $this->generateMenuItemOptions(),
            'generate menu item role dual listbox options'  => $this->generateMenuItemRoleDualListBoxOptions(),
            default                                         => $this->systemHelper::sendErrorResponse(
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

    public function saveMenuItem(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'menu_item_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $menuItemId     = $_POST['menu_item_id'] ?? null;
        $menuItemName   = $_POST['menu_item_name'] ?? null;
        $appModuleId    = $_POST['app_module_id'] ?? null;
        $orderSequence  = $_POST['order_sequence'] ?? null;
        $parentId       = $_POST['parent_id'] ?? null;
        $menuItemIcon   = $_POST['menu_item_icon'] ?? null;
        $menuItemUrl    = $_POST['menu_item_url'] ?? null;
        $tableName      = $_POST['table_name'] ?? null;

        $appModuleDetails   = $this->appModule->fetchAppModule($appModuleId);
        $appModuleName      = $appModuleDetails['app_module_name'] ?? '';

        $parentDetails  = $this->menuItem->fetchMenuItem($parentId);
        $parentName     = $parentDetails['menu_item_name'] ?? '';

        $menuItemId = $this->menuItem->saveMenuItem(
            $menuItemId,
            $menuItemName,
            $menuItemUrl,
            $menuItemIcon,
            $appModuleId,
            $appModuleName,
            $parentId,
            $parentName,
            $tableName,
            $orderSequence,
            $lastLogBy
        );
        
        $encryptedmenuItemId = $this->security->encryptData($menuItemId);

        $this->systemHelper::sendSuccessResponse(
            'Save Menu Item Success',
            'The menu item has been saved successfully.',
            ['menu_item_id' => $encryptedmenuItemId]
        );
    }

    public function saveMenuItemRolePermission(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'role_permission_assignment_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $menuItemId     = $_POST['menu_item_id'] ?? null;
        $roleIds        = $_POST['role_id'] ?? null;

        if(empty($roleIds)){
            $this->systemHelper::sendErrorResponse(
                'Assign Role Error',
                'Please select the role(s) you wish to assign to the menu item.'
            );
        }

        $menuItemDetails    = $this->menuItem->fetchMenuItem($menuItemId);
        $menuItemName       = $menuItemDetails['menu_item_name'] ?? '';

        foreach ($roleIds as $roleId) {
            $roleDetails    = $this->role->fetchRole($roleId);
            $roleName       = $roleDetails['role_name'] ?? null;

            $this->role->insertRolePermission(
                $roleId,
                $roleName,
                $menuItemId,
                $menuItemName,
                $lastLogBy
            );
        }

        $this->systemHelper::sendSuccessResponse(
            'Assign Role Success',
            'The role has been assigned successfully.'
        );
    }

    public function updateMenuItemRolePermission(
        int $lastLogBy
    ) {
        $rolePermissionId   = $_POST['role_permission_id'] ?? null;
        $accessType         = $_POST['access_type'] ?? null;
        $access             = $_POST['access'] ?? null;

        $checkMenuItemRolePermissionExist   = $this->role->checkRolePermissionExist($rolePermissionId);
        $total                              = $checkMenuItemRolePermissionExist['total'] ?? 0;

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

    public function deleteMenuItem() {
        $menuItemId = $_POST['menu_item_id'] ?? null;

        $this->menuItem->deleteMenuItem($menuItemId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Menu Item Success',
            'The menu item has been deleted successfully.'
        );
    }

    public function deleteMultipleMenuItem() {
        $menuItemIds = $_POST['menu_item_id'] ?? null;

        foreach($menuItemIds as $menuItemId){
            $this->menuItem->deleteMenuItem($menuItemId);
        }

        $this->systemHelper::sendSuccessResponse(
            'Delete Multiple Menu Items Success',
            'The selected menu items have been deleted successfully.'
        );
    }

    public function deleteMenuItemRolePermission() {
        $rolePermissionId = $_POST['role_permission_id'] ?? null;

        $this->role->deleteRolePermission($rolePermissionId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Role Permission Success',
            'The role permission has been deleted successfully.'
        );
    }

    public function fetchMenuItemDetails() {
        $menuItemId             = $_POST['menu_item_id'] ?? null;
        $checkMenuItemExist     = $this->menuItem->checkMenuItemExist($menuItemId);
        $total                  = $checkMenuItemExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get Menu Item Details',
                'The menu item does not exist'
            );
        }

        $menuItemDetails   = $this->menuItem->fetchMenuItem($menuItemId);
        $parentId          = $menuItemDetails['parent_id'] == 0 ? '' : $menuItemDetails['parent_id'];

        $response = [
            'success'           => true,
            'menuItemName'      => $menuItemDetails['menu_item_name'] ?? null,
            'menuItemURL'       => $menuItemDetails['menu_item_url'] ?? null,
            'menuItemIcon'      => $menuItemDetails['menu_item_icon'] ?? null,
            'appModuleID'       => $menuItemDetails['app_module_id'] ?? null,
            'parentID'          => $parentId,
            'tableName'         => $menuItemDetails['table_name'] ?? null,
            'orderSequence'     => $menuItemDetails['order_sequence'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function generateMenuItemTable() {
        $filterAppModule    = $this->systemHelper->checkFilter($_POST['app_module_filter'] ?? null);
        $filterParentId     = $this->systemHelper->checkFilter($_POST['parent_id_filter'] ?? null);
        $pageLink           = $_POST['page_link'] ?? null;
        $response           = [];

        $menuItems = $this->menuItem->generateMenuItemTable(
            $filterAppModule,
            $filterParentId
        );

        foreach ($menuItems as $row) {
            $menuItemId     = $row['menu_item_id'];
            $menuItemName   = $row['menu_item_name'];
            $appModuleName  = $row['app_module_name'];
            $parentName     = !empty($row['parent_name']) ? $row['parent_name'] : '-';
            $orderSequence  = $row['order_sequence'];

            $menuItemIdEncrypted = $this->security->encryptData($menuItemId);

            $response[] = [
                'CHECK_BOX'         => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                            <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $menuItemId .'">
                                        </div>',
                'MENU_ITEM_NAME'    => $menuItemName,
                'APP_MODULE_NAME'   => $appModuleName,
                'PARENT_NAME'       => $parentName,
                'ORDER_SEQUENCE'    => $orderSequence,
                'LINK'              => $pageLink .'&id='. $menuItemIdEncrypted
            ];
        }

        echo json_encode($response);
    }

    public function generateMenuItemAssignedRoleTable(
        int $userId,
        int $pageId
    ) {
        $menuItemId     = $_POST['menu_item_id'] ?? null;
        $response       = [];

        $updateRoleAccess   = $this->authentication->checkUserSystemActionPermission($userId, 6)['total'] ?? 0;
        $deleteRoleAccess   = $this->authentication->checkUserSystemActionPermission($userId, 7)['total'] ?? 0;
        $logNotesAccess     = $this->authentication->checkUserPermission($userId, $pageId, 'log notes')['total'] ?? 0;
        $disabled           = ($updateRoleAccess == 0) ? 'disabled' : '';
        
        $menuItems = $this->menuItem->generateMenuItemAssignedRoleTable($menuItemId);

        foreach ($menuItems as $row) {
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

    public function generateMenuItemOptions() {
        $multiple       = $_POST['multiple'] ?? false;
        $menuItemId     = $_POST['menu_item_id'] ?? null;
        $response       = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $menuItems = $this->menuItem->generateMenuItemOptions($menuItemId);

        foreach ($menuItems as $row) {
            $response[] = [
                'id'    => $row['menu_item_id'],
                'text'  => $row['menu_item_name']
            ];
        }

        echo json_encode($response);
    }

    public function generateMenuItemRoleDualListBoxOptions() {
        $menuItemId     = $_POST['menu_item_id'] ?? null;
        $response       = [];
        $menuItems      = $this->menuItem->generateMenuItemRoleDualListBoxOptions($menuItemId);

        foreach ($menuItems as $row) {
            $response[] = [
                'id'    => $row['role_id'],
                'text'  => $row['role_name']
            ];
        }

        echo json_encode($response);
    }
}

$controller = new MenuItemController(
    new MenuItem(),
    new AppModule(),
    new Role(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();