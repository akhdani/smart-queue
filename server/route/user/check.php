<?php defined('ALT_PATH') OR exit('No direct script access allowed');

Alt_Validation::instance()
    ->rule(Alt_Validation::required($_REQUEST["numberid"]), "Numberid tidak boleh kosong!")
    ->check();

$dbo = new Queue();

return $dbo->check($_REQUEST);