<?php
    $addMenuItemRoleAccess = $authentication->checkUserSystemActionPermission($userID, 7);
?>
<div class="card mb-10">
    <div class="card-header border-0">
        <div class="card-title m-0">
            <h3 class="fw-bold m-0">Menu Item Details</h3>
        </div>
        <?php
            if ($permissions['delete'] > 0) {
                $action = '<a href="#" class="btn btn-light-primary btn-flex btn-center btn-active-light-primary show menu-dropdown align-self-center" data-kt-menu-trigger="click" data-kt-menu-placement="bottom-end">
                                        Actions
                                        <i class="ki-outline ki-down fs-5 ms-1"></i>
                                    </a>
                                    <div class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-600 menu-state-bg-light-primary fw-semibold fs-7 w-125px py-4" data-kt-menu="true" style="z-index: 107; position: fixed; inset: 0px 0px auto auto; margin: 0px; transform: translate(-60px, 539px);" data-popper-placement="bottom-end">';
                    
                if ($permissions['delete'] > 0) {
                    $action .= '<div class="menu-item px-3">
                                    <a href="javascript:void(0);" class="menu-link px-3" id="delete-menu-item">
                                        Delete
                                    </a>
                                </div>';
                }
                        
                $action .= '</div>';
                        
                echo $action;
            }
        ?>
    </div>
    <div class="card-body">
        <form id="menu_item_form" method="post" action="#">
            <?= $security->csrfInput('menu_item_form'); ?>
            <div class="fv-row mb-4">
                <label class="fs-6 fw-semibold form-label mt-3" for="menu_item_name">
                    <span class="required">Display Name</span>
                </label>

                <input type="text" class="form-control" id="menu_item_name" name="menu_item_name" maxlength="100" autocomplete="off" <?php echo $disabled; ?>>
            </div>

            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="app_module_id">
                            <span class="required">App Module</span>
                        </label>

                        <select id="app_module_id" name="app_module_id" class="form-select" data-control="select2" data-allow-clear="false" <?php echo $disabled; ?>></select>
                    </div>

                </div>

                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="parent_id">
                            Parent Menu
                        </label>

                        <select id="parent_id" name="parent_id" class="form-select" data-control="select2" data-allow-clear="false" <?php echo $disabled; ?>></select>
                    </div>
                </div>
            </div>

            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="app_module_id">
                            Icon
                        </label>

                        <select id="menu_item_icon" name="menu_item_icon" class="form-select" data-control="select2" data-allow-clear="false" <?php echo $disabled; ?>>
                            <option value="">--</option>
                            <optgroup label="Abstract">
                                <option value="ki-outline ki-abstract">ki-outline ki-abstract</option>
                                <option value="ki-outline ki-abstract-1">ki-outline ki-abstract-1</option>
                                <option value="ki-outline ki-abstract-2">ki-outline ki-abstract-2</option>
                                <option value="ki-outline ki-abstract-3">ki-outline ki-abstract-3</option>
                                <option value="ki-outline ki-abstract-4">ki-outline ki-abstract-4</option>
                                <option value="ki-outline ki-abstract-5">ki-outline ki-abstract-5</option>
                                <option value="ki-outline ki-abstract-6">ki-outline ki-abstract-6</option>
                                <option value="ki-outline ki-abstract-7">ki-outline ki-abstract-7</option>
                                <option value="ki-outline ki-abstract-8">ki-outline ki-abstract-8</option>
                                <option value="ki-outline ki-abstract-9">ki-outline ki-abstract-9</option>
                                <option value="ki-outline ki-abstract-10">ki-outline ki-abstract-10</option>
                                <option value="ki-outline ki-abstract-11">ki-outline ki-abstract-11</option>
                                <option value="ki-outline ki-abstract-12">ki-outline ki-abstract-12</option>
                                <option value="ki-outline ki-abstract-13">ki-outline ki-abstract-13</option>
                                <option value="ki-outline ki-abstract-14">ki-outline ki-abstract-14</option>
                                <option value="ki-outline ki-abstract-15">ki-outline ki-abstract-15</option>
                                <option value="ki-outline ki-abstract-16">ki-outline ki-abstract-16</option>
                                <option value="ki-outline ki-abstract-17">ki-outline ki-abstract-17</option>
                                <option value="ki-outline ki-abstract-18">ki-outline ki-abstract-18</option>
                                <option value="ki-outline ki-abstract-19">ki-outline ki-abstract-19</option>
                                <option value="ki-outline ki-abstract-20">ki-outline ki-abstract-20</option>
                                <option value="ki-outline ki-abstract-21">ki-outline ki-abstract-21</option>
                                <option value="ki-outline ki-abstract-22">ki-outline ki-abstract-22</option>
                                <option value="ki-outline ki-abstract-23">ki-outline ki-abstract-23</option>
                                <option value="ki-outline ki-abstract-24">ki-outline ki-abstract-24</option>
                                <option value="ki-outline ki-abstract-25">ki-outline ki-abstract-25</option>
                                <option value="ki-outline ki-abstract-26">ki-outline ki-abstract-26</option>
                                <option value="ki-outline ki-abstract-27">ki-outline ki-abstract-27</option>
                                <option value="ki-outline ki-abstract-28">ki-outline ki-abstract-28</option>
                                <option value="ki-outline ki-abstract-29">ki-outline ki-abstract-29</option>
                                <option value="ki-outline ki-abstract-30">ki-outline ki-abstract-30</option>
                                <option value="ki-outline ki-abstract-31">ki-outline ki-abstract-31</option>
                                <option value="ki-outline ki-abstract-32">ki-outline ki-abstract-32</option>
                                <option value="ki-outline ki-abstract-33">ki-outline ki-abstract-33</option>
                                <option value="ki-outline ki-abstract-34">ki-outline ki-abstract-34</option>
                                <option value="ki-outline ki-abstract-35">ki-outline ki-abstract-35</option>
                                <option value="ki-outline ki-abstract-36">ki-outline ki-abstract-36</option>
                                <option value="ki-outline ki-abstract-37">ki-outline ki-abstract-37</option>
                                <option value="ki-outline ki-abstract-38">ki-outline ki-abstract-38</option>
                                <option value="ki-outline ki-abstract-39">ki-outline ki-abstract-39</option>
                                <option value="ki-outline ki-abstract-40">ki-outline ki-abstract-40</option>
                                <option value="ki-outline ki-abstract-41">ki-outline ki-abstract-41</option>
                                <option value="ki-outline ki-abstract-42">ki-outline ki-abstract-42</option>
                                <option value="ki-outline ki-abstract-43">ki-outline ki-abstract-43</option>
                                <option value="ki-outline ki-abstract-44">ki-outline ki-abstract-44</option>
                                <option value="ki-outline ki-abstract-45">ki-outline ki-abstract-45</option>
                                <option value="ki-outline ki-abstract-46">ki-outline ki-abstract-46</option>
                                <option value="ki-outline ki-abstract-47">ki-outline ki-abstract-47</option>
                                <option value="ki-outline ki-abstract-48">ki-outline ki-abstract-48</option>
                                <option value="ki-outline ki-abstract-49">ki-outline ki-abstract-49</option>
                            </optgroup>

                            <optgroup label="Settings">
                                <option value="ki-outline ki-category">ki-outline ki-category</option>
                                <option value="ki-outline ki-more-2">ki-outline ki-more-2</option>
                                <option value="ki-outline ki-setting">ki-outline ki-setting</option>
                                <option value="ki-outline ki-setting-2">ki-outline ki-setting-2</option>
                                <option value="ki-outline ki-setting-3">ki-outline ki-setting-3</option>
                                <option value="ki-outline ki-setting-4">ki-outline ki-setting-4</option>
                                <option value="ki-outline ki-toggle-off">ki-outline ki-toggle-off</option>
                                <option value="ki-outline ki-toggle-off-circle">ki-outline ki-toggle-off-circle</option>
                                <option value="ki-outline ki-toggle-on">ki-outline ki-toggle-on</option>
                                <option value="ki-outline ki-toggle-on-circle">ki-outline ki-toggle-on-circle</option>
                            </optgroup>

                            <optgroup label="Design">
                                <option value="ki-outline ki-add-item">ki-outline ki-add-item</option>
                                <option value="ki-outline ki-brush">ki-outline ki-brush</option>
                                <option value="ki-outline ki-bucket">ki-outline ki-bucket</option>
                                <option value="ki-outline ki-bucket-square">ki-outline ki-bucket-square</option>
                                <option value="ki-outline ki-colors-square">ki-outline ki-colors-square</option>
                                <option value="ki-outline ki-color-swatch">ki-outline ki-color-swatch</option>
                                <option value="ki-outline ki-copy">ki-outline ki-copy</option>
                                <option value="ki-outline ki-copy-success">ki-outline ki-copy-success</option>
                                <option value="ki-outline ki-design">ki-outline ki-design</option>
                                <option value="ki-outline ki-design-2">ki-outline ki-design-2</option>
                                <option value="ki-outline ki-design-frame">ki-outline ki-design-frame</option>
                                <option value="ki-outline ki-design-mask">ki-outline ki-design-mask</option>
                                <option value="ki-outline ki-eraser">ki-outline ki-eraser</option>
                                <option value="ki-outline ki-feather">ki-outline ki-feather</option>
                                <option value="ki-outline ki-glass">ki-outline ki-glass</option>
                                <option value="ki-outline ki-paintbucket">ki-outline ki-paintbucket</option>
                                <option value="ki-outline ki-pencil">ki-outline ki-pencil</option>
                                <option value="ki-outline ki-size">ki-outline ki-size</option>
                                <option value="ki-outline ki-text">ki-outline ki-text</option>
                            </optgroup>

                            <optgroup label="Social Media">
                                <option value="ki-outline ki-behance">ki-outline ki-behance</option>
                                <option value="ki-outline ki-classmates">ki-outline ki-classmates</option>
                                <option value="ki-outline ki-dribbble">ki-outline ki-dribbble</option>
                                <option value="ki-outline ki-facebook">ki-outline ki-facebook</option>
                                <option value="ki-outline ki-instagram">ki-outline ki-instagram</option>
                                <option value="ki-outline ki-snapchat">ki-outline ki-snapchat</option>
                                <option value="ki-outline ki-social-media">ki-outline ki-social-media</option>
                                <option value="ki-outline ki-tiktok">ki-outline ki-tiktok</option>
                                <option value="ki-outline ki-twitter">ki-outline ki-twitter</option>
                                <option value="ki-outline ki-whatsapp">ki-outline ki-whatsapp</option>
                                <option value="ki-outline ki-youtube">ki-outline ki-youtube</option>
                            </optgroup>

                            <optgroup label="IT Network">
                                <option value="ki-outline ki-click">ki-outline ki-click</option>
                                <option value="ki-outline ki-code">ki-outline ki-code</option>
                                <option value="ki-outline ki-data">ki-outline ki-data</option>
                                <option value="ki-outline ki-disconnect">ki-outline ki-disconnect</option>
                                <option value="ki-outline ki-fasten">ki-outline ki-fasten</option>
                                <option value="ki-outline ki-frame">ki-outline ki-frame</option>
                                <option value="ki-outline ki-gear">ki-outline ki-gear</option>
                                <option value="ki-outline ki-loading">ki-outline ki-loading</option>
                                <option value="ki-outline ki-message-programming">ki-outline ki-message-programming</option>
                                <option value="ki-outline ki-scroll">ki-outline ki-scroll</option>
                                <option value="ki-outline ki-square-brackets">ki-outline ki-square-brackets</option>
                                <option value="ki-outline ki-underlining">ki-outline ki-underlining</option>
                                <option value="ki-outline ki-wrench">ki-outline ki-wrench</option>
                            </optgroup>

                            <optgroup label="Technologies">
                                <option value="ki-outline ki-artificial-intelligence">ki-outline ki-artificial-intelligence</option>
                                <option value="ki-outline ki-electricity">ki-outline ki-electricity</option>
                                <option value="ki-outline ki-faceid">ki-outline ki-faceid</option>
                                <option value="ki-outline ki-fingerprint-scanning">ki-outline ki-fingerprint-scanning</option>
                                <option value="ki-outline ki-joystick">ki-outline ki-joystick</option>
                                <option value="ki-outline ki-technology">ki-outline ki-technology</option>
                                <option value="ki-outline ki-technology-2">ki-outline ki-technology-2</option>
                                <option value="ki-outline ki-technology-3">ki-outline ki-technology-3</option>
                                <option value="ki-outline ki-technology-4">ki-outline ki-technology-4</option>
                                <option value="ki-outline ki-tech-wifi">ki-outline ki-tech-wifi</option>
                            </optgroup>

                            <optgroup label="Ecommerce">
                                <option value="ki-outline ki-barcode">ki-outline ki-barcode</option>
                                <option value="ki-outline ki-basket">ki-outline ki-basket</option>
                                <option value="ki-outline ki-basket-ok">ki-outline ki-basket-ok</option>
                                <option value="ki-outline ki-cheque">ki-outline ki-cheque</option>
                                <option value="ki-outline ki-discount">ki-outline ki-discount</option>
                                <option value="ki-outline ki-handcart">ki-outline ki-handcart</option>
                                <option value="ki-outline ki-lots-shopping">ki-outline ki-lots-shopping</option>
                                <option value="ki-outline ki-package">ki-outline ki-package</option>
                                <option value="ki-outline ki-percentage">ki-outline ki-percentage</option>
                                <option value="ki-outline ki-purchase">ki-outline ki-purchase</option>
                                <option value="ki-outline ki-shop">ki-outline ki-shop</option>
                                <option value="ki-outline ki-tag">ki-outline ki-tag</option>
                            </optgroup>

                            <optgroup label="Archive">
                                <option value="ki-outline ki-archive-tick">ki-outline ki-archive-tick</option>
                                <option value="ki-outline ki-book-square">ki-outline ki-book-square</option>
                                <option value="ki-outline ki-receipt-square">ki-outline ki-receipt-square</option>
                                <option value="ki-outline ki-save-2">ki-outline ki-save-2</option>
                            </optgroup>

                            <optgroup label="Security">
                                <option value="ki-outline ki-eye">ki-outline ki-eye</option>
                                <option value="ki-outline ki-eye-slash">ki-outline ki-eye-slash</option>
                                <option value="ki-outline ki-key">ki-outline ki-key</option>
                                <option value="ki-outline ki-key-square">ki-outline ki-key-square</option>
                                <option value="ki-outline ki-lock">ki-outline ki-lock</option>
                                <option value="ki-outline ki-lock-2">ki-outline ki-lock-2</option>
                                <option value="ki-outline ki-lock-3">ki-outline ki-lock-3</option>
                                <option value="ki-outline ki-password-check">ki-outline ki-password-check</option>
                                <option value="ki-outline ki-scan-barcode">ki-outline ki-scan-barcode</option>
                                <option value="ki-outline ki-security-check">ki-outline ki-security-check</option>
                                <option value="ki-outline ki-security-user">ki-outline ki-security-user</option>
                                <option value="ki-outline ki-shield">ki-outline ki-shield</option>
                                <option value="ki-outline ki-shield-cross">ki-outline ki-shield-cross</option>
                                <option value="ki-outline ki-shield-search">ki-outline ki-shield-search</option>
                                <option value="ki-outline ki-shield-slash">ki-outline ki-shield-slash</option>
                                <option value="ki-outline ki-shield-tick">ki-outline ki-shield-tick</option>
                            </optgroup>

                            <optgroup label="General">
                                <option value="ki-outline ki-archive">ki-outline ki-archive</option>
                                <option value="ki-outline ki-auto-brightness">ki-outline ki-auto-brightness</option>
                                <option value="ki-outline ki-call">ki-outline ki-call</option>
                                <option value="ki-outline ki-cd">ki-outline ki-cd</option>
                                <option value="ki-outline ki-chrome">ki-outline ki-chrome</option>
                                <option value="ki-outline ki-cloud">ki-outline ki-cloud</option>
                                <option value="ki-outline ki-cloud-add">ki-outline ki-cloud-add</option>
                                <option value="ki-outline ki-cloud-change">ki-outline ki-cloud-change</option>
                                <option value="ki-outline ki-cloud-download">ki-outline ki-cloud-download</option>
                                <option value="ki-outline ki-coffee">ki-outline ki-coffee</option>
                                <option value="ki-outline ki-crown">ki-outline ki-crown</option>
                                <option value="ki-outline ki-crown-2">ki-outline ki-crown-2</option>
                                <option value="ki-outline ki-cup">ki-outline ki-cup</option>
                                <option value="ki-outline ki-diamonds">ki-outline ki-diamonds</option>
                                <option value="ki-outline ki-disk">ki-outline ki-disk</option>
                                <option value="ki-outline ki-emoji-happy">ki-outline ki-emoji-happy</option>
                                <option value="ki-outline ki-filter">ki-outline ki-filter</option>
                                <option value="ki-outline ki-filter-edit">ki-outline ki-filter-edit</option>
                                <option value="ki-outline ki-filter-search">ki-outline ki-filter-search</option>
                                <option value="ki-outline ki-filter-square">ki-outline ki-filter-square</option>
                                <option value="ki-outline ki-filter-tick">ki-outline ki-filter-tick</option>
                                <option value="ki-outline ki-flash-circle">ki-outline ki-flash-circle</option>
                                <option value="ki-outline ki-general-mouse">ki-outline ki-general-mouse</option>
                                <option value="ki-outline ki-ghost">ki-outline ki-ghost</option>
                                <option value="ki-outline ki-gift">ki-outline ki-gift</option>
                                <option value="ki-outline ki-happy-emoji">ki-outline ki-happy-emoji</option>
                                <option value="ki-outline ki-home">ki-outline ki-home</option>
                                <option value="ki-outline ki-home-1">ki-outline ki-home-1</option>
                                <option value="ki-outline ki-home-2">ki-outline ki-home-2</option>
                                <option value="ki-outline ki-home-3">ki-outline ki-home-3</option>
                                <option value="ki-outline ki-icon">ki-outline ki-icon</option>
                                <option value="ki-outline ki-information">ki-outline ki-information</option>
                                <option value="ki-outline ki-magnifier">ki-outline ki-magnifier</option>
                                <option value="ki-outline ki-menu">ki-outline ki-menu</option>
                                <option value="ki-outline ki-milk">ki-outline ki-milk</option>
                                <option value="ki-outline ki-mouse-circle">ki-outline ki-mouse-circle</option>
                                <option value="ki-outline ki-mouse-square">ki-outline ki-mouse-square</option>
                                <option value="ki-outline ki-paper-clip">ki-outline ki-paper-clip</option>
                                <option value="ki-outline ki-picture">ki-outline ki-picture</option>
                                <option value="ki-outline ki-pin">ki-outline ki-pin</option>
                                <option value="ki-outline ki-ranking">ki-outline ki-ranking</option>
                                <option value="ki-outline ki-rescue">ki-outline ki-rescue</option>
                                <option value="ki-outline ki-rocket">ki-outline ki-rocket</option>
                                <option value="ki-outline ki-safe-home">ki-outline ki-safe-home</option>
                                <option value="ki-outline ki-send">ki-outline ki-send</option>
                                <option value="ki-outline ki-share">ki-outline ki-share</option>
                                <option value="ki-outline ki-slider">ki-outline ki-slider</option>
                                <option value="ki-outline ki-sort">ki-outline ki-sort</option>
                                <option value="ki-outline ki-star">ki-outline ki-star</option>
                                <option value="ki-outline ki-status">ki-outline ki-status</option>
                                <option value="ki-outline ki-subtitle">ki-outline ki-subtitle</option>
                                <option value="ki-outline ki-switch">ki-outline ki-switch</option>
                                <option value="ki-outline ki-tag-cross">ki-outline ki-tag-cross</option>
                                <option value="ki-outline ki-trash">ki-outline ki-trash</option>
                                <option value="ki-outline ki-trash-square">ki-outline ki-trash-square</option>
                                <option value="ki-outline ki-tree">ki-outline ki-tree</option>
                                <option value="ki-outline ki-triangle">ki-outline ki-triangle</option>
                                <option value="ki-outline ki-verify">ki-outline ki-verify</option>
                                <option value="ki-outline ki-wifi-home">ki-outline ki-wifi-home</option>
                                <option value="ki-outline ki-wifi-square">ki-outline ki-wifi-square</option>
                            </optgroup>

                            <optgroup label="Location">
                                <option value="ki-outline ki-compass">ki-outline ki-compass</option>
                                <option value="ki-outline ki-flag">ki-outline ki-flag</option>
                                <option value="ki-outline ki-focus">ki-outline ki-focus</option>
                                <option value="ki-outline ki-geolocation">ki-outline ki-geolocation</option>
                                <option value="ki-outline ki-geolocation-home">ki-outline ki-geolocation-home</option>
                                <option value="ki-outline ki-map">ki-outline ki-map</option>
                                <option value="ki-outline ki-pointers">ki-outline ki-pointers</option>
                                <option value="ki-outline ki-route">ki-outline ki-route</option>
                                <option value="ki-outline ki-satellite">ki-outline ki-satellite</option>
                                <option value="ki-outline ki-telephone-geolocation">ki-outline ki-telephone-geolocation</option>
                            </optgroup>

                            <optgroup label="Education">
                                <option value="ki-outline ki-award">ki-outline ki-award</option>
                                <option value="ki-outline ki-book">ki-outline ki-book</option>
                                <option value="ki-outline ki-bookmark">ki-outline ki-bookmark</option>
                                <option value="ki-outline ki-bookmark-2">ki-outline ki-bookmark-2</option>
                                <option value="ki-outline ki-book-open">ki-outline ki-book-open</option>
                                <option value="ki-outline ki-briefcase">ki-outline ki-briefcase</option>
                                <option value="ki-outline ki-brifecase-cros">ki-outline ki-brifecase-cros</option>
                                <option value="ki-outline ki-brifecase-tick">ki-outline ki-brifecase-tick</option>
                                <option value="ki-outline ki-brifecase-timer">ki-outline ki-brifecase-timer</option>
                                <option value="ki-outline ki-clipboard">ki-outline ki-clipboard</option>
                                <option value="ki-outline ki-note">ki-outline ki-note</option>
                                <option value="ki-outline ki-note-2">ki-outline ki-note-2</option>
                                <option value="ki-outline ki-teacher">ki-outline ki-teacher</option>
                            </optgroup>

                            <optgroup label="Business">
                                <option value="ki-outline ki-badge">ki-outline ki-badge</option>
                                <option value="ki-outline ki-chart">ki-outline ki-chart</option>
                                <option value="ki-outline ki-chart-line">ki-outline ki-chart-line</option>
                                <option value="ki-outline ki-chart-line-down">ki-outline ki-chart-line-down</option>
                                <option value="ki-outline ki-chart-line-down-2">ki-outline ki-chart-line-down-2</option>
                                <option value="ki-outline ki-chart-line-star">ki-outline ki-chart-line-star</option>
                                <option value="ki-outline ki-chart-line-up">ki-outline ki-chart-line-up</option>
                                <option value="ki-outline ki-chart-line-up-2">ki-outline ki-chart-line-up-2</option>
                                <option value="ki-outline ki-chart-pie-3">ki-outline ki-chart-pie-3</option>
                                <option value="ki-outline ki-chart-pie-4">ki-outline ki-chart-pie-4</option>
                                <option value="ki-outline ki-chart-pie-simple">ki-outline ki-chart-pie-simple</option>
                                <option value="ki-outline ki-chart-pie-too">ki-outline ki-chart-pie-too</option>
                                <option value="ki-outline ki-chart-simple">ki-outline ki-chart-simple</option>
                                <option value="ki-outline ki-chart-simple-2">ki-outline ki-chart-simple-2</option>
                                <option value="ki-outline ki-chart-simple-3">ki-outline ki-chart-simple-3</option>
                                <option value="ki-outline ki-graph">ki-outline ki-graph</option>
                                <option value="ki-outline ki-graph-2">ki-outline ki-graph-2</option>
                                <option value="ki-outline ki-graph-3">ki-outline ki-graph-3</option>
                                <option value="ki-outline ki-graph-4">ki-outline ki-graph-4</option>
                                <option value="ki-outline ki-graph-up">ki-outline ki-graph-up</option>
                            </optgroup>

                            <optgroup label="Files Folders">
                                <option value="ki-outline ki-add-files">ki-outline ki-add-files</option>
                                <option value="ki-outline ki-add-folder">ki-outline ki-add-folder</option>
                                <option value="ki-outline ki-add-notepad">ki-outline ki-add-notepad</option>
                                <option value="ki-outline ki-delete-files">ki-outline ki-delete-files</option>
                                <option value="ki-outline ki-delete-folder">ki-outline ki-delete-folder</option>
                                <option value="ki-outline ki-document">ki-outline ki-document</option>
                                <option value="ki-outline ki-file">ki-outline ki-file</option>
                                <option value="ki-outline ki-file-added">ki-outline ki-file-added</option>
                                <option value="ki-outline ki-file-deleted">ki-outline ki-file-deleted</option>
                                <option value="ki-outline ki-file-down">ki-outline ki-file-down</option>
                                <option value="ki-outline ki-file-left">ki-outline ki-file-left</option>
                                <option value="ki-outline ki-file-right">ki-outline ki-file-right</option>
                                <option value="ki-outline ki-file-sheet">ki-outline ki-file-sheet</option>
                                <option value="ki-outline ki-files-tablet">ki-outline ki-files-tablet</option>
                                <option value="ki-outline ki-file-up">ki-outline ki-file-up</option>
                                <option value="ki-outline ki-filter-tablet">ki-outline ki-filter-tablet</option>
                                <option value="ki-outline ki-folder">ki-outline ki-folder</option>
                                <option value="ki-outline ki-folder-added">ki-outline ki-folder-added</option>
                                <option value="ki-outline ki-folder-down">ki-outline ki-folder-down</option>
                                <option value="ki-outline ki-folder-up">ki-outline ki-folder-up</option>
                                <option value="ki-outline ki-like-folder">ki-outline ki-like-folder</option>
                                <option value="ki-outline ki-minus-folder">ki-outline ki-minus-folder</option>
                                <option value="ki-outline ki-notepad">ki-outline ki-notepad</option>
                                <option value="ki-outline ki-notepad-bookmark">ki-outline ki-notepad-bookmark</option>
                                <option value="ki-outline ki-notepad-edit">ki-outline ki-notepad-edit</option>
                                <option value="ki-outline ki-questionnaire-tablet">ki-outline ki-questionnaire-tablet</option>
                                <option value="ki-outline ki-search-list">ki-outline ki-search-list</option>
                                <option value="ki-outline ki-some-files">ki-outline ki-some-files</option>
                                <option value="ki-outline ki-tablet-book">ki-outline ki-tablet-book</option>
                                <option value="ki-outline ki-tablet-delete">ki-outline ki-tablet-delete</option>
                                <option value="ki-outline ki-tablet-down">ki-outline ki-tablet-down</option>
                                <option value="ki-outline ki-tablet-ok">ki-outline ki-tablet-ok</option>
                                <option value="ki-outline ki-tablet-text-down">ki-outline ki-tablet-text-down</option>
                                <option value="ki-outline ki-tablet-text-up">ki-outline ki-tablet-text-up</option>
                                <option value="ki-outline ki-tablet-up">ki-outline ki-tablet-up</option>
                                <option value="ki-outline ki-update-file">ki-outline ki-update-file</option>
                                <option value="ki-outline ki-update-folder">ki-outline ki-update-folder</option>
                            </optgroup>

                            <optgroup label="Software">
                                <option value="ki-outline ki-android">ki-outline ki-android</option>
                                <option value="ki-outline ki-angular">ki-outline ki-angular</option>
                                <option value="ki-outline ki-apple">ki-outline ki-apple</option>
                                <option value="ki-outline ki-bootstrap">ki-outline ki-bootstrap</option>
                                <option value="ki-outline ki-css">ki-outline ki-css</option>
                                <option value="ki-outline ki-dj">ki-outline ki-dj</option>
                                <option value="ki-outline ki-dropbox">ki-outline ki-dropbox</option>
                                <option value="ki-outline ki-figma">ki-outline ki-figma</option>
                                <option value="ki-outline ki-github">ki-outline ki-github</option>
                                <option value="ki-outline ki-google">ki-outline ki-google</option>
                                <option value="ki-outline ki-google-play">ki-outline ki-google-play</option>
                                <option value="ki-outline ki-html">ki-outline ki-html</option>
                                <option value="ki-outline ki-illustrator">ki-outline ki-illustrator</option>
                                <option value="ki-outline ki-js">ki-outline ki-js</option>
                                <option value="ki-outline ki-js-2">ki-outline ki-js-2</option>
                                <option value="ki-outline ki-laravel">ki-outline ki-laravel</option>
                                <option value="ki-outline ki-microsoft">ki-outline ki-microsoft</option>
                                <option value="ki-outline ki-pails">ki-outline ki-pails</option>
                                <option value="ki-outline ki-photoshop">ki-outline ki-photoshop</option>
                                <option value="ki-outline ki-python">ki-outline ki-python</option>
                                <option value="ki-outline ki-react">ki-outline ki-react</option>
                                <option value="ki-outline ki-slack">ki-outline ki-slack</option>
                                <option value="ki-outline ki-soft">ki-outline ki-soft</option>
                                <option value="ki-outline ki-soft-2">ki-outline ki-soft-2</option>
                                <option value="ki-outline ki-soft-3">ki-outline ki-soft-3</option>
                                <option value="ki-outline ki-spotify">ki-outline ki-spotify</option>
                                <option value="ki-outline ki-spring-framework">ki-outline ki-spring-framework</option>
                                <option value="ki-outline ki-ts">ki-outline ki-ts</option>
                                <option value="ki-outline ki-twitch">ki-outline ki-twitch</option>
                                <option value="ki-outline ki-vue">ki-outline ki-vue</option>
                                <option value="ki-outline ki-vuesax">ki-outline ki-vuesax</option>
                                <option value="ki-outline ki-xaomi">ki-outline ki-xaomi</option>
                                <option value="ki-outline ki-xd">ki-outline ki-xd</option>
                                <option value="ki-outline ki-yii">ki-outline ki-yii</option>
                            </optgroup>

                            <optgroup label="Time">
                                <option value="ki-outline ki-calendar">ki-outline ki-calendar</option>
                                <option value="ki-outline ki-calendar-2">ki-outline ki-calendar-2</option>
                                <option value="ki-outline ki-calendar-8">ki-outline ki-calendar-8</option>
                                <option value="ki-outline ki-calendar-add">ki-outline ki-calendar-add</option>
                                <option value="ki-outline ki-calendar-edit">ki-outline ki-calendar-edit</option>
                                <option value="ki-outline ki-calendar-remove">ki-outline ki-calendar-remove</option>
                                <option value="ki-outline ki-calendar-search">ki-outline ki-calendar-search</option>
                                <option value="ki-outline ki-calendar-tick">ki-outline ki-calendar-tick</option>
                                <option value="ki-outline ki-time">ki-outline ki-time</option>
                                <option value="ki-outline ki-timer">ki-outline ki-timer</option>
                                <option value="ki-outline ki-watch">ki-outline ki-watch</option>
                            </optgroup>

                            <optgroup label="Support">
                                <option value="ki-outline ki-dislike">ki-outline ki-dislike</option>
                                <option value="ki-outline ki-heart">ki-outline ki-heart</option>
                                <option value="ki-outline ki-heart-circle">ki-outline ki-heart-circle</option>
                                <option value="ki-outline ki-information-2">ki-outline ki-information-2</option>
                                <option value="ki-outline ki-information-3">ki-outline ki-information-3</option>
                                <option value="ki-outline ki-information-4">ki-outline ki-information-4</option>
                                <option value="ki-outline ki-information-5">ki-outline ki-information-5</option>
                                <option value="ki-outline ki-like">ki-outline ki-like</option>
                                <option value="ki-outline ki-like-2">ki-outline ki-like-2</option>
                                <option value="ki-outline ki-like-shapes">ki-outline ki-like-shapes</option>
                                <option value="ki-outline ki-like-tag">ki-outline ki-like-tag</option>
                                <option value="ki-outline ki-lovely">ki-outline ki-lovely</option>
                                <option value="ki-outline ki-medal-star">ki-outline ki-medal-star</option>
                                <option value="ki-outline ki-message-question">ki-outline ki-message-question</option>
                                <option value="ki-outline ki-question">ki-outline ki-question</option>
                                <option value="ki-outline ki-question-2">ki-outline ki-question-2</option>
                                <option value="ki-outline ki-support-24">ki-outline ki-support-24</option>
                            </optgroup>

                            <optgroup label="Users">
                                <option value="ki-outline ki-bandage">ki-outline ki-bandage</option>
                                <option value="ki-outline ki-capsule">ki-outline ki-capsule</option>
                                <option value="ki-outline ki-flask">ki-outline ki-flask</option>
                                <option value="ki-outline ki-mask">ki-outline ki-mask</option>
                                <option value="ki-outline ki-Medicine">ki-outline ki-Medicine</option>
                                <option value="ki-outline ki-people">ki-outline ki-people</option>
                                <option value="ki-outline ki-pill">ki-outline ki-pill</option>
                                <option value="ki-outline ki-profile-circle">ki-outline ki-profile-circle</option>
                                <option value="ki-outline ki-profile-user">ki-outline ki-profile-user</option>
                                <option value="ki-outline ki-pulse">ki-outline ki-pulse</option>
                                <option value="ki-outline ki-syringe">ki-outline ki-syringe</option>
                                <option value="ki-outline ki-test-tubes">ki-outline ki-test-tubes</option>
                                <option value="ki-outline ki-thermometer">ki-outline ki-thermometer</option>
                                <option value="ki-outline ki-user">ki-outline ki-user</option>
                                <option value="ki-outline ki-user-edit">ki-outline ki-user-edit</option>
                                <option value="ki-outline ki-user-square">ki-outline ki-user-square</option>
                                <option value="ki-outline ki-user-tick">ki-outline ki-user-tick</option>
                                <option value="ki-outline ki-virus">ki-outline ki-virus</option>
                            </optgroup>

                            <optgroup label="Burger Menu">
                                <option value="ki-outline ki-burger-menu">ki-outline ki-burger-menu</option>
                                <option value="ki-outline ki-burger-menu-1">ki-outline ki-burger-menu-1</option>
                                <option value="ki-outline ki-burger-menu-2">ki-outline ki-burger-menu-2</option>
                                <option value="ki-outline ki-burger-menu-3">ki-outline ki-burger-menu-3</option>
                                <option value="ki-outline ki-burger-menu-4">ki-outline ki-burger-menu-4</option>
                                <option value="ki-outline ki-burger-menu-5">ki-outline ki-burger-menu-5</option>
                                <option value="ki-outline ki-burger-menu-6">ki-outline ki-burger-menu-6</option>
                            </optgroup>

                            <optgroup label="Typography">
                                <option value="ki-outline ki-text-align-center">ki-outline ki-text-align-center</option>
                                <option value="ki-outline ki-text-align-justify-center">ki-outline ki-text-align-justify-center</option>
                                <option value="ki-outline ki-text-align-left">ki-outline ki-text-align-left</option>
                                <option value="ki-outline ki-text-align-right">ki-outline ki-text-align-right</option>
                                <option value="ki-outline ki-text-bold">ki-outline ki-text-bold</option>
                                <option value="ki-outline ki-text-circle">ki-outline ki-text-circle</option>
                                <option value="ki-outline ki-text-italic">ki-outline ki-text-italic</option>
                                <option value="ki-outline ki-text-number">ki-outline ki-text-number</option>
                                <option value="ki-outline ki-text-strikethrough">ki-outline ki-text-strikethrough</option>
                                <option value="ki-outline ki-text-underline">ki-outline ki-text-underline</option>
                            </optgroup>

                            <optgroup label="Finance">
                                <option value="ki-outline ki-avalanche">ki-outline ki-avalanche</option>
                                <option value="ki-outline ki-bank">ki-outline ki-bank</option>
                                <option value="ki-outline ki-bill">ki-outline ki-bill</option>
                                <option value="ki-outline ki-binance">ki-outline ki-binance</option>
                                <option value="ki-outline ki-binance-usd">ki-outline ki-binance-usd</option>
                                <option value="ki-outline ki-bitcoin">ki-outline ki-bitcoin</option>
                                <option value="ki-outline ki-celsius">ki-outline ki-celsius</option>
                                <option value="ki-outline ki-credit-cart">ki-outline ki-credit-cart</option>
                                <option value="ki-outline ki-dash">ki-outline ki-dash</option>
                                <option value="ki-outline ki-dollar">ki-outline ki-dollar</option>
                                <option value="ki-outline ki-educare">ki-outline ki-educare</option>
                                <option value="ki-outline ki-enjin-coin">ki-outline ki-enjin-coin</option>
                                <option value="ki-outline ki-euro">ki-outline ki-euro</option>
                                <option value="ki-outline ki-finance-calculator">ki-outline ki-finance-calculator</option>
                                <option value="ki-outline ki-financial-schedule">ki-outline ki-financial-schedule</option>
                                <option value="ki-outline ki-lts">ki-outline ki-lts</option>
                                <option value="ki-outline ki-nexo">ki-outline ki-nexo</option>
                                <option value="ki-outline ki-ocean">ki-outline ki-ocean</option>
                                <option value="ki-outline ki-office-bag">ki-outline ki-office-bag</option>
                                <option value="ki-outline ki-paypal">ki-outline ki-paypal</option>
                                <option value="ki-outline ki-price-tag">ki-outline ki-price-tag</option>
                                <option value="ki-outline ki-save-deposit">ki-outline ki-save-deposit</option>
                                <option value="ki-outline ki-theta">ki-outline ki-theta</option>
                                <option value="ki-outline ki-trello">ki-outline ki-trello</option>
                                <option value="ki-outline ki-two-credit-cart">ki-outline ki-two-credit-cart</option>
                                <option value="ki-outline ki-vibe">ki-outline ki-vibe</option>
                                <option value="ki-outline ki-wallet">ki-outline ki-wallet</option>
                                <option value="ki-outline ki-wanchain">ki-outline ki-wanchain</option>
                                <option value="ki-outline ki-xmr">ki-outline ki-xmr</option>
                            </optgroup>

                            <optgroup label="Weather">
                                <option value="ki-outline ki-drop">ki-outline ki-drop</option>
                                <option value="ki-outline ki-moon">ki-outline ki-moon</option>
                                <option value="ki-outline ki-night-day">ki-outline ki-night-day</option>
                                <option value="ki-outline ki-sun">ki-outline ki-sun</option>
                            </optgroup>

                            <optgroup label="Arrows">
                                <option value="ki-outline ki-arrow-circle-left">ki-outline ki-arrow-circle-left</option>
                                <option value="ki-outline ki-arrow-circle-right">ki-outline ki-arrow-circle-right</option>
                                <option value="ki-outline ki-arrow-diagonal">ki-outline ki-arrow-diagonal</option>
                                <option value="ki-outline ki-arrow-down">ki-outline ki-arrow-down</option>
                                <option value="ki-outline ki-arrow-down-left">ki-outline ki-arrow-down-left</option>
                                <option value="ki-outline ki-arrow-down-refraction">ki-outline ki-arrow-down-refraction</option>
                                <option value="ki-outline ki-arrow-down-right">ki-outline ki-arrow-down-right</option>
                                <option value="ki-outline ki-arrow-left">ki-outline ki-arrow-left</option>
                                <option value="ki-outline ki-arrow-mix">ki-outline ki-arrow-mix</option>
                                <option value="ki-outline ki-arrow-right">ki-outline ki-arrow-right</option>
                                <option value="ki-outline ki-arrow-right-left">ki-outline ki-arrow-right-left</option>
                                <option value="ki-outline ki-arrows-circle">ki-outline ki-arrows-circle</option>
                                <option value="ki-outline ki-arrows-loop">ki-outline ki-arrows-loop</option>
                                <option value="ki-outline ki-arrow-two-diagonals">ki-outline ki-arrow-two-diagonals</option>
                                <option value="ki-outline ki-arrow-up">ki-outline ki-arrow-up</option>
                                <option value="ki-outline ki-arrow-up-down">ki-outline ki-arrow-up-down</option>
                                <option value="ki-outline ki-arrow-up-left">ki-outline ki-arrow-up-left</option>
                                <option value="ki-outline ki-arrow-up-refraction">ki-outline ki-arrow-up-refraction</option>
                                <option value="ki-outline ki-arrow-up-right">ki-outline ki-arrow-up-right</option>
                                <option value="ki-outline ki-arrow-zigzag">ki-outline ki-arrow-zigzag</option>
                                <option value="ki-outline ki-black-down">ki-outline ki-black-down</option>
                                <option value="ki-outline ki-black-left">ki-outline ki-black-left</option>
                                <option value="ki-outline ki-black-left-line">ki-outline ki-black-left-line</option>
                                <option value="ki-outline ki-black-right">ki-outline ki-black-right</option>
                                <option value="ki-outline ki-black-right-line">ki-outline ki-black-right-line</option>
                                <option value="ki-outline ki-black-up">ki-outline ki-black-up</option>
                                <option value="ki-outline ki-check">ki-outline ki-check</option>
                                <option value="ki-outline ki-check-circle">ki-outline ki-check-circle</option>
                                <option value="ki-outline ki-check-square">ki-outline ki-check-square</option>
                                <option value="ki-outline ki-cross">ki-outline ki-cross</option>
                                <option value="ki-outline ki-cross-circle">ki-outline ki-cross-circle</option>
                                <option value="ki-outline ki-cross-square">ki-outline ki-cross-square</option>
                                <option value="ki-outline ki-dots-circle">ki-outline ki-dots-circle</option>
                                <option value="ki-outline ki-dots-circle-vertical">ki-outline ki-dots-circle-vertical</option>
                                <option value="ki-outline ki-dots-horizontal">ki-outline ki-dots-horizontal</option>
                                <option value="ki-outline ki-dots-square">ki-outline ki-dots-square</option>
                                <option value="ki-outline ki-dots-square-vertical">ki-outline ki-dots-square-vertical</option>
                                <option value="ki-outline ki-dots-vertical">ki-outline ki-dots-vertical</option>
                                <option value="ki-outline ki-double-check">ki-outline ki-double-check</option>
                                <option value="ki-outline ki-double-check-circle">ki-outline ki-double-check-circle</option>
                                <option value="ki-outline ki-double-down">ki-outline ki-double-down</option>
                                <option value="ki-outline ki-double-left">ki-outline ki-double-left</option>
                                <option value="ki-outline ki-double-left-arrow">ki-outline ki-double-left-arrow</option>
                                <option value="ki-outline ki-double-right">ki-outline ki-double-right</option>
                                <option value="ki-outline ki-double-right-arrow">ki-outline ki-double-right-arrow</option>
                                <option value="ki-outline ki-double-up">ki-outline ki-double-up</option>
                                <option value="ki-outline ki-down">ki-outline ki-down</option>
                                <option value="ki-outline ki-down-square">ki-outline ki-down-square</option>
                                <option value="ki-outline ki-entrance-left">ki-outline ki-entrance-left</option>
                                <option value="ki-outline ki-entrance-right">ki-outline ki-entrance-right</option>
                                <option value="ki-outline ki-exit-down">ki-outline ki-exit-down</option>
                                <option value="ki-outline ki-exit-left">ki-outline ki-exit-left</option>
                                <option value="ki-outline ki-exit-right">ki-outline ki-exit-right</option>
                                <option value="ki-outline ki-exit-right-corner">ki-outline ki-exit-right-corner</option>
                                <option value="ki-outline ki-exit-up">ki-outline ki-exit-up</option>
                                <option value="ki-outline ki-left">ki-outline ki-left</option>
                                <option value="ki-outline ki-left-square">ki-outline ki-left-square</option>
                                <option value="ki-outline ki-minus">ki-outline ki-minus</option>
                                <option value="ki-outline ki-minus-circle">ki-outline ki-minus-circle</option>
                                <option value="ki-outline ki-minus-square">ki-outline ki-minus-square</option>
                                <option value="ki-outline ki-plus">ki-outline ki-plus</option>
                                <option value="ki-outline ki-plus-circle">ki-outline ki-plus-circle</option>
                                <option value="ki-outline ki-plus-square">ki-outline ki-plus-square</option>
                                <option value="ki-outline ki-right">ki-outline ki-right</option>
                                <option value="ki-outline ki-right-left">ki-outline ki-right-left</option>
                                <option value="ki-outline ki-right-square">ki-outline ki-right-square</option>
                                <option value="ki-outline ki-to-left">ki-outline ki-to-left</option>
                                <option value="ki-outline ki-to-right">ki-outline ki-to-right</option>
                                <option value="ki-outline ki-up">ki-outline ki-up</option>
                                <option value="ki-outline ki-up-down">ki-outline ki-up-down</option>
                                <option value="ki-outline ki-up-square">ki-outline ki-up-square</option>
                            </optgroup>

                            <optgroup label="Communication">
                                <option value="ki-outline ki-address-book">ki-outline ki-address-book</option>
                                <option value="ki-outline ki-directbox-default">ki-outline ki-directbox-default</option>
                                <option value="ki-outline ki-message-add">ki-outline ki-message-add</option>
                                <option value="ki-outline ki-message-edit">ki-outline ki-message-edit</option>
                                <option value="ki-outline ki-message-minus">ki-outline ki-message-minus</option>
                                <option value="ki-outline ki-message-notif">ki-outline ki-message-notif</option>
                                <option value="ki-outline ki-messages">ki-outline ki-messages</option>
                                <option value="ki-outline ki-message-text">ki-outline ki-message-text</option>
                                <option value="ki-outline ki-message-text-2">ki-outline ki-message-text-2</option>
                                <option value="ki-outline ki-sms">ki-outline ki-sms</option>
                            </optgroup>

                            <optgroup label="Notifications">
                                <option value="ki-outline ki-notification">ki-outline ki-notification</option>
                                <option value="ki-outline ki-notification-2">ki-outline ki-notification-2</option>
                                <option value="ki-outline ki-notification-bing">ki-outline ki-notification-bing</option>
                                <option value="ki-outline ki-notification-circle">ki-outline ki-notification-circle</option>
                                <option value="ki-outline ki-notification-favorite">ki-outline ki-notification-favorite</option>
                                <option value="ki-outline ki-notification-on">ki-outline ki-notification-on</option>
                                <option value="ki-outline ki-notification-status">ki-outline ki-notification-status</option>
                            </optgroup>

                            <optgroup label="Delivery and Logistics">
                                <option value="ki-outline ki-airplane">ki-outline ki-airplane</option>
                                <option value="ki-outline ki-airplane-square">ki-outline ki-airplane-square</option>
                                <option value="ki-outline ki-bus">ki-outline ki-bus</option>
                                <option value="ki-outline ki-car">ki-outline ki-car</option>
                                <option value="ki-outline ki-car-2">ki-outline ki-car-2</option>
                                <option value="ki-outline ki-car-3">ki-outline ki-car-3</option>
                                <option value="ki-outline ki-courier">ki-outline ki-courier</option>
                                <option value="ki-outline ki-courier-express">ki-outline ki-courier-express</option>
                                <option value="ki-outline ki-cube-2">ki-outline ki-cube-2</option>
                                <option value="ki-outline ki-cube-3">ki-outline ki-cube-3</option>
                                <option value="ki-outline ki-delivery">ki-outline ki-delivery</option>
                                <option value="ki-outline ki-delivery-2">ki-outline ki-delivery-2</option>
                                <option value="ki-outline ki-delivery-24">ki-outline ki-delivery-24</option>
                                <option value="ki-outline ki-delivery-3">ki-outline ki-delivery-3</option>
                                <option value="ki-outline ki-delivery-door">ki-outline ki-delivery-door</option>
                                <option value="ki-outline ki-delivery-geolocation">ki-outline ki-delivery-geolocation</option>
                                <option value="ki-outline ki-delivery-time">ki-outline ki-delivery-time</option>
                                <option value="ki-outline ki-logistic">ki-outline ki-logistic</option>
                                <option value="ki-outline ki-parcel">ki-outline ki-parcel</option>
                                <option value="ki-outline ki-parcel-tracking">ki-outline ki-parcel-tracking</option>
                                <option value="ki-outline ki-scooter">ki-outline ki-scooter</option>
                                <option value="ki-outline ki-scooter-2">ki-outline ki-scooter-2</option>
                                <option value="ki-outline ki-ship">ki-outline ki-ship</option>
                                <option value="ki-outline ki-trailer">ki-outline ki-trailer</option>
                                <option value="ki-outline ki-truck">ki-outline ki-truck</option>
                            </optgroup>

                            <optgroup label="Devices">
                                <option value="ki-outline ki-airpod">ki-outline ki-airpod</option>
                                <option value="ki-outline ki-bluetooth">ki-outline ki-bluetooth</option>
                                <option value="ki-outline ki-calculator">ki-outline ki-calculator</option>
                                <option value="ki-outline ki-devices">ki-outline ki-devices</option>
                                <option value="ki-outline ki-devices-2">ki-outline ki-devices-2</option>
                                <option value="ki-outline ki-electronic-clock">ki-outline ki-electronic-clock</option>
                                <option value="ki-outline ki-external-drive">ki-outline ki-external-drive</option>
                                <option value="ki-outline ki-keyboard">ki-outline ki-keyboard</option>
                                <option value="ki-outline ki-laptop">ki-outline ki-laptop</option>
                                <option value="ki-outline ki-monitor-mobile">ki-outline ki-monitor-mobile</option>
                                <option value="ki-outline ki-mouse">ki-outline ki-mouse</option>
                                <option value="ki-outline ki-phone">ki-outline ki-phone</option>
                                <option value="ki-outline ki-printer">ki-outline ki-printer</option>
                                <option value="ki-outline ki-router">ki-outline ki-router</option>
                                <option value="ki-outline ki-screen">ki-outline ki-screen</option>
                                <option value="ki-outline ki-simcard">ki-outline ki-simcard</option>
                                <option value="ki-outline ki-simcard-2">ki-outline ki-simcard-2</option>
                                <option value="ki-outline ki-speaker">ki-outline ki-speaker</option>
                                <option value="ki-outline ki-tablet">ki-outline ki-tablet</option>
                                <option value="ki-outline ki-wifi">ki-outline ki-wifi</option>
                            </optgroup>

                            <optgroup label="Grid">
                                <option value="ki-outline ki-element-1">ki-outline ki-element-1</option>
                                <option value="ki-outline ki-element-10">ki-outline ki-element-10</option>
                                <option value="ki-outline ki-element-11">ki-outline ki-element-11</option>
                                <option value="ki-outline ki-element-12">ki-outline ki-element-12</option>
                                <option value="ki-outline ki-element-2">ki-outline ki-element-2</option>
                                <option value="ki-outline ki-element-3">ki-outline ki-element-3</option>
                                <option value="ki-outline ki-element-4">ki-outline ki-element-4</option>
                                <option value="ki-outline ki-element-5">ki-outline ki-element-5</option>
                                <option value="ki-outline ki-element-6">ki-outline ki-element-6</option>
                                <option value="ki-outline ki-element-7">ki-outline ki-element-7</option>
                                <option value="ki-outline ki-element-8">ki-outline ki-element-8</option>
                                <option value="ki-outline ki-element-9">ki-outline ki-element-9</option>
                                <option value="ki-outline ki-element-equal">ki-outline ki-element-equal</option>
                                <option value="ki-outline ki-element-plus">ki-outline ki-element-plus</option>
                                <option value="ki-outline ki-fat-rows">ki-outline ki-fat-rows</option>
                                <option value="ki-outline ki-grid">ki-outline ki-grid</option>
                                <option value="ki-outline ki-grid-2">ki-outline ki-grid-2</option>
                                <option value="ki-outline ki-grid-frame">ki-outline ki-grid-frame</option>
                                <option value="ki-outline ki-kanban">ki-outline ki-kanban</option>
                                <option value="ki-outline ki-maximize">ki-outline ki-maximize</option>
                                <option value="ki-outline ki-row-horizontal">ki-outline ki-row-horizontal</option>
                                <option value="ki-outline ki-row-vertical">ki-outline ki-row-vertical</option>
                                <option value="ki-outline ki-slider-horizontal">ki-outline ki-slider-horizontal</option>
                                <option value="ki-outline ki-slider-horizontal-2">ki-outline ki-slider-horizontal-2</option>
                                <option value="ki-outline ki-slider-vertical">ki-outline ki-slider-vertical</option>
                                <option value="ki-outline ki-slider-vertical-2">ki-outline ki-slider-vertical-2</option>
                            </optgroup>
                        </select>
                    </div>

                </div>

                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="parent_id">
                            <span class="required">Order Sequence</span>
                        </label>

                        <input type="number" class="form-control" id="order_sequence" name="order_sequence" min="0" <?php echo $disabled; ?>>
                    </div>
                </div>
            </div>

            <div class="row row-cols-1 row-cols-sm-2 rol-cols-md-1 row-cols-lg-2">
                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="app_module_id">
                            Import Table
                        </label>

                        <select id="table_name" name="table_name" class="form-select" data-control="select2" data-allow-clear="false" <?php echo $disabled; ?>></select>
                    </div>

                </div>

                <div class="col">
                    <div class="fv-row mb-7">
                        <label class="fs-6 fw-semibold form-label mt-3" for="parent_id">
                            URL
                        </label>

                        <input type="text" class="form-control" id="menu_item_url" name="menu_item_url" maxlength="50" autocomplete="off" <?php echo $disabled; ?>>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <?php
        echo ($writeAccess['total'] > 0) ? ' <div class="card-footer d-flex justify-content-end py-6 px-9">
                                                <button type="button" id="discard-create" class="btn btn-light btn-active-light-primary me-2">Discard</button>
                                                <button type="submit" form="menu_item_form" class="btn btn-primary" id="submit-data">Save</button>
                                            </div>' : '';
    ?>
