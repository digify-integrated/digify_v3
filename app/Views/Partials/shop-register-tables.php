<div class="card card-flush card-p-0 bg-transparent border-0 "> 
    <div class="card-body">
        <ul class="nav nav-pills d-flex justify-content-between nav-pills-custom gap-3 mb-6">
            <?php
                $floorPlansHtml = '';
                $floorPlans     = $shop->fetchShopFloorPlans($shopId);

                $isFirst = true;

                foreach ($floorPlans as $row) {
                    $floorPlanId   = $row['floor_plan_id'];
                    $floorPlanName = $row['floor_plan_name'];

                    $tableCount = $floorPlan->fetchFloorPlanTableCount($floorPlanId)['total'] ?? 0;
                    $seatCount = $floorPlan->fetchFloorPlanSeatCount($floorPlanId)['total'] ?? 0;

                    $tableLabel = $tableCount === 1 ? 'Table' : 'Tables';
                    $seatLabel = $seatCount === 1 ? 'Seat' : 'Seats';

                    $activeClass = $isFirst ? 'show active' : '';

                    $floorPlansHtml .= '
                        <li class="nav-item mb-3 me-0">
                            <a class="nav-link nav-link-border-solid btn btn-outline btn-flex btn-active-color-primary flex-column flex-stack pt-7 pb-7 page-bg ' . $activeClass . '" 
                                data-bs-toggle="pill" href="#floor_plan_' . $floorPlanId . '">
                                
                                <div>
                                    <span class="text-gray-800 fw-bold fs-2 d-block">'
                                        . htmlspecialchars($floorPlanName) .
                                    '</span> 
                                    
                                    <span class="text-gray-500 fw-semibold fs-7">'
                                        . number_format($tableCount) . ' ' . $tableLabel .
                                    '</span> 
                                    
                                    <span class="text-gray-500 fw-semibold fs-7">'
                                        . number_format($seatCount) . ' ' . $seatLabel .
                                    '</span> 
                                </div>
                            </a>
                        </li>';

                    $isFirst = false;
                }

                echo $floorPlansHtml;
            ?>
        </ul>

        <div class="tab-content">0
            <?php
            
            ?>
            <div class="tab-pane fade show active" id="kt_pos_food_content_1"> 
                                                                           
            </div>
        </div>
    </div>
</div>