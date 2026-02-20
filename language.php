<?php
$view = [
    'folder'  => 'language',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Language',
    ],
];

require './app/Views/Partials/layout.php';