<div class="row g-5 g-xl-9">
    <?php
        $apps = '';
                    
        $appModules = $authentication->fetchAppModuleStack($userID);

        foreach ($appModules as $row) {
            $appModuleID = $row['app_module_id'];
            $appModuleName = $row['app_module_name'];
            $appModuleDescription = $row['app_module_description'];
            $menuItemID = $row['menu_item_id'];
            $appLogo = $systemHelper->checkImageExist($row['app_logo'], 'app module logo');

            $menuItemDetails = $menuItem->fetchMenuItem($menuItemID);
            $menuItemURL = $menuItemDetails['menu_item_url'] ?? null;
                        
            $apps .= '<div class="col-md-6 col-xl-4">
                        <a href="'. $menuItemURL .'?app_module_id='. $security->encryptData($appModuleID) .'&page_id='. $security->encryptData($menuItemID) .'" class="card border-hover-primary">
                            <div class="card-header border-0 pt-9">
                                <div class="card-title m-0">
                                    <div class="symbol symbol-50px w-50px bg-light">
                                        <img src="'. $appLogo .'" alt="image" class="p-3" />
                                    </div>
                                </div>
                            </div>

                            <div class="card-body p-9">
                                <div class="fs-1 fw-bold text-gray-900">
                                    '. $appModuleName .'
                                </div>
                                <p class="text-gray-500 fw-semibold fs-7 mt-1">
                                    '. $appModuleDescription .'
                                </p>
                            </div>
                        </a>
                    </div>';
        }
                
        echo $apps;
    ?>
</div>