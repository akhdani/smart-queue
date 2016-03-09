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
            "clientid"          => "",
            "number"            => "",
            "date"              => "",
            "ipaddress"         => "",
            "useragent"         => "",
            "session"           => "",
            "starttime"         => "",
            "endtime"           => "",
            "isfinish"          => "",
            "counterid"         => "",
            "entrytime"         => "",
            "entryuser"         => "",
            "iscancel"          => "",
            "canceltime"        => "",
            "canceluser"        => "",
        );
    }

    /**
     * Retrieve number, add additional data (remaining time before called)
     * @param array $data
     * @return array
     * @throws Alt_Exception
     */
    public function retrieve($data = array(), $returnsql = false){
        // validate
        Alt_Validation::instance()
            ->rule(Alt_Validation::required($data['numberid']), 'Numberid tidak boleh kosong')
            ->check();

        // retrieving number
        $number = parent::retrieve($data, $returnsql);
        if($returnsql)
            return $number;

        if($number == null)
            throw new Alt_Exception('Nomor antrian tidak ditemukan!');

        $dboQueue = new Queue();
        $queue = $dboQueue->retrieve(array('queueid' => $number['queueid']));

        // predict time remaining
        $number['timeremaining'] = intval($number['number']) - intval($queue['number']) > 0 ? intval($queue['avgtime']) * (intval($number['number']) - intval($queue['number'])) : 0;

        // check counter time open and close
        list($hour, $minute) = explode(":", $queue['starttime']);
        $timestart = mktime($hour, $minute, 0);

        list($hour, $minute) = explode(":", $queue['endtime']);
        $timeend = mktime($hour, $minute, 0);

        $timenow = time();

        if($timenow > $timeend)
            throw new Alt_Exception('Antrian sudah tidak berlaku karena sudah tutup!');

        // calculate time
        $number['timeremaining'] = ($timestart > $timenow ? $timestart - $timenow : 0) + $number['timeremaining'];

        return $number;
    }
}