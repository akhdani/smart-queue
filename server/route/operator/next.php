<?php defined('ALT_PATH') OR exit('No direct script access allowed');

$_REQUEST['numberid'] = $_REQUEST['numberid'] ? $_REQUEST['numberid'] : 0;

Alt_Validation::instance()
    ->rule(Alt_Validation::required($_REQUEST["clientid"]), "Clientid tidak boleh kosong!")
    ->rule(Alt_Validation::required($_REQUEST["queueid"]), "Queueid tidak boleh kosong!")
    ->rule(Alt_Validation::required($_REQUEST["counterid"]), "Counterid tidak boleh kosong!")
    ->rule(Alt_Validation::required($_REQUEST["numberid"]), "Numberid tidak boleh kosong!")
    ->check();

$dbo = new Queue();

try{
    // if previous number exist, finish it
    if($_REQUEST['numberid'] > 0)
        $dbo->finish($_REQUEST);
}catch(Exception $e){

}

return $dbo->next($_REQUEST);