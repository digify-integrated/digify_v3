<?php
$view = [
    'folder'  => 'warehouse-type',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Warehouse Type',
    ],
];

require './app/Views/Partials/layout.php';