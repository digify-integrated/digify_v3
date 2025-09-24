<div class="card">
    <div class="card-header d-flex align-items-center">
        <h5 class="card-title mb-0">Departure Reason Details</h5>
    </div>
    <div class="card-body">
        <form id="departure_reason_form" method="post" action="#">
            <?= $security->csrfInput('departure_reason_form'); ?>
            <div class="fv-row mb-4">
                <label class="fs-6 fw-semibold form-label mt-3" for="departure_reason_name">
                    <span class="required">Display Name</span>
                </label>

                <input type="text" class="form-control" id="departure_reason_name" name="departure_reason_name" maxlength="100" autocomplete="off">
            </div>
        </form>
    </div>
    <div class="card-footer d-flex justify-content-end py-6 px-9">
        <button type="button" id="discard-create" class="btn btn-light btn-active-light-primary me-2">Discard</button>
        <button type="submit" form="departure_reason_form" class="btn btn-primary" id="submit-data">Save</button>
    </div>
</div>