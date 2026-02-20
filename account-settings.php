<?php
$view = [
    'folder'  => 'account-settings',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Account Setting',
    ],
];

require './app/Views/Partials/layout.php';