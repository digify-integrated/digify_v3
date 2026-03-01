<div class="card mb-10">
    <div class="card-header border-0">
        <div class="card-title m-0">
            <h3 class="fw-bold m-0">Floor Plan Details</h3>
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
                                    <a href="javascript:void(0);" class="menu-link px-3" id="delete-floor-plan">
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
        <form id="floor_plan_form" method="post" action="#">
            <?= $security->csrfInput('floor_plan_form'); ?>
            <div class="fv-row mb-4">
                <label class="fs-6 fw-semibold required form-label mt-3" for="floor_plan_name">
                    Display Name
                </label>

                <input type="text" class="form-control" id="floor_plan_name" name="floor_plan_name" maxlength="100" autocomplete="off" <?php echo $disabled; ?>>
            </div>
        </form>
    </div>

    <?php
        echo ($permissions['write'] > 0) ? ' <div class="card-footer d-flex justify-content-end py-6 px-9">
                                                <button type="button" id="discard-create" class="btn btn-light btn-active-light-primary me-2">Discard</button>
                                                <button type="submit" form="floor_plan_form" class="btn btn-primary" id="submit-data">Save</button>
                                            </div>' : '';
    ?>
</div>

<div class="card">
    <div class="card-header border-0 pt-6">
        <div class="card-title">
            <div class="d-flex align-items-center position-relative my-1 me-3">
                <i class="ki-outline ki-magnifier fs-3 position-absolute ms-5"></i> <input type="text" class="form-control w-250px ps-12" id="floor-plan-table-datatable-search" placeholder="Search..." autocomplete="off" />
            </div>
            <select id="floor-plan-table-datatable-length" class="form-select w-auto">
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
                    echo $permissions['write'] > 0 ? '<button type="button" class="btn btn-light-primary me-3" data-bs-toggle="modal" data-bs-target="#floor_plan_table_modal" id="add-floor-plan-table"><i class="ki-outline ki-plus fs-2"></i> Add</button>' : '';
                ?> 
            </div>
        </div>
    </div>
    <div class="card-body pt-9">
        <table class="table align-middle cursor-pointer table-row-dashed fs-6 gy-5 gs-7" id="floor-plan-table">
            <thead>
                <tr class="fw-semibold fs-6 text-gray-800">
                    <th>Table No.</th>
                    <th>Seats</th>
                    <th></th>
                </tr>
            </thead>
            <tbody class="fw-semibold text-gray-600"></tbody>
        </table>
    </div>
</div>

<div id="floor_plan_table_modal" class="modal fade" tabindex="-1" aria-labelledby="floor_plan_table_modal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Floor Plan Table</h3>
                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </div>
            </div>

            <div class="modal-body">
                <form id="floor_plan_table_form" method="post" action="#">
                    <?= $security->csrfInput('floor_plan_table_form'); ?>
                    <input type="hidden" id="floor_plan_table_id" name="floor_plan_table_id">
                    <div class="row mb-6">
                        <label class="col-lg-3 col-form-label required fw-semibold fs-6" for="table_number">Table Number</label>
                        <div class="col-lg-9">
                            <div class="row">
                                <div class="col-lg-12">
                                    <input type="number" id="table_number" name="table_number" class="form-control mb-2" min="0" step="1">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <label class="col-lg-3 col-form-label required fw-semibold fs-6" for="seats">Seats</label>
                        <div class="col-lg-9">
                            <div class="row">
                                <div class="col-lg-12">
                                    <input type="number" id="seats" name="seats" class="form-control mb-2" min="0" step="1">
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                <button type="submit" form="floor_plan_table_form" class="btn btn-primary" id="submit-floor-plan-table">Save</button>
            </div>
        </div>
    </div>
</div>

<?php require_once './app/Views/Partials/log-notes-modal.php'; ?>