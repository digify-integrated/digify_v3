<?php
$view = [
    'folder'  => 'employee',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Employee',
    ],
];

require './app/Views/Partials/layout.php';