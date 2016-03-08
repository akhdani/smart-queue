<?php defined('ALT_PATH') or die('No direct script access.');

class Queue extends Alt_Dbo {

    public function __construct() {
        // call parent constructor
        parent::__construct();

        // define this class specific properties
        $this->pkey             = "queueid";
        $this->table_name       = "queue";
        $this->table_fields     = array(
            "queueid"           => "",
            "clientid"          => "",
            "date"              => "",
            "name"              => "",
            "description"       => "",
            "starttime"         => "",
            "endtime"           => "",
            "avgtime"           => "",
            "numberid"          => "",
            "counterid"         => "",
            "isactive"          => "",
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