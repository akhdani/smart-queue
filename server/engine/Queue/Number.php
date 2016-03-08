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
            "entrytime"         => "",
            "entryuser"         => "",
        );
    }

    /**
     * Take queue number
     * @param $data
     * @return mixed
     * @throws Alt_Exception
     */
    public function take($data){
        // get last number
        $last = $this->get(array(
            'queueid' => '= ' . $this->quote($data['queueid']),
            'clientid' => '= ' . $this->quote($data['clientid']),
            'limit' => 1,
            'order' => 'number desc',
        ));
        $last = count($last) > 0 ? $last[0]['number'] : 1;

        // try to insert
        $i = 0;
        $isinserted = false;
        while(!$isinserted && $i < 10){
            try{
                $data['number'] = $last;
                $this->insert($data);
                $isinserted = true;
            }catch(Exception $e){
                $last++;
            }
            $i++;
        }

        if($i >= 10)
            throw new Alt_Exception('Tidak dapat mengambil nomor antrian!');

        return $data['number'];
    }

    /**
     * Retrieve number with remaining time
     * @param array $data
     * @return array
     * @throws Alt_Exception
     */
    public function retrieve($data = array(), $returnsql = false){
        $number = parent::retrieve($data, $returnsql);
        if($returnsql)
            return $number;

        $dboQueue = new Queue();
        $queue = $dboQueue->retrieve(array('queueid' => $number['queueid']));

        // predict time remaining
        $number['timeremaining'] = intval($queue['avgtime']) * (intval($number['number']) - intval($queue['number'] + 1));

        return $number;
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