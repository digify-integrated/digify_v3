<?php
$view = [
    'folder'  => 'floor-plan',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Floor Plan',
    ],
];

require './app/Views/Partials/layout.php';