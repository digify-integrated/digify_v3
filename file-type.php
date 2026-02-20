<?php
$view = [
    'folder'  => 'file-type',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'File Type',
    ],
];

require './app/Views/Partials/layout.php';