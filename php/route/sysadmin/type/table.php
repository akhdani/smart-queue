<?php defined('ALT_PATH') OR exit('No direct script access allowed');

System_Auth::set_permission(0);

$dbo = new Master_Type();

return array(
    'total' => $dbo->count($_REQUEST),
    'list' => $dbo->get($_REQUEST),
);