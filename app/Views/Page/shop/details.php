<?php
    use App\Models\Shop;

    $shop = new Shop();

    $archiveShop    = $authentication->checkUserSystemActionPermission($userID, 23);
    $unarchiveShop  = $authentication->checkUserSystemActionPermission($userID, 24);

    $shopDetails    = $shop->fetchShop($detailID);
    $shopStatus     = $shopDetails['shop_status'] ?? 'Active';
    $shopBadge = $shopStatus == 'Active' ? '<span class="badge badge-light-success">'. $shopStatus .'</span>' : '<span class="badge badge-light-danger">'. $shopStatus .'</span>';
?>

<div class="card mb-10">
    <div class="card-body pt-9 pb-0">
        <div class="d-flex flex-wrap flex-sm-nowrap mb-6">            
            <div class="flex-grow-1">
                <div class="d-flex justify-content-between align-items-start flex-wrap mb-2">
                    <div class="d-flex flex-column">
                        <div class="d-flex align-items-center mb-4">
                            <h1 class="text-gray-800 fs-2 fw-bold me-3" id="shop">-</h1>
                            <?= $shopBadge ?>
                        </div>
                        <div class="d-flex flex-wrap fw-semibold fs-6 mb-4 pe-2">
                            <div class="d-flex align-items-center text-gray-500 me-5 mb-2" id="company">
                                -
                            </div>
                        </div>
                    </div>
                    
                    <div class="d-flex mb-4">
                        <?php
                            if ($permissions['delete'] > 0 || ($archiveShop['total'] > 0 && $shopStatus === 'Active') || ($unarchiveShop['total'] > 0 && $shopStatus === 'Archived')) {
                                $action = ' <div class="me-0">
                                                <button class="btn btn-sm btn-primary" data-kt-menu-trigger="click" data-kt-menu-placement="bottom-end">
                                                    Actions
                                                    <i class="ki-outline ki-down fs-2 me-0"></i>
                                                </button>
                                                
                                                <div class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-600 menu-state-bg-light-primary fw-semibold fs-7 w-125px py-4" data-kt-menu="true">';
                                            
                                if($archiveShop['total'] > 0 && $shopStatus === 'Active'){
                                    $action .= ' <div class="menu-item px-3">
                                                    <a href="javascript:void(0);" class="menu-link px-3" id="archive-shop">
                                                        Archive
                                                    </a>
                                                </div>';
                                }
                                            
                                if($unarchiveShop['total'] > 0 && $shopStatus === 'Archived'){
                                    $action .= ' <div class="menu-item px-3">
                                                    <a href="javascript:void(0);" class="menu-link px-3" id="unarchive-shop">
                                                        Unarchive
                                                    </a>
                                                </div>';
                                }
                                            
                                if($permissions['delete'] > 0){
                                    $action .= ' <div class="menu-item px-3">
                                                    <a href="javascript:void(0);" class="menu-link px-3" id="delete-shop">
                                                        Delete
                                                    </a>
                                                </div>';
                                }

                                $action .= '</div>
                                        </div>';
                                            
                                echo $action;
                            }
                        ?>
                    </div>
                </div>
            </div>
        </div>

        <div class="separator"></div>

        <ul class="nav nav-stretch nav-line-tabs nav-line-tabs-2x border-transparent fs-5 fw-bold" role="tablist">
            <li class="nav-item" role="presentation">
                <a class="nav-link text-active-primary py-5 me-6  active" data-bs-toggle="tab" href="#general_tab" aria-selected="false" role="tab" tabindex="-1">General</a>
            </li>

            <li class="nav-item" role="presentation">
                <a class="nav-link text-active-primary py-5 me-6 " data-bs-toggle="tab" href="#products_tab" aria-selected="false" role="tab" tabindex="-1">Products</a>
            </li>

            <li class="nav-item" role="presentation">
                <a class="nav-link text-active-primary py-5 me-6 " data-bs-toggle="tab" href="#advanced_tab" aria-selected="false" role="tab" tabindex="-1">Advanced</a>
            </li>
        </ul>
    </div>
