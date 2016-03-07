<?php defined('ALT_PATH') OR exit('No direct script access allowed');

$dbo = new Queue_Counter();

return array(
    'total' => $dbo->count($_REQUEST),
    'list' => $dbo->get($_REQUEST),
);