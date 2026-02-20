<?php
$view = [
    'folder'  => 'contact-information-type',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Contact Information Type',
    ],
];

require './app/Views/Partials/layout.php';