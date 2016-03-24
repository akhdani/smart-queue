<?php defined('ALT_PATH') OR exit('No direct script access allowed');

Alt_Validation::instance()
    ->rule(Alt_Validation::required($_REQUEST["clientid"]), "Queueid tidak boleh kosong!")
    ->rule(Alt_Validation::required($_REQUEST["queueid"]), "Queueid tidak boleh kosong!")
    ->rule(Alt_Validation::required($_REQUEST["name"]), "Nama tidak boleh kosong!")
    ->check();

$dboQueue = new Queue();
$queue = $dboQueue->retrieve(array('queueid' => $_REQUEST['queueid']));
if($queue['clientid'] != $_REQUEST['clientid'])
    throw new Alt_Exception('Anda tidak berhak menambah loket untuk antrian ini!', Alt::STATUS_FORBIDDEN);

$dbo = new Queue_Counter();

return $dbo->insert($_REQUEST);