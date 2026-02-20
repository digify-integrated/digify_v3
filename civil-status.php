<?php
$view = [
    'folder'  => 'civil-status',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Civil Status',
    ],
];

require './app/Views/Partials/layout.php';