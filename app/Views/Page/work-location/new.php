<div class="card">
    <div class="card-header d-flex align-items-center">
        <h5 class="card-title mb-0">Work Location Details</h5>
    </div>
    <div class="card-body">
        <form id="work_location_form" method="post" action="#">
            <?= $security->csrfInput('work_location_form'); ?>
            <div class="fv-row mb-4">
                <label class="fs-6 fw-semibold form-label mt-3" for="work_location_name">
                    <span class="required">Display Name</span>
                </label>

                <input type="text" class="form-control" id="work_location_name" name="work_location_name" maxlength="100" autocomplete="off">
            </div>
            
            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="address">
                            <span class="required">Address</span>
                        </label>

                        <input type="text" class="form-control" id="address" name="address" maxlength="1000" autocomplete="off">
                    </div>
                </div>

                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="city_id">
                            <span class="required">City</span>
                        </label>

                        <select id="city_id" name="city_id" class="form-select" data-control="select2" data-allow-clear="false"></select>
                    </div>
                </div>
            </div>

            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="phone">
                            Phone
                        </label>

                        <input type="text" class="form-control" id="phone" name="phone" maxlength="20" autocomplete="off">
                    </div>
                </div>

                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="telephone">
                            Telephone
                        </label>

                        <input type="text" class="form-control" id="telephone" name="telephone" maxlength="20" autocomplete="off">
                    </div>
                </div>
            </div>

            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="email">
                            Email
                        </label>

                        <input type="email" class="form-control" id="email" name="email" maxlength="250" autocomplete="off">
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="card-footer d-flex justify-content-end py-6 px-9">
        <button type="button" id="discard-create" class="btn btn-light btn-active-light-primary me-2">Discard</button>
        <button type="submit" form="work_location_form" class="btn btn-primary" id="submit-data">Save</button>
    </div>
</div>