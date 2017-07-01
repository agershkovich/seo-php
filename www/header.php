<?php

//Read text from csv
$handle = fopen("url_title_description.csv", "r");
$data = fgetcsv($handle, 1000, ",");
$num = count($data);

//Setting up title and description
$pageTitle=$data[1];
$pageDescription=$data[2];

fclose($handle);
