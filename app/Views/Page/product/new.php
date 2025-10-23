<div class="card">
    <div class="card-header d-flex align-items-center">
        <h5 class="card-title mb-0">Product Details</h5>
    </div>
    <div class="card-body">
        <form id="product_form" method="post" action="#">
            <?= $security->csrfInput('product_form'); ?>
            <div class="fv-row mb-4">
                <label class="fs-6 fw-semibold form-label mt-3" for="product_name">
                    <span class="required">Product Name</span>
                </label>

                <input type="text" class="form-control" id="product_name" name="product_name" maxlength="200" autocomplete="off">
            </div>
            <div class="fv-row mb-4">
                <label class="fs-6 fw-semibold form-label mt-3" for="product_description">
                    Description
                </label>

                <textarea class="form-control" id="product_description" name="product_description" maxlength="1000" rows="3"></textarea>
            </div>
        </form>
    </div>
    <div class="card-footer d-flex justify-content-end py-6 px-9">
        <button type="button" id="discard-create" class="btn btn-light btn-active-light-primary me-2">Discard</button>
        <button type="submit" form="product_form" class="btn btn-primary" id="submit-data">Save</button>
    </div>
</div>