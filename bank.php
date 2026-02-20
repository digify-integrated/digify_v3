<?php
$view = [
    'folder'  => 'bank',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Bank',
    ],
];

require './app/Views/Partials/layout.php';
