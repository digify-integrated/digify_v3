<?php
$view = [
    'folder'  => 'employment-type',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Employment Type',
    ],
];

require './app/Views/Partials/layout.php';