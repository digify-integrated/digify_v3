<?php
$view = [
    'folder'  => 'role',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Role',
    ],
];

require './app/Views/Partials/layout.php';