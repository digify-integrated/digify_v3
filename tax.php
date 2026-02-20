<?php
$view = [
    'folder'  => 'tax',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Tax',
    ],
];

require './app/Views/Partials/layout.php';