<?php
    use App\Models\Shop;

    $shop = new Shop();
?>
<div class="row g-5 g-xl-9">
    <?php
        $pos = '';
                    
        $posStack = $shop->fetchPOSStack($userID);

        foreach ($posStack as $row) {
            $shopId = $row['shop_id'];
            $shopName = $row['shop_name'];
            $registerStatus = $row['register_status'];

            $fetchShopSession = $shop->fetchShopSession($shopId);
            $openTime = $systemHelper->checkDate('summary', $fetchShopSession['open_time'] ?? null, '', 'd M Y h:i:s', '');
            $openAmount = number_format($fetchShopSession['open_amount'] ?? 0, 2);
            $closeTime = $systemHelper->checkDate('summary', $fetchShopSession['close_time'] ?? null, '', 'd M Y h:i:s', '');
            $closeAmount = number_format($fetchShopSession['close_amount'] ?? 0, 2);

            $registerBadge = $registerStatus == 'Open' ? '<span class="badge badge-light-success">'. $registerStatus .'</span>' : '<span class="badge badge-light-warning">'. $registerStatus .'</span>';

            $button = $registerStatus === 'Closed'
                    ? '<button class="btn btn-success w-100 open-shop"
                            data-bs-toggle="modal"
                            data-bs-target="#open-shop-modal"
                            data-shop-id="' . htmlspecialchars($shopId) . '">
                            Open Register
                    </button>'
                    : ($registerStatus === 'Open'
                        ? '<a href="shop-register.php?shop_id=' . urlencode($shopId) . '" 
                            class="btn btn-warning w-100">
                            View Register
                        </a>'
                        : ''
                    );
                        
            $pos .= '<div class="col-md-6 col-xl-4">
                        <div class="card card-flush mb-0">
                            <div class="card-header">
                                <div class="card-title">
                                    <h2>'. $shopName .'</h2>
                                </div>
                                <div class="card-toolbar">
                                    '. $registerBadge .'
                                </div>
                            </div>                            
                            <div class="card-body pt-0 fs-6">                                
                                <div class="separator separator-dashed mb-7"></div>

                                <div class="mb-5">
                                    <h5 class="mb-4">Shop Session</h5>

                                    <table class="table fs-6 fw-semibold gs-0 gy-2 gx-2">                                        
                                        <tr class="">
                                            <td class="text-gray-500">Open Date</td>
                                            <td class="text-gray-500">Starting Balance</td>
                                        </tr>
                                        <tr class="">
                                            <td class="text-gray-800">'. $openTime .'</td>
                                            <td class="text-gray-800">&#8369; '. $openAmount .'</td>
                                        </tr>

                                        <tr class="">
                                            <td class="text-gray-500">Close Date</td>
                                            <td class="text-gray-500">Ending Amount</td>
                                        </tr>

                                        <tr class="">
                                            <td class="text-gray-800">'. $closeTime .'</td>
                                            <td class="text-gray-800">&#8369; '. $closeAmount .'</td>
                                        </tr>
                                    </table>
                                </div>
                                
                                <div class="mb-0">
                                    '. $button .'
                                </div>
                            </div>
                        </div>
                    </div>';
        }
                
        echo $pos;
    ?>
</div>

