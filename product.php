<?php
$view = [
    'folder'  => 'product',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Product',
    ],
];

require './app/Views/Partials/layout.php';