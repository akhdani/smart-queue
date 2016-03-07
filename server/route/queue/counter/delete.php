<?php defined('ALT_PATH') OR exit('No direct script access allowed');

Alt_Validation::instance()
    ->rule(Alt_Validation::required("counterid"), "Counterid tidak boleh kosong!")
    ->check();

$dbo = new Queue_Counter();

return $dbo->delete($_REQUEST);