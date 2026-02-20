<?php
$view = [
    'folder'  => 'app-module',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'App Module',
    ],
];

require './app/Views/Partials/layout.php';