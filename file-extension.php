<?php
$view = [
    'folder'  => 'file-extension',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'File Extension',
    ],
];

require './app/Views/Partials/layout.php';