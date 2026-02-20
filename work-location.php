<?php
$view = [
    'folder'  => 'work-location',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Work Location',
    ],
];

require './app/Views/Partials/layout.php';