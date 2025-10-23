<div class="card mb-6">
    <div class="card-header border-0">
        <div class="card-title">
            <?php require './app/Views/Partials/datatable-search.php'; ?>
        </div>
        <div class="card-toolbar">
            <div class="d-flex justify-content-end" data-kt-customer-table-toolbar="base">
                <div class="d-flex flex-wrap my-1">
                    <ul class="nav nav-pills me-5" role="tablist">
                        <li class="nav-item m-0" role="presentation">
                            <a class="btn btn-icon btn-light btn-color-muted btn-active-primary me-3 active" data-bs-toggle="tab" href="#tab_card_view" aria-selected="true" role="tab">
                                <i class="ki-outline ki-element-11 fs-1"></i>
                            </a>
                        </li>

                        <li class="nav-item m-0" role="presentation">
                            <a class="btn btn-icon btn-light btn-color-muted btn-active-primary" data-bs-toggle="tab" href="#tab_table_view" aria-selected="false" role="tab" tabindex="-1">
                                <i class="ki-outline ki-element-8 fs-2"></i>
                            </a>
                        </li>
                    </ul>
                </div>
                <?php
                    if ($permissions['delete'] > 0 || $permissions['export'] > 0) {
                        $action = '<a href="#" class="btn btn-light-primary btn-flex btn-center btn-active-light-primary show menu-dropdown action-dropdown me-3 d-none" data-kt-menu-trigger="click" data-kt-menu-placement="bottom-end">
                                        Actions
                                        <i class="ki-outline ki-down fs-5 ms-1"></i>
                                    </a>
                                    <div class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-600 menu-state-bg-light-primary fw-semibold fs-7 w-125px py-4" data-kt-menu="true" style="z-index: 107; position: fixed; inset: 0px 0px auto auto; margin: 0px; transform: translate(-60px, 539px);" data-popper-placement="bottom-end">';
                    
                        if ($permissions['export'] > 0) {
                            $action .= '<div class="menu-item px-3">
                                            <a href="javascript:void(0);" class="menu-link px-3" data-bs-toggle="modal" id="export-data" data-bs-target="#export-modal">
                                                Export
                                            </a>
                                        </div>';
                        }
                    
                        if ($permissions['delete'] > 0) {
                            $action .= '<div class="menu-item px-3">
                                            <a href="javascript:void(0);" class="menu-link px-3" id="delete-product">
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
                        <div class="px-7 py-5 mh-300px overflow-auto">
                            <div class="mb-10">
                                <label class="form-label fs-6 fw-semibold" for="product_type_filter">Product Type:</label>
                                <select id="product_type_filter" name="product_type_filter" multiple="multiple" class="form-select" data-control="select2" data-allow-clear="false">
                                    <option value="Goods">Goods</option>
                                    <option value="Services">Services</option>
                                </select>
                            </div>
                            <div class="mb-10">
                                <label class="form-label fs-6 fw-semibold" for="product_category_filter">Product Category:</label>
                                <select id="product_category_filter" name="product_category_filter" multiple="multiple" class="form-select" data-control="select2" data-allow-clear="false"></select>
                            </div>
                            <div class="mb-10">
                                <label class="form-label fs-6 fw-semibold" for="is_sellable_filter">Is Sellable:</label>
                                <select id="is_sellable_filter" name="is_sellable_filter" multiple="multiple" class="form-select" data-control="select2" data-allow-clear="false">
                                    <option value="Yes">Yes</option>
                                    <option value="No">No</option>
                                </select>
                            </div>
                            <div class="mb-10">
                                <label class="form-label fs-6 fw-semibold" for="is_purchasable_filter">Is Purchasable:</label>
                                <select id="is_purchasable_filter" name="is_purchasable_filter" multiple="multiple" class="form-select" data-control="select2" data-allow-clear="false">
                                    <option value="Yes">Yes</option>
                                    <option value="No">No</option>
                                </select>
                            </div>
                            <div class="mb-10">
                                <label class="form-label fs-6 fw-semibold" for="show_on_pos_filter">Show on POS:</label>
                                <select id="show_on_pos_filter" name="show_on_pos_filter" multiple="multiple" class="form-select" data-control="select2" data-allow-clear="false">
                                    <option value="Yes">Yes</option>
                                    <option value="No">No</option>
                                </select>
                            </div>
                            <div class="mb-10">
                                <label class="form-label fs-6 fw-semibold" for="product_status_filter">Product Status:</label>
                                <select id="product_status_filter" name="product_status_filter" multiple="multiple" class="form-select" data-control="select2" data-allow-clear="false">
                                    <option value="Active" selected>Active</option>
                                    <option value="Archived">Archived</option>
                                </select>
                            </div>
                        </div>
                        <div class="px-7 py-5">                            
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
</div>

<div class="tab-content">
    <div id="tab_card_view" class="tab-pane fade active show" role="tabpanel">
        <div class="row g-6 g-xl-9" id="product-card"></div>
    </div>

    <div id="tab_table_view" class="tab-pane fade" role="tabpanel">
        <div class="card mb-6">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table align-middle cursor-pointer table-row-dashed fs-6 gy-5 text-nowrap" id="product-table">
                        <thead>
                            <tr class="text-start text-gray-800 fw-bold fs-7 text-uppercase gs-0">
                                <th>
                                    <div class="form-check form-check-sm form-check-custom form-check-solid me-3">
                                        <input class="form-check-input" id="datatable-checkbox" type="checkbox">
                                    </div>
                                </th>
                                <th>Product</th>
                                <th>Barcode</th>
                                <th>Product Type</th>
                                <th>Product Category</th>
                                <th>Quantity On Hand</th>
                                <th>Sales Price</th>
                                <th>Cost</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody class="fw-semibold text-gray-800"></tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<?php
    $permissions['export'] > 0 ? require './app/Views/Partials/export-modal.php' : '';
?>