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
                        <label class="fs-6 fw-semibold required form-label mt-3" for="physical_inventory_name">
                            Display Name
                        </label>

                        <input type="text" class="form-control" id="physical_inventory_name" name="physical_inventory_name" maxlength="100" autocomplete="off">
                    </div>
                </div>

                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="parent_category_id">
                            Parent Category
                        </label>

                        <select id="parent_category_id" name="parent_category_id" class="form-select" data-control="select2" data-allow-clear="false"></select>
                    </div>
                </div>
            </div>
            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">                
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold required form-label mt-3" for="parent_category_id">
                            Costing Method
                        </label>

                        <select id="costing_method" name="costing_method" class="form-select" data-control="select2" data-allow-clear="false" <?php echo $disabled; ?>>
                            <option value="">--</option>
                            <option value="Average Cost">Average Cost</option>
                            <option value="First In First Out">First In First Out</option>
                            <option value="Standard Price">Standard Price</option>
                        </select>
                    </div>
                </div>
                
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold required form-label mt-3" for="display_order">
                            Display Order
                        </label>

                        <input type="number" id="display_order" name="display_order" class="form-control mb-2" min="0" step="1"/>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="card-footer d-flex justify-content-end py-6 px-9">
        <button type="button" id="discard-create" class="btn btn-light btn-active-light-primary me-2">Discard</button>
        <button type="submit" form="physical_inventory_form" class="btn btn-primary" id="submit-data">Save</button>
    </div>
</div>