<?php defined('ALT_PATH') or die('No direct script access.');

class Master_Client extends Alt_Dbo {

    public function __construct() {
        // call parent constructor
        parent::__construct();

        // define this class specific properties
        $this->pkey             = "clientid";
        $this->table_name       = "master_client";
        $this->table_fields     = array(
            "clientid"          => "",
            "name"              => "",
            "shortname"         => "",
            "address"           => "",
            "phone"             => "",
            "email"             => "",
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