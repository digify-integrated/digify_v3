<div class="card">
    <div class="card-header d-flex align-items-center">
        <h5 class="card-title mb-0">Tax Details</h5>
    </div>
    <div class="card-body">
        <form id="tax_form" method="post" action="#">
            <?= $security->csrfInput('tax_form'); ?>
            <div class="fv-row mb-4">
                <label class="fs-6 fw-semibold required form-label mt-3" for="tax_name">
                    Display Name
                </label>

                <input type="text" class="form-control" id="tax_name" name="tax_name" maxlength="100" autocomplete="off">
            </div>
            
            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold required form-label mt-3" for="tax_computation">
                            Tax Computation
                        </label>

                        <select id="tax_computation" name="tax_computation" class="form-select" data-control="select2" data-allow-clear="false">
                            <option value="">--</option>
                            <option value="Fixed">Fixed</option>
                            <option value="Percentage">Percentage</option>
                        </select>
                    </div>
                </div>

                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold required form-label mt-3" for="tax_rate">
                            Tax Rate
                        </label>

                        <input type="number" class="form-control" id="tax_rate" name="tax_rate" min="0" step="0.01">
                    </div>
                </div>
            </div>

            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold required form-label mt-3" for="tax_type">
                            Tax Type
                        </label>

                        <select id="tax_type" name="tax_type" class="form-select" data-control="select2" data-allow-clear="false">
                            <option value="">--</option>
                            <option value="None">None</option>
                            <option value="Purchases">Purchases</option>
                            <option value="Sales">Sales</option>
                        </select>
                    </div>
                </div>
                
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="tax_scope">
                            Tax Scope
                        </label>

                        <select id="tax_scope" name="tax_scope" class="form-select" data-control="select2" data-allow-clear="false">
                            <option value="">--</option>
                            <option value="Goods">Goods</option>
                            <option value="Services">Services</option>
                        </select>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="card-footer d-flex justify-content-end py-6 px-9">
        <button type="button" id="discard-create" class="btn btn-light btn-active-light-primary me-2">Discard</button>
        <button type="submit" form="tax_form" class="btn btn-primary" id="submit-data">Save</button>
    </div>
</div>