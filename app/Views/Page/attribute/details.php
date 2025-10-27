<div class="card mb-10">
    <div class="card-header border-0">
        <div class="card-title m-0">
            <h3 class="fw-bold m-0">Attribute Details</h3>
        </div>
        <?php
            if ($permissions['delete'] > 0) {
                $action = '<a href="#" class="btn btn-light-primary btn-flex btn-center btn-active-light-primary show menu-dropdown align-self-center" data-kt-menu-trigger="click" data-kt-menu-placement="bottom-end">
                                        Actions
                                        <i class="ki-outline ki-down fs-5 ms-1"></i>
                                    </a>
                                    <div class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-600 menu-state-bg-light-primary fw-semibold fs-7 w-125px py-4" data-kt-menu="true" style="z-index: 107; position: fixed; inset: 0px 0px auto auto; margin: 0px; transform: translate(-60px, 539px);" data-popper-placement="bottom-end">';
                    
                if ($permissions['delete'] > 0) {
                    $action .= '<div class="menu-item px-3">
                                    <a href="javascript:void(0);" class="menu-link px-3" id="delete-attribute">
                                        Delete
                                    </a>
                                </div>';
                }
                        
                $action .= '</div>';
                        
                echo $action;
            }
        ?>
    </div>
    <div class="card-body">
        <form id="attribute_form" method="post" action="#">
            <?= $security->csrfInput('attribute_form'); ?>
            <div class="fv-row mb-4">
                <label class="fs-6 fw-semibold form-label mt-3" for="attribute_name">
                    <span class="required">Display Name</span>
                </label>

                <input type="text" class="form-control" id="attribute_name" name="attribute_name" maxlength="100" autocomplete="off" <?php echo $disabled; ?>>
            </div>
            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="variant_creation">
                            <span class="required">Variant Creation</span>
                        </label>

                        <select id="variant_creation" name="variant_creation" class="form-select" data-control="select2" data-allow-clear="false" <?php echo $disabled; ?>>
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

                        <select id="display_type" name="display_type" class="form-select" data-control="select2" data-allow-clear="false" <?php echo $disabled; ?>>
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

                <textarea class="form-control" id="attribute_description" name="attribute_description" maxlength="500" rows="3" <?php echo $disabled; ?>></textarea>
            </div>
        </form>
    </div>

    <?php
        echo ($permissions['write'] > 0) ? ' <div class="card-footer d-flex justify-content-end py-6 px-9">
                                                <button type="button" id="discard-create" class="btn btn-light btn-active-light-primary me-2">Discard</button>
                                                <button type="submit" form="attribute_form" class="btn btn-primary" id="submit-data">Save</button>
                                            </div>' : '';
    ?>
</div>

<div class="card">
    <div class="card-header border-0 pt-6">
        <div class="card-title">
            <div class="d-flex align-items-center position-relative my-1 me-3">
                <i class="ki-outline ki-magnifier fs-3 position-absolute ms-5"></i> <input type="text" class="form-control w-250px ps-12" id="attribute-value-datatable-search" placeholder="Search..." autocomplete="off" />
            </div>
            <select id="attribute-value-datatable-length" class="form-select w-auto">
                <option value="-1">All</option>
                <option value="5">5</option>
                <option value="10" selected>10</option>
                <option value="20">20</option>
                <option value="25">25</option>
                <option value="50">50</option>
                <option value="100">100</option>
            </select>
        </div>
        <div class="card-toolbar">
            <div class="d-flex justify-content-end" data-kt-customer-table-toolbar="base">
                <?php
                    echo $permissions['write'] > 0 ? '<button type="button" class="btn btn-light-primary me-3" data-bs-toggle="modal" data-bs-target="#attribute_value_modal" id="add-attribute-value"><i class="ki-outline ki-plus fs-2"></i> Add</button>' : '';
                ?> 
            </div>
        </div>
    </div>
    <div class="card-body pt-9">
        <table class="table align-middle cursor-pointer table-row-dashed fs-6 gy-5 gs-7" id="attribute-value-table">
            <thead>
                <tr class="fw-semibold fs-6 text-gray-800">
                    <th>Attribute</th>
                    <th></th>
                </tr>
            </thead>
            <tbody class="fw-semibold text-gray-600"></tbody>
        </table>
    </div>
</div>

<div id="attribute_value_modal" class="modal fade" tabindex="-1" aria-labelledby="attribute_value_modal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Attribute Value</h3>
                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </div>
            </div>

            <div class="modal-body">
                <form id="attribute_value_form" method="post" action="#">
                    <?= $security->csrfInput('attribute_value_form'); ?>
                    <input type="hidden" id="attribute_value_id" name="attribute_value_id">
                    <div class="row mb-6">
                        <label class="col-lg-3 col-form-label required fw-semibold fs-6" for="departure_date">Attribute Value</label>
                        <div class="col-lg-9">
                            <div class="row">
                                <div class="col-lg-12">
                                    <input type="text" class="form-control mb-3 mb-lg-0" id="attribute_value_name" name="attribute_value_name" maxlength="100" autocomplete="off">
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                <button type="submit" form="attribute_value_form" class="btn btn-primary" id="submit-attribute-value">Save</button>
            </div>
        </div>
    </div>
</div>

<?php require_once './app/Views/Partials/log-notes-modal.php'; ?>