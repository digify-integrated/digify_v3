<div class="row">
    <div class="col-lg-8" id="">
        <div class="row nav nav-pills nav-pills-custom" id="shop-product-category-container"></div>

        <div class="row mt-3" id="shop-products-container"></div>
    </div>
    
    <div class="col-lg-4">
        <div class="card card-flush bg-body"> 
            <div class="card-header">
                <h3 class="card-title">
                    <span class="fw-bold text-gray-900">Order Details</span>
                </h3>

                <div class="card-toolbar">
                    <div class="d-flex justify-content-end fs-4 text-warning" data-kt-customer-table-toolbar="base">
                        <span class="text-primary fw-bold fs-5" id="order-details-title"></span>
                    </div>
                </div>
            </div>

            <div class="card-body pt-3">
                <div class="hover-scroll-overlay-y pe-6 me-n9" style="max-height: 320px" id="shop-order-list"></div>
                <div class="mt-4">
                    <div class="border border-dashed border-gray-300 rounded mb-5">
                        <div class="p-6">
                            <div id="order-summary-list"></div>

                            <div class="d-flex flex-stack mt-4">
                                <div class="fs-4 fw-bold">AMOUNT DUE</div>
                                <div class="fs-2 fw-bold" id="shop-order-total">₱ 0.00</div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="separator separator-dashed mb-4"></div>

                    <div class="btn-group w-100 mb-4 d-none" id="order-preset" data-kt-buttons="true" data-kt-buttons-target="[data-kt-button]">
                        <label class="btn btn-outline btn-color-muted btn-active-primary p-4 active" data-kt-button="true">
                            <input class="btn-check order-preset-option" type="radio" name="method" value="On-Site"/>
                            On-Site
                        </label>
                        <label class="btn btn-outline btn-color-muted btn-active-primary p-4" data-kt-button="true">
                            <input class="btn-check order-preset-option" type="radio" name="method" checked="checked" value="Pickup"/>
                            Pickup
                        </label>
                        <label class="btn btn-outline btn-color-muted btn-active-primary p-4" data-kt-button="true">
                            <input class="btn-check order-preset-option" type="radio" name="method" checked="checked" value="Delivery"/>
                            Delivery
                        </label>
                    </div>

                    <div class="d-flex flex-equal gap-3 px-0 mb-3">
                        <button class="btn btn-light-success w-100 p-4 d-none" id="discount-button" data-bs-toggle="modal" data-bs-target="#discount-modal" id="discount-button">
                            Discount
                        </button>

                        
                        <button class="btn btn-light-danger w-100 p-4 d-none" id="charges-button" data-bs-toggle="modal" data-bs-target="#charges-modal" id="charges-button">
                            Extra Charges
                        </button>
                    </div>

                    <div class="d-flex flex-equal gap-3 px-0 mb-3">
                        <?php if ($floorPlanCount > 0): ?>               
                            <button class="btn btn-warning w-100 p-4 d-none" id="send-kitchen-button">
                                Send To Kitchen
                            </button>

                            <button class="btn btn-light-primary w-100 p-4 d-none" id="set-table-button">
                                Set Table
                            </button>
                        <?php endif; ?>

                        <button class="btn btn-light-primary w-100 p-4 d-none" data-bs-toggle="modal" data-bs-target="#set-tab-modal" id="set-tab-button">
                            Set Tab
                        </button>
                    </div>

                    <div class="d-flex flex-equal gap-3 px-0 mb-3">
                        <button class="btn btn-secondary w-100 p-4 d-none" id="print-bill">
                            Print Bill
                        </button>

                        <button class="btn btn-success w-100 p-4 d-none" id="payment-button">
                            Payment
                        </button>
                    </div>

                    <div class="d-flex flex-equal gap-3 px-0 mb-0">
                        <button class="btn btn-light-danger w-100 p-4 d-none" data-bs-toggle="modal" data-bs-target="#cancel-order-modal" id="cancel-order-button">
                            Cancel Order
                        </button>

                        <button class="btn btn-warning w-100 p-4 d-none" id="new-order-button">
                            New Order
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
                <h3 class="modal-title">Discount</h3>
                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </div>
            </div>

            <div class="modal-body">
                <form id="order_discount_form" method="post" action="#">
                    <?= $security->csrfInput('order_discount_form'); ?>
                    <div id="discount-lists"></div>
                </form>
            </div>

            <div class="modal-footer">
               <button type="button" class="btn btn-light" data-bs-dismiss="modal">
                    Close
                </button>
                <button type="submit" form="order_discount_form" class="btn btn-primary" id="submit-order-discount">
                    Save
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

            <div class="modal-body">
                <form id="order_charge_form" method="post" action="#">
                    <?= $security->csrfInput('order_charge_form'); ?>
                    <div id="charges-list"></div>
                </form>
            </div>

            <div class="modal-footer">
               <button type="button" class="btn btn-light" data-bs-dismiss="modal">
                    Close
                </button>
                <button type="submit" form="order_charge_form" class="btn btn-primary" id="submit-order-charge">
                    Save
                </button>
            </div>
        </div>
    </div>
</div>