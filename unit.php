<?php
$view = [
    'folder'  => 'unit',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Unit',
    ],
];

require './app/Views/Partials/layout.php';