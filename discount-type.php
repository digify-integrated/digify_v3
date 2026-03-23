<?php
$view = [
    'folder'  => 'discount-type',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Discount Type',
    ],
];

require './app/Views/Partials/layout.php';