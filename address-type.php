<?php
$view = [
    'folder'  => 'address-type',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Address Type',
    ],
];

require './app/Views/Partials/layout.php';