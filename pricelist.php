<?php
$view = [
    'folder'  => 'pricelist',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Pricelist',
    ],
];

require './app/Views/Partials/layout.php';