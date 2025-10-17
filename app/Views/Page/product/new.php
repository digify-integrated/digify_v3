<div class="card">
    <div class="card-header d-flex align-items-center">
        <h5 class="card-title mb-0">Product Details</h5>
    </div>
    <div class="card-body">
        <form id="product_form" method="post" action="#">
            <?= $security->csrfInput('product_form'); ?>
            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="product_name">
                            <span class="required">Product Name</span>
                        </label>

                        <input type="text" class="form-control" id="product_name" name="product_name" maxlength="200" autocomplete="off">
                    </div>
                </div>

                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="barcode">
                            <span>Barcode</span>
                        </label>

                        <input type="text" class="form-control" id="barcode" name="barcode" maxlength="50" autocomplete="off">
                    </div>
                </div>
            </div>
            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="product_type_id">
                            <span class="required">Product Type</span>
                        </label>

                        <select id="product_type_id" name="product_type_id" class="form-select" data-control="select2" data-allow-clear="false"></select>
                    </div>
                </div>
                
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="product_category_id">
                            <span class="required">Product Category</span>
                        </label>

                        <select id="product_category_id" name="product_category_id" class="form-select" data-control="select2" data-allow-clear="false"></select>
                    </div>
                </div>
            </div>
            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="quantity">
                            <span class="required">Quantity On-Hand</span>
                        </label>

                         <input type="number" class="form-control" id="quantity" name="quantity" min="0" step="1">
                    </div>
                </div>
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="sales_price">
                            <span class="required">Sales Price</span>
                        </label>

                         <input type="number" class="form-control" id="sales_price" name="sales_price" min="0.01" step="0.01">
                    </div>
                </div>
            </div>
            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="cost">
                            <span class="required">Cost</span>
                        </label>

                         <input type="number" class="form-control" id="cost" name="cost" min="0" step="0.01">
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="card-footer d-flex justify-content-end py-6 px-9">
        <button type="button" id="discard-create" class="btn btn-light btn-active-light-primary me-2">Discard</button>
        <button type="submit" form="product_form" class="btn btn-primary" id="submit-data">Save</button>
    </div>
</div>