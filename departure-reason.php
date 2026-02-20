<?php
$view = [
    'folder'  => 'departure-reason',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Departure Reason',
    ],
];

require './app/Views/Partials/layout.php';