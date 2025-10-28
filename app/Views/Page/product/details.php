<?php
    use App\Models\Product;

    $product = new Product();

    $archiveProduct    = $authentication->checkUserSystemActionPermission($userID, 19);
    $unarchiveProduct  = $authentication->checkUserSystemActionPermission($userID, 20);

    $productDetails     = $product->fetchProduct($detailID);
    $productStatus      = $productDetails['product_status'] ?? 'Active';
?>
<div class="d-flex flex-column flex-lg-row">
    <div class="flex-column flex-lg-row-auto w-lg-250px w-xl-350px mb-10">
        <div class="card mb-5 mb-xl-8">
            <div class="card-body">
                <div class="d-flex flex-center flex-column py-5">
                    <div class="image-input image-input-outline mb-7" data-kt-image-input="true">
                        <div class="image-input-wrapper w-120px h-120px" id="product_image_thumbnail" style="background-image: url(./assets/images/default/upload-placeholder.png)"></div>

                        <?php
                            echo ($permissions['write'] > 0) ? '<label class="btn btn-icon btn-circle btn-active-color-primary w-25px h-25px bg-body shadow" data-kt-image-input-action="change" data-bs-toggle="tooltip" aria-label="Change product image" data-bs-original-title="Change product image" data-kt-initialized="1">
                                                                    <i class="ki-outline ki-pencil fs-7"></i>
                                                                    <input type="file" id="product_image" name="product_image" accept=".png, .jpg, .jpeg">
                                                                </label>' : '';
                        ?>
                    </div>
                    <div class="text-muted  text-center fs-7">Set the product image. Only *.png, *.jpg and *.jpeg image files are accepted</div>
                </div>
            </div>
        </div>

        <div class="card pt-4 mb-6 mb-xl-9">
            <div class="card-header">
                <div class="card-title">
                    <h2>Categories</h2>
                </div>
            </div>
                            
            <form id="product_category_form" class="form" method="post" action="#">
                <?= $security->csrfInput('product_category_form'); ?>
                <div class="card-body border-top p-9">
                    <div class="fv-row mb-0">
                        <select id="product_category_id" name="product_category_id[]" multiple="multiple" class="form-select" data-control="select2" data-allow-clear="false" <?php echo $disabled; ?>></select>
                    </div>
                </div>
                <?php
                    echo ($permissions['write'] > 0) ? '<div class="card-footer d-flex justify-content-end py-6 px-9">
                                                            <button type="submit" form="product_category_form" class="btn btn-primary" id="submit-product-category">Save</button>
                                                        </div>' : '';
                ?>
            </form>
        </div>

        <div class="card mb-5 mb-xl-8">
            <div class="card-header border-0">
                <div class="card-title">
                    <h3 class="fw-bold m-0">Product Settings</h3>
                </div>
            </div>
            
            <div class="card-body pt-2">                
                <div class="py-2">
                    <div class="d-flex flex-stack">
                        <div class="d-flex">
                            <div class="d-flex flex-column">
                                <div class="fs-5 text-gray-900 fw-bold">Sales</div>
                                <div class="fs-7 fw-semibold text-muted">Check if you want this product to be sellable.</div>
                            </div>
                        </div>

                        <div class="d-flex justify-content-end">
                            <label class="form-check form-switch form-switch-sm form-check-custom form-check-solid">
                                <input class="form-check-input" type="checkbox" id="is-sellable" <?php echo $disabled; ?>>
                                <span class="form-check-label fw-semibold text-muted" for="is-sellable"></span>
                            </label>
                        </div>
                    </div>

                    <div class="separator separator-dashed my-5"></div>

                    <div class="d-flex flex-stack">
                        <div class="d-flex">
                            <div class="d-flex flex-column">
                                <div class="fs-5 text-gray-900 fw-bold">Purchase</div>
                                <div class="fs-7 fw-semibold text-muted">Check if you want this product to be purchasable.</div>
                            </div>
                        </div>

                        <div class="d-flex justify-content-end">
                            <label class="form-check form-switch form-switch-sm form-check-custom form-check-solid">
                                <input class="form-check-input" type="checkbox" id="is-purchasable" <?php echo $disabled; ?>>
                                <span class="form-check-label fw-semibold text-muted" for="is-purchasable"></span>
                            </label>
                        </div>
                    </div>

                    <div class="separator separator-dashed my-5"></div>

                    <div class="d-flex flex-stack">
                        <div class="d-flex">
                            <div class="d-flex flex-column">
                                <div class="fs-5 text-gray-900 fw-bold">Point of Sale</div>
                                <div class="fs-7 fw-semibold text-muted">Check if you want this product to appear in the Point of Sale.</div>
                            </div>
                        </div>

                        <div class="d-flex justify-content-end">
                            <label class="form-check form-switch form-switch-sm form-check-custom form-check-solid">
                                <input class="form-check-input" type="checkbox" id="show-on-pos" <?php echo $disabled; ?>>
                                <span class="form-check-label fw-semibold text-muted" for="show-on-pos"></span>
                            </label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="flex-lg-row-fluid ms-lg-15">
        <ul class="nav nav-custom nav-tabs nav-line-tabs nav-line-tabs-2x border-0 fs-4 fw-semibold mb-8" role="tablist">
            <li class="nav-item" role="presentation">
                <a class="nav-link text-active-primary pb-4 active" data-bs-toggle="tab" href="#general_tab" aria-selected="false" role="tab" tabindex="-1">General</a>
            </li>

            <li class="nav-item" role="presentation">
                <a class="nav-link text-active-primary pb-4" data-bs-toggle="tab" href="#advanced_tab" aria-selected="false" role="tab" tabindex="-1">Advanced</a>
            </li>
            
            <?php
                if ($permissions['delete'] > 0 || ($archiveProduct['total'] > 0 && $productStatus === 'Active') || ($unarchiveProduct['total'] > 0 && $productStatus === 'Archived')) {
                    $action = '<li class="nav-item ms-auto">
                                    <a href="#" class="btn btn-primary ps-7" data-kt-menu-trigger="click" data-kt-menu-attach="parent" data-kt-menu-placement="bottom-end">
                                        Actions
                                        <i class="ki-outline ki-down fs-2 me-0"></i>
                                    </a>
                                    <div class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-600 menu-state-bg-light-primary fw-semibold fs-7 w-125px py-4" data-kt-menu="true">';
                            
                                    if($archiveProduct['total'] > 0 && $productStatus === 'Active'){
                                        $action .= ' <div class="menu-item px-3">
                                                        <a href="javascript:void(0);" class="menu-link px-3" id="archive-product">
                                                            Archive
                                                        </a>
                                                    </div>';
                                    }
                            
                                    if($unarchiveProduct['total'] > 0 && $productStatus === 'Archived'){
                                        $action .= ' <div class="menu-item px-3">
                                                        <a href="javascript:void(0);" class="menu-link px-3" id="unarchive-product">
                                                            Unarchive
                                                        </a>
                                                    </div>';
                                    }
                            
                                    if($permissions['delete'] > 0){
                                        $action .= ' <div class="menu-item px-3">
                                                        <a href="javascript:void(0);" class="menu-link px-3" id="delete-product">
                                                            Delete
                                                        </a>
                                                    </div>';
                                    }
                        
                    $action .= '<div>
                            </li>';
                        
                    echo $action;
                }
            ?>        
        </ul>

        <div class="tab-content">
            <div class="tab-pane fade active show" id="general_tab" role="tabpanel">
                <div class="card card-flush py-4 mb-10">
                    <div class="card-header">
                        <div class="card-title">
                            <h2>General</h2>
                        </div>
                    </div>
                    
                    <div class="card-body pt-0">
                        <form id="product_general_form" class="form" method="post" action="#">
                            <?= $security->csrfInput('product_general_form'); ?>
                            <div class="mb-10 fv-row">
                                <label class="required form-label">Product Name</label>
                                <input type="text" id="product_name" name="product_name" class="form-control mb-2" maxlength="100" autocomplete="off" <?php echo $disabled; ?>/>
                                <div class="text-muted fs-7">A product name is required and recommended to be unique.</div>
                            </div>
                            
                            <div>
                                <label class="form-label">Description</label>
                                <textarea class="form-control" id="product_description" name="product_description" maxlength="1000" rows="3" <?php echo $disabled; ?>></textarea>
                            </div>
                        </form>
                    </div>
                    <?php
                        echo ($permissions['write'] > 0) ? '<div class="d-flex justify-content-end py-6 px-9">
                                                                <button type="submit" form="product_general_form" class="btn btn-primary" id="submit-general">Save</button>
                                                            </div>' : '';
                    ?>
                </div>

                <div class="card card-flush py-4">
                    <div class="card-header">
                        <div class="card-title">
                            <h2>Pricing</h2>
                        </div>
                    </div>
                
                    <div class="card-body pt-0">
                        <form id="product_pricing_form" class="form" method="post" action="#">
                            <?= $security->csrfInput('product_pricing_form'); ?>
                            
                            <div class="d-flex flex-wrap gap-5">
                                <div class="fv-row w-100 flex-md-root mb-2">
                                    <label class="required form-label" for="sales_price">Sales Price</label>
                                    <input type="number" id="sales_price" name="sales_price" class="form-control" min="0" step="0.0001" <?php echo $disabled; ?>/>
                                </div>

                                <div class="fv-row w-100 flex-md-root mb-10">
                                    <label class="required form-label" for="cost">Cost</label>
                                    <input type="number" id="cost" name="cost" class="form-control" min="0" step="0.0001" <?php echo $disabled; ?>/>
                                </div>
                            </div>

                            <div class="d-flex flex-wrap gap-5">
                                <div class="fv-row w-100 flex-md-root mb-2">
                                    <label class="form-label" for="sales_tax_id">Sales Tax</label>
                                    <select id="sales_tax_id" name="sales_tax_id[]" multiple="multiple" class="form-select" data-control="select2" data-allow-clear="false" <?php echo $disabled; ?>></select>
                                </div>
                                <div class="fv-row w-100 flex-md-root">
                                    <label class="form-label" for="purchase_tax_id">Purchase Tax</label>
                                    <select id="purchase_tax_id" name="purchase_tax_id[]" multiple="multiple" class="form-select" data-control="select2" data-allow-clear="false" <?php echo $disabled; ?>></select>
                                </div>
                            </div>
                        </form>
                    </div>
                    <?php
                        echo ($permissions['write'] > 0) ? '<div class="d-flex justify-content-end py-6 px-9">
                                                                <button type="submit" form="product_pricing_form" class="btn btn-primary" id="submit-pricing">Save</button>
                                                            </div>' : '';
                    ?>
                </div>
            </div>

            <div class="tab-pane fade" id="advanced_tab" role="tabpanel">
                <div class="d-flex flex-column gap-7 gap-lg-10">
                    <div class="card card-flush py-4">
                        <div class="card-header">
                            <div class="card-title">
                                <h2>Inventory</h2>
                            </div>
                        </div>
                        
                        <div class="card-body pt-0">
                            <form id="product_inventory_form" class="form" method="post" action="#">
                                <?= $security->csrfInput('product_inventory_form'); ?>
                                <div class="fv-row">
                                    <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">                
                                        <div class="col">
                                            <div class="fv-row mb-7">
                                            <label class="required form-label" for="sku">SKU</label>
                                                <input type="text" id="sku" name="sku" class="form-control mb-2" maxlength="200" <?php echo $disabled; ?>>
                                            </div>
                                        </div>

                                        <div class="col">
                                            <div class="fv-row mb-7">
                                                <label class="required form-label" for="barcode">Barcode</label>
                                                <input type="text" id="barcode" name="barcode" class="form-control mb-2"  maxlength="200" <?php echo $disabled; ?>>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="fv-row">
                                    <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">  
                                        <div class="col">
                                            <div class="fv-row mb-7">
                                                <label class="required form-label" for="product_type">Product Type</label>
                                                <div class="d-flex gap-3">
                                                    <select id="product_type" name="product_type" class="form-select" data-control="select2" data-allow-clear="false" <?php echo $disabled; ?>>
                                                        <option value="">--</option>
                                                        <option value="Combo">Combo</option>
                                                        <option value="Goods">Goods</option>
                                                        <option value="Services">Services</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col">
                                            <div class="fv-row mb-7">
                                            <label class="required form-label" for="quantity_on_hand">Quantity On Hand</label>
                                                <div class="d-flex gap-3">
                                                    <input type="number" id="quantity_on_hand" name="quantity_on_hand" class="form-control mb-2" min="0" step="0.0001" <?php echo $disabled; ?>>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="fv-row">
                                    <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">                
                                        <div class="col">
                                            <div class="fv-row mb-7">
                                            <label class="required form-label" for="unit_id">Unit of Measurement</label>
                                                <select id="unit_id" name="unit_id" class="form-select" data-control="select2" data-allow-clear="false"></select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <?php
                            echo ($permissions['write'] > 0) ? '<div class="d-flex justify-content-end py-6 px-9">
                                                                    <button type="submit" form="product_inventory_form" class="btn btn-primary" id="submit-inventory">Save</button>
                                                                </div>' : '';
                        ?>
                    </div>

                    <div class="card card-flush py-4">
                        <div class="card-header">
                            <div class="card-title">
                                <h2>Variations</h2>
                            </div>
                            <div class="card-toolbar">
                                <div class="d-flex justify-content-end" data-kt-customer-table-toolbar="base">
                                    <?php
                                        echo $permissions['write'] > 0 ? '<button type="button" class="btn btn-light-primary me-3" data-bs-toggle="modal" data-bs-target="#product-variations-modal" id="product-variation">Add Variation</button>' : '';
                                    ?> 
                                </div>
                            </div>
                        </div>
                        
                        <div class="card-body pt-0">
                            <table class="table align-middle cursor-pointer table-row-dashed fs-6 gy-5 gs-7" id="role-permission-table">
                                <thead>
                                    <tr class="fw-semibold fs-6 text-gray-800">
                                        <th>Variation</th>
                                        <th>Attribute</th>
                                        <th>Extra Price</th>
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
                                <h2>Pricelist</h2>
                            </div>
                            <div class="card-toolbar">
                                <div class="d-flex justify-content-end" data-kt-customer-table-toolbar="base">
                                    <?php
                                        echo $permissions['write'] > 0 ? '<button type="button" class="btn btn-light-primary me-3" data-bs-toggle="modal" data-bs-target="#product-pricelist-modal" id="product-pricelist">Add Pricelist</button>' : '';
                                    ?> 
                                </div>
                            </div>
                        </div>
                        
                        <div class="card-body pt-0">
                            <table class="table align-middle cursor-pointer table-row-dashed fs-6 gy-5 gs-7" id="role-permission-table">
                                <thead>
                                    <tr class="fw-semibold fs-6 text-gray-800">
                                        <th>Variation</th>
                                        <th>Attribute</th>
                                        <th>Extra Price</th>
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
                                <h2>Shipping</h2>
                            </div>
                        </div>
                        
                        <div class="card-body pt-0">
                            <form id="product_shipping_form" class="form" method="post" action="#">
                                <?= $security->csrfInput('product_shipping_form'); ?>
                                <div class="mb-10 fv-row">
                                    <label class="form-label">Weight</label>
                                    <div class="input-group">
                                        <input type="number" id="weight" name="weight" class="form-control" min="0" step="0.0001" <?php echo $disabled; ?>>
                                        <span class="input-group-text">kg</span>
                                    </div>
                                </div>
                                <div class="fv-row">
                                    <label class="form-label">Dimension</label>
                                    <div class="d-flex flex-wrap flex-sm-nowrap gap-3">
                                        <div class="input-group">
                                            <input type="number" id="width" name="width" class="form-control" min="0" step="0.0001" placeholder="Width" <?php echo $disabled; ?>>
                                            <span class="input-group-text">cm</span>
                                        </div>
                                        <div class="input-group">
                                            <input type="number" id="height" name="height" class="form-control" min="0" step="0.0001" placeholder="Height" <?php echo $disabled; ?>>
                                            <span class="input-group-text">cm</span>
                                        </div>
                                            
                                        <div class="input-group">
                                            <input type="number" id="length" name="length" class="form-control" min="0" step="0.0001" placeholder="Length" <?php echo $disabled; ?>>
                                            <span class="input-group-text">cm</span>
                                        </div>                                        
                                    </div>
                                </div>
                            </form>
                        </div>
                        <?php
                            echo ($permissions['write'] > 0) ? '<div class="d-flex justify-content-end py-6 px-9">
                                                                    <button type="submit" form="product_shipping_form" class="btn btn-primary" id="submit-shipping">Save</button>
                                                                </div>' : '';
                        ?>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="product-variations-modal" class="modal fade" tabindex="-1" aria-labelledby="product-variations-modal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Add Variation</h3>
                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </div>
            </div>

            <div class="modal-body">
                <form id="personal_details_form" method="post" action="#">
                    <?= $security->csrfInput('personal_details_form'); ?>

                    <div class="row mb-6">
                        <label class="col-lg-3 required col-form-label fw-semibold fs-6" for="blood_type_id">Variation</label>
                        <div class="col-lg-9">
                            <div class="row">
                                <div class="col-lg-12 fv-row">
                                    <select id="attribute_value_id" name="attribute_value_id" class="form-select" data-control="select2" data-allow-clear="false"></select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <label class="col-lg-3 required col-form-label fw-semibold fs-6" for="extra_price">Extra Price</label>
                        <div class="col-lg-9">
                            <div class="row">
                                <div class="col-lg-12 fv-row">
                                    <input type="number" class="form-control" id="extra_price" name="extra_price" min="0" step="0.01">
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                <button type="submit" form="role_permission_assignment_form" class="btn btn-primary" id="submit-assignment">Assign</button>
            </div>
        </div>
    </div>
</div>

<?php require_once './app/Views/Partials/log-notes-modal.php'; ?>