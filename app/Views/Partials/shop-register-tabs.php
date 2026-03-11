<?php if ($floorPlanCount > 0): ?>

    <li class="nav-item" role="presentation">
        <a class="nav-link text-white text-active-primary fs-5 fw-bold active"
           data-bs-toggle="tab"
           href="#tables_tab"
           role="tab">
            Tables
        </a>
    </li>

    <li class="nav-item" role="presentation">
        <a class="nav-link text-white text-active-primary fs-5 fw-bold"
           data-bs-toggle="tab"
           href="#register_tab"
           role="tab">
            Register
        </a>
    </li>

<?php else: ?>

    <li class="nav-item" role="presentation">
        <a class="nav-link text-white text-active-primary fs-5 fw-bold active"
           data-bs-toggle="tab"
           href="#register_tab"
           role="tab">
            Register
        </a>
    </li>

<?php endif; ?>

<li class="nav-item" role="presentation">
    <a class="nav-link text-white text-active-primary fs-5 fw-bold"
        data-bs-toggle="tab"
        href="#orders_tab"
        aria-selected="false"
        role="tab"
        tabindex="-1">
        Orders
    </a>
</li>