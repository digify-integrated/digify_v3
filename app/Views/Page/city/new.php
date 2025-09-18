<div class="card">
    <div class="card-header d-flex align-items-center">
        <h5 class="card-title mb-0">City Details</h5>
    </div>
    <div class="card-body">
        <form id="city-form" method="post" action="#">
            <div class="fv-row mb-4">
                <label class="fs-6 fw-semibold form-label mt-3" for="city_name">
                    <span class="required">Display Name</span>
                </label>

                <input type="text" class="form-control" id="city_name" name="city_name" maxlength="100" autocomplete="off">
            </div>

            <div class="fv-row mb-4">
                <label class="fs-6 fw-semibold form-label mt-3" for="state_id">
                    <span class="required">State</span>
                </label>

                <select id="state_id" name="state_id" class="form-select" data-control="select2" data-allow-clear="false"></select>
            </div>
        </form>
    </div>
    <div class="card-footer d-flex justify-content-end py-6 px-9">
        <button type="button" id="discard-create" class="btn btn-light btn-active-light-primary me-2">Discard</button>
        <button type="submit" form="city-form" class="btn btn-primary" id="submit-data">Save</button>
    </div>
</div>