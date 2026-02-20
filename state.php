<?php
$view = [
    'folder'  => 'state',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'State',
    ],
];

require './app/Views/Partials/layout.php';