<?php
$view = [
    'folder'  => 'supplier',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Supplier',
    ],
];

require './app/Views/Partials/layout.php';