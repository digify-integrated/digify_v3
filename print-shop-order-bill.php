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
    $tableDisplay = (!empty($data['floorPlanName']) ? $data['floorPlanName'] . ' ' : '') . 'Table No. ' . $data['tableNumber'];
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
                <thead>
                    <tr>
                        <td width="15%"><b>QTY</b></td>
                        <td width="55%"><b>ITEM</b></td>
                        <td width="30%" align="right"><b>PRICE</b></td>
                    </tr>
                </thead>
                <tbody>';

    foreach ($data['orders'] as $order) {
        $qty     = number_format($order['quantity'] ?? 1);
        $itemName = htmlspecialchars($order['product_name'] ?? 'Item');
        $price    = number_format($order['total_price'] ?? 0, 2);
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
    $pdf->MultiCell(0, 4, 'SUBTOTAL: P' . 0, 0, 'R');
    $pdf->MultiCell(0, 4, 'VAT Sales: P' . 0, 0, 'R');
    $pdf->MultiCell(0, 4, 'VAT: P' . 0, 0, 'R');
    $pdf->MultiCell(0, 4, 'SC: P' . 0, 0, 'R');
    $pdf->MultiCell(0, 4, 'DISCOUNT: P' . 0, 0, 'R');

    $pdf->SetFont('courier', 'B', 9);
    $pdf->MultiCell(0, 4, 'AMOUNT DUE: P' . 0, 0, 'R');
    $pdf->SetFont('courier', '', 9);

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

    $shopOrderDetails = $shop->fetchShopOrderDetails($shopOrderId);
    $shopId           = $shopOrderDetails['shop_id'] ?? null;
    $data['tableNumber'] = $shopOrderDetails['table_number'] ?? null;
    $floorPlanTableId = $shopOrderDetails['floor_plan_table_id'] ?? null;

    $floorPlanTableDetails = $floorPlan->fetchFloorPlanTable($floorPlanTableId);
    $data['floorPlanName'] = $floorPlanTableDetails['floor_plan_name'] ?? null;

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