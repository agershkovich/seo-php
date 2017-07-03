<?php



 function expectedValueOf($value) {

    $handle = fopen(dirname(__DIR__) . "/resources/url_title_description.csv", "r");
    $data = fgetcsv($handle, 1000, ",");

    switch ($value) {
        case "url":

            $result = $data[0];
            break;

        case "title":

            $result = $data[1];
            break;

        case "description":

            $result = $data[2];
            break;
    }
    return $result;
}


function actualValueOf($url, $value)
{
    $tags = get_meta_tags($url);

    switch ($value) {

        case "url":

            $result = $tags['url'];
            break;

        case "title":

            $result = $tags['title'];
            break;


        case "description":

            $result = $tags['description'];
            break;

    }
    return $result;
}

