<?php defined('ALT_PATH') OR exit('No direct script access allowed');

Alt_Validation::instance()
    ->rule(Alt_Validation::required("queueid"), "Queueid tidak boleh kosong!")
    ->check();

$dbo = new Queue();

return $dbo->delete($_REQUEST);