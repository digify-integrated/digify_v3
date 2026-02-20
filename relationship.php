<?php
$view = [
    'folder'  => 'relationship',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Relationship',
    ],
];

require './app/Views/Partials/layout.php';