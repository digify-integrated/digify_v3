<?php
$view = [
    'folder'  => 'language-proficiency',
    'bodyData' => [
        'app-id' => $appId ?? '',
        'table'  => $databaseTable ?? '',
    ],
    'styles'  => [],
    'scripts' => [],
    'data' => [
        'pageTitle' => 'Language Proficiency',
    ],
];

require './app/Views/Partials/layout.php';