<?php
namespace App\Controllers;

session_start();

use App\Models\Department;
use App\Models\Employee;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class DepartmentController {
    protected Department $department;
    protected Employee $employee;
    protected Authentication $authentication;
    protected Security $security;
    protected SystemHelper $systemHelper;

    public function __construct(
        Department $department,
        Employee $employee,
        Authentication $authentication,
        Security $security,
        SystemHelper $systemHelper
    ) {
        $this->department       = $department;
        $this->employee         = $employee;
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
            'save department'                       => $this->saveDepartment($lastLogBy),
            'delete department'                     => $this->deleteDepartment(),
            'delete multiple department'            => $this->deleteMultipleDepartment(),
            'fetch department details'              => $this->fetchDepartmentDetails(),
            'generate department table'             => $this->generateDepartmentTable(),
            'generate department options'           => $this->generateDepartmentOptions(),
            'generate parent department options'    => $this->generateParentDepartmentOptions(),
            default                                 => $this->systemHelper::sendErrorResponse(
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

    public function saveDepartment(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'department_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $departmentId           = $_POST['department_id'] ?? null;
        $departmentName         = $_POST['department_name'] ?? null;
        $parentDepartmentId     = $_POST['parent_department_id'] ?? '';
        $managerId              = $_POST['manager_id'] ?? '';

        $parentDepartmentDetails    = $this->department->fetchDepartment($parentDepartmentId);
        $parentDepartmentName       = $parentDepartmentDetails['department_name'] ?? '';

        $managerDetails     = $this->employee->fetchEmployee(p_employee_id: $managerId);
        $managerName        = $managerDetails['full_name'] ?? '';

        $departmentId = $this->department->saveDepartment(
            $departmentId,
            $departmentName,
            $parentDepartmentId,
            $parentDepartmentName,
            $managerId,
            $managerName,
            $lastLogBy
        );
        
        $encryptedDepartmentId = $this->security->encryptData($departmentId);

        $this->systemHelper::sendSuccessResponse(
            'Save Department Success',
            'The department has been saved successfully.',
            ['department_id' => $encryptedDepartmentId]
        );
    }

    public function deleteDepartment() {
        $departmentId = $_POST['department_id'] ?? null;

        $this->department->deleteDepartment($departmentId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Department Success',
            'The department has been deleted successfully.'
        );
    }

    public function deleteMultipleDepartment() {
        $departmentIds = $_POST['department_id'] ?? null;

        foreach($departmentIds as $departmentId){
            $this->department->deleteDepartment($departmentId);
        }

        $this->systemHelper::sendSuccessResponse(
            'Delete Multiple Departments Success',
            'The selected departments have been deleted successfully.'
        );
    }

    public function fetchDepartmentDetails() {
        $departmentId           = $_POST['department_id'] ?? null;
        $checkDepartmentExist   = $this->department->checkDepartmentExist($departmentId);
        $total                  = $checkDepartmentExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get Department Details',
                'The department does not exist',
                ['notExist' => true]
            );
        }

        $departmentDetails = $this->department->fetchDepartment($departmentId);

        $response = [
            'success'               => true,
            'departmentName'        => $departmentDetails['department_name'] ?? null,
            'parentDepartmentId'    => $departmentDetails['parent_department_id'] ?? '',
            'managerId'             => $departmentDetails['manager_id'] ?? '',
        ];

        echo json_encode($response);
        exit;
    }

    public function generateDepartmentTable() {
        $filterParentDepartment     = $this->systemHelper->checkFilter($_POST['parent_department_filter'] ?? null);
        $filterManager              = $this->systemHelper->checkFilter($_POST['manager_filter'] ?? null);
        $pageLink                   = $_POST['page_link'] ?? null;
        $response                   = [];

        $departments = $this->department->generateDepartmentTable($filterParentDepartment, $filterManager);

        foreach ($departments as $row) {
            $departmentId           = $row['department_id'];
            $departmentName         = $row['department_name'];
            $parentDepartmentName   = $row['parent_department_name'];
            $managerName            = $row['manager_name'];

            $departmentIdEncrypted = $this->security->encryptData($departmentId);

            $response[] = [
                'CHECK_BOX'                 => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                                    <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $departmentId .'">
                                                </div>',
                'DEPARTMENT_NAME'           => $departmentName,
                'PARENT_DEPARTMENT_NAME'    => $parentDepartmentName,
                'MANAGER_NAME'              => $managerName,
                'LINK'                      => $pageLink .'&id='. $departmentIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateDepartmentOptions() {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $departments = $this->department->generateDepartmentOptions();

        foreach ($departments as $row) {
            $response[] = [
                'id'    => $row['department_id'],
                'text'  => $row['department_name']
            ];
        }

        echo json_encode($response);
    }

    
    public function generateParentDepartmentOptions() {
        $departmentID   = $_POST['department_id'] ?? null;
        $multiple       = $_POST['multiple'] ?? false;
        $response       = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $departments = $this->department->generateParentDepartmentOptions($departmentID);

        foreach ($departments as $row) {
            $response[] = [
                'id'    => $row['department_id'],
                'text'  => $row['department_name']
            ];
        }

        echo json_encode($response);
    }
}

$controller = new DepartmentController(
    new Department(),
    new Employee(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();