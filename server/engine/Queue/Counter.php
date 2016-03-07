<?php defined('ALT_PATH') or die('No direct script access.');

class Queue_Counter extends Alt_Dbo {

    public function __construct() {
        // call parent constructor
        parent::__construct();

        // define this class specific properties
        $this->pkey             = "counterid";
        $this->table_name       = "queue_counter";
        $this->table_fields     = array(
            "counterid"         => "",
            "queueid"           => "",
            "name"              => "",
            "description"       => "",
            "entrytime"         => "",
            "entryuser"         => "",
            "modifiedtime"      => "",
            "modifieduser"      => "",
            "deletedtime"       => "",
            "deleteduser"       => "",
            "isdeleted"         => "",
        );
    }
}