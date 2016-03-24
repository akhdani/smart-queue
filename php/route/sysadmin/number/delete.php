<?php defined('ALT_PATH') OR exit('No direct script access allowed');

Alt_Validation::instance()
    ->rule(Alt_Validation::required("numberid"), "Numberid tidak boleh kosong!")
    ->check();

$dbo = new Queue_Number();

return $dbo->delete($_REQUEST);