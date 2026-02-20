<?php
$view = [
    'folder'  => 'department',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Department',
    ],
];

require './app/Views/Partials/layout.php';