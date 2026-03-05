<?php
declare(strict_types=1);
$pageTitle = 'Shop Register';

require_once './app/Views/Partials/required-files.php';

$shopId = $_GET['shop_id'] ?? null;

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
    <div class="d-flex flex-column flex-root app-root" id="kt_app_root">
        <div class="app-page flex-column flex-column-fluid" id="kt_app_page">
            <div class="app-wrapper flex-column flex-row-fluid" id="kt_app_wrapper">
                <?php require_once './app/Views/Partials/shop-register-toolbar.php'; ?>
                <div class="app-container container-xxl">
                    <div class="app-main flex-column flex-row-fluid" id="kt_app_main">
                        <div class="d-flex flex-column flex-column-fluid">
                            <div id="kt_app_content" class="app-content flex-column-fluid">
                                <div class="card mb-5 mb-xxl-8">
                                    <div class="card-body pt-9 pb-0">
                                        <div class="d-flex flex-column flex-row-fluid">
                                            <div class="d-flex flex-stack flex-wrap flex-lg-nowrap gap-4 gap-lg-10 pt-0 pb-6 mb-lg-0 mb-8">
                                                <div class="page-title me-5">
                                                    <h1 class="page-heading d-flex fw-bold fs-2 flex-column justify-content-center my-0">
                                                        <?= $shopName ?>
                                                    </h1>
                                                </div>
                                                <div class="d-flex align-self-center flex-center flex-shrink-1">
                                                    <button id="close-shop-register" class="btn btn-flex btn-danger ms-3 px-4"  data-bs-toggle="modal" data-bs-target="#close-shop-modal">Close Register</button>
                                                </div>
                                            </div>
                                        </div>
                                        <ul class="nav nav-stretch nav-line-tabs nav-line-tabs-2x border-transparent fs-5 fw-bold">
                                            <?php include_once './app/Views/Partials/shop-register-tabs.php'; ?>
                                        </ul>
                                    </div>
                                </div>

                                <div class="tab-content">
                                    <?php include_once './app/Views/Partials/shop-register-tab-contents.php'; ?>                                    
                                </div>
                            </div>
                        </div>
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

<script type="module" src=""></script>

</body>
</html>