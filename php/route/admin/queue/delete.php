<?php defined('ALT_PATH') OR exit('No direct script access allowed');

Alt_Validation::instance()
    ->rule(Alt_Validation::required("queueid"), "Queueid tidak boleh kosong!")
    ->rule(Alt_Validation::required("clientid"), "Clientid tidak boleh kosong!")
    ->check();

$dbo = new Queue();

$data = $dbo->retrieve();
if($data['clientid'] != $_REQUEST['clientid'])
    throw new Alt_Exception('Anda tidak berhak menghapus antrian ini!', Alt::STATUS_FORBIDDEN);

return $dbo->delete($_REQUEST);