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

           // Refined Button Logic (UX: Clearer action intent)
            $button = $registerStatus === 'Closed'
                ? '<button class="btn btn-light-success w-100 open-shop" 
                        data-bs-toggle="modal" data-bs-target="#open-shop-modal" data-shop-id="' . htmlspecialchars($shopId) . '">
                        Open New Session
                </button>'
                : ($registerStatus === 'Open'
                    ? '<a href="shop-register.php?id=' . urlencode($shopId) . '" class="btn btn-warning w-100">
                        Manage Register
                    </a>'
                    : '');

            // State-based styling
            $cardClass = ($registerStatus === 'Open') ? 'border-primary' : 'border-transparent';
            $bgClass = ($registerStatus === 'Open') ? 'bg-light-primary' : 'bg-light';

            $pos .= '
            <div class="col-md-6 col-xl-4">
                <div class="card card-flush h-xl-100 shadow-sm ' . $cardClass . '">
                    <div class="card-header pt-5">
                        <div class="card-title flex-column">
                            <h2 class="fw-bold text-gray-900 fs-2 mb-1">' . $shopName . '</h2>
                            <span class="text-gray-500 fw-semibold fs-7">Shop ID: #' . $shopId . '</span>
                        </div>
                        <div class="card-toolbar">
                            ' . $registerBadge . '
                        </div>
                    </div>

                    <div class="card-body pt-2">
                        <div class="separator separator-dashed my-4"></div>

                        <div class="row g-3 mb-6">
                            <div class="col-6">
                                <div class="rounded-3 p-3 ' . $bgClass . '">
                                    <span class="text-gray-600 fw-bold fs-8 d-block text-uppercase ls-1 pb-1">Starting</span>
                                    <div class="d-flex align-items-center">
                                        <span class="fs-6 fw-bolder text-gray-800">&#8369; ' . $openAmount . '</span>
                                    </div>
                                    <span class="text-gray-500 fs-9 d-block mt-1 italic">' . $openTime . '</span>
                                </div>
                            </div>

                            <div class="col-6">
                                <div class="rounded-3 p-3 bg-secondary bg-opacity-25">
                                    <span class="text-gray-600 fw-bold fs-8 d-block text-uppercase ls-1 pb-1">Ending</span>
                                    <div class="d-flex align-items-center">
                                        <span class="fs-6 fw-bolder text-gray-800">&#8369; ' . $closeAmount . '</span>
                                    </div>
                                    <span class="text-gray-500 fs-9 d-block mt-1 italic">' . ($closeTime ?? '---') . '</span>
                                </div>
                            </div>
                        </div>
                        
                        <div class="mt-auto">
                            ' . $button . '
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
            <div class="modal-body">
                <form id="open_register_form" method="post" action="#">
                    <?= $security->csrfInput('open_register_form'); ?>
                    <input type="hidden" id="shop_id" name="shop_id" />

                    <div class="d-flex align-items-center mb-5">
                        <h2 class="fw-bold mb-0">Cash Count</h2>
                        <div class="ms-auto badge py-3 px-4 fs-7 badge-light-success">Register Opening</div>
                    </div>

                    <div class="row g-5">
                        <div class="col-md-6">
                            <h5 class="text-muted text-uppercase fs-7 fw-bold mb-4 border-bottom pb-2">Bills</h5>
                            
                            <?php 
                            $bills = [
                                '1000' => '1,000.00', '500' => '500.00', '200' => '200.00', 
                                '100' => '100.00', '50' => '50.00', '20' => '20.00'
                            ];
                            foreach ($bills as $id => $label): ?>
                            <div class="mb-3 d-flex align-items-center">
                                <label class="fw-semibold fs-6 w-100px mb-0" for="open_<?= $id ?>">&#8369; <?= $label ?></label>
                                <input type="number" id="open_<?= $id ?>" name="open_<?= $id ?>" 
                                        class="form-control form-control-solid border-start-0" min="0" step="1" />
                            </div>
                            <?php endforeach; ?>
                        </div>

                        <div class="col-md-6">
                            <h5 class="text-muted text-uppercase fs-7 fw-bold mb-4 border-bottom pb-2">Coins</h5>
                            
                            <?php 
                            $coins = [
                                '10' => '10.00', '5' => '5.00', '1' => '1.00', 
                                '0_50' => '0.50', '0_25' => '0.25', '0_10' => '0.10', 
                                '0_05' => '0.05', '0_01' => '0.01'
                            ];
                            foreach ($coins as $id => $label): ?>
                            <div class="mb-3 d-flex align-items-center">
                                <label class="fw-semibold fs-6 w-100px mb-0" for="open_<?= $id ?>">&#8369; <?= $label ?></label>
                                <input type="number" id="open_<?= $id ?>" name="open_<?= $id ?>" 
                                        class="form-control form-control-solid border-start-0" min="0" step="1" />
                            </div>
                            <?php endforeach; ?>
                        </div>
                    </div>

                    <hr class="my-8 border-secondary-subtle">

                    <div class="row g-5">
                        <div class="col-md-7">
                            <label class="fw-semibold fs-6 mb-2" for="open_remarks">Opening Note / Remarks</label>
                            <textarea class="form-control form-control-solid" id="open_remarks" name="open_remarks" 
                                    placeholder="Note the starting cash drawer status..." maxlength="1000" rows="6"></textarea>
                        </div>
                        
                        <div class="col-md-5">
                            <div class="p-5 rounded bg-light-primary border border-primary border-dashed">
                                <label class="fw-bold fs-4 text-primary mb-2" for="open_total">Grand Total</label>
                                <div class="input-group">
                                    <span class="input-group-text border-0 bg-transparent fs-2 fw-bold text-primary">&#8369;</span>
                                    <input type="text" id="open_total" name="open_total" 
                                        class="form-control form-control-flush fs-1 fw-bolder text-primary" 
                                        value="0.00" readonly/>
                                </div>
                                <div class="fs-7 text-muted mt-2 italic">* Automatically calculated based on quantities</div>
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