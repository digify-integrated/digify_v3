<?php
$view = [
    'folder'  => 'menu-item',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Menu Item',
    ],
];

require './app/Views/Partials/layout.php';