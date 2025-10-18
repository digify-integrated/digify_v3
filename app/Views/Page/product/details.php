
<div class="d-flex flex-column flex-lg-row">
    <div class="d-flex flex-column gap-7 gap-lg-10 w-100 w-lg-300px mb-7 me-lg-10">
        <div class="card card-flush">
            <div class="card-body text-center">
                <div class="image-input image-input-outline" data-kt-image-input="true">
                    <div class="image-input-wrapper w-125px h-125px" id="product_image_thumbnail" style="background-image: url(./assets/images/default/default-product-image.png); background-size: cover; background-repeat: no-repeat; background-position: center;"></div>

                    <?php
                        echo ($permissions['write'] > 0) ? '<label class="btn btn-icon btn-circle btn-active-color-primary w-25px h-25px bg-body shadow" data-kt-image-input-action="change" data-bs-toggle="tooltip" aria-label="Change image" data-bs-original-title="Change image" data-kt-initialized="1">
                                                                <i class="ki-outline ki-pencil fs-7"></i>
                                                                <input type="file" id="product_image" name="product_image" accept=".png, .jpg, .jpeg">
                                                            </label>' : '';
                    ?>
                </div>
                        
                <div class="form-text mt-5">Set the product image image. Only *.png, *.jpg and *.jpeg image files are accepted.</div>
            </div>
        </div>
    </div>
    <div class="d-flex flex-column flex-row-fluid gap-7 gap-lg-10">
        <div class="card card-flush">
            <div class="card-header border-0">
                <div class="card-title m-0">
                    <h3 class="fw-bold m-0">Product Details</h3>
                </div>
                <?php
                    if ($permissions['delete'] > 0) {
                        $action = '<a href="#" class="btn btn-light-primary btn-flex btn-center btn-active-light-primary show menu-dropdown align-self-center" data-kt-menu-trigger="click" data-kt-menu-placement="bottom-end">
                                        Actions
                                        <i class="ki-outline ki-down fs-5 ms-1"></i>
                                    </a>
                                    <div class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-600 menu-state-bg-light-primary fw-semibold fs-7 w-125px py-4" data-kt-menu="true" style="z-index: 107; position: fixed; inset: 0px 0px auto auto; margin: 0px; transform: translate(-60px, 539px);" data-popper-placement="bottom-end">';
                    
                        if ($permissions['delete'] > 0) {
                            $action .= '<div class="menu-item px-3">
                                            <a href="javascript:void(0);" class="menu-link px-3" id="delete-product">
                                                Delete
                                            </a>
                                        </div>';
                        }
                    
                        $action .= '</div>';
                    
                        echo $action;
                    }
                ?>
            </div>
            <div class="card-body">
                <form id="product_form" class="form" method="post" action="#">
                    <?= $security->csrfInput('product_form'); ?>
                    <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                        <div class="col">
                            <div class="fv-row mb-7">
                                <label class="fs-6 fw-semibold form-label mt-3" for="product_name">
                                    <span class="required">Product Name</span>
                                </label>

                                <input type="text" class="form-control" id="product_name" name="product_name" maxlength="200" autocomplete="off" <?php echo $disabled; ?>>
                            </div>
                        </div>

                        <div class="col">
                            <div class="fv-row mb-7">
                                <label class="fs-6 fw-semibold form-label mt-3" for="barcode">
                                    <span>Barcode</span>
                                </label>

                                <input type="text" class="form-control" id="barcode" name="barcode" maxlength="50" autocomplete="off" <?php echo $disabled; ?>>
                            </div>
                        </div>
                    </div>
                    <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                        <div class="col">
                            <div class="fv-row mb-7">
                                <label class="fs-6 fw-semibold form-label mt-3" for="product_type_id">
                                    <span class="required">Product Type</span>
                                </label>

                                <select id="product_type_id" name="product_type_id" class="form-select" data-control="select2" data-allow-clear="false" <?php echo $disabled; ?>></select>
                            </div>
                        </div>
                        
                        <div class="col">
                            <div class="fv-row mb-7">
                                <label class="fs-6 fw-semibold form-label mt-3" for="product_category_id">
                                    <span class="required">Product Category</span>
                                </label>

                                <select id="product_category_id" name="product_category_id" class="form-select" data-control="select2" data-allow-clear="false" <?php echo $disabled; ?>></select>
                            </div>
                        </div>
                    </div>
                    <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                        <div class="col">
                            <div class="fv-row mb-7">
                                <label class="fs-6 fw-semibold form-label mt-3" for="quantity">
                                    <span class="required">Quantity On-Hand</span>
                                </label>

                                <input type="number" class="form-control" id="quantity" name="quantity" min="0" step="1" <?php echo $disabled; ?>>
                            </div>
                        </div>
                        <div class="col">
                            <div class="fv-row mb-7">
                                <label class="fs-6 fw-semibold form-label mt-3" for="sales_price">
                                    <span class="required">Sales Price</span>
                                </label>

                                <input type="number" class="form-control" id="sales_price" name="sales_price" min="0" step="0.01" <?php echo $disabled; ?>>
                            </div>
                        </div>
                    </div>
                    <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                        <div class="col">
                            <div class="fv-row mb-7">
                                <label class="fs-6 fw-semibold form-label mt-3" for="cost">
                                    <span class="required">Cost</span>
                                </label>

                                <input type="number" class="form-control" id="cost" name="cost" min="0" step="0.01" <?php echo $disabled; ?>>
                            </div>
                        </div>
                    </div>

                    <?php
                        echo ($permissions['write'] > 0) ? '<div class="card-footer d-flex justify-content-end py-6 px-9">
                                                                <button type="button" id="discard-create" class="btn btn-light btn-active-light-primary me-2">Discard</button>
                                                                <button type="submit" form="product_form" class="btn btn-primary" id="submit-data">Save Changes</button>
                                                            </div>' : '';
                    ?>
                </form>
            </div>
        </div>
    </div>
</div>

<?php require_once './app/Views/Partials/log-notes-modal.php'; ?>