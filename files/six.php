<?php
$url="goeuro.com";
$http_check='http://';
$https_check='https://';
if(substr($url,0,7)!=$http_check){
    $url=$http_check.$url;
}else if(substr($url,0,8)!=$https_check){
    $url=$https_check.$url;
}else{
    $url=$url;
}

$tags = get_meta_tags($url);
//echo "<pre>";
print_r($tags);