</div>

<div class="card">
    <div class="card-header border-0 pt-6">
        <div class="card-title">
            <?php require('./components/view/_datatable_search.php') ?>
        </div>
        <div class="card-toolbar">
            <div class="d-flex justify-content-end" data-kt-customer-table-toolbar="base">
                <?php
                    echo $addMenuItemRoleAccess['total'] > 0 ? '<button type="button" class="btn btn-light-primary me-3" data-bs-toggle="modal" data-bs-target="#role-permission-assignment-modal" id="assign-role-permission"><i class="ki-outline ki-plus fs-2"></i> Assign</button>' : '';
                ?> 
            </div>
        </div>
    </div>
    <div class="card-body pt-9">
        <table class="table align-middle cursor-pointer table-row-dashed fs-6 gy-5 gs-7" id="role-permission-table">
            <thead>
                <tr class="fw-semibold fs-6 text-gray-800">
                    <th>Role</th>
                    <th>Read Access</th>
                    <th>Create Access</th>
                    <th>Write Access</th>
                    <th>Delete Access</th>
                    <th>Import Access</th>
                    <th>Export Access</th>
                    <th>Log Notes Access</th>
                    <th></th>
                </tr>
            </thead>
            <tbody class="fw-semibold text-gray-600"></tbody>
        </table>
    </div>
</div>

<div id="role-permission-assignment-modal" class="modal fade" tabindex="-1" aria-labelledby="role-permission-assignment-modal" aria-hidden="true">
    <div class="modal-dialog modal-dialog-scrollable modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Assign Role</h3>
                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
                    <i class="ki-duotone ki-cross fs-1"><span class="path1"></span><span class="path2"></span></i>
                </div>
            </div>

            <div class="modal-body">
                <form id="role-permission-assignment-form" method="post" action="#">
                    <div class="row">
                        <div class="col-12">
                            <select multiple="multiple" size="20" id="role_id" name="role_id[]"></select>
                        </div>
                    </div>
                </form>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                <button type="submit" form="role-permission-assignment-form" class="btn btn-primary" id="submit-assignment">Assign</button>
            </div>
        </div>
    </div>
</div>

<?php require_once('components/view/_log_notes_modal.php'); ?>