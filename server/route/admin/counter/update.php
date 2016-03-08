<?php defined('ALT_PATH') OR exit('No direct script access allowed');

Alt_Validation::instance()
    ->rule(Alt_Validation::required($_REQUEST["clientid"]), "Counterid tidak boleh kosong!")
    ->rule(Alt_Validation::required($_REQUEST["counterid"]), "Counterid tidak boleh kosong!")
    ->rule(Alt_Validation::required($_REQUEST["name"]), "Nama tidak boleh kosong!")
    ->check();

$dboQueue = new Queue();
$queue = $dboQueue->retrieve($_REQUEST);
if($queue['clientid'] != $_REQUEST['clientid'])
    throw new Alt_Exception('Anda tidak berhak mengubah loket untuk antrian ini!', Alt::STATUS_FORBIDDEN);

$dbo = new Queue_Counter();
$data = $dbo->retrieve($_REQUEST);
if($data['clientid'] != $_REQUEST['clientid'])
    throw new Alt_Exception('Anda tidak berhak mengubah loket ini!', Alt::STATUS_FORBIDDEN);

return $dbo->update($_REQUEST);