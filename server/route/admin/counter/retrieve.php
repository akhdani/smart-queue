<?php defined('ALT_PATH') OR exit('No direct script access allowed');

Alt_Validation::instance()
    ->rule(Alt_Validation::required($_REQUEST["clientid"]), "Clientid tidak boleh kosong!")
    ->rule(Alt_Validation::required($_REQUEST["counterid"]), "Counterid tidak boleh kosong!")
    ->check();

$dbo = new Queue_Counter();

$data = $dbo->retrieve($_REQUEST);
if($data['clientid'] != $_REQUEST['clientid'])
    throw new Alt_Exception('Anda tidak berhak mengakses data!', Alt::STATUS_FORBIDDEN);

return $data;