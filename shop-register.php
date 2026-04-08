<?php
declare(strict_types=1);
$pageTitle = 'Shop Register';

require_once './app/Views/Partials/required-files.php';

$shopId = $_GET['id'] ?? null;

if(empty($shopId)) {
    $systemHelper->redirect('apps.php');
}

use App\Models\Shop;
use App\Models\FloorPlan;

$shop       = new Shop();
$floorPlan  = new FloorPlan();

$shopDetails    = $shop->fetchShop($shopId);
$shopName       = $shopDetails['shop_name'] ?? '';
$shopStatus     = $shopDetails['shop_status'] ?? 'Active';

if($shopStatus !== 'Active') {
    $systemHelper->redirect('apps.php');
}

$floorPlanCount = $shop->fetchShopFloorPlanCount($shopId)['total'] ?? 0;

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <?php
        require_once './app/Views/Partials/head-meta-tags.php';
        require_once './app/Views/Partials/head-stylesheet.php';
    ?>
    <link href="./vendor/datatables/datatables.bundle.css" rel="stylesheet" type="text/css"/>
</head>

<?php require_once './app/Views/Partials/theme-script.php'; ?>

<body id="kt_body" class="app-default bgi-size-cover bgi-attachment-fixed bgi-position-center bgi-no-repeat" data-kt-app-page-loading-enabled="true" data-kt-app-page-loading="off">
    <input type="hidden" id="shop_id" value="<?= $shopId ?>">
    <div class="d-flex flex-column flex-root app-root" id="kt_app_root">
        <div class="app-page flex-column flex-column-fluid mb-0 pb-0" id="kt_app_page">
            <div id="kt_app_header" class="app-header" data-kt-sticky="true" data-kt-sticky-activate="{default: false, lg: true}" data-kt-sticky-name="app-header-sticky" data-kt-sticky-offset="{default: false, lg: '300px'}">
                <div class="app-container container-xxl d-flex align-items-stretch justify-content-between" id="kt_app_header_container">
                    <div class="d-flex align-items-center flex-grow-1 flex-lg-grow-0">
                        <img alt="Logo" src="./assets/images/logos/logo-light.svg" class="h-30px d-sm-none" />
                        <img alt="Logo" src="./assets/images/logos/logo-light.svg" class="h-30px d-none d-sm-block" />
                        <ul class="nav nav-stretch nav-line-tabs border-transparent ms-10 h-100" role="tablist">
                            <?php include_once './app/Views/Partials/shop-register-tabs.php'; ?>
                        </ul>
                    </div>
                    <div class="d-flex align-items-center justify-content-between flex-lg-grow-1" id="kt_app_header_wrapper">
                        <div></div>
                        <a href="#" class="btn btn-primary btn-flex btn-center show menu-dropdown align-self-center" data-kt-menu-trigger="click" data-kt-menu-placement="bottom-end">
                            Actions
                        </a>
                        <div class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-600 menu-state-bg-light-primary fw-semibold fs-7 w-125px py-4" data-kt-menu="true" style="z-index: 107; position: fixed; inset: 0px 0px auto auto; margin: 0px; transform: translate(-60px, 539px);" data-popper-placement="bottom-end">
                            <div class="menu-item px-3">
                                <a href="point-of-sale.php?app_module_id=hst0rdswN8qoe2Ay65e8IZkbQ5QceGO7UtiE22bGUdQ%3D&page_id=CSvFIEWIqWL2wEIfVGjnSeyuA51jjQ7rXjGI%2Bxgkzq8%3D" class="menu-link px-3">
                                    Backend
                                </a>
                            </div>
                            <div class="menu-item px-3">
                                <a href="javascript:void(0);" class="menu-link px-3" data-bs-toggle="modal" data-bs-target="#close-shop-modal" id="closer-register">
                                    Close Register
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
             <div class="app-container container-xxl">
                <div class="app-main flex-column flex-row-fluid" id="kt_app_main">
                    <div class="d-flex flex-column flex-column-fluid">
                        <div id="kt_app_content" class="app-content flex-column-fluid mt-0">
                            <div class="tab-content">
                                <?php include_once './app/Views/Partials/shop-register-tab-contents.php'; ?>                                    
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="close-shop-modal" class="modal fade" tabindex="-1" aria-labelledby="close-shop-modal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable modal-lg">
            <div class="modal-content">
                <div class="modal-body">
                    <form id="close_register_form" method="post" action="#">
                        <?= $security->csrfInput('close_register_form'); ?>

                        <div class="d-flex align-items-center mb-5">
                            <h2 class="fw-bold mb-0">Cash Count</h2>
                            <div class="ms-auto badge py-3 px-4 fs-7 badge-light-primary">Register Closing</div>
                        </div>

                        <div class="row g-5">
                            <div class="col-md-6">
                                <h5 class="text-muted text-uppercase fs-7 fw-bold mb-4 border-bottom pb-2">Bills</h5>
                                
                                <?php 
                                $bills = [
                                    '1000' => '1,000.00', '500' => '500.00', '200' => '200.00', 
                                    '100' => '100.00', '50' => '50.00', '20' => '20.00'
                                ];
                                foreach ($bills as $id => $label): ?>
                                <div class="mb-3 d-flex align-items-center">
                                    <label class="fw-semibold fs-6 w-100px mb-0" for="close_<?= $id ?>">&#8369; <?= $label ?></label>
                                    <input type="number" id="close_<?= $id ?>" name="close_<?= $id ?>" 
                                            class="form-control form-control-solid border-start-0" min="0" step="1" />
                                </div>
                                <?php endforeach; ?>
                            </div>

                            <div class="col-md-6">
                                <h5 class="text-muted text-uppercase fs-7 fw-bold mb-4 border-bottom pb-2">Coins</h5>
                                
                                <?php 
                                $coins = [
                                    '10' => '10.00', '5' => '5.00', '1' => '1.00', 
                                    '0_50' => '0.50', '0_25' => '0.25', '0_10' => '0.10', 
                                    '0_05' => '0.05', '0_01' => '0.01'
                                ];
                                foreach ($coins as $id => $label): ?>
                                <div class="mb-3 d-flex align-items-center">
                                    <label class="fw-semibold fs-6 w-100px mb-0" for="close_<?= $id ?>">&#8369; <?= $label ?></label>
                                    <input type="number" id="close_<?= $id ?>" name="close_<?= $id ?>" 
                                            class="form-control form-control-solid border-start-0" min="0" step="1" />
                                </div>
                                <?php endforeach; ?>
                            </div>
                        </div>

                        <hr class="my-8 border-secondary-subtle">

                        <div class="row g-5">
                            <div class="col-md-7">
                                <label class="fw-semibold fs-6 mb-2" for="close_remarks">Closing Note / Remarks</label>
                                <textarea class="form-control form-control-solid" id="close_remarks" name="close_remarks" 
                                        placeholder="Any discrepancies or notes..." maxlength="1000" rows="6"></textarea>
                            </div>
                            
                            <div class="col-md-5">
                                <div class="p-5 rounded bg-light-primary border border-primary border-dashed">
                                    <label class="fw-bold fs-4 text-primary mb-2" for="close_total">Grand Total</label>
                                    <div class="input-group">
                                        <span class="input-group-text border-0 bg-transparent fs-2 fw-bold text-primary">&#8369;</span>
                                        <input type="text" id="close_total" name="close_total" 
                                            class="form-control form-control-flush fs-1 fw-bolder text-primary" 
                                            value="0.00" readonly/>
                                    </div>
                                    <div class="fs-7 text-muted mt-2 italic">* Automatically calculated based on quantities</div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                    <button type="submit" form="close_register_form" class="btn btn-success" id="submit-data">Close Register</button>
                </div>
            </div>
        </div>
    </div>
</div>

<?php
    require_once './app/Views/Partials/error-modal.php';
    require_once './app/Views/Partials/required-js.php';
?>
<script src="./vendor/datatables/datatables.bundle.js"></script>

<script type="module" src="./assets/js/page/shop-register/index.js?v=<?= rand(); ?>"></script>

</body>
</html>