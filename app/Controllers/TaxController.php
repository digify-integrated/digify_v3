<?php
namespace App\Controllers;

session_start();

use App\Models\Tax;
use App\Models\Authentication;
use App\Core\Security;
use App\Helpers\SystemHelper;

require_once '../../config/config.php';

class TaxController {
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
            'save tax'                          => $this->saveTax($lastLogBy),
            'update tax archive'                => $this->updateTaxArchive($lastLogBy),
            'update tax unarchive'              => $this->updateTaxUnarchive($lastLogBy),
            'delete tax'                        => $this->deleteTax(),
            'delete multiple tax'               => $this->deleteMultipleTax(),
            'fetch tax details'                 => $this->fetchTaxDetails(),
            'generate tax table'                => $this->generateTaxTable(),
            'generate tax options'              => $this->generateTaxOptions(),
            'generate sales tax options'        => $this->generateSalesTaxOptions(),
            'generate purchase tax options'     => $this->generatePurchaseTaxOptions(),
            default                             => $this->systemHelper::sendErrorResponse(
                                                        'Transaction Failed',
                                                        'We encountered an issue while processing your request.'
                                                    )
        };
    }

    /* =============================================================================================
        SECTION 1: SAVE METHOD
    ============================================================================================= */

    public function saveTax(
        int $lastLogBy
    ) {
        $csrfToken = $_POST['csrf_token'] ?? null;

        if (!$csrfToken || !$this->security::validateCSRFToken($csrfToken, 'tax_form')) {
            $this->systemHelper::sendErrorResponse(
                'Invalid Request',
                'Security check failed. Please refresh and try again.'
            );
        }

        $taxId              = $_POST['tax_id'] ?? null;
        $taxName            = $_POST['tax_name'] ?? null;
        $taxComputation     = $_POST['tax_computation'] ?? 'Percentage';
        $taxRate            = $_POST['tax_rate'] ?? 0;
        $taxType            = $_POST['tax_type'] ?? 'Sales';
        $taxCcope           = $_POST['tax_scope'] ?? null;

        $taxId = $this->tax->saveTax(
            $taxId,
            $taxName,
            $taxRate,
            $taxType,
            $taxComputation,
            $taxCcope,
            $lastLogBy
        );

        $encryptedtaxId = $this->security->encryptData($taxId);

        $this->systemHelper::sendSuccessResponse(
            'Save Tax Success',
            'The tax has been saved successfully.',
            ['tax_id' => $encryptedtaxId]
        );
    }
    
    /* =============================================================================================
        SECTION 2: INSERT METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 3: UPDATE METHOD
    ============================================================================================= */

    public function updateTaxArchive(
        int $lastLogBy
    ) {
        $taxId = $_POST['tax_id'] ?? null;

        $this->tax->updateTaxArchive(
            $taxId,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Tax Archive Success',
            'The tax has been archived successfully.'
        );
    }

    public function updateTaxUnarchive(
        int $lastLogBy
    ) {
        $taxId = $_POST['tax_id'] ?? null;

        $this->tax->updateTaxUnarchive(
            $taxId,
            $lastLogBy
        );

        $this->systemHelper::sendSuccessResponse(
            'Tax Unarchive Success',
            'The tax has been unarchived successfully.'
        );
    }

    /* =============================================================================================
        SECTION 4: FETCH METHOD
    ============================================================================================= */

    public function fetchTaxDetails() {
        $taxId          = $_POST['tax_id'] ?? null;
        $checkTaxExist  = $this->tax->checkTaxExist($taxId);
        $total          = $checkTaxExist['total'] ?? 0;

        if($total === 0){
            $this->systemHelper::sendErrorResponse(
                'Get Tax Details',
                'The tax does not exist',
                ['notExist' => true]
            );
        }

        $taxDetails = $this->tax->fetchTax($taxId);

        $response = [
            'success'           => true,
            'taxName'           => $taxDetails['tax_name'] ?? null,
            'taxRate'           => $taxDetails['tax_rate'] ?? 0,
            'taxType'           => $taxDetails['tax_type'] ?? 'Sales',
            'taxComputation'    => $taxDetails['tax_computation'] ?? 'Percentage',
            'taxScope'          => $taxDetails['tax_scope'] ?? null
        ];

        echo json_encode($response);
        exit;
    }

    /* =============================================================================================
        SECTION 5: DELETE METHOD
    ============================================================================================= */

    public function deleteTax() {
        $taxId = $_POST['tax_id'] ?? null;

        $this->tax->deleteTax($taxId);

        $this->systemHelper::sendSuccessResponse(
            'Delete Tax Success',
            'The tax has been deleted successfully.'
        );
    }

    public function deleteMultipleTax() {
        $taxIds = $_POST['tax_id'] ?? null;

        foreach($taxIds as $taxId){
            $this->tax->deleteTax($taxId);
        }

        $this->systemHelper::sendSuccessResponse(
            'Delete Multiple Taxes Success',
            'The selected taxes have been deleted successfully.'
        );
    }

    /* =============================================================================================
        SECTION 6: CHECK METHOD
    ============================================================================================= */

    /* =============================================================================================
        SECTION 7: GENERATE METHOD
    ============================================================================================= */

    public function generateTaxTable() {
        $pageLink               = $_POST['page_link'] ?? null;
        $taxTypeFilter          = $this->systemHelper->checkFilter($_POST['tax_type_filter'] ?? null);
        $taxComputationFilter   = $this->systemHelper->checkFilter($_POST['tax_computation_filter'] ?? null);
        $taxScopeFilter         = $this->systemHelper->checkFilter($_POST['tax_scope_filter'] ?? null);
        $taxStatusFilter        = $this->systemHelper->checkFilter($_POST['tax_status_filter'] ?? null);
        $response               = [];

        $taxs = $this->tax->generateTaxTable(
            $taxTypeFilter,
            $taxComputationFilter,
            $taxScopeFilter,
            $taxStatusFilter
        );

        foreach ($taxs as $row) {
            $taxId              = $row['tax_id'];
            $taxName            = $row['tax_name'];
            $taxRate            = $row['tax_rate'];
            $taxType            = $row['tax_type'];
            $taxScope           = $row['tax_scope'];
            $taxIdEncrypted     = $this->security->encryptData($taxId);

            $response[] = [
                'CHECK_BOX'     => '<div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                        <input class="form-check-input datatable-checkbox-children" type="checkbox" value="'. $taxId .'">
                                    </div>',
                'TAX'           => $taxName,
                'TAX_RATE'      => number_format($taxRate, 2),
                'TAX_TYPE'      => $taxType,
                'TAX_SCOPE'     => $taxScope,
                'LINK'          => $pageLink .'&id='. $taxIdEncrypted
            ];
        }

        echo json_encode($response);
    }
    
    public function generateTaxOptions() {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $taxes = $this->tax->generateTaxOptions();

        foreach ($taxes as $row) {
            $response[] = [
                'id'    => $row['tax_id'],
                'text'  => $row['tax_name']
            ];
        }

        echo json_encode($response);
    }
    
    public function generateSalesTaxOptions() {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $taxes = $this->tax->generateSalesTaxOptions();

        foreach ($taxes as $row) {
            $response[] = [
                'id'    => $row['tax_id'],
                'text'  => $row['tax_name']
            ];
        }

        echo json_encode($response);
    }
    
    public function generatePurchaseTaxOptions() {
        $multiple   = $_POST['multiple'] ?? false;
        $response   = [];

        if(!$multiple){
            $response[] = [
                'id'    => '',
                'text'  => '--'
            ];
        }

        $taxes = $this->tax->generatePurchaseTaxOptions();

        foreach ($taxes as $row) {
            $response[] = [
                'id'    => $row['tax_id'],
                'text'  => $row['tax_name']
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

$controller = new TaxController(
    new Tax(),
    new Authentication(),
    new Security(),
    new SystemHelper()
);

$controller->handleRequest();