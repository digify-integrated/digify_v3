<div class="card mb-6">
    <div class="card-header border-0 pt-6">
        <div class="card-title">
            <?php require './app/Views/Partials/datatable-search.php'; ?>
        </div>
    </div>
    <div class="card-body pt-9">
        <div class="table-responsive">
            <table class="table align-middle table-hover cursor-pointer table-row-dashed fs-6 gy-5" id="orders-table">
                <thead>
                    <tr class="text-start text-gray-800 fw-bold fs-7 text-uppercase gs-0">
                        <th>Order ID</th>
                        <th>Table</th>
                        <th>Tab</th>
                        <th>Amount Due</th>
                        <th>Amount Paid</th>
                        <th>Change</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody class="fw-semibold text-gray-800"></tbody>
            </table>
        </div>
    </div>
</div>