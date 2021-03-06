<?php defined('ALT_PATH') OR exit('No direct script access allowed');

Alt_Validation::instance()
    ->rule(Alt_Validation::required($_REQUEST["clientid"]), "Clientid tidak boleh kosong!")
    ->rule(Alt_Validation::required($_REQUEST["queueid"]), "Queueid tidak boleh kosong!")
    ->rule(Alt_Validation::required($_REQUEST["counterid"]), "Counterid tidak boleh kosong!")
    ->rule(Alt_Validation::required($_REQUEST["number"]), "Nomor antrian tidak boleh kosong!")
    ->check();

$dbo = new Queue();

// if previous number exist, finish it
$dbo->finish($_REQUEST);

return $dbo->call($_REQUEST);