<?php defined('ALT_PATH') or die('No direct script access.');

class Queue_Number extends Alt_Dbo {

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

    /**
     * Archiving queue number on new day or on cancel
     * @param $date
     * @param string $user
     * @return int
     */
    public function archive($date, $user = 'system'){
        $list = $this->get(array('where' => 'date = ' . $this->quote($date)));

        $res = 0;
        $dbo = new Queue_Archive();
        foreach($list as $item){
            $item['entryuser'] = $user;
            $dbo->insert($item);
            $res += $this->delete(array('numberid' => $item['numberid']));
        }

        return $res;
    }
}