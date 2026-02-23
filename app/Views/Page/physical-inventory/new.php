<div class="card">
    <div class="card-header d-flex align-items-center">
        <h5 class="card-title mb-0">Physical Inventory Details</h5>
    </div>
    <div class="card-body">
        <form id="physical_inventory_form" method="post" action="#">
            <?= $security->csrfInput('physical_inventory_form'); ?>

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
                        <label class="fs-6 required fw-semibold form-label mt-3" for="inventory_date">
                            Inventory Date
                        </label>

                        <input class="form-control mb-3 mb-lg-0" id="inventory_date" name="inventory_date" type="text" autocomplete="off" />
                    </div>
                </div>
            </div>

            <div class="row row-cols-1 row-cols-sm-3 rol-cols-md-3 row-cols-lg-3">
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
                        <label class="fs-6 required fw-semibold form-label mt-3" for="inventory_date">
                            Inventory Count
                        </label>
                        <input type="number" id="inventory_count" name="inventory_count" class="form-control mb-2" min="0" step="0.0001" value="0.0000">
                    </div>
                </div>

                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="inventory_difference">
                            Difference
                        </label>
                        
                        <input type="number" id="inventory_difference" name="inventory_difference" class="form-control mb-2" step="0.0001" value="0.0000" readonly>
                    </div>
                </div>
            </div>

            <div class="col">
                <div class="fv-row mb-7">
                    <label class="fs-6 fw-semibold form-label mt-3" for="display_order">
                        Remarks
                    </label>

                    <textarea class="form-control" id="remarks" name="remarks" maxlength="1000" rows="3"></textarea>
                </div>
            </div>
        </form>
    </div>
    <div class="card-footer d-flex justify-content-end py-6 px-9">
        <button type="button" id="discard-create" class="btn btn-light btn-active-light-primary me-2">Discard</button>
        <button type="submit" form="physical_inventory_form" class="btn btn-primary" id="submit-data">Save</button>
    </div>
</div>