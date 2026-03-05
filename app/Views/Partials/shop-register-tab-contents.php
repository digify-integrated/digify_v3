<?php if ($floorPlanCount > 0): ?>

   <div class="tab-pane fade active show" id="tables_tab" role="tabpanel">
        <?php include_once './app/Views/Partials/shop-register-tables.php'; ?>
    </div>

    <div class="tab-pane fade" id="register_tab" role="tabpanel">
        <?php include_once './app/Views/Partials/shop-register-register.php'; ?>
    </div>

<?php else: ?>

    <div class="tab-pane fade active show" id="register_tab" role="tabpanel">
        <?php include_once './app/Views/Partials/shop-register-register.php'; ?>
    </div>

<?php endif; ?>

<div class="tab-pane fade" id="orders_tab" role="tabpanel">
    <?php include_once './app/Views/Partials/shop-register-orders.php'; ?>
</div>