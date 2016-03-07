<?php defined('ALT_PATH') OR exit('No direct script access allowed');

System_Auth::set_permission(3);

Alt_Validation::instance()
    ->rule(Alt_Validation::required($_REQUEST["queueid"]), "Queueid tidak boleh kosong!")
    ->rule(Alt_Validation::required($_REQUEST["date"]), "Tanggal tidak boleh kosong!")
    ->rule(Alt_Validation::required($_REQUEST["name"]), "Nama tidak boleh kosong!")
    ->rule(Alt_Validation::required($_REQUEST["starttime"]), "Jam awal tidak boleh kosong!")
    ->rule(Alt_Validation::required($_REQUEST["endtime"]), "Jam akhir tidak boleh kosong!")
    ->rule(Alt_Validation::required($_REQUEST["avgtime"]), "Rata-rata waktu tidak boleh kosong!")
    ->check();

$dbo = new Queue_Number();

$userdata = System_Auth::get_user_data();
if(System_Auth::check(2) && $data['clientid'] != $userdata['clientid'])
    throw new Alt_Exception('Anda tidak berhak mengakses data', Alt::STATUS_FORBIDDEN);

$_REQUEST['clientid'] = $userdata['clientid'] ? $userdata['clientid'] : $_REQUEST['clientid'];

return $dbo->update($_REQUEST);