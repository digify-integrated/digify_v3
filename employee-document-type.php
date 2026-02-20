<?php
$view = [
    'folder'  => 'employee-document-type',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Employee Document Type',
    ],
];

require './app/Views/Partials/layout.php';