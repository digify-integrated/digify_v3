<?php
    use App\Models\Product;

    $product = new Product();

    $archiveProduct    = $authentication->checkUserSystemActionPermission($userID, 19);
    $unarchiveProduct  = $authentication->checkUserSystemActionPermission($userID, 20);

    $productDetails    = $product->fetchProduct($detailID);
    $employmentStatus   = $productDetails['employment_status'] ?? 'Active';
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
                                                            <button type="submit" form="product_category_form" class="btn btn-primary" id="submit-file-extension">Save</button>
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
                                <input class="form-check-input" type="checkbox" id="two-factor-authentication" <?php echo $disabled; ?>>
                                <span class="form-check-label fw-semibold text-muted" for="two-factor-authentication"></span>
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
                                <input class="form-check-input" type="checkbox" id="multiple-login-sessions" <?php echo $disabled; ?>>
                                <span class="form-check-label fw-semibold text-muted" for="multiple-login-sessions"></span>
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
                                <input class="form-check-input" type="checkbox" id="multiple-login-sessions" <?php echo $disabled; ?>>
                                <span class="form-check-label fw-semibold text-muted" for="multiple-login-sessions"></span>
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
                if ($permissions['delete'] > 0 || ($archiveProduct['total'] > 0 && $employmentStatus === 'Active') || ($unarchiveProduct['total'] > 0 && $employmentStatus === 'Archived')) {
                    $action = '<li class="nav-item ms-auto">
                                    <a href="#" class="btn btn-primary ps-7" data-kt-menu-trigger="click" data-kt-menu-attach="parent" data-kt-menu-placement="bottom-end">
                                        Actions
                                        <i class="ki-outline ki-down fs-2 me-0"></i>
                                    </a>
                                    <div class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-600 menu-state-bg-light-primary fw-semibold fs-7 w-125px py-4" data-kt-menu="true">';
                            
                                    if($archiveProduct['total'] > 0 && $employmentStatus === 'Active'){
                                        $action .= ' <div class="menu-item px-3">
                                                        <a href="javascript:void(0);" class="menu-link px-3" data-bs-toggle="modal" data-bs-target="#archive_product_modal">
                                                            Archive
                                                        </a>
                                                    </div>';
                                    }
                            
                                    if($unarchiveProduct['total'] > 0 && $employmentStatus === 'Archived'){
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
                        <div class="mb-10 fv-row">
                            <label class="required form-label">Product Name</label>
                            <input type="text" name="product_name" class="form-control mb-2" placeholder="Product name" value="Sample product" />
                            <div class="text-muted fs-7">A product name is required and recommended to be unique.</div>
                        </div>
                        
                        <div>
                            <label class="form-label">Description</label>
                            <textarea class="form-control" id="product_description" name="product_description" maxlength="1000" rows="3"></textarea>
                        </div>
                    </div>
                </div>

                <div class="card card-flush py-4">
                    <div class="card-header">
                        <div class="card-title">
                            <h2>Pricing</h2>
                        </div>
                    </div>
                
                    <div class="card-body pt-0">
                        <div class="mb-10 fv-row">
                            <label class="required form-label">Sales Price</label>
                            <input type="text" id="sales_price" name="sales_price" class="form-control mb-2" />
                            <div class="text-muted fs-7">Set the product price.</div>
                        </div>
                        
                        <div class="fv-row mb-10">
                            <label class="fs-6 fw-semibold mb-2">
                                Discount Type
                                <span class="ms-1"  data-bs-toggle="tooltip" title="Select a discount type that will be applied to this product" >
                                <i class="ki-outline ki-information-5 text-gray-500 fs-6"></i></span>
                            </label>
                            
                            <div class="row row-cols-1 row-cols-md-3 row-cols-lg-1 row-cols-xl-3 g-9" data-kt-buttons="true" data-kt-buttons-target="[data-kt-button='true']">
                                <div class="col">
                                    <label class="btn btn-outline btn-outline-dashed btn-active-light-primary active d-flex text-start p-6" data-kt-button="true">
                                        <span class="form-check form-check-custom form-check-solid form-check-sm align-items-start mt-1">
                                            <input class="form-check-input" type="radio" name="discount_option" value="None" checked="checked" />
                                        </span>
                                        <span class="ms-5">
                                            <span class="fs-4 fw-bold text-gray-800 d-block">No Discount</span>
                                        </span>
                                    </label>
                                </div>
                                
                                <div class="col">
                                    <label class="btn btn-outline btn-outline-dashed btn-active-light-primary d-flex text-start p-6" data-kt-button="true">
                                        <span class="form-check form-check-custom form-check-solid form-check-sm align-items-start mt-1">
                                            <input class="form-check-input" type="radio" name="discount_option" value="Percentage" />
                                        </span>

                                        <span class="ms-5">
                                            <span class="fs-4 fw-bold text-gray-800 d-block">Percentage %</span>
                                        </span>
                                    </label>
                                </div>
                                
                                <div class="col">
                                    <label class="btn btn-outline btn-outline-dashed btn-active-light-primary d-flex text-start p-6" data-kt-button="true">
                                        <span class="form-check form-check-custom form-check-solid form-check-sm align-items-start mt-1">
                                            <input class="form-check-input" type="radio" name="discount_option" value="Fixed" />
                                        </span>
                                        
                                        <span class="ms-5">
                                            <span class="fs-4 fw-bold text-gray-800 d-block">Fixed Price</span>
                                        </span>
                                    </label>
                                </div>
                            </div>
                        </div>

                        <div class="mb-10 fv-row" id="kt_ecommerce_add_product_discount_fixed">
                            <label class="form-label">Discounted Price</label>
                            <input type="text" name="dicsounted_price" class="form-control mb-2" placeholder="Discounted price" />
                            <div class="text-muted fs-7">Set the discounted product price. The product will be reduced at the determined fixed price</div>
                        </div>
                        
                        <div class="d-flex flex-wrap gap-5">
                            <div class="fv-row w-100 flex-md-root">
                                <label class="required form-label">Sales Tax</label>
                                <select id="sales_tax_id" name="sales_tax_id[]" multiple="multiple" class="form-select" data-control="select2" data-allow-clear="false"></select>
                            </div>
                            <div class="fv-row w-100 flex-md-root">
                                <label class="required form-label">Purchase Tax</label>
                               <select id="purchase_tax_id" name="purchase_tax_id[]" multiple="multiple" class="form-select" data-control="select2" data-allow-clear="false"></select>
                            </div>
                        </div>
                    </div>
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
                            <div class="fv-row fv-plugins-icon-container">
                                <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">                
                                    <div class="col">
                                        <div class="fv-row mb-7">
                                           <label class="required form-label">SKU</label>
                                            <input type="text" name="sku" class="form-control mb-2" placeholder="SKU Number" value="011985001">
                                        </div>
                                    </div>

                                    <div class="col">
                                        <div class="fv-row mb-7">
                                            <label class="required form-label">Barcode</label>
                                            <input type="text" name="barcode" class="form-control mb-2" placeholder="Barcode Number" value="45874521458">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="fv-row fv-plugins-icon-container">
                                <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">  
                                    <div class="col">
                                        <div class="fv-row mb-7">
                                            <label class="required form-label">Product Type</label>
                                            <div class="d-flex gap-3">
                                                <select id="product_type" name="private_address_city_id" class="form-select" data-control="select2" data-allow-clear="false">
                                                    <option value="">--</option>
                                                    <option value="Goods">Goods</option>
                                                    <option value="Services">Services</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col">
                                        <div class="fv-row mb-7">
                                           <label class="required form-label">Quantity On Hand</label>
                                            <div class="d-flex gap-3">
                                                <input type="number" name="shelf" class="form-control mb-2" min="0" step="1">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card card-flush py-4">
                        <div class="card-header">
                            <div class="card-title">
                                <h2>Variations</h2>
                            </div>
                        </div>
                        
                        <div class="card-body pt-0">
                        </div>
                    </div>

                    <div class="card card-flush py-4">
                        <div class="card-header">
                            <div class="card-title">
                                <h2>Shipping</h2>
                            </div>
                        </div>
                        
                        <div class="card-body pt-0">
                            <div id="kt_ecommerce_add_product_shipping">
                                <div class="mb-10 fv-row">
                                    <label class="form-label">Weight</label>
                                    <input type="text" name="weight" class="form-control mb-2" placeholder="Product weight" value="4.3">
                                    <div class="text-muted fs-7">Set a product weight in kilograms (kg).</div>
                                </div>
                                <div class="fv-row">
                                    <label class="form-label">Dimension</label>
                                    <div class="d-flex flex-wrap flex-sm-nowrap gap-3">
                                        <input type="number" name="width" class="form-control mb-2" placeholder="Width (w)" value="12">
                                        <input type="number" name="height" class="form-control mb-2" placeholder="Height (h)" value="4">
                                        <input type="number" name="length" class="form-control mb-2" placeholder="Lengtn (l)" value="8.5">
                                    </div>
                                    <div class="text-muted fs-7">Enter the product dimensions in centimeters (cm).</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="update_personal_details_modal" class="modal fade" tabindex="-1" aria-labelledby="update_personal_details_modal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Personal Details</h3>
                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </div>
            </div>

            <div class="modal-body">
                <form id="personal_details_form" method="post" action="#">
                    <?= $security->csrfInput('personal_details_form'); ?>
                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label required fw-semibold fs-6" for="first_name">First Name</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <input type="text" class="form-control mb-3 mb-lg-0" id="first_name" name="first_name" maxlength="300" autocomplete="off">
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label fw-semibold fs-6" for="middle_name">Middle Name</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <input type="text" class="form-control mb-3 mb-lg-0" id="middle_name" name="middle_name" maxlength="300" autocomplete="off">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label required fw-semibold fs-6" for="last_name">Last Name</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <input type="text" class="form-control mb-3 mb-lg-0" id="last_name" name="last_name" maxlength="300" autocomplete="off">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label fw-semibold fs-6" for="suffix">Suffix</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <input type="text" class="form-control mb-3 mb-lg-0" id="suffix" name="suffix" maxlength="10" autocomplete="off">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label required fw-semibold fs-6">Private Address</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <textarea class="form-control mb-3 mb-lg-0" id="private_address" name="private_address" maxlength="500" autocomplete="off"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <div class="col-lg-4"></div>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <select id="private_address_city_id" name="private_address_city_id" class="form-select" data-control="select2" data-allow-clear="false"></select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label fw-semibold fs-6" for="nickname">Nickname</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <input type="text" class="form-control mb-3 mb-lg-0" id="nickname" name="nickname" maxlength="100" autocomplete="off">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label required fw-semibold fs-6" for="civil_status_id">Civil Status</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <select id="civil_status_id" name="civil_status_id" class="form-select" data-control="select2" data-allow-clear="false"></select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label fw-semibold fs-6" for="dependents">Number of Dependents</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <input type="number" class="form-control" id="dependents" name="dependents" min="0" step="1">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label fw-semibold fs-6" for="religion_id">Religion</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <select id="religion_id" name="religion_id" class="form-select" data-control="select2" data-allow-clear="false"></select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label fw-semibold fs-6" for="blood_type_id">Blood Type</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <select id="blood_type_id" name="blood_type_id" class="form-select" data-control="select2" data-allow-clear="false"></select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label fw-semibold fs-6" for="home_work_distance">Home-Work Distance</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <div class="input-group">
                                        <input type="number" class="form-control" id="home_work_distance" name="home_work_distance" min="0" step="0.01">
                                        <span class="input-group-text">km</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label fw-semibold fs-6" for="height">Height</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <div class="input-group">
                                        <input type="number" class="form-control" id="height" name="height" min="0" step="0.01">
                                        <span class="input-group-text">cm</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <label class="col-lg-4 col-form-label fw-semibold fs-6" for="weight">Weight</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <div class="input-group">
                                        <input type="number" class="form-control" id="weight" name="weight" min="0" step="0.01">
                                        <span class="input-group-text">kg</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                <button type="submit" form="personal_details_form" class="btn btn-primary" id="submit-personal-details">Save</button>
            </div>
        </div>
    </div>
</div>

<div id="product_language_modal" class="modal fade" tabindex="-1" aria-labelledby="product_language_modal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Product Language</h3>
                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </div>
            </div>

            <div class="modal-body">
                <form id="product_language_form" method="post" action="#">
                    <?= $security->csrfInput('product_language_form'); ?>
                    <input type="hidden" id="product_language_id" name="product_language_id">
                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label required fw-semibold fs-6" for="language_id">Language</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <select id="language_id" name="language_id" class="form-select" data-dropdown-parent="#product_language_modal" data-control="select2" data-allow-clear="false"></select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <label class="col-lg-4 col-form-label required fw-semibold fs-6" for="language_proficiency_id">Language Proficiency</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <select id="language_proficiency_id" name="language_proficiency_id" data-dropdown-parent="#product_language_modal" class="form-select" data-control="select2" data-allow-clear="false"></select>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                <button type="submit" form="product_language_form" class="btn btn-primary" id="submit_product_language">Save</button>
            </div>
        </div>
    </div>
</div>

<div id="product_education_modal" class="modal fade" tabindex="-1" aria-labelledby="product_education_modal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Product Educational Background</h3>
                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </div>
            </div>

            <div class="modal-body">
                <form id="product_education_form" method="post" action="#">
                    <?= $security->csrfInput('product_education_form'); ?>
                    <input type="hidden" id="product_education_id" name="product_education_id">
                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label required fw-semibold fs-6" for="school">School</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <input type="text" class="form-control mb-3 mb-lg-0" id="school" name="school" maxlength="100" autocomplete="off">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label fw-semibold fs-6" for="degree">Degree</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <input type="text" class="form-control mb-3 mb-lg-0" id="degree" name="degree" maxlength="100" autocomplete="off">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label fw-semibold fs-6" for="field_of_study">Field of Study</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <input type="text" class="form-control mb-3 mb-lg-0" id="field_of_study" name="field_of_study" maxlength="100" autocomplete="off">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label required fw-semibold fs-6" for="start_month">Start Date</label>
                        <div class="col-lg-4">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <select id="start_month" name="start_month" class="form-select" data-dropdown-parent="#product_education_modal" data-control="select2" data-allow-clear="false">
                                        <option value="">--</option>
                                        <?php echo $systemHelper->generateMonthOptions(); ?>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <select id="start_year" name="start_year" class="form-select" data-dropdown-parent="#product_education_modal" data-control="select2" data-allow-clear="false">
                                        <option value="">--</option>
                                        <?php echo $systemHelper->generateYearOptions(date('Y'), date('Y', strtotime('-100 years'))); ?>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label fw-semibold fs-6" for="end_month">End Date (or expected)</label>
                        <div class="col-lg-4">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <select id="end_month" name="end_month" class="form-select" data-dropdown-parent="#product_education_modal" data-control="select2" data-allow-clear="false">
                                        <option value="">--</option>
                                        <?php echo $systemHelper->generateMonthOptions(); ?>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <select id="end_year" name="end_year" class="form-select" data-dropdown-parent="#product_education_modal" data-control="select2" data-allow-clear="false">
                                        <option value="">--</option>
                                       <?php echo $systemHelper->generateYearOptions(date('Y'), date('Y', strtotime('-100 years'))); ?>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label fw-semibold fs-6" for="activities_societies">Activities and Societies</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <textarea class="form-control" id="activities_societies" name="activities_societies" maxlength="5000"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-4 col-form-label fw-semibold fs-6" for="education_description">Description</label>
                        <div class="col-lg-8">
                            <div class="row">
                                <div class="col-lg-12 fv-row fv-plugins-icon-container">
                                    <textarea class="form-control" id="education_description" name="education_description" maxlength="5000"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                <button type="submit" form="product_education_form" class="btn btn-primary" id="submit_product_education">Save</button>
            </div>
        </div>
    </div>
</div>

<?php require_once './app/Views/Partials/log-notes-modal.php'; ?>