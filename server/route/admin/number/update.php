<?php defined('ALT_PATH') OR exit('No direct script access allowed');

Alt_Validation::instance()
    ->rule(Alt_Validation::required($_REQUEST["numberid"]), "Numberid tidak boleh kosong!")
    ->rule(Alt_Validation::required($_REQUEST["name"]), "Nama tidak boleh kosong!")
    ->check();

$dbo = new Queue_Number();
$data = $dbo->retrieve($_REQUEST);

$userdata = System_Auth::get_user_data();
if(!System_Auth::check(1) && $data['clientid'] != $userdata['clientid'])
    throw new Alt_Exception('Anda tidak berhak mengakses data', Alt::STATUS_FORBIDDEN);

$_REQUEST['clientid'] = $userdata['clientid'] ? $userdata['clientid'] : $_REQUEST['clientid'];

return $dbo->update($_REQUEST);