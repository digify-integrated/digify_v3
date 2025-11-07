<div class="card">
    <div class="card-header d-flex align-items-center">
        <h5 class="card-title mb-0">App Module Details</h5>
    </div>
    <div class="card-body">
        <form id="app_module_form" method="post" action="#">
            <?= $security->csrfInput('app_module_form'); ?>
            <div class="row row-cols-1 row-cols-sm-3 rol-cols-md-2 row-cols-lg-3">
                <div class="col">
                    <div class="fv-row mb-4">
                        <label class="fs-6 fw-semibold required form-label mt-3" for="app_module_name">
                            Display Name
                        </label>

                        <input type="text" class="form-control" id="app_module_name" name="app_module_name" maxlength="100" autocomplete="off">
                    </div>
                </div>
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold required form-label mt-3" for="menu_item_id">
                            Default Page
                        </label>

                        <select id="menu_item_id" name="menu_item_id" class="form-select" data-control="select2" data-allow-clear="false"></select>
                    </div>
                </div>
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold required form-label mt-3" for="order_sequence">
                            Order Sequence
                        </label>

                        <input type="number" class="form-control" id="order_sequence" name="order_sequence" min="0">
                    </div>
                </div>
            </div>

            <div class="fv-row mb-4">
                <label class="fs-6 fw-semibold required form-label mt-3" for="app_module_description">
                    Description
                </label>

                <textarea class="form-control" id="app_module_description" name="app_module_description" maxlength="500" rows="3"></textarea>
            </div>
        </form>
    </div>
    <div class="card-footer d-flex justify-content-end py-6 px-9">
        <button type="button" id="discard-create" class="btn btn-light btn-active-light-primary me-2">Discard</button>
        <button type="submit" form="app_module_form" class="btn btn-primary" id="submit-data">Save</button>
    </div>
</div>