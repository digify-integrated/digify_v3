<?php
$view = [
    'folder'  => 'point-of-sale',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Point of Sale',
    ],
];

require './app/Views/Partials/layout.php';