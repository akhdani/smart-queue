<?php defined('ALT_PATH') OR exit('No direct script access allowed');

Alt_Validation::instance()
    ->rule(Alt_Validation::required($_REQUEST["clientid"]), "Clientid tidak boleh kosong!")
    ->rule(Alt_Validation::required($_REQUEST["date"]), "Tanggal tidak boleh kosong!")
    ->rule(Alt_Validation::required($_REQUEST["name"]), "Nama tidak boleh kosong!")
    ->rule(Alt_Validation::required($_REQUEST["starttime"]), "Jam awal tidak boleh kosong!")
    ->rule(Alt_Validation::required($_REQUEST["endtime"]), "Jam akhir tidak boleh kosong!")
    ->rule(Alt_Validation::required($_REQUEST["avgtime"]), "Rata-rata waktu tidak boleh kosong!")
    ->check();

$dbo = new Queue();

return $dbo->insert($_REQUEST);