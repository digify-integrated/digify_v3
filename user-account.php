<?php
$view = [
    'folder'  => 'user-account',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'User Account',
    ],
];

require './app/Views/Partials/layout.php';