<?php
$view = [
    'folder'  => 'warehouse',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Warehouse',
    ],
];

require './app/Views/Partials/layout.php';