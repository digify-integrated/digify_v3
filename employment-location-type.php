<?php
$view = [
    'folder'  => 'employment-location-type',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Employment Location Type',
    ],
];

require './app/Views/Partials/layout.php';