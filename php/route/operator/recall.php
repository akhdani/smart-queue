<?php defined('ALT_PATH') OR exit('No direct script access allowed');

Alt_Validation::instance()
    ->rule(Alt_Validation::required($_REQUEST["counterid"]), "Counterid tidak boleh kosong!")
    ->check();

$dbo = new Queue();

return $dbo->retrieve($_REQUEST);