<?php
$view = [
    'folder'  => 'product-category',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Product Category',
    ],
];

require './app/Views/Partials/layout.php';