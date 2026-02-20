<?php
$view = [
    'folder'  => 'nationality',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Nationality',
    ],
];

require './app/Views/Partials/layout.php';