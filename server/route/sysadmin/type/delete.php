<?php defined('ALT_PATH') OR exit('No direct script access allowed');

System_Auth::set_permission(1);

Alt_Validation::instance()
    ->rule(Alt_Validation::required("typeid"), "Typeid tidak boleh kosong!")
    ->check();

$dbo = new Master_Type();

return $dbo->delete($_REQUEST);