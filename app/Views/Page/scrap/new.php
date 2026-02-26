<div class="card">
    <div class="card-header d-flex align-items-center">
        <h5 class="card-title mb-0">Scrap Details</h5>
    </div>
    <div class="card-body">
        <form id="scrap_form" method="post" action="#">
            <?= $security->csrfInput('scrap_form'); ?>

            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold required form-label mt-3" for="parent_category_id">
                            Product
                        </label>

                        <select id="product_id" name="product_id" class="form-select" data-control="select2" data-allow-clear="false"></select>
                    </div>
                </div>

                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 required fw-semibold form-label mt-3" for="reference_number">
                            Reference Number
                        </label>

                        <input type="text" class="form-control mb-3 mb-lg-0" id="reference_number" name="reference_number" maxlength="500" autocomplete="off" />
                    </div>
                </div>
            </div>

            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-2 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="quantity_on_hand">
                            Quantity On-Hand
                        </label>
                        
                        <input type="number" id="quantity_on_hand" name="quantity_on_hand" class="form-control mb-2" min="0" step="0.0001" readonly>
                    </div>
                </div>

                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 required fw-semibold form-label mt-3" for="scrap_quantity">
                            Scrap Quantity
                        </label>
                        <input type="number" id="scrap_quantity" name="scrap_quantity" class="form-control mb-2" min="0.0001" step="0.0001" value="0.0001">
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold required form-label mt-3" for="scrap_reason_id">
                            Scrap Reason
                        </label>

                        <select id="scrap_reason_id" name="scrap_reason_id" class="form-select" data-control="select2" data-allow-clear="false"></select>
                    </div>
                </div>
            </div>

            <div class="col">
                <div class="fv-row mb-7">
                    <label class="fs-6 fw-semibold form-label mt-3" for="detailed_scrap_reason">
                        Detailed Scrap Reason
                    </label>

                    <textarea class="form-control" id="detailed_scrap_reason" name="detailed_scrap_reason" maxlength="5000" rows="3"></textarea>
                </div>
            </div>
        </form>
    </div>
    <div class="card-footer d-flex justify-content-end py-6 px-9">
        <button type="button" id="discard-create" class="btn btn-light btn-active-light-primary me-2">Discard</button>
        <button type="submit" form="scrap_form" class="btn btn-primary" id="submit-data">Save</button>
    </div>
</div>