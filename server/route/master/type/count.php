<?php defined('ALT_PATH') OR exit('No direct script access allowed');

$dbo = new Master_Type();

return $dbo->count($_REQUEST);
