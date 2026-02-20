<?php
$view = [
    'folder'  => 'educatonal-stage',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Educational Stage',
    ],
];

require './app/Views/Partials/layout.php';