<div id="open-shop-modal" class="modal fade" tabindex="-1" aria-labelledby="open-shop-modal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Open Register</h3>
                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </div>
            </div>

            <div class="modal-body">
                <form id="open_register_form" method="post" action="#">
                    <?= $security->csrfInput('open_register_form'); ?>
                    <input type="hidden" id="shop_id" name="shop_id" />
                    <div class="row mb-6">
                        <h1 class="col-lg-3 col-form-label fw-semibold">Cash Count</h1>
                    </div>
                    <div class="row mb-6">
                        <label class="col-lg-3 col-form-label fw-semibold fs-6" for="open_1000">1,000.00 &#8369;</label>
                        <div class="col-lg-3">
                            <div class="row">
                                <div class="col-lg-12 fv-row">
                                    <input type="number" id="open_1000" name="open_1000" class="form-control" value="0" min="0" step="1" />
                                </div>
                            </div>
                        </div>
                        <label class="col-lg-3 col-form-label fw-semibold fs-6" for="open_5">5.00 &#8369;</label>
                        <div class="col-lg-3">
                            <div class="row">
                                <div class="col-lg-12 fv-row">
                                    <input type="number" id="open_5" name="open_5" class="form-control" value="0" min="0" step="1" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-3 col-form-label fw-semibold fs-6" for="open_500">500.00 &#8369;</label>
                        <div class="col-lg-3">
                            <div class="row">
                                <div class="col-lg-12 fv-row">
                                    <input type="number" id="open_500" name="open_500" class="form-control" value="0" min="0" step="1" />
                                </div>
                            </div>
                        </div>
                        <label class="col-lg-3 col-form-label fw-semibold fs-6" for="open_1">1.00 &#8369;</label>
                        <div class="col-lg-3">
                            <div class="row">
                                <div class="col-lg-12 fv-row">
                                    <input type="number" id="open_1" name="open_1" class="form-control" value="0" min="0" step="1" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-3 col-form-label fw-semibold fs-6" for="open_200">200.00 &#8369;</label>
                        <div class="col-lg-3">
                            <div class="row">
                                <div class="col-lg-12 fv-row">
                                    <input type="number" id="open_200" name="open_200" class="form-control" value="0" min="0" step="1" />
                                </div>
                            </div>
                        </div>
                        <label class="col-lg-3 col-form-label fw-semibold fs-6" for="open_0_50">0.50 &#8369;</label>
                        <div class="col-lg-3">
                            <div class="row">
                                <div class="col-lg-12 fv-row">
                                    <input type="number" id="open_0_50" name="open_0_50" class="form-control" value="0" min="0" step="1" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-3 col-form-label fw-semibold fs-6" for="open_100">100.00 &#8369;</label>
                        <div class="col-lg-3">
                            <div class="row">
                                <div class="col-lg-12 fv-row">
                                    <input type="number" id="open_100" name="open_100" class="form-control" value="0" min="0" step="1" />
                                </div>
                            </div>
                        </div>
                        <label class="col-lg-3 col-form-label fw-semibold fs-6" for="open_0_25">0.25 &#8369;</label>
                        <div class="col-lg-3">
                            <div class="row">
                                <div class="col-lg-12 fv-row">
                                    <input type="number" id="open_0_25" name="open_0_25" class="form-control" value="0" min="0" step="1" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-3 col-form-label fw-semibold fs-6" for="open_50">50.00 &#8369;</label>
                        <div class="col-lg-3">
                            <div class="row">
                                <div class="col-lg-12 fv-row">
                                    <input type="number" id="open_50" name="open_50" class="form-control" value="0" min="0" step="1" />
                                </div>
                            </div>
                        </div>
                        <label class="col-lg-3 col-form-label fw-semibold fs-6" for="open_0_10">0.10 &#8369;</label>
                        <div class="col-lg-3">
                            <div class="row">
                                <div class="col-lg-12 fv-row">
                                    <input type="number" id="open_0_10" name="open_0_10" class="form-control" value="0" min="0" step="1" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-3 col-form-label fw-semibold fs-6" for="open_20">20.00 &#8369;</label>
                        <div class="col-lg-3">
                            <div class="row">
                                <div class="col-lg-12 fv-row">
                                    <input type="number" id="open_20" name="open_20" class="form-control" value="0" min="0" step="1" />
                                </div>
                            </div>
                        </div>
                        <label class="col-lg-3 col-form-label fw-semibold fs-6" for="open_0_05">0.05 &#8369;</label>
                        <div class="col-lg-3">
                            <div class="row">
                                <div class="col-lg-12 fv-row">
                                    <input type="number" id="open_0_05" name="open_0_05" class="form-control" value="0" min="0" step="1" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-3 col-form-label fw-semibold fs-6" for="open_10">10.00 &#8369;</label>
                        <div class="col-lg-3">
                            <div class="row">
                                <div class="col-lg-12 fv-row">
                                    <input type="number" id="open_10" name="open_10" class="form-control" value="0" min="0" step="1" />
                                </div>
                            </div>
                        </div>
                        <label class="col-lg-3 col-form-label fw-semibold fs-6" for="open_0_01">0.01 &#8369;</label>
                        <div class="col-lg-3">
                            <div class="row">
                                <div class="col-lg-12 fv-row">
                                    <input type="number" id="open_0_01" name="open_0_01" class="form-control" value="0" min="0" step="1" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-3 col-form-label fw-semibold fs-6" for="open_total">Total</label>
                        <div class="col-lg-9">
                            <div class="row">
                                <div class="col-lg-12 fv-row">
                                    <input type="text" id="open_total" name="open_total" class="form-control" value="0" readonly/>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-6">
                        <label class="col-lg-3 col-form-label fw-semibold fs-6" for="open_remarks">Opening Note</label>
                        <div class="col-lg-9">
                            <div class="row">
                                <div class="col-lg-12 fv-row">
                                    <textarea class="form-control" id="open_remarks" name="open_remarks" maxlength="1000" rows="3"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                <button type="submit" form="open_register_form" class="btn btn-success" id="submit-data">Open Register</button>
            </div>
        </div>
    </div>
</div>