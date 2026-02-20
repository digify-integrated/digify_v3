<?php
$view = [
    'folder'  => 'country',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Country',
    ],
];

require './app/Views/Partials/layout.php';