<?php
$view = [
    'folder'  => 'notification-setting',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [
        './vendor/tinymce/tinymce.min.js',
    ],
    'data' => [
        'pageTitle' => 'Notification Setting',
    ],
];

require './app/Views/Partials/layout.php';