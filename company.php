<?php
$view = [
    'folder'  => 'company',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Company',
    ],
];

require './app/Views/Partials/layout.php';