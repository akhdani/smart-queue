<?php defined('ALT_PATH') OR exit('No direct script access allowed');

System_Auth::set_permission(3);

Alt_Validation::instance()
    ->rule(Alt_Validation::required($_REQUEST["queueid"]), "Queueid tidak boleh kosong!")
    ->rule(Alt_Validation::required($_REQUEST["name"]), "Nama tidak boleh kosong!")
    ->check();

$dbo = new Queue_Counter();

return $dbo->insert($_REQUEST);