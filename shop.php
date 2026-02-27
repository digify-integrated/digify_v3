<?php
$view = [
    'folder'  => 'shop',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Shop',
    ],
];

require './app/Views/Partials/layout.php';