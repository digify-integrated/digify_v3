<?php
namespace App\Controllers;

session_start();

use App\Models\SystemAction;
use App\Models\Role;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class SystemActionController {
    protected SystemAction $systemAction;
    protected Role $role;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        SystemAction $systemAction,
        Role $role,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->systemAction     = $systemAction;
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
            'save system action'                                => $this->saveSystemAction($lastLogBy),
            'save system action role permission'                => $this->saveSystemActionRolePermission($lastLogBy),
            'update system action role permission'              => $this->updateSystemActionRolePermission($lastLogBy),
            'delete system action'                              => $this->deleteSystemAction(),
            'delete multiple system action'                     => $this->deleteMultipleSystemAction(),
            'delete system action role permission'              => $this->deleteSystemActionRolePermission(),
            'fetch system action details'                       => $this->fetchSystemActionDetails(),
            'generate system action table'                      => $this->generateSystemActionTable(),
            'generate system action assigned role table'        => $this->generateSystemActionAssignedRoleTable($lastLogBy, $pageId),
            'generate system action options'                    => $this->generateSystemActionOptions(),
            'generate system action role dual listbox options'  => $this->generateSystemActionRoleDualListBoxOptions(),
            default                                             => $this->systemHelper::sendErrorResponse(
                                                                        'Transaction Failed',
                                                                        'We encountered an issue while processing your request.'
                                                                    )
        };
    }

    /* =============================================================================================
        SECTION 1: SAVE METHOD
    ============================================================================================= */

    public function saveSystemAction(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'system_action_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $systemActionId             = $_POST['system_action_id'] ?? null;
        $systemActionName           = $_POST['system_action_name'] ?? null;
        $systemActionDescription    = $_POST['system_action_description'] ?? null;

        $systemActionId = $this->systemAction->saveSystemAction(
            $systemActionId,
            $systemActionName,
            $systemActionDescription,
            $lastLogBy
        );
        
        $encryptedSystemActionId = $this->security->encryptData($systemActionId);

        $this->systemHelper::sendSuccessResponse(
            'Save System Action Success',
            'The system action has been saved successfully.',
            ['system_action_id' => $encryptedSystemActionId]
        );
    }

    public function saveSystemActionRolePermission(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'role_permission_assignment_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $systemActionId     = $_POST['system_action_id'] ?? null;
        $roleIds            = $_POST['role_id'] ?? null;

        if(empty($roleIds)){
            $this->systemHelper::sendErrorResponse(
                'Assign Role Error',
                'Please select the role(s) you wish to assign to the system action.'
            );
        }

        $systemActionDetails    = $this->systemAction->fetchSystemAction($systemActionId);
        $systemActionName       = $systemActionDetails['system_action_name'] ?? '';

        foreach ($roleIds as $roleId) {
            $roleDetails    = $this->role->fetchRole($roleId);
            $roleName       = $roleDetails['role_name'] ?? null;

            $this->role->insertRoleSystemActionPermission(
                $roleId,
                $roleName,
                $systemActionId,
                $systemActionName,
                $lastLogBy
            );
        }

        $this->systemHelper::sendSuccessResponse(
            'Assign Role Success',
            'The role has been assigned successfully.'
        );
    }

    /* =============================================================================================
        SECTION 2: INSERT METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 3: UPDATE METHOD
    ============================================================================================= */

    public function updateSystemActionRolePermission(
        int $lastLogBy
    ) {
        $rolePermissionId   = $_POST['role_permission_id'] ?? null;
        $access             = $_POST['access'] ?? null;

        $checkSystemActionRolePermissionExist   = $this->role->checkRoleSystemActionPermissionExist($rolePermissionId);
        $total                                  = $checkSystemActionRolePermissionExist['total'] ?? 0;

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

    /* =============================================================================================
        SECTION 4: FETCH METHOD
    ============================================================================================= */

    public function fetchSystemActionDetails() {
        $systemActionId             = $_POST['system_action_id'] ?? null;
        $checkSystemActionExist     = $this->systemAction->checkSystemActionExist($systemActionId);
        $total                      = $checkSystemActionExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get System Action Details',
                'The system action does not exist',
                ['notExist' => true]
            );
        }

        $systemActionDetails = $this->systemAction->fetchSystemAction($systemActionId);

        $response = [
            'success'                   => true,
            'systemActionName'          => $systemActionDetails['system_action_name'] ?? null,
            'systemActionDescription'   => $systemActionDetails['system_action_description'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    /* =============================================================================================
        SECTION 5: DELETE METHOD
    ============================================================================================= */

    public function deleteSystemAction() {
        $systemActionId = $_POST['system_action_id'] ?? null;

        $this->systemAction->deleteSystemAction($systemActionId);

        $this->systemHelper::sendSuccessResponse(
            'Delete System Action Success',
            'The system action has been deleted successfully.'
        );
    }

    public function deleteMultipleSystemAction() {
        $systemActionIds = $_POST['system_action_id'] ?? null;

        foreach($systemActionIds as $systemActionId){
            $this->systemAction->deleteSystemAction($systemActionId);
        }

        $this->systemHelper::sendSuccessResponse(
            'Delete Multiple System Actions Success',
            'The selected system actions have been deleted successfully.'
        );
    }

    public function deleteSystemActionRolePermission() {
        $rolePermissionId = $_POST['role_permission_id'] ?? null;

        $this->role->deleteRoleSystemActionPermission($rolePermissionId);

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

    public function generateSystemActionTable() {
        $pageLink   = $_POST['page_link'] ?? null;
        $response   = [];

        $systemActions = $this->systemAction->generateSystemActionTable();

        foreach ($systemActions as $row) {
            $systemActionId             = $row['system_action_id'];
            $systemActionName           = $row['system_action_name'];
            $systemActionDescription    = $row['system_action_description'];

            $systemActionIdEncrypted = $this->security->encryptData($systemActionId);

            $response[] = [
                'CHECK_BOX'             => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                                <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $systemActionId .'">
                                            </div>',
                'SYSTEM_ACTION_NAME'    => '<div class="d-flex flex-column">
                                                <div class="fs-5 text-gray-900 fw-bold">'. $systemActionName .'</div>
                                                <div class="fs-7 text-gray-500">'. $systemActionDescription .'</div>
                                            </div>',
                'LINK'                  => $pageLink .'&id='. $systemActionIdEncrypted
            ];
        }

        echo json_encode($response);
    }

    public function generateSystemActionAssignedRoleTable(
        int $userId,
        int $pageId
    ) {
        $systemActionId     = $_POST['system_action_id'] ?? null;
        $response           = [];

        $updateRoleSystemActionAccess   = $this->authentication->checkUserSystemActionPermission($userId, 9)['total'] ?? 0;
        $deleteRoleSystemActionAccess   = $this->authentication->checkUserSystemActionPermission($userId, 10)['total'] ?? 0;
        $logNotesAccess                 = $this->authentication->checkUserPermission($userId, $pageId, 'log notes')['total'] ?? 0;
        $disabled                       = ($updateRoleSystemActionAccess == 0) ? 'disabled' : '';

        $systemActions = $this->systemAction->generateSystemActionAssignedRoleTable($systemActionId);

        foreach ($systemActions as $row) {
            $roleSystemActionPermissionId   = $row['role_system_action_permission_id'];
            $roleName                       = $row['role_name'];
            $roleAccess                     = $row['system_action_access'];

            $roleAccessChecked = $roleAccess ? 'checked' : '';

            $deleteButton = '';
            if($deleteRoleSystemActionAccess > 0){
                $deleteButton = '<button class="btn btn-icon btn-light btn-active-light-danger delete-role-permission" data-role-permission-id="' . $roleSystemActionPermissionId . '" title="Delete Role Permission">
                                        <i class="ki-outline ki-trash fs-3 m-0 fs-5"></i>
                                    </button>';
            }

            $logNotes = '';
            if($logNotesAccess > 0){
                $logNotes = '<button class="btn btn-icon btn-light btn-active-light-primary view-role-permission-log-notes" data-role-permission-id="' . $roleSystemActionPermissionId . '" data-bs-toggle="modal" data-bs-target="#log-notes-modal" title="View Log Notes">
                                    <i class="ki-outline ki-shield-search fs-3 m-0 fs-5"></i>
                                </button>';
            }

            $roleAccessButton = '<div class="form-check form-switch form-switch-sm form-check-custom form-check-solid">
                                        <input class="form-check-input update-role-permission" type="checkbox" data-role-permission-id="' . $roleSystemActionPermissionId . '" ' . $roleAccessChecked . ' '. $disabled .' />
                                    </div>';

            $response[] = [
                'ROLE_NAME'     => $roleName,
                'ACCESS'        => $roleAccessButton,
                'ACTION'        => '<div class="d-flex justify-content-end gap-3">
                                        '. $logNotes .'
                                        '. $deleteButton .'
                                    </div>'
            ];
        }

        echo json_encode($response);
    }

    public function generateSystemActionOptions() {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $systemActions = $this->systemAction->generateSystemActionOptions();

        foreach ($systemActions as $row) {
            $response[] = [
                'id'    => $row['system_action_id'],
                'text'  => $row['system_action_name']
            ];
        }

        echo json_encode($response);
    }

    public function generateSystemActionRoleDualListBoxOptions() {
        $systemActionId     = $_POST['system_action_id'] ?? null;
        $response           = [];
        $systemActions      = $this->systemAction->generateSystemActionRoleDualListBoxOptions($systemActionId);

        foreach ($systemActions as $row) {
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

$controller = new SystemActionController(
    new SystemAction(),
    new Role(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();