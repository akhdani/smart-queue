<?php defined('ALT_PATH') OR exit('No direct script access allowed');

$dbo = new Queue();

return $dbo->count($_REQUEST);

