<div class="card">
    <div class="card-header d-flex align-items-center">
        <h5 class="card-title mb-0">Attribute Details</h5>
    </div>
    <div class="card-body">
        <form id="attribute_form" method="post" action="#">
            <?= $security->csrfInput('attribute_form'); ?>
            <div class="fv-row mb-4">
                <label class="fs-6 fw-semibold form-label mt-3" for="attribute_name">
                    <span class="required">Display Name</span>
                </label>

                <input type="text" class="form-control" id="attribute_name" name="attribute_name" maxlength="100" autocomplete="off">
            </div>
            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="variant_creation">
                            <span class="required">Variant Creation</span>
                        </label>

                        <select id="variant_creation" name="variant_creation" class="form-select" data-control="select2" data-allow-clear="false">
                            <option value="">--</option>
                            <option value="Instantly">Instantly</option>
                            <option value="Never">Never</option>
                        </select>
                    </div>
                </div>

                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="display_type">
                            <span class="required">Display Type</span>
                        </label>

                        <select id="display_type" name="display_type" class="form-select" data-control="select2" data-allow-clear="false">
                            <option value="">--</option>
                            <option value="Radio">Radio</option>
                            <option value="Checkbox">Checkbox</option>
                        </select>
                    </div>
                </div>      
            </div>
            <div class="fv-row mb-4">
                <label class="fs-6 fw-semibold form-label mt-3" for="attribute_description">
                    Description
                </label>

                <textarea class="form-control" id="attribute_description" name="attribute_description" maxlength="500" rows="3"></textarea>
            </div>
        </form>
    </div>
    <div class="card-footer d-flex justify-content-end py-6 px-9">
        <button type="button" id="discard-create" class="btn btn-light btn-active-light-primary me-2">Discard</button>
        <button type="submit" form="attribute_form" class="btn btn-primary" id="submit-data">Save</button>
    </div>
</div>