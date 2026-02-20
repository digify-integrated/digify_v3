<?php
$view = [
    'folder'  => 'attribute',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Attributes',
    ],
];

require './app/Views/Partials/layout.php';