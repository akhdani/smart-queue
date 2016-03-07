<?php defined('ALT_PATH') OR exit('No direct script access allowed');

System_Auth::set_permission(1);

$dbo = new Master_Client();

return array(
    'total' => $dbo->count($_REQUEST),
    'list' => $dbo->get($_REQUEST),
);