</div>

<div class="tab-content">
    <div class="tab-pane fade active show" id="general_tab" role="tabpanel">
        <div class="row">
            <div class="col-lg-12">
                <div class="card card-flush py-4 mb-10">
                    <div class="card-header">
                        <div class="card-title">
                            <h2>General</h2>
                        </div>
                    </div>
                                
                    <div class="card-body pt-0">
                        <form id="shop_form" method="post" action="#">
                            <?= $security->csrfInput('shop_form'); ?>
                            <div class="fv-row mb-4">
                                <label class="fs-6 fw-semibold required form-label mt-3" for="shop_name">
                                    Display Name
                                </label>

                                <input type="text" class="form-control" id="shop_name" name="shop_name" maxlength="100" autocomplete="off" <?php echo $disabled; ?>>
                            </div>

                            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                                <div class="col">
                                    <div class="fv-row mb-7">
                                        <label class="fs-6 fw-semibold required form-label mt-3" for="company_id">
                                            Company
                                        </label>

                                        <select id="company_id" name="company_id" class="form-select" data-control="select2" data-allow-clear="false" <?php echo $disabled; ?>></select>
                                    </div>
                                </div>

                                <div class="col">
                                    <div class="fv-row mb-7">
                                        <label class="fs-6 fw-semibold required form-label mt-3" for="shop_type_id">
                                            Shop Type
                                        </label>

                                        <select id="shop_type_id" name="shop_type_id" class="form-select" data-control="select2" data-allow-clear="false" <?php echo $disabled; ?>></select>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <?php
                        echo ($permissions['write'] > 0) ? '<div class="d-flex justify-content-end py-6 px-9">
                                                                <button type="submit" form="shop_form" class="btn btn-primary" id="submit-shop">Save</button>
                                                            </div>' : '';
                    ?>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-6">
                <div class="card card-flush py-4 mb-10">
                    <div class="card-header">
                        <div class="card-title">
                            <h2 class="me-4">Shop Floor Plan</h2>
                        </div>
                        <div class="card-toolbar">
                            <div class="d-flex align-items-center position-relative my-1 me-3">
                                <i class="ki-outline ki-magnifier fs-3 position-absolute ms-5"></i> <input type="text" class="form-control w-250px ps-12" id="shop-floor-plan-datatable-search" placeholder="Search..." autocomplete="off" />
                            </div>
                            <select id="shop-floor-plan-datatable-length" class="form-select w-auto me-4">
                                <option value="-1">All</option>
                                <option value="5">5</option>
                                <option value="10" selected>10</option>
                                <option value="20">20</option>
                                <option value="25">25</option>
                                <option value="50">50</option>
                                <option value="100">100</option>
                            </select>
                            <div class="d-flex justify-content-end" data-kt-customer-table-toolbar="base">
                                <?php
                                    echo $permissions['write'] > 0 ? '<button type="button" class="btn btn-light-primary me-3" data-bs-toggle="modal" data-bs-target="#shop-floor-plan-modal" id="add-shop-floor-plan">Add Floor Plan</button>' : '';
                                ?> 
                            </div>
                        </div>
                    </div>
                                    
                    <div class="card-body pt-0">
                        <table class="table align-middle table-row-dashed fs-6 gy-5 gs-7" id="shop-floor-plan-table">
                            <thead>
                                <tr class="fw-semibold fs-6 text-gray-800">
                                    <th>Floor Plan</th>
                                    <th>No. Tables</th>
                                    <th>No. Seats</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody class="fw-semibold text-gray-600"></tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="card card-flush py-4">
                    <div class="card-header">
                        <div class="card-title">
                            <h2 class="me-4">Shop Access</h2>
                        </div>
                        <div class="card-toolbar">
                            <div class="d-flex align-items-center position-relative my-1 me-3">
                                <i class="ki-outline ki-magnifier fs-3 position-absolute ms-5"></i> <input type="text" class="form-control w-250px ps-12" id="shop-access-datatable-search" placeholder="Search..." autocomplete="off" />
                            </div>
                            <select id="shop-access-datatable-length" class="form-select w-auto me-4">
                                <option value="-1">All</option>
                                <option value="5">5</option>
                                <option value="10" selected>10</option>
                                <option value="20">20</option>
                                <option value="25">25</option>
                                <option value="50">50</option>
                                <option value="100">100</option>
                            </select>
                            <div class="d-flex justify-content-end" data-kt-customer-table-toolbar="base">
                                <?php
                                    echo $permissions['write'] > 0 ? '<button type="button" class="btn btn-light-primary me-3" data-bs-toggle="modal" data-bs-target="#shop-access-modal" id="add-shop-access">Add User Account</button>' : '';
                                ?> 
                            </div>
                        </div>
                    </div>
                                    
                    <div class="card-body pt-0">
                        <table class="table align-middle table-row-dashed fs-6 gy-5 gs-7" id="shop-access-table">
                            <thead>
                                <tr class="fw-semibold fs-6 text-gray-800">
                                    <th>User Account</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody class="fw-semibold text-gray-600"></tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="tab-pane fade" id="products_tab" role="tabpanel">
        <div class="d-flex flex-column gap-7 gap-lg-10">
            <div class="card card-flush py-4">
                <div class="card-header">
                    <div class="card-title">
                        <h2 class="me-4">Shop Product</h2>
                    </div>
                    <div class="card-toolbar">
                        <div class="d-flex align-items-center position-relative my-1 me-3">
                            <i class="ki-outline ki-magnifier fs-3 position-absolute ms-5"></i> <input type="text" class="form-control w-250px ps-12" id="shop-product-datatable-search" placeholder="Search..." autocomplete="off" />
                        </div>
                        <select id="shop-product-datatable-length" class="form-select w-auto me-4">
                            <option value="-1">All</option>
                            <option value="5">5</option>
                            <option value="10" selected>10</option>
                            <option value="20">20</option>
                            <option value="25">25</option>
                            <option value="50">50</option>
                            <option value="100">100</option>
                        </select>
                        <div class="d-flex justify-content-end" data-kt-customer-table-toolbar="base">
                            <?php
                                echo $permissions['write'] > 0 ? '<button type="button" class="btn btn-light-primary me-3" data-bs-toggle="modal" data-bs-target="#shop-product-modal" id="add-shop-product">Add Product</button>' : '';
                            ?> 
                        </div>
                    </div>
                </div>
                            
                <div class="card-body pt-0">
                    <table class="table align-middle table-row-dashed fs-6 gy-5 gs-7" id="shop-product-table">
                        <thead>
                            <tr class="fw-semibold fs-6 text-gray-800">
                                <th>Product</th>
                                <th>Qty.</th>
                                <th>Sales Price</th>
                                <th>Cost</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody class="fw-semibold text-gray-600"></tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <div class="tab-pane fade" id="advanced_tab" role="tabpanel">
        <div class="d-flex flex-column gap-7 gap-lg-10">
            <div class="card card-flush">
                <div class="card-header">
                    <div class="card-title">
                        <h2 class="me-4">Payment Method</h2>
                    </div>
                    <div class="card-toolbar">
                        <div class="d-flex align-items-center position-relative my-1 me-3">
                            <i class="ki-outline ki-magnifier fs-3 position-absolute ms-5"></i> <input type="text" class="form-control w-250px ps-12" id="shop-payment-method-datatable-search" placeholder="Search..." autocomplete="off" />
                        </div>
                        <select id="shop-payment-method-datatable-length" class="form-select w-auto me-4">
                            <option value="-1">All</option>
                            <option value="5">5</option>
                            <option value="10" selected>10</option>
                            <option value="20">20</option>
                            <option value="25">25</option>
                            <option value="50">50</option>
                            <option value="100">100</option>
                        </select>
                        <div class="d-flex justify-content-end" data-kt-customer-table-toolbar="base">
                            <?php
                                echo $permissions['write'] > 0 ? '<button type="button" class="btn btn-light-primary me-3" data-bs-toggle="modal" data-bs-target="#shop-payment-method-modal" id="add-shop-payment-method">Add Payment Method</button>' : '';
                            ?> 
                        </div>
                    </div>
                </div>
                                    
                <div class="card-body pt-0">
                    <table class="table align-middle table-row-dashed fs-6 gy-5 gs-7" id="shop-payment-method-table">
                        <thead>
                            <tr class="fw-semibold fs-6 text-gray-800">
                                <th>Payment Method</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody class="fw-semibold text-gray-600"></tbody>
                    </table>
                </div>
            </div>

            <div class="card card-flush py-4">
                <div class="card-header">
                    <div class="card-title">
                        <h2 class="me-4">Discounts</h2>
                    </div>
                    <div class="card-toolbar">
                        <div class="d-flex align-items-center position-relative my-1 me-3">
                            <i class="ki-outline ki-magnifier fs-3 position-absolute ms-5"></i> <input type="text" class="form-control w-250px ps-12" id="shop-discounts-datatable-search" placeholder="Search..." autocomplete="off" />
                        </div>
                        <select id="shop-discounts-datatable-length" class="form-select w-auto me-4">
                            <option value="-1">All</option>
                            <option value="5">5</option>
                            <option value="10" selected>10</option>
                            <option value="20">20</option>
                            <option value="25">25</option>
                            <option value="50">50</option>
                            <option value="100">100</option>
                        </select>
                        <div class="d-flex justify-content-end" data-kt-customer-table-toolbar="base">
                            <?php
                                echo $permissions['write'] > 0 ? '<button type="button" class="btn btn-light-primary me-3" data-bs-toggle="modal" data-bs-target="#shop-discounts-modal" id="add-shop-discounts">Add Discounts</button>' : '';
                            ?> 
                        </div>
                    </div>
                </div>
                            
                <div class="card-body pt-0">
                    <table class="table align-middle table-row-dashed fs-6 gy-5 gs-7" id="shop-discounts-table">
                        <thead>
                            <tr class="fw-semibold fs-6 text-gray-800">
                                <th>Discount</th>
                                <th>Value Type</th>
                                <th>Discount Value</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody class="fw-semibold text-gray-600"></tbody>
                    </table>
                </div>
            </div>
            
            <div class="card card-flush py-4">
                <div class="card-header">
                    <div class="card-title">
                        <h2 class="me-4">Charges</h2>
                    </div>
                    <div class="card-toolbar">
                        <div class="d-flex align-items-center position-relative my-1 me-3">
                            <i class="ki-outline ki-magnifier fs-3 position-absolute ms-5"></i> <input type="text" class="form-control w-250px ps-12" id="shop-charges-datatable-search" placeholder="Search..." autocomplete="off" />
                        </div>
                        <select id="shop-charges-datatable-length" class="form-select w-auto me-4">
                            <option value="-1">All</option>
                            <option value="5">5</option>
                            <option value="10" selected>10</option>
                            <option value="20">20</option>
                            <option value="25">25</option>
                            <option value="50">50</option>
                            <option value="100">100</option>
                        </select>
                        <div class="d-flex justify-content-end" data-kt-customer-table-toolbar="base">
                            <?php
                                echo $permissions['write'] > 0 ? '<button type="button" class="btn btn-light-primary me-3" data-bs-toggle="modal" data-bs-target="#shop-charges-modal" id="add-shop-charges">Add Charges</button>' : '';
                            ?> 
                        </div>
                    </div>
                </div>
                            
                <div class="card-body pt-0">
                    <table class="table align-middle table-row-dashed fs-6 gy-5 gs-7" id="shop-charges-table">
                        <thead>
                            <tr class="fw-semibold fs-6 text-gray-800">
                                <th>Charge</th>
                                <th>Value Type</th>
                                <th>Charge Value</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody class="fw-semibold text-gray-600"></tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="shop-payment-method-modal" class="modal fade" tabindex="-1" aria-labelledby="shop-payment-method-modal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Payment Method</h3>
                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </div>
            </div>

            <div class="modal-body">
                <form id="shop_payment_method_form" method="post" action="#">
                    <?= $security->csrfInput('shop_payment_method_form'); ?>

                    <div class="row mb-6">
                        <label class="col-lg-3 required col-form-label fw-semibold fs-6" for="payment_method_id">Payment Method</label>
                        <div class="col-lg-9">
                            <div class="row">
                                <div class="col-lg-12 fv-row">
                                    <select id="payment_method_id" name="payment_method_id[]" multiple="multiple" class="form-select" data-control="select2" data-allow-clear="false"></select>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                <button type="submit" form="shop_payment_method_form" class="btn btn-primary" id="submit-shop-payment-method">Assign</button>
            </div>
        </div>
    </div>
