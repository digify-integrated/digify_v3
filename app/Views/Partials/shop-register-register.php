<div class="row">
    <div class="col-lg-8" id="">
        <div class="row nav nav-pills nav-pills-custom" id="shop-product-category-container"></div>

        <div class="row" id="shop-products-container"></div>
    </div>
    
    <div class="col-lg-4">
        <div class="card bg-body"> 
            <div class="card-header">
                <h3 class="card-title mt-5 align-items-start flex-column">
                    <span class="text-dark fw-bold fs-3 mb-2" id="order-details-title"></span>
                    <span class="text-muted fw-semibold fs-7">Order ID: <span id="order-id">-</span>
                </h3>

                <div class="card-toolbar">
                    <div class="me-0">
                        <button class="btn btn-sm btn-icon btn-bg-light btn-light d-none" data-kt-menu-trigger="click" data-kt-menu-placement="bottom-end" id="order-actions-menu">
                            <i class="ki-outline ki-gear fs-3"></i>
                        </button>

                        <div class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-800 menu-state-bg-light-primary fw-semibold w-200px py-3" data-kt-menu="true">                            
                            <div class="menu-item px-3">
                                <a href="JavaScript:void(0);" class="menu-link px-3" data-bs-toggle="modal" data-bs-target="#cancel-order-modal" id="cancel-order-button">
                                    Cancel Order
                                </a>
                            </div>
                            <div class="menu-item px-3">
                                <a href="JavaScript:void(0);" class="menu-link px-3" id="new-order-button">
                                    New Order
                                </a>
                            </div>
                            
                        </div>
                    </div>
                </div>
            </div>

            <div class="card-body pt-3 ">
                <div class="d-flex flex-equal gap-3 px-0 mb-3">
                    <?php if ($floorPlanCount > 0): ?>
                        <button class="btn btn-light-primary w-100 p-3 d-none" id="set-table-button">
                            Set Table
                        </button>
                    <?php endif; ?>

                    <button class="btn btn-light-primary w-100 p-3 d-none" data-bs-toggle="modal" data-bs-target="#set-tab-modal" id="set-tab-button">
                        Set Tab
                    </button>

                    <select class="form-select form-select-solid p-3 d-none" id="order-preset" data-control="select2" data-hide-search="true">
                        <option value="On-Site">On-Site</option>
                        <option value="Pickup">Pickup</option>
                        <option value="Delivery">Delivery</option>
                    </select>
                </div>
                <div class="hover-scroll-overlay-y pe-6 me-n9" style="max-height: 320px" id="shop-order-list"></div>
                <div class="mt-4">
                    <div class="border border-dashed border-gray-300 rounded mb-5">
                        <div class="p-6">
                            <div id="order-summary-list"></div>

                            <div class="separator separator-dashed mb-4 mt-4"></div>

                            <div class="d-flex flex-stack mt-4">
                                <div class="fs-4 fw-bold">Total</div>
                                <div class="fs-2 fw-bold" id="shop-order-total">₱ 0.00</div>
                            </div>
                        </div>
                    </div>
                    <div class="d-flex flex-equal gap-3 px-0 mb-3">
                        <button class="btn btn-secondary w-100 p-4 d-none" id="print-bill">
                            Print Bill
                        </button>

                        <button class="btn btn-light-success w-100 p-4 d-none" id="discount-button" data-bs-toggle="modal" data-bs-target="#discount-modal" id="discount-button">
                            Discounts
                        </button>

                        <button class="btn btn-light-danger w-100 p-4 d-none" id="charge-button" data-bs-toggle="modal" data-bs-target="#charges-modal" id="charges-button">
                            Charges
                        </button>
                    </div>

                    <div class="d-flex flex-equal gap-3 px-0">
                        <?php if ($floorPlanCount > 0): ?>               
                            <button class="btn btn-warning w-100 p-4 d-none" id="send-kitchen-button">
                                Send To Kitchen
                            </button>

                            <button class="btn btn-light-primary w-100 p-4 d-none" id="set-table-button">
                                Set Table
                            </button>
                        <?php endif; ?>
                        <button class="btn btn-success w-100 p-4 d-none" id="payment-button">
                            Payment
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="set-tab-modal" class="modal fade" tabindex="-1" aria-labelledby="set-tab-modal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Order For</h3>
                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </div>
            </div>

            <div class="modal-body">
                <form id="set_tab_form" method="post" action="#">
                    <?= $security->csrfInput('set_tab_form'); ?>
                    <div class="row mb-6">
                        <div class="col-lg-12">
                            <input type="text" class="form-control" id="order_for" name="order_for" autocomplete="off">
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                <button type="submit" form="set_tab_form" class="btn btn-primary" id="submit-set-tab">Save</button>
            </div>
        </div>
    </div>
</div>

<div id="cancel-order-modal" class="modal fade" tabindex="-1" aria-labelledby="cancel-order-modal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Cancel Order</h3>
                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </div>
            </div>

            <div class="modal-body">
                <form id="cancel_order_form" method="post" action="#">
                    <?= $security->csrfInput('cancel_order_form'); ?>
                    <div class="row mb-6">
                        <div class="col-lg-12">
                            <textarea class="form-control" id="cancelled_reason" name="cancelled_reason" maxlength="500" rows="5" placeholder="Cancellation Reason"></textarea>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                <button type="submit" form="cancel_order_form" class="btn btn-primary" id="submit-cancel-order">Save</button>
            </div>
        </div>
    </div>
</div>

<div id="order-notes-modal" class="modal fade" tabindex="-1" aria-labelledby="order-notes-modal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Notes</h3>
                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </div>
            </div>

            <div class="modal-body">
                <form id="order_notes_form" method="post" action="#">
                    <?= $security->csrfInput('order_notes_form'); ?>
                    <input type="hidden" id="shop_order_details_id" name="shop_order_details_id">
                    <div class="row">
                        <div class="col-lg-12">
                          <textarea class="form-control" id="note" name="note" maxlength="500" rows="5"></textarea>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">
                    Close
                </button>
                <button type="submit" form="order_notes_form" class="btn btn-primary" id="submit-order-notes">
                    Save
                </button>
            </div>
        </div>
    </div>
</div>

<div id="discount-modal" class="modal fade" tabindex="-1" aria-labelledby="discount-modal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Discounts</h3>
                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </div>
            </div>

            <div class="modal-body" id="discount-lists">
            </div>

            <div class="modal-footer">
               <button type="button" class="btn btn-light" data-bs-dismiss="modal">
                    Close
                </button>
            </div>
        </div>
    </div>
</div>

<div id="charges-modal" class="modal fade" tabindex="-1" aria-labelledby="charges-modal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Charges</h3>
                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </div>
            </div>

            <div class="modal-body" id="charge-lists">
            </div>

            <div class="modal-footer">
               <button type="button" class="btn btn-light" data-bs-dismiss="modal">
                    Close
                </button>
            </div>
        </div>
    </div>
</div>