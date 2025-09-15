<div class="card">
    <div class="card-header d-flex align-items-center">
        <h5 class="card-title mb-0">Menu Item Details</h5>
    </div>
    <div class="card-body">
        <form id="menu_item_form" method="post" action="#">
            <?= $security->csrfInput('menu_item_form'); ?>
            <div class="fv-row mb-4">
                <label class="fs-6 fw-semibold form-label mt-3" for="menu_item_name">
                    <span class="required">Display Name</span>
                </label>

                <input type="text" class="form-control" id="menu_item_name" name="menu_item_name" maxlength="100" autocomplete="off">
            </div>

            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="app_module_id">
                            <span class="required">App Module</span>
                        </label>

                        <select id="app_module_id" name="app_module_id" class="form-select" data-control="select2" data-allow-clear="false"></select>
                    </div>

                </div>

                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="parent_id">
                            Parent Menu
                        </label>

                        <select id="parent_id" name="parent_id" class="form-select" data-control="select2" data-allow-clear="false"></select>
                    </div>
                </div>
            </div>

            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="app_module_id">
                            Icon
                        </label>

                        <select id="menu_item_icon" name="menu_item_icon" class="form-select" data-control="select2" data-allow-clear="false">
                            <option value="">--</option>
                            <?php include __DIR__ . '/../../Partials/menu-item-options.php'; ?>
                        </select>
                    </div>

                </div>

                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="parent_id">
                            <span class="required">Order Sequence</span>
                        </label>

                        <input type="number" class="form-control" id="order_sequence" name="order_sequence" min="0">
                    </div>
                </div>
            </div>

            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="app_module_id">
                            Import Table
                        </label>

                        <select id="table_name" name="table_name" class="form-select" data-control="select2" data-allow-clear="false"></select>
                    </div>

                </div>

                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="parent_id">
                            URL
                        </label>

                        <input type="text" class="form-control" id="menu_item_url" name="menu_item_url" maxlength="50" autocomplete="off">
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="card-footer d-flex justify-content-end py-6 px-9">
        <button type="button" id="discard-create" class="btn btn-light btn-active-light-primary me-2">Discard</button>
        <button type="submit" form="menu_item_form" class="btn btn-primary" id="submit-data">Save</button>
    </div>
</div>