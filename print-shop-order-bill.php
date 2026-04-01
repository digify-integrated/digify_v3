<?php

error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once './config/config.php';
require_once './config/session.php';

use App\Core\Security;
use App\Helpers\SystemHelper;
use App\Models\Authentication;
use App\Models\Company;
use App\Models\Shop;
use App\Models\FloorPlan;

$authentication = new Authentication();
$security       = new Security();
$company        = new Company();
$shop           = new Shop();
$floorPlan      = new FloorPlan();
$systemHelper   = new SystemHelper();

require('vendor/tcpdf2/tcpdf.php');

/**
 * Reusable function to render receipt content
 */
function renderReceiptContent($pdf, $data) {
    if (!empty($data['companyLogo'])) {
        $logoWidth = 30;
        $pageWidth = $pdf->getPageWidth();
        $x = ($pageWidth - $logoWidth) / 2;
        $pdf->Image($data['companyLogo'], $x, '', $logoWidth);
        $pdf->Ln(30); 
    }

    $pdf->SetFont('courier', '', 9);
    $fullAddress = trim($data['companyAddress'] . ', ' . $data['cityName'] . ', ' . $data['stateName']);
    $pdf->MultiCell(0, 4, $fullAddress, 0, 'C');

    if (!empty($data['taxId'])) {
        $pdf->MultiCell(0, 4, 'TIN No: ' . $data['taxId'], 0, 'C');
    }

    $pdf->Ln(2);
    $tableNum = $data['tableNumber'] ?? null;
    $orderFor = $data['orderFor'] ?? null;
    $floorPlan = $data['floorPlanName'] ?? '';

    $tableDisplay = '';

    if ($tableNum && !$orderFor) {
        $prefix = $floorPlan ? "$floorPlan " : "";
        $tableDisplay = "{$prefix}Table No. $tableNum";
    } elseif ($orderFor && !$tableNum) {
        $tableDisplay = "Order For: $orderFor";
    }
    
    $pdf->MultiCell(0, 4, $tableDisplay, 0, 'L');
    $pdf->MultiCell(0, 4, 'Date Time: ' . date('Y-m-d H:i:s'), 0, 'L');
    $pdf->MultiCell(0, 4, 'Cashier: ' . $data['userFileAs'], 0, 'L');

    $pdf->Ln(2);
    $pdf->writeHTML('<hr>', true, false, true, false, 'C');
    $pdf->Ln(-3);
    $pdf->SetFont('courier', 'B', 10);
    $pdf->MultiCell(0, 4, 'BILL', 0, 'C');
    $pdf->Ln(1);
    $pdf->writeHTML('<hr>', true, false, true, false, 'C');
    $pdf->Ln(-3);

    $pdf->SetFont('courier', '', 9);
    $html = '<table cellpadding="2">
                <tbody>';

    foreach ($data['orders'] as $order) {
        $qty     = number_format($order['quantity'] ?? 1);
        $itemName = htmlspecialchars($order['product_name'] ?? 'Item');
        $price    = number_format($order['subtotal'] ?? 0, 2);
        $html .= '<tr>
                    <td width="15%">' . $qty . '</td>
                    <td width="55%">' . $itemName . '</td>
                    <td width="30%" align="right">P ' . $price . '</td>
                  </tr>';
    }
    $html .= '</tbody></table>';

    $pdf->writeHTML($html, true, false, true, false, '');
    $pdf->Ln(-3);
    
    // Totals Section
    $pdf->MultiCell(0, 4, 'Subtotal: P' . number_format($data['gross_sales'] ?? 0, 2), 0, 'R');

    foreach ($data['charges'] as $charge) {
        $pdf->MultiCell(0, 4, $charge['name'] . ': P' . number_format($charge['amount'] ?? 0, 2), 0, 'R');
    }

    foreach ($data['discounts'] as $discount) {
        $pdf->MultiCell(0, 4, $discount['name'] . ': P ' . number_format($discount['amount'] ?? 0, 2), 0, 'R');
    }

    $pdf->SetFont('courier', 'B', 9);
    $pdf->MultiCell(0, 4, 'AMOUNT DUE: P' . number_format($data['total_amount_due'], 2), 0, 'R');

    $pdf->SetFont('courier', '', 9);

    $pdf->Ln(3);
    $pdf->MultiCell(0, 4, 'VATable Sales: P' . number_format($data['vat_sales'] ?? 0, 2), 0, 'R');
    $pdf->MultiCell(0, 4, 'VAT-Exempt Sales: P' . number_format($data['vat_exempt_sales'] ?? 0, 2), 0, 'R');
    $pdf->MultiCell(0, 4, 'VAT Zero-Rated Sales: P' . number_format($data['zero_rated_sales'] ?? 0, 2), 0, 'R');
    $pdf->MultiCell(0, 4, 'VAT Amount: P' . number_format($data['vat_amount'] ?? 0, 2), 0, 'R');

    $pdf->Ln(3);
    $footerText = "Thank you for your purchase.\nThis is NOT an OFFICIAL RECEIPT";
    $pdf->MultiCell(0, 4, $footerText, 0, 'C');
}

// --- Data Fetching ---
$data = [];
if(isset($_GET['id']) && !empty($_GET['id'])){
    $shopOrderId = $_GET['id'];
    $loginCredentialsDetails = $authentication->fetchLoginCredentials($userID);
    $data['userFileAs'] = $loginCredentialsDetails['file_as'] ?? '';

    $shopOrderDetails           = $shop->fetchShopOrderDetails($shopOrderId);
    $shopId                     = $shopOrderDetails['shop_id'] ?? null;
    $data['tableNumber']        = $shopOrderDetails['table_number'] ?? null;
    $floorPlanTableId           = $shopOrderDetails['floor_plan_table_id'] ?? null;
    $data['orderFor']           = $shopOrderDetails['order_for'] ?? null;
    $data['gross_sales']        = $shopOrderDetails['gross_sales'] ?? 0;
    $data['vat_sales']          = $shopOrderDetails['vat_sales'] ?? 0;
    $data['vat_amount']         = $shopOrderDetails['vat_amount'] ?? 0;
    $data['vat_exempt_sales']   = $shopOrderDetails['vat_exempt_sales'] ?? 0;
    $data['zero_rated_sales']   = $shopOrderDetails['zero_rated_sales'] ?? 0;
    $data['additiveTaxTotal']   = $shopOrderDetails['additive_tax_total'] ?? 0;
    $data['total_amount_due']   = $shopOrderDetails['total_amount_due'] ?? 0;

    $charges            = $shop->fetchOrderCharges($shopOrderId) ?? [];
    $discounts          = $shop->fetchOrderDiscounts($shopOrderId) ?? [];
    $data['charges']    = $charges;
    $data['discounts']  = $discounts;

    if(!empty($floorPlanTableId)){
        $floorPlanTableDetails = $floorPlan->fetchFloorPlanTable($floorPlanTableId);
        $data['floorPlanName'] = $floorPlanTableDetails['floor_plan_name'] ?? null;
    }    

    $shopDetails    = $shop->fetchShop($shopId);
    $companyId      = $shopDetails['company_id'] ?? null;

    $companyDetails = $company->fetchCompany($companyId);
    $data['companyAddress'] = $companyDetails['address'] ?? null;
    $data['cityName']       = $companyDetails['city_name'] ?? null;
    $data['stateName']      = $companyDetails['state_name'] ?? null;
    $data['taxId']          = $companyDetails['tax_id'] ?? null;
    $data['companyLogo']    = $systemHelper->checkImageExist($companyDetails['company_logo'] ?? null, 'company logo');

    $data['orders'] = $shop->fetchShopOrderList($shopOrderId);
} else {
    exit;
}

ob_start();

// --- Phase 1: Calculate Height ---
$dummy = new TCPDF('P', 'mm', array(80, 2000), true, 'UTF-8', false);
$dummy->setPrintHeader(false);
$dummy->setPrintFooter(false);
$dummy->SetMargins(5, 5, 5);
$dummy->AddPage();

renderReceiptContent($dummy, $data);

$calculatedHeight = $dummy->GetY() + 15;
$dummy->Close();

// --- Phase 2: Final Output ---
$pdf = new TCPDF('P', 'mm', array(80, $calculatedHeight), true, 'UTF-8', false);
$pdf->setPrintHeader(false);
$pdf->setPrintFooter(false);
$pdf->SetMargins(5, 5, 5);
$pdf->SetAutoPageBreak(false); // Keeps it on one continuous slip
$pdf->AddPage();

renderReceiptContent($pdf, $data);

$pdf->Output('receipt.pdf', 'I');
ob_end_flush();