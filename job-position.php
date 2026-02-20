<?php
$view = [
    'folder'  => 'job-position',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Job Position',
    ],
];

require './app/Views/Partials/layout.php';