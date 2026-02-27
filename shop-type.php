<?php
$view = [
    'folder'  => 'shop-type',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Shop Type',
    ],
];

require './app/Views/Partials/layout.php';