<?php defined('ALT_PATH') or die('No direct script access.');

class Master_Type extends Alt_Dbo {

    public function __construct() {
        // call parent constructor
        parent::__construct();

        // define this class specific properties
        $this->pkey             = "typeid";
        $this->table_name       = "master_type";
        $this->table_fields     = array(
            "typeid"            => "",
            "name"              => "",
            "description"       => "",
        );
    }
}