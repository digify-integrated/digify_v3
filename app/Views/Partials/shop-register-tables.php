<?php
$floorPlansHtml = '';
$floorPlansContentHtml = '';

$floorPlans = $shop->fetchShopFloorPlans($shopId);

$isFirst = true;

foreach ($floorPlans as $row) {

    $floorPlanId   = $row['floor_plan_id'];
    $floorPlanName = $row['floor_plan_name'];

    $tableCount = $floorPlan->fetchFloorPlanTableCount($floorPlanId)['total'] ?? 0;
    $seatCount  = $floorPlan->fetchFloorPlanSeatCount($floorPlanId)['total'] ?? 0;

    $tableLabel = $tableCount === 1 ? 'Table' : 'Tables';
    $seatLabel  = $seatCount === 1 ? 'Seat' : 'Seats';

    $activeNav  = $isFirst ? 'active' : '';
    $activePane = $isFirst ? 'show active' : '';

    $fetchFloorPlanTables = $floorPlan->fetchFloorPlanTables($floorPlanId);

    $floorPlanTableHtml = '<div class="tab-pane fade '.$activePane.'" id="floor_plan_'.$floorPlanId.'">
    <div class="row g-6 g-xl-9">';

    foreach ($fetchFloorPlanTables as $tableRow) {

        $floorPlanTableId = $tableRow['floor_plan_table_id'];
        $tableNumber      = $tableRow['table_number'] ?? 1;
        $seats            = $tableRow['seats'] ?? 1;

        $floorPlanTableHtml .= '
        <div class="col-md-6 col-xl-4">
            <div class="card border-success">
                <div class="card-header border-0 pt-9">
                    <div class="card-title m-0">
                        <h3 class="card-title align-items-start flex-column">
                            <span class="card-label fw-bold">
                                Table No. '.number_format($tableNumber).'
                            </span>

                            <span class="text-gray-700 mt-1 fw-semibold fs-6">
                                Seats: '.number_format($seats).'
                            </span>
                        </h3>
                    </div>

                    <div class="card-toolbar">
                        <span class="badge badge-light-success fw-bold me-auto px-4 py-3">
                            Available
                        </span>
                    </div>
                </div>

                <div class="card-body p-8">

                    <div class="separator separator-dashed mb-7"></div>

                    <button class="btn btn-success w-100 open-shop"
                        data-bs-toggle="modal"
                        data-bs-target="#open-shop-modal"
                        data-shop-id="'.htmlspecialchars($shopId).'">

                        Add Order

                    </button>

                </div>

            </div>
        </div>';
    }

    $floorPlanTableHtml .= '</div></div>';

    $floorPlansContentHtml .= $floorPlanTableHtml;

    $floorPlansHtml .= '
    <div class="col-lg-2 mb-7">
        <a class="nav-link nav-link-border-solid btn btn-outline btn-flex 
        btn-active-color-primary flex-column flex-stack w-100 p-8 page-bg '.$activeNav.'"
        data-bs-toggle="pill"
        href="#floor_plan_'.$floorPlanId.'">

            <div>
                <span class="text-gray-800 fw-bold fs-2 d-block">
                    '.htmlspecialchars($floorPlanName).'
                </span>

                <span class="text-primary fw-semibold fs-7">
                    '.number_format($tableCount).' '.$tableLabel.'
                </span>

                <span class="text-primary fw-semibold fs-7">
                    '.number_format($seatCount).' '.$seatLabel.'
                </span>

            </div>

        </a>
    </div>';

    $isFirst = false;
}
?>

<div class="row nav nav-pills nav-pills-custom">
    <?= $floorPlansHtml ?>
</div>

<div class="tab-content">
    <?= $floorPlansContentHtml ?: '<div class="col-12"><div class="alert alert-info">No tables found for this floor plan.</div></div>'; ?>
</div>