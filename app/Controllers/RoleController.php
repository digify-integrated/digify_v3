<?php
namespace App\Controllers;

session_start();

use App\Models\Role;
use App\Models\MenuItem;
use App\Models\SystemAction;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class RoleController {
    protected Role $role;
    protected MenuItem $menuItem;
    protected SystemAction $systemAction;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        Role $role,
        MenuItem $menuItem,
        SystemAction $systemAction,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->role             = $role;
        $this->menuItem         = $menuItem;
        $this->systemAction     = $systemAction;
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
            'save role'                                         => $this->saveRole($lastLogBy),
            'save role menu item permission'                    => $this->saveRoleMenuItemPermission($lastLogBy),
            'update role menu item permission'                  => $this->updateRoleMenuItemPermission($lastLogBy),
            'save role system action permission'                => $this->saveRoleSystemActionPermission($lastLogBy),
            'update role system action permission'              => $this->updateRoleSystemActionPermission($lastLogBy),
            'delete role'                                       => $this->deleteRole(),
            'delete multiple role'                              => $this->deleteMultipleRole(),
            'delete role menu item permission'                  => $this->deleteRoleMenuItemPermission(),
            'delete role system action permission'              => $this->deleteRoleSystemActionPermission(),
            'fetch role details'                                => $this->fetchRoleDetails(),
            'generate role table'                               => $this->generateRoleTable(),
            'generate role assigned menu item table'            => $this->generateRoleAssignedMenuItemTable($lastLogBy, $pageId),
            'generate role assigned system action table'        => $this->generateRoleAssignedSystemActionTable($lastLogBy, $pageId),
            'generate role menu item dual listbox options'      => $this->generateRoleMenuItemDualListBoxOptions(),
            'generate role system action dual listbox options'  => $this->generateRoleSystemActionDualListBoxOptions(),
            default                                             => $this->systemHelper::sendErrorResponse(
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

    public function saveRole(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'role_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $roleId             = $_POST['role_id'] ?? null;
        $roleName           = $_POST['role_name'] ?? null;
        $roleDescription    = $_POST['role_description'] ?? null;

        $roleId = $this->role->saveRole(
            $roleId,
            $roleName,
            $roleDescription,
            $lastLogBy
        );
        
        $encryptedRoleId = $this->security->encryptData($roleId);

        $this->systemHelper::sendSuccessResponse(
            'Save Role Success',
            'The role has been saved successfully.',
            ['role_id' => $encryptedRoleId]
        );
    }

    public function saveRoleMenuItemPermission(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'menu_item_permission_assignment_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $roleId         = $_POST['role_id'] ?? null;
        $menuItemIds    = $_POST['menu_item_id'] ?? null;

        if(empty($menuItemIds)){
            $this->systemHelper::sendErrorResponse(
                'Assign Menu Item Error',
                'Please select the menu item(s) you wish to assign to the role.'
            );
        }
        
        $roleDetails    = $this->role->fetchRole($roleId);
        $roleName       = $roleDetails['role_name'] ?? null;

        foreach ($menuItemIds as $menuItemId) {            
            $menuItemDetails    = $this->menuItem->fetchMenuItem($menuItemId);
            $menuItemName       = $menuItemDetails['menu_item_name'] ?? '';

            $this->role->insertRolePermission(
                $roleId,
                $roleName,
                $menuItemId,
                $menuItemName,
                $lastLogBy
            );
        }

        $this->systemHelper::sendSuccessResponse(
            'Assign Menu Item Success',
            'The menu item has been assigned successfully.'
        );
    }

    public function saveRoleSystemActionPermission(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'system_action_permission_assignment_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $roleId             = $_POST['role_id'] ?? null;
        $systemActionIds    = $_POST['system_action_id'] ?? null;

        if(empty($systemActionIds)){
            $this->systemHelper::sendErrorResponse(
                'Assign System Action Error',
                'Please select the system action(s) you wish to assign to the role.'
            );
        }
        
        $roleDetails    = $this->role->fetchRole($roleId);
        $roleName       = $roleDetails['role_name'] ?? null;

        foreach ($systemActionIds as $systemActionId) {
            $systemActionDetails    = $this->systemAction->fetchSystemAction($systemActionId);
            $systemActionName       = $systemActionDetails['system_action_name'] ?? '';

            $this->role->insertRoleSystemActionPermission(
                $roleId,
                $roleName,
                $systemActionId,
                $systemActionName,
                $lastLogBy
            );
        }

        $this->systemHelper::sendSuccessResponse(
            'Assign System Action Success',
            'The system action has been assigned successfully.'
        );
    }

    public function updateRoleMenuItemPermission(
        int $lastLogBy
    ) {
        $rolePermissionId   = $_POST['role_permission_id'] ?? null;
        $accessType         = $_POST['access_type'] ?? null;
        $access             = $_POST['access'] ?? null;

        $checkRoleMenuItemPermissionExist   = $this->role->checkRolePermissionExist($rolePermissionId);
        $total                              = $checkRoleMenuItemPermissionExist['total'] ?? 0;

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

    public function updateRoleSystemActionPermission(
        int $lastLogBy
    ) {
        $rolePermissionId   = $_POST['role_permission_id'] ?? null;
        $access             = $_POST['access'] ?? null;

        $checkRoleSystemActionPermissionExist   = $this->role->checkRoleSystemActionPermissionExist($rolePermissionId);
        $total                                  = $checkRoleSystemActionPermissionExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Update Role Permission Error',
                'The role permission does not exist.'
            );
        }

        $this->role->updateRoleSystemActionPermission(
            $rolePermissionId,
            $access,
            $lastLogBy
        );
        
        $this->systemHelper::sendSuccessResponse(
            'Update Role Permission Success',
            'The role permission has been updated successfully.'
        );
    }

    public function deleteRole() {
        $roleId = $_POST['role_id'] ?? null;

        $this->role->deleteRole($roleId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Role Success',
            'The role has been deleted successfully.'
        );
    }

    public function deleteMultipleRole() {
        $roleIds = $_POST['role_id'] ?? null;

        foreach($roleIds as $roleId){
            $this->role->deleteRole($roleId);
        }

        $this->systemHelper::sendSuccessResponse(
            'Delete Multiple Roles Success',
            'The selected roles have been deleted successfully.'
        );
    }
    
    public function deleteRoleMenuItemPermission() {
        $rolePermissionId = $_POST['role_permission_id'] ?? null;

        $this->role->deleteRolePermission($rolePermissionId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Role Permission Success',
            'The role permission has been deleted successfully.'
        );
    }

    public function deleteRoleSystemActionPermission() {
        $rolePermissionId = $_POST['role_permission_id'] ?? null;

        $this->role->deleteRoleSystemActionPermission($rolePermissionId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Role Permission Success',
            'The role permission has been deleted successfully.'
        );
    }

    public function fetchRoleDetails() {
        $roleId             = $_POST['role_id'] ?? null;
        $checkRoleExist     = $this->role->checkRoleExist($roleId);
        $total              = $checkRoleExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get Role Details',
                'The role does not exist',
                ['notExist' => true]
            );
        }

        $roleDetails = $this->role->fetchRole($roleId);

        $response = [
            'success'           => true,
            'roleName'          => $roleDetails['role_name'] ?? null,
            'roleDescription'   => $roleDetails['role_description'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    public function generateRoleTable() {
        $pageLink   = $_POST['page_link'] ?? '';
        $response   = [];

        $roles = $this->role->generateRoleTable();

        foreach ($roles as $row) {
            $roleId             = $row['role_id'];
            $roleName           = $row['role_name'];
            $roleDescription    = $row['role_description'];

            $roleIdEncrypted = $this->security->encryptData($roleId);

            $response[] = [
                'CHECK_BOX'     => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                        <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $roleId .'">
                                    </div>',
                'ROLE_NAME'     => '<div class="d-flex flex-column">
                                        <a href="#" class="fs-5 text-gray-900 fw-bold">'. $roleName .'</a>
                                        <div class="fs-7 text-gray-500">'. $roleDescription .'</div>
                                    </div>',
                'LINK'          => $pageLink .'&id='. $roleIdEncrypted
            ];
        }

        echo json_encode($response);
    }

    public function generateRoleAssignedMenuItemTable(
        int $userId,
        int $pageId
    ) {
        $roleId     = $_POST['role_id'] ?? null;
        $response   = [];

        $updateRoleAccess   = $this->authentication->checkUserSystemActionPermission($userId, 6)['total'] ?? 0;
        $deleteRoleAccess   = $this->authentication->checkUserSystemActionPermission($userId, 7)['total'] ?? 0;
        $logNotesAccess     = $this->authentication->checkUserPermission($userId, $pageId, 'log notes')['total'] ?? 0;
        $disabled           = ($updateRoleAccess == 0) ? 'disabled' : '';
        
        $menuItems = $this->role->generateRoleAssignedMenuItemTable($roleId);

        foreach ($menuItems as $row) {
            $rolePermissionId       = $row['role_permission_id'];
            $menuItemName           = $row['menu_item_name'];
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
                $deleteButton = '<button class="btn btn-icon btn-light btn-active-light-danger delete-menu-item-permission" data-role-permission-id="' . $rolePermissionId . '" title="Delete Role Permission">
                                    <i class="ki-outline ki-trash fs-3 m-0 fs-5"></i>
                                </button>';
            }

            $logNotes = '';
            if($logNotesAccess > 0){
                $logNotes = '<button class="btn btn-icon btn-light btn-active-light-primary view-menu-item-permission-log-notes" data-role-permission-id="' . $rolePermissionId . '" data-bs-toggle="modal" data-bs-target="#log-notes-modal" title="View Log Notes">
                                <i class="ki-outline ki-shield-search fs-3 m-0 fs-5"></i>
                            </button>';
            }

            $readAccessButton = '<div class="form-check form-switch form-switch-sm form-check-custom form-check-solid">
                                    <input class="form-check-input update-menu-item-permission" type="checkbox" data-role-permission-id="' . $rolePermissionId . '" data-access-type="read" ' . $readAccessChecked . ' '. $disabled .' />
                                </div>';

            $writeAccessButton = '<div class="form-check form-switch form-switch-sm form-check-custom form-check-solid">
                                    <input class="form-check-input update-menu-item-permission" type="checkbox" data-role-permission-id="' . $rolePermissionId . '" data-access-type="write" ' . $writeAccessChecked . ' '. $disabled .' />
                                </div>';

            $createAccessButton = '<div class="form-check form-switch form-switch-sm form-check-custom form-check-solid">
                                    <input class="form-check-input update-menu-item-permission" type="checkbox" data-role-permission-id="' . $rolePermissionId . '" data-access-type="create" ' . $createAccessChecked . ' '. $disabled .' />
                                </div>';

            $deleteAccessButton = '<div class="form-check form-switch form-switch-sm form-check-custom form-check-solid">
                                    <input class="form-check-input update-menu-item-permission" type="checkbox" data-role-permission-id="' . $rolePermissionId . '" data-access-type="delete" ' . $deleteAccessChecked . ' '. $disabled .' />
                                </div>';

            $importAccessButton = '<div class="form-check form-switch form-switch-sm form-check-custom form-check-solid">
                                    <input class="form-check-input update-menu-item-permission" type="checkbox" data-role-permission-id="' . $rolePermissionId . '" data-access-type="import" ' . $importAccessChecked . ' '. $disabled .' />
                                </div>';

            $exportAccessButton = '<div class="form-check form-switch form-switch-sm form-check-custom form-check-solid">
                                    <input class="form-check-input update-menu-item-permission" type="checkbox" data-role-permission-id="' . $rolePermissionId . '" data-access-type="export" ' . $exportAccessChecked . ' '. $disabled .' />
                                </div>';

            $logNotesAccessButton = '<div class="form-check form-switch form-switch-sm form-check-custom form-check-solid">
                                    <input class="form-check-input update-menu-item-permission" type="checkbox" data-role-permission-id="' . $rolePermissionId . '" data-access-type="log notes" ' . $logNotesAccessChecked . ' '. $disabled .' />
                                </div>';

            $response[] = [
                'MENU_ITEM_NAME'    => $menuItemName,
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

    public function generateRoleAssignedSystemActionTable(
        int $userId,
        int $pageId
    ) {
        $roleId     = $_POST['role_id'] ?? null;
        $response   = [];

        $updateRoleSystemActionAccess   = $this->authentication->checkUserSystemActionPermission($userId, 9)['total'] ?? 0;
        $deleteRoleSystemActionAccess   = $this->authentication->checkUserSystemActionPermission($userId, 10)['total'] ?? 0;
        $logNotesAccess                 = $this->authentication->checkUserPermission($userId, $pageId, 'log notes')['total'] ?? 0;
        $disabled                       = ($updateRoleSystemActionAccess == 0) ? 'disabled' : '';
        $deleteButton                   = '';
        $logNotes                       = '';

        $systemActions = $this->role->generateRoleAssignedSystemActionTable($roleId);

        foreach ($systemActions as $row) {
            $roleSystemActionPermissionId   = $row['role_system_action_permission_id'];
            $systemActionName               = $row['system_action_name'];
            $roleAccess                     = $row['system_action_access'];

            $roleAccessChecked = $roleAccess ? 'checked' : '';

            if($deleteRoleSystemActionAccess > 0){
                $deleteButton = '<button class="btn btn-icon btn-light btn-active-light-danger delete-system-action-permission" data-role-permission-id="' . $roleSystemActionPermissionId . '" title="Delete Role Permission">
                                        <i class="ki-outline ki-trash fs-3 m-0 fs-5"></i>
                                    </button>';
            }

            if($logNotesAccess > 0){
                $logNotes = '<button class="btn btn-icon btn-light btn-active-light-primary view-system-action-permission-log-notes" data-role-permission-id="' . $roleSystemActionPermissionId . '" data-bs-toggle="modal" data-bs-target="#log-notes-modal" title="View Log Notes">
                                    <i class="ki-outline ki-shield-search fs-3 m-0 fs-5"></i>
                                </button>';
            }

            $roleAccessButton = '<div class="form-check form-switch form-switch-sm form-check-custom form-check-solid">
                                        <input class="form-check-input update-system-action-permission" type="checkbox" data-role-permission-id="' . $roleSystemActionPermissionId . '" ' . $roleAccessChecked . ' '. $disabled .' />
                                    </div>';

            $response[] = [
                'SYSTEM_ACTION_NAME'    => $systemActionName,
                'ACCESS'                => $roleAccessButton,
                'ACTION'                => '<div class="d-flex justify-content-end gap-3">
                                                '. $logNotes .'
                                                '. $deleteButton .'
                                            </div>'
            ];
        }

        echo json_encode($response);
    }

    public function generateRoleMenuItemDualListBoxOptions() {
        $roleId     = $_POST['role_id'] ?? null;
        $response   = [];
        $menuItems  = $this->role->generateRoleMenuItemDualListBoxOptions($roleId);

        foreach ($menuItems as $row) {
            $response[] = [
                'id'    => $row['menu_item_id'],
                'text'  => $row['menu_item_name']
            ];
        }

        echo json_encode($response);
    }

    public function generateRoleSystemActionDualListBoxOptions() {
        $roleId         = $_POST['role_id'] ?? null;
        $response       = [];
        $systemActions  = $this->role->generateRoleSystemActionDualListBoxOptions($roleId);

        foreach ($systemActions as $row) {
            $response[] = [
                'id'    => $row['system_action_id'],
                'text'  => $row['system_action_name']
            ];
        }

        echo json_encode($response);
    }
}

$controller = new RoleController(
    new Role(),
    new MenuItem(),
    new SystemAction(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();