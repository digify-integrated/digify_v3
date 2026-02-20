<?php
$view = [
    'folder'  => 'credential-type',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Credential Type',
    ],
];

require './app/Views/Partials/layout.php';