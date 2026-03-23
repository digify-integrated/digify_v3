<?php
$view = [
    'folder'  => 'charge-type',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Charge Type',
    ],
];

require './app/Views/Partials/layout.php';