<div class="card">
    <div class="card-header d-flex align-items-center">
        <h5 class="card-title mb-0">Pricelist Details</h5>
    </div>
    <div class="card-body">
        <form id="product_pricelist_form" method="post" action="#">
            <?= $security->csrfInput('product_pricelist_form'); ?>
            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold required form-label mt-3" for="product_id">
                            Product
                        </label>

                        <select id="product_id" name="product_id" class="form-select" data-control="select2" data-allow-clear="false"></select>
                    </div>
                </div>

                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold required form-label mt-3" for="discount_type">
                            Discount Type
                        </label>

                        <select id="discount_type" name="discount_type" class="form-select" data-control="select2" data-allow-clear="false">
                            <option value="">--</option>
                            <option value="Percentage">Percentage</option>
                            <option value="Fixed Amount">Fixed Amount</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 required fw-semibold form-label mt-3" for="fixed_price">
                            Fixed Price
                        </label>

                        <input type="number" id="fixed_price" name="fixed_price" class="form-control" min="0" step="0.01" />
                    </div>
                </div>
                
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold required form-label mt-3" for="min_quantity">
                            Minimum Qty.
                        </label>

                        <input type="number" id="min_quantity" name="min_quantity" class="form-control" min="1" step="1" />
                    </div>
                </div>
            </div>

            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 required fw-semibold form-label mt-3" for="validity_start_date">
                            Validity Start Date
                        </label>

                        <input class="form-control mb-3 mb-lg-0" id="validity_start_date" name="validity_start_date" type="text" autocomplete="off" />
                    </div>
                </div>

                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="validity_end_date">
                            Validity End Date
                        </label>

                        <input class="form-control mb-3 mb-lg-0" id="validity_end_date" name="validity_end_date" type="text" autocomplete="off" />
                    </div>
                </div>
            </div>

            <div class="fv-row">
                <label class="fs-6 fw-semibold form-label mt-3" for="remarks">
                    Remarks
                </label>

                <textarea class="form-control" id="remarks" name="remarks" maxlength="1000" rows="3"></textarea>
            </div>
        </form>
    </div>
    <div class="card-footer d-flex justify-content-end py-6 px-9">
        <button type="button" id="discard-create" class="btn btn-light btn-active-light-primary me-2">Discard</button>
        <button type="submit" form="product_pricelist_form" class="btn btn-primary" id="submit-data">Save</button>
    </div>
</div>