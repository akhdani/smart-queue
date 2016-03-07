<?php defined('ALT_PATH') OR exit('No direct script access allowed');

System_Auth::set_permission(1);

Alt_Validation::instance()
    ->rule(Alt_Validation::required($_REQUEST["clientid"]), "Clientid tidak boleh kosong!")
    ->check();

$dbo = new Queue_Number();

return $dbo->retrieve($_REQUEST);