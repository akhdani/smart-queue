<?php defined('ALT_PATH') OR exit('No direct script access allowed');

Alt_Validation::instance()
    ->rule(Alt_Validation::required($_REQUEST["queueid"]), "Queueid tidak boleh kosong!")
    ->rule(Alt_Validation::required($_REQUEST["clientid"]), "Queueid tidak boleh kosong!")
    ->rule(Alt_Validation::required($_REQUEST["date"]), "Tanggal tidak boleh kosong!")
    ->rule(Alt_Validation::required($_REQUEST["name"]), "Nama tidak boleh kosong!")
    ->rule(Alt_Validation::required($_REQUEST["starttime"]), "Jam awal tidak boleh kosong!")
    ->rule(Alt_Validation::required($_REQUEST["endtime"]), "Jam akhir tidak boleh kosong!")
    ->rule(Alt_Validation::required($_REQUEST["avgtime"]), "Rata-rata waktu tidak boleh kosong!")
    ->check();

$dbo = new Queue_Number();

$data = $dbo->retrieve($_REQUEST);
if($data['clientid'] != $_REQUEST['clientid'])
    throw new Alt_Exception('Anda tidak berhak mengupdate data ini!', Alt::STATUS_FORBIDDEN);

return $dbo->update($_REQUEST);