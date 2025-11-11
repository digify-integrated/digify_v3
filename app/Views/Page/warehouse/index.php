<div class="card mb-6">
    <div class="card-header border-0 pt-6">
        <div class="card-title">
            <?php require './app/Views/Partials/datatable-search.php'; ?>
        </div>
        <div class="card-toolbar">
            <div class="d-flex justify-content-end" data-kt-customer-table-toolbar="base">
                <?php
                    if ($permissions['delete'] > 0 || $permissions['export'] > 0) {
                        $action = '<a href="#" class="btn btn-light-primary btn-flex btn-center btn-active-light-primary show menu-dropdown action-dropdown me-3 d-none" data-kt-menu-trigger="click" data-kt-menu-placement="bottom-end">
                                        Actions
                                        <i class="ki-outline ki-down fs-5 ms-1"></i>
                                    </a>
                                    <div class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-600 menu-warehouse-bg-light-primary fw-semibold fs-7 w-125px py-4" data-kt-menu="true" style="z-index: 107; position: fixed; inset: 0px 0px auto auto; margin: 0px; transform: translate(-60px, 539px);" data-popper-placement="bottom-end">';
                    
                        if ($permissions['export'] > 0) {
                            $action .= '<div class="menu-item px-3">
                                            <a href="javascript:void(0);" class="menu-link px-3" data-bs-toggle="modal" id="export-data" data-bs-target="#export-modal">
                                                Export
                                            </a>
                                        </div>';
                        }
                    
                        if ($permissions['delete'] > 0) {
                            $action .= '<div class="menu-item px-3">
                                            <a href="javascript:void(0);" class="menu-link px-3" id="delete-warehouse">
                                                Delete
                                            </a>
                                        </div>';
                        }
                    
                        $action .= '</div>';
                    
                        echo $action;
                    }
                ?>
                <div>
                    <button type="button" class="btn btn-light-primary me-3" data-kt-menu-trigger="click" data-kt-menu-placement="bottom-end"><i class="ki-outline ki-filter fs-2"></i> Filter</button>
                    <div class="menu menu-sub menu-sub-dropdown w-300px w-md-325px" data-kt-menu="true">
                        <div class="px-7 py-5">
                            <div class="fs-5 text-gray-900 fw-bold">Filter Options</div>
                        </div>
                        <div class="separator border-gray-200"></div>
                        <div class="px-7 py-5">
                            <div class="mb-10">
                                <label class="form-label fs-6 fw-semibold" for="filter_by_warehouse_type">Warehouse Type:</label>
                                <select id="filter_by_warehouse_type" name="filter_by_warehouse_type" multiple="multiple" class="form-select" data-control="select2" data-allow-clear="false"></select>
                            </div>
                            <div class="mb-10">
                                <label class="form-label fs-6 fw-semibold" for="filter_by_city">City:</label>
                                <select id="filter_by_city" name="filter_by_city" multiple="multiple" class="form-select" data-control="select2" data-allow-clear="false"></select>
                            </div>
                            <div class="mb-10">
                                <label class="form-label fs-6 fw-semibold" for="filter_by_state">State:</label>
                                <select id="filter_by_state" name="filter_by_state" multiple="multiple" class="form-select" data-control="select2" data-allow-clear="false"></select>
                            </div>
                            <div class="mb-10">
                                <label class="form-label fs-6 fw-semibold" for="filter_by_country">Country:</label>
                                <select id="filter_by_country" name="filter_by_country" multiple="multiple" class="form-select" data-control="select2" data-allow-clear="false"></select>
                            </div>
                            <div class="mb-10">
                                <label class="form-label fs-6 fw-semibold" for="filter_by_warehouse_status">Status:</label>
                                <select id="filter_by_warehouse_status" name="filter_by_warehouse_status" multiple="multiple" class="form-select" data-control="select2" data-allow-clear="false">
                                    <option value="Active" selected>Active</option>
                                    <option value="Archived">Archived</option>
                                </select>
                            </div>
                            <div class="d-flex justify-content-end">
                                <button type="reset" class="btn btn-light btn-active-light-primary fw-semibold me-2 px-6" id="reset-filter" data-kt-menu-dismiss="true">Reset</button>
                                <button type="button" class="btn btn-primary fw-semibold px-6" id="apply-filter" data-kt-menu-dismiss="true">Apply</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="card-body pt-9">
        <div class="table-responsive">
            <table class="table align-middle cursor-pointer table-row-dashed fs-6 gy-5 text-nowrap" id="warehouse-table">
                <thead>
                    <tr class="text-start text-gray-800 fw-bold fs-7 text-uppercase gs-0">
                        <th>
                            <div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                <input class="form-check-input" id="datatable-checkbox" type="checkbox">
                            </div>
                        </th>
                        <th>Warehouse</th>
                    </tr>
                </thead>
                <tbody class="fw-semibold text-gray-800"></tbody>
            </table>
        </div>
    </div>
</div>

<?php
    $permissions['export'] > 0 ? require './app/Views/Partials/export-modal.php' : '';
?>