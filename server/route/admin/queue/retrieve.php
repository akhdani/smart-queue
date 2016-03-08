<?php defined('ALT_PATH') OR exit('No direct script access allowed');

Alt_Validation::instance()
    ->rule(Alt_Validation::required($_REQUEST["queueid"]), "Queueid tidak boleh kosong!")
    ->rule(Alt_Validation::required($_REQUEST["clientid"]), "Clientid tidak boleh kosong!")
    ->check();

$dbo = new Queue_Number();

$data = $dbo->retrieve();
if($data['clientid'] != $_REQUEST['clientid'])
    throw new Alt_Exception('Anda tidak berhak mengakses data ini!', Alt::STATUS_FORBIDDEN);

return $data;