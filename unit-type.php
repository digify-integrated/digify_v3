<?php
$view = [
    'folder'  => 'unit-type',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Unit Type',
    ],
];

require './app/Views/Partials/layout.php';