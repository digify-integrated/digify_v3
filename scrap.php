<?php
$view = [
    'folder'  => 'scrap',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Scrap',
    ],
];

require './app/Views/Partials/layout.php';