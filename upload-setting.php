<?php
$view = [
    'folder'  => 'upload-setting',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Upload Setting',
    ],
];

require './app/Views/Partials/layout.php';