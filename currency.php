<?php
$view = [
    'folder'  => 'currency',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Currency',
    ],
];

require './app/Views/Partials/layout.php';