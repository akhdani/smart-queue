<?php defined('ALT_PATH') OR exit('No direct script access allowed');

$userdata = System_Auth::get_user_data();
$_REQUEST['clientid'] = $userdata['clientid'];
$_REQUEST['counterid'] = $userdata['counterid'];
$_REQUEST['date'] = date('Ymd');