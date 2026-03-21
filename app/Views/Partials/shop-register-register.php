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
                <div class="hover-scroll-overlay-y pe-6 me-n6" style="max-height: 320px" id="shop-order-list"></div>
                <div class="mt-4">
                    <div class="border border-dashed border-gray-300 rounded mb-5">
                        <div class="d-flex flex-stack p-6">
                            <div class="fs-6 fw-bold">
                                <span class="d-block mb-2">Subtotal</span>
                                <span class="d-block mb-2">Taxes</span>
                                <span class="d-block mb-2">Discount</span>
                                <span class="d-block fs-2 lh-1">Total</span>
                            </div> 
                            
                            <div class="fs-6 fw-bold text-end">
                                <span class="d-block mb-2" id="shop-order-subtotal">&#8369; 0.00</span>
                                <span class="d-block mb-2" id="shop-order-taxes">&#8369; 0.00</span>
                                <span class="d-block mb-2" id="shop-order-transaction-discounts">&#8369; 0.00</span>
                                <span class="d-block fs-2 lh-1" id="shop-order-total">&#8369; 0.00</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="separator separator-dashed mb-4"></div>

                    <div class="btn-group w-100 mb-4 d-none" id="order-preset" data-kt-buttons="true" data-kt-buttons-target="[data-kt-button]">
                        <label class="btn btn-outline btn-color-muted btn-active-primary p-5 active" data-kt-button="true">
                            <input class="btn-check order-preset-option" type="radio" name="method" value="On-Site"/>
                            On-Site
                        </label>
                        <label class="btn btn-outline btn-color-muted btn-active-primary p-5" data-kt-button="true">
                            <input class="btn-check order-preset-option" type="radio" name="method" checked="checked" value="Pickup"/>
                            Pickup
                        </label>
                        <label class="btn btn-outline btn-color-muted btn-active-primary p-5" data-kt-button="true">
                            <input class="btn-check order-preset-option" type="radio" name="method" checked="checked" value="Delivery"/>
                            Delivery
                        </label>
                    </div>

                    <div class="d-flex flex-equal gap-3 px-0 mb-3">
                        <?php if ($floorPlanCount > 0): ?>
                            <button class="btn btn-light-warning w-100 p-5 d-none" id="send-kitchen-button">
                                Kitchen
                            </button>
                            
                            <button class="btn btn-light-primary w-100 p-5 d-none" id="set-table-button">
                                Set Table
                            </button>
                        <?php endif; ?>

                        <button class="btn btn-light-primary w-100 p-5 d-none" data-bs-toggle="modal" data-bs-target="#set-tab-modal" id="set-tab-button">
                            Set Tab
                        </button>
                    </div>

                    <div class="d-flex flex-equal gap-3 px-0 mb-3">
                        <button class="btn btn-light-success w-100 p-5 d-none" id="discount-button" data-bs-toggle="modal" data-bs-target="#discount-modal" id="discount-button">
                            Discount
                        </button>

                        <button class="btn btn-secondary w-100 p-5 d-none" id="print-bill">
                            Print Bill
                        </button>

                        <button class="btn btn-success w-100 p-5 d-none" id="payment-button">
                            Payment
                        </button>
                    </div>

                    <div class="d-flex flex-equal gap-3 px-0 mb-0">
                        <button class="btn btn-light-danger w-100 p-5 d-none" data-bs-toggle="modal" data-bs-target="#cancel-order-modal" id="cancel-order-button">
                            Cancel Order
                        </button>

                        <button class="btn btn-warning w-100 p-5 d-none" id="new-order-button">
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

<div id="update-order-details-modal" class="modal fade" tabindex="-1" aria-labelledby="update-order-details-modal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Update Order</h3>
                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </div>
            </div>

            <div class="modal-body">
                <form id="update_order_details_form" method="post" action="#">
                    <?= $security->csrfInput('update_order_details_form'); ?>
                    <input type="hidden" id="shop_order_details_id" name="shop_order_details_id">
                    <div class="row mb-6">
                        <label class="col-lg-2 col-form-label required fw-semibold fs-6" for="quantity">Quantity</label>
                        <div class="col-lg-10">
                           <input type="number" class="form-control" id="quantity" name="quantity" min="0" step="0.0001">
                        </div>
                    </div>
                    <div class="row mb-6">
                        <label class="col-lg-2 col-form-label fw-semibold fs-6" for="discount_type">Discount</label>
                        <div class="col-lg-5">
                           <select id="discount_type" name="discount_type" class="form-select" data-dropdown-parent="#update-order-details-modal" data-control="select2" data-allow-clear="false">
                                <option value="">--</option>
                                <option value="Percentage">Percentage</option>
                                <option value="Fixed Amount">Fixed Amount</option>
                            </select>
                        </div>
                        <div class="col-lg-5">
                           <input type="number" class="form-control" id="discount_value" name="discount_value" min="0" step="0.01">
                        </div>
                    </div>
                    <div class="row">
                        <label class="col-lg-2 col-form-label fw-semibold fs-6" for="note">Note</label>
                        <div class="col-lg-10">
                          <textarea class="form-control" id="note" name="note" maxlength="500" rows="5"></textarea>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <div class="d-flex justify-content-between  w-100">
                    <button type="button" class="btn btn-danger" id="delete-order-details">
                        Delete
                    </button>
                    <div>
                        <button type="button" class="btn btn-light" data-bs-dismiss="modal">
                            Close
                        </button>
                        <button type="submit" form="update_order_details_form" class="btn btn-primary" id="submit-order-details">
                            Save
                        </button>
                    </div>
                </div>
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
                <form id="transaction_discount_form" method="post" action="#">
                    <?= $security->csrfInput('transaction_discount_form'); ?>
                    <div class="row mb-6">
                        <label class="col-lg-2 col-form-label fw-semibold fs-6" for="transaction_discount_type">Discount</label>
                        <div class="col-lg-5">
                           <select id="transaction_discount_type" name="transaction_discount_type" class="form-select" data-dropdown-parent="#discount-modal" data-control="select2" data-allow-clear="false">
                                <option value="">--</option>
                                <option value="Percentage">Percentage</option>
                                <option value="Fixed Amount">Fixed Amount</option>
                            </select>
                        </div>
                        <div class="col-lg-5">
                           <input type="number" class="form-control" id="transaction_discount_value" name="transaction_discount_value" min="0" step="0.01">
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
               <button type="button" class="btn btn-light" data-bs-dismiss="modal">
                    Close
                </button>
                <button type="submit" form="transaction_discount_form" class="btn btn-primary" id="submit-transaction-discount">
                    Save
                </button>
            </div>
        </div>
    </div>
</div>