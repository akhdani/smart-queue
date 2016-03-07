<?php defined('ALT_PATH') OR exit('No direct script access allowed');

System_Auth::set_permission(0);

$dbo = new Queue();

$userdata = System_Auth::get_user_data();
if(System_Auth::check(6))
    $_REQUEST['clientid']  = '= ' . $dbo->quote($userdata['clientid']);

return array(
    'total' => $dbo->count($_REQUEST),
    'list' => $dbo->get($_REQUEST),
);