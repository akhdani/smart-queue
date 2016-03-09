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
     * Take queue number
     * @param $data
     * @return mixed
     * @throws Alt_Exception
     */
    public function take($data){
        // validate
        Alt_Validation::instance()
            ->rule(Alt_Validation::required($data['clientid']), 'Clientid tidak boleh kosong')
            ->rule(Alt_Validation::required($data['queueid']), 'Queueid tidak boleh kosong')
            ->check();

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
        // validate
        Alt_Validation::instance()
            ->rule(Alt_Validation::required($data['queueid']), 'Queueid tidak boleh kosong')
            ->check();

        // retrieving number
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
     * Cancel number
     * @param $data
     * @return int
     * @throws Alt_Exception
     */
    public function cancel($data){
        // validate
        Alt_Validation::instance()
            ->rule(Alt_Validation::required($data['numberid']), 'Numberid tidak boleh kosong')
            ->check();

        $userdata = System_Auth::get_user_data();

        return $this->update(array(
            'numberid' => $data['numberid'],
            'iscancel' => 1,
            'canceltime' => date('YmdHis', time()),
            'canceluser' => $userdata['username'],
        ));
    }

    /**
     * Archiving queue number on new day
     * @param $data
     * @return int
     * @throws Alt_Exception
     */
    public function archive($data){
        $data['user'] = $data['user'] ? $data['user'] : 'system';

        // validate
        Alt_Validation::instance()
            ->rule(Alt_Validation::required($data['date']), 'Tanggal tidak boleh kosong')
            ->rule(Alt_Validation::required($data['user']), 'User tidak boleh kosong')
            ->check();

        $list = $this->get(array('where' => 'date = ' . $this->quote($data['date'])));

        $res = 0;
        $dbo = new Queue_Archive();
        foreach($list as $item){
            $item['entryuser'] = $data['user'];
            $dbo->insert($item);
            $res += $this->delete(array('numberid' => $item['numberid']));
        }

        return $res;
    }
}