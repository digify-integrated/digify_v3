<?php
$view = [
    'folder'  => 'scrap-reason',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Scrap Reason',
    ],
];

require './app/Views/Partials/layout.php';