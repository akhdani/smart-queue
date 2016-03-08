<?php defined('ALT_PATH') OR exit('No direct script access allowed');

$_REQUEST['userid'] = $_REQUEST['ipaddress'] ? $_REQUEST['ipaddress'] : $_SERVER['REMOTE_ADDR'];
$_REQUEST['ipaddress'] = $_REQUEST['ipaddress'] ? $_REQUEST['ipaddress'] : $_SERVER['REMOTE_ADDR'];
$_REQUEST['useragent'] = $_REQUEST['useragent'] ? $_REQUEST['useragent'] : $_SERVER['HTTP_USER_AGENT'];
$_REQUEST['date'] = date('Ymd');