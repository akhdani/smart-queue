<?php defined('ALT_PATH') OR exit('No direct script access allowed');

$dbo = new Queue_Number();

return $dbo->count($_REQUEST);

