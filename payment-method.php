<?php
$view = [
    'folder'  => 'payment-method',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Payment Method',
    ],
];

require './app/Views/Partials/layout.php';