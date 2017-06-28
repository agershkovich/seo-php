<?php

$url="https://www.youtube.com/";
function extract_tags_from_url($url) {
    $tags = array();

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_HEADER, 0);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);

    $contents = curl_exec($ch);
    curl_close($ch);

    if (empty($contents)) {
        return $tags;
    }

    if (preg_match_all('/<meta([^>]+)content="([^>]+)>/', $contents, $matches)) {
        $doc = new DOMDocument();
        $doc->loadHTML('<?xml encoding="utf-8" ?>' . implode($matches[0]));
        $tags = array();
        foreach($doc->getElementsByTagName('meta') as $metaTag) {
            if($metaTag->getAttribute('name') != "") {
                $tags[$metaTag->getAttribute('name')] = $metaTag->getAttribute('content');
            }
            elseif ($metaTag->getAttribute('property') != "") {
                $tags[$metaTag->getAttribute('property')] = $metaTag->getAttribute('content');
            }
        }
    }

    return $tags;
}