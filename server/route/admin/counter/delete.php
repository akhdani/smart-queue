<?php defined('ALT_PATH') OR exit('No direct script access allowed');

Alt_Validation::instance()
    ->rule(Alt_Validation::required("counterid"), "Counterid tidak boleh kosong!")
    ->check();

$dbo = new Queue_Counter();
$data = $dbo->retrieve($_REQUEST);

$userdata = System_Auth::get_user_data();
if(!System_Auth::check(1) && $data['clientid'] != $userdata['clientid'])
    throw new Alt_Exception('Anda tidak berhak menghapus data', Alt::STATUS_FORBIDDEN);

return $dbo->delete($_REQUEST);