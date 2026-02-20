<?php
$view = [
    'folder'  => 'physical-inventory',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Physical Inventory',
    ],
];

require './app/Views/Partials/layout.php';