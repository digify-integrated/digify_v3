<?php
$view = [
    'folder'  => 'product-variant',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Product Variant',
    ],
];

require './app/Views/Partials/layout.php';