<?php
$view = [
    'folder'  => 'religion',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Religion',
    ],
];

require './app/Views/Partials/layout.php';