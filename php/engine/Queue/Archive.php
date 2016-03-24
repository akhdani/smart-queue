<?php defined('ALT_PATH') or die('No direct script access.');

class Queue_Archive extends Alt_Dbo {

    public function __construct() {
        // call parent constructor
        parent::__construct();

        // define this class specific properties
        $this->pkey             = "numberid";
        $this->table_name       = "queue_number";
        $this->table_fields     = array(
            "numberid"          => "",
            "queueid"           => "",
            "counterid"         => "",
            "clientid"          => "",
            "number"            => "",
            "date"              => "",
            "ipaddress"         => "",
            "useragent"         => "",
            "session"           => "",
            "entrytime"         => "",
            "entryuser"         => "",
        );
    }
}