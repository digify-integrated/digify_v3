<?php
$view = [
    'folder'  => 'bank-account-type',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Bank Account Type',
    ],
];

require './app/Views/Partials/layout.php';