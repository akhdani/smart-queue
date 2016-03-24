<?php defined('ALT_PATH') OR exit('No direct script access allowed');

$_REQUEST['clientid']  = '= ' . $dbo->quote($_REQUEST['clientid']);
$dbo = new Queue_Number();

return array(
    'total' => $dbo->count($_REQUEST),
    'list' => $dbo->get($_REQUEST),
);