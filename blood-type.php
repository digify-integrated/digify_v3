<?php
$view = [
    'folder'  => 'blood-type',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Blood Type',
    ],
];

require './app/Views/Partials/layout.php';