<?php
$view = [
    'folder'  => 'system-action',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'System Action',
    ],
];

require './app/Views/Partials/layout.php';