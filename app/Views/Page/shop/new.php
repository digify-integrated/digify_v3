<div class="card">
    <div class="card-header d-flex align-items-center">
        <h5 class="card-title mb-0">Shop Details</h5>
    </div>
    <div class="card-body">
        <form id="shop_form" method="post" action="#">
            <?= $security->csrfInput('shop_form'); ?>
            <div class="fv-row mb-4">
                <label class="fs-6 fw-semibold required form-label mt-3" for="shop_name">
                    Display Name
                </label>

                <input type="text" class="form-control" id="shop_name" name="shop_name" maxlength="100" autocomplete="off">
            </div>

            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold required form-label mt-3" for="company_id">
                            Company
                        </label>

                        <select id="company_id" name="company_id" class="form-select" data-control="select2" data-allow-clear="false"></select>
                    </div>

                </div>

                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold required form-label mt-3" for="shop_type_id">
                            Shop Type
                        </label>

                        <select id="shop_type_id" name="shop_type_id" class="form-select" data-control="select2" data-allow-clear="false"></select>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="card-footer d-flex justify-content-end py-6 px-9">
        <button type="button" id="discard-create" class="btn btn-light btn-active-light-primary me-2">Discard</button>
        <button type="submit" form="shop_form" class="btn btn-primary" id="submit-data">Save</button>
    </div>
</div>