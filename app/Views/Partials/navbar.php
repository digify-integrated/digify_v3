<div class="app-header-menu app-header-mobile-drawer align-items-stretch" data-kt-drawer="true" data-kt-drawer-name="app-header-menu" data-kt-drawer-activate="{default: true, lg: false}" data-kt-drawer-overlay="true" data-kt-drawer-width="250px" data-kt-drawer-direction="start" data-kt-drawer-toggle="#kt_app_header_menu_toggle" data-kt-swapper="true" data-kt-swapper-mode="{default: 'append', lg: 'prepend'}" data-kt-swapper-parent="{default: '#kt_app_body', lg: '#kt_app_header_wrapper'}">
    <div class="menu menu-rounded menu-active-bg menu-state-primary menu-column menu-lg-row menu-title-gray-700 menu-icon-gray-500 menu-arrow-gray-500 menu-bullet-gray-500 my-5 my-lg-0 align-items-stretch fw-semibold px-2 px-lg-0" id="kt_app_header_menu" data-kt-menu="true">
        <?php
            $menu = '';

            if (!empty($_GET['page_id']) && !empty($_GET['app_module_id'])) {

                $navBar = $menuItem->fetchNavBar($userID, $appModuleID);

                foreach ($navBar as $row) {
                    $menuItemID     = $row['menu_item_id'];
                    $menuItemName   = $row['menu_item_name'];
                    $menuItemURL    = $row['menu_item_url'] ?? null;
                    $parentID       = $row['parent_id'];
                    $appModuleID    = $row['app_module_id'];
                    $menuItemIcon   = !empty($row['menu_item_icon']) ? $row['menu_item_icon'] : null;
                    
                    $menuItemArray = [
                        'MENU_ITEM_ID'      => $menuItemID,
                        'MENU_ITEM_NAME'    => $menuItemName,
                        'MENU_ITEM_URL'     => $menuItemURL,
                        'PARENT_ID'         => $parentID,
                        'MENU_ITEM_ICON'    => $menuItemIcon,
                        'APP_MODULE_ID'     => $appModuleID,
                        'CHILDREN'          => []
                    ];
                    
                    $menuItems[$menuItemID] = $menuItemArray;
                }

                foreach ($menuItems as $menuItemArray) {
                    if (!empty($menuItemArray['PARENT_ID'])) {
                        if ($authentication->checkUserPermission($userID, $menuItemArray['PARENT_ID'], 'read')['total'] > 0) {
                            $menuItems[$menuItemArray['PARENT_ID']]['CHILDREN'][] = &$menuItems[$menuItemArray['MENU_ITEM_ID']];
                        }
                    }
                }
                    
                $rootMenuItems = array_filter($menuItems, function ($item) {
                    return empty($item['PARENT_ID']);
                });
                    
                foreach ($rootMenuItems as $rootMenuItem) {
                    $menu .= $systemHelper->buildMenuItemHTML($rootMenuItem);
                }      
            }

            echo $menu;
        ?>
    </div>
</div>