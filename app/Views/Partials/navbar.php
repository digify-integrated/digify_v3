<div class="app-header-menu app-header-mobile-drawer align-items-stretch" data-kt-drawer="true" data-kt-drawer-name="app-header-menu" data-kt-drawer-activate="{default: true, lg: false}" data-kt-drawer-overlay="true" data-kt-drawer-width="250px" data-kt-drawer-direction="start" data-kt-drawer-toggle="#kt_app_header_menu_toggle" data-kt-swapper="true" data-kt-swapper-mode="{default: 'append', lg: 'prepend'}" data-kt-swapper-parent="{default: '#kt_app_body', lg: '#kt_app_header_wrapper'}">
    <div class="menu menu-rounded menu-active-bg menu-state-primary menu-column menu-lg-row menu-title-gray-700 menu-icon-gray-500 menu-arrow-gray-500 menu-bullet-gray-500 my-5 my-lg-0 align-items-stretch fw-semibold px-2 px-lg-0" id="kt_app_header_menu" data-kt-menu="true">
        <?php
            $menu = '';

            if (!empty($_GET['page_id']) && !empty($_GET['app_module_id'])) {

                $navBar = $menuItem->fetchNavBar($userID, $appModuleID);

                $menuItems = [];
                foreach ($navBar as $row) {
                    $id = $row['menu_item_id'];
                    $menuItems[$id] = [
                        'MENU_ITEM_ID'   => $id,
                        'MENU_ITEM_NAME' => $row['menu_item_name'],
                        'MENU_ITEM_URL'  => $row['menu_item_url'] ?? null,
                        'PARENT_ID'      => $row['parent_id'],
                        'MENU_ITEM_ICON' => $row['menu_item_icon'] ?? null,
                        'APP_MODULE_ID'  => $row['app_module_id'],
                        'ORDER_SEQUENCE' => $row['order_sequence'] ?? 0,
                        'CHILDREN'       => []
                    ];
                }

                foreach ($menuItems as $id => $item) {
                    if (!empty($item['PARENT_ID']) && isset($menuItems[$item['PARENT_ID']])) {
                        $menuItems[$item['PARENT_ID']]['CHILDREN'][$id] = &$menuItems[$id];
                    }
                }

                $rootMenuItems = [];
                foreach ($menuItems as $id => &$item) {
                    if (empty($item['PARENT_ID'])) {
                        $rootMenuItems[$id] = &$item;
                    }
                }

                unset($item);
                    
                $sortTree = function (&$items) use (&$sortTree) {
                    if (empty($items)) return;
                    uasort($items, function ($a, $b) {
                        $as = $a['ORDER_SEQUENCE'] ?? 0;
                        $bs = $b['ORDER_SEQUENCE'] ?? 0;
                        if ($as === $bs) {
                            return strcmp($a['MENU_ITEM_NAME'], $b['MENU_ITEM_NAME']);
                        }
                        return $as <=> $bs;
                    });
                    foreach ($items as &$it) {
                        if (!empty($it['CHILDREN'])) {
                            $sortTree($it['CHILDREN']);
                        }
                    }
                    unset($it);
                };

                $sortTree($rootMenuItems);

                foreach ($rootMenuItems as $root) {
                    $menu .= $systemHelper->buildMenuItemHTML($root);
                }
            }

            echo $menu;
        ?>
    </div>
</div>