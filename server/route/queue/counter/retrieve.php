<?php defined('ALT_PATH') OR exit('No direct script access allowed');

System_Auth::set_permission(0);

Alt_Validation::instance()
    ->rule(Alt_Validation::required($_REQUEST["counterid"]), "Counterid tidak boleh kosong!")
    ->check();

$dbo = new Queue_Counter();
$data = $dbo->retrieve($_REQUEST);

$userdata = System_Auth::get_user_data();
if(!System_Auth::check(1) && $data['clientid'] != $userdata['clientid'])
    throw new Alt_Exception('Anda tidak berhak mengakses data', Alt::STATUS_FORBIDDEN);

return $data;