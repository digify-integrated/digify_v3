<?php
$view = [
    'folder'  => 'gender',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Gender',
    ],
];

require './app/Views/Partials/layout.php';