<?php defined('ALT_PATH') OR exit('No direct script access allowed');

Alt_Validation::instance()
    ->rule(Alt_Validation::required($_REQUEST["clientid"]), "Clientid tidak boleh kosong!")
    ->rule(Alt_Validation::required($_REQUEST["queueid"]), "Queueid tidak boleh kosong!")
    ->rule(Alt_Validation::required($_REQUEST["counterid"]), "Counterid tidak boleh kosong!")
    ->rule(Alt_Validation::required($_REQUEST["numberid"]), "Numberid tidak boleh kosong!")
    ->check();

$dbo = new Queue();
$dbo->skip($_REQUEST);

return $dbo->next($_REQUEST);