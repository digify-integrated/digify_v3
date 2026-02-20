<?php
$view = [
    'folder'  => 'city',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'City',
    ],
];

require './app/Views/Partials/layout.php';