</div>

<div id="shop-floor-plan-modal" class="modal fade" tabindex="-1" aria-labelledby="shop-floor-plan-modal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Floor Plan</h3>
                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </div>
            </div>

            <div class="modal-body">
                <form id="shop_floor_plan_form" method="post" action="#">
                    <?= $security->csrfInput('shop_floor_plan_form'); ?>

                    <div class="row mb-6">
                        <label class="col-lg-3 required col-form-label fw-semibold fs-6" for="floor_plan_id">Floor Plan</label>
                        <div class="col-lg-9">
                            <div class="row">
                                <div class="col-lg-12 fv-row">
                                    <select id="floor_plan_id" name="floor_plan_id[]" multiple="multiple" class="form-select" data-control="select2" data-allow-clear="false"></select>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                <button type="submit" form="shop_floor_plan_form" class="btn btn-primary" id="submit-shop-floor-plan">Assign</button>
            </div>
        </div>
    </div>
</div>

<div id="shop-access-modal" class="modal fade" tabindex="-1" aria-labelledby="shop-access-modal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Access</h3>
                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </div>
            </div>

            <div class="modal-body">
                <form id="shop_access_form" method="post" action="#">
                    <?= $security->csrfInput('shop_access_form'); ?>

                    <div class="row mb-6">
                        <label class="col-lg-3 required col-form-label fw-semibold fs-6" for="user_account_id">User Account</label>
                        <div class="col-lg-9">
                            <div class="row">
                                <div class="col-lg-12 fv-row">
                                    <select id="user_account_id" name="user_account_id[]" multiple="multiple" class="form-select" data-control="select2" data-allow-clear="false"></select>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                <button type="submit" form="shop_access_form" class="btn btn-primary" id="submit-shop-access">Assign</button>
            </div>
        </div>
    </div>
</div>

<div id="shop-product-modal" class="modal fade" tabindex="-1" aria-labelledby="shop-product-modal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Product</h3>
                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </div>
            </div>

            <div class="modal-body">
                <form id="shop_product_form" method="post" action="#">
                    <?= $security->csrfInput('shop_product_form'); ?>

                    <div class="row mb-6">
                        <label class="col-lg-3 required col-form-label fw-semibold fs-6" for="product_id">Product</label>
                        <div class="col-lg-9">
                            <div class="row">
                                <div class="col-lg-12 fv-row">
                                    <select id="product_id" name="product_id[]" multiple="multiple" class="form-select" data-control="select2" data-allow-clear="false"></select>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                <button type="submit" form="shop_product_form" class="btn btn-primary" id="submit-shop-product">Assign</button>
            </div>
        </div>
    </div>
</div>

<?php require_once './app/Views/Partials/log-notes-modal.php'; ?>