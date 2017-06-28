<?php
$url="https://www.youtube.com/";
function curl_get_contents($url) {

$timeout = 5;
//    $useragent = 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:27.0) Gecko/20100101 Firefox/27.0';

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_USERAGENT, $useragent);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, $timeout);
    $data = curl_exec($ch);
    curl_close($ch);

    return $data;
}

// ------------------------------------------------------

function fetch_meta_tags($url) {

    $html = curl_get_contents($url);
    $mdata = array();

    $doc = new DOMDocument();
    $doc->loadHTML($html);

    $titlenode = $doc->getElementsByTagName('title');
    $title = $titlenode->item(0)->nodeValue;

    $metanodes = $doc->getElementsByTagName('meta');
    foreach($metanodes as $node) {
        $key = $node->getAttribute('name');
        $val = $node->getAttribute('content');
        if (!empty($key)) { $mdata[$key] = $val; }
    }

    $res = array($url, $title, $mdata);

    return $res;
}