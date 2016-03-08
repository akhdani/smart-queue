<?php defined('ALT_PATH') OR exit('No direct script access allowed');

System_Auth::set_permission(0);

Alt_Validation::instance()
    ->rule(Alt_Validation::required($_REQUEST["queueid"]), "Queueid tidak boleh kosong!")
    ->rule(Alt_Validation::required($_REQUEST["name"]), "Nama tidak boleh kosong!")
    ->check();

$dbo = new Queue_Number();

$userdata = System_Auth::get_user_data();
$_REQUEST['clientid'] = System_Auth::check(1) ? $_REQUEST['clientid'] : $userdata['clientid'];

return $dbo->insert($_REQUEST);