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
            "typeid"            => "",
            "clientid"          => "",
            "date"              => "",
            "name"              => "",
            "description"       => "",
            "starttime"         => "",
            "endtime"           => "",
            "avgtime"           => "",
            "number"            => "",
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

    /**
     * Operator call next number
     * @param $data
     * @return array
     * @throws Alt_Exception
     */
    public function next($data){
        // validate
        Alt_Validation::instance()
            ->rule(Alt_Validation::required($data['queueid']), 'Queueid tidak boleh kosong')
            ->rule(Alt_Validation::required($data['counterid']), 'Counterid tidak boleh kosong')
            ->rule(Alt_Validation::required($data['numberid']), 'Numberid tidak boleh kosong')
            ->check();

        $dboNumber = new Queue_Number();
        $next = $dboNumber->get(array(
            'queueid' => $data['queueid'],
            'where' => 'numberid > ' . $data['numberid'] . ' and isfinish <> 1 and iscancel = 0',
            'order' => 'number asc',
            'limit' => 1,
        ));

        if(count($next) <= 0)
            throw new Alt_Exception('Nomor antrian sudah habis!');

        $next = $next[0];

        $dboQueue = new Queue();
        $dboQueue->update(array(
            'queueid' => $data['queueid'],
            'counterid' => $data['counterid'],
            'number' => $next['number'],
        ));

        $dboCounter = new Queue_Counter();
        $dboCounter->update(array(
            'counterid' => $data['counterid'],
            'numberid' => $next['numberid'],
        ));

        return $dboQueue->retrieve(array(
            'queueid' => $data['queueid'],
        ));
    }

    /**
     * Operator skip a number
     * @param $data
     * @return int
     * @throws Alt_Exception
     */
    public function skip($data){
        // validate
        Alt_Validation::instance()
            ->rule(Alt_Validation::required($data['queueid']), 'Queueid tidak boleh kosong')
            ->rule(Alt_Validation::required($data['counterid']), 'Counterid tidak boleh kosong')
            ->rule(Alt_Validation::required($data['numberid']), 'Numberid tidak boleh kosong')
            ->check();

        // update number
        $dboNumber = new Queue_Number();
        $number = $dboNumber->retrieve(array('numberid' => $data['numberid']));

        $number['counter'] = 0;
        $number['starttime'] = "";
        $number['endtime'] = "";
        $number['isfinish'] = 0;

        return $dboNumber->update($number);
    }

    /**
     * Operator finish number
     * @param $data
     * @return int
     * @throws Alt_Exception
     */
    public function finish($data){
        // validate
        Alt_Validation::instance()
            ->rule(Alt_Validation::required($data['queueid']), 'Queueid tidak boleh kosong')
            ->rule(Alt_Validation::required($data['counterid']), 'Counterid tidak boleh kosong')
            ->rule(Alt_Validation::required($data['numberid']), 'Numberid tidak boleh kosong')
            ->check();

        // update number
        $dboNumber = new Queue_Number();
        $number = $dboNumber->retrieve(array('numberid' => $data['numberid']));

        if($number['isfinish'] == 1)
            throw new Alt_Exception('Nomor antrian sudah selesai!');

        $number['counter'] = $data['counterid'];
        $number['endtime'] = time();
        $number['isfinish'] = 1;
        $dboNumber->update($number);

        // update queue
        $dboQueue = new Queue();
        $queue = $dboQueue->retrieve(array('queueid' => $data['queueid']));

        $queue['avgtime'] = ($queue['avgtime'] + abs($number['endtime'] - $number['starttime'])) / 2;
        $dboQueue->update($queue);

        // update counter
        $dboCounter = new Queue_Counter();
        return $dboCounter->update(array(
            'counterid' => $data['counterid'],
            'number' => '0',
        ));
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
        $dboNumber = new Queue_Number();
        $last = $dboNumber->get(array(
            'queueid' => '= ' . $dboNumber->quote($data['queueid']),
            'clientid' => '= ' . $dboNumber->quote($data['clientid']),
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
                $dboNumber->insert($data);
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

        $dboNumber = new Queue_Number();
        return $dboNumber->update(array(
            'numberid' => $data['numberid'],
            'iscancel' => 1,
            'canceltime' => date('YmdHis', time()),
            'canceluser' => $userdata['username'],
        ));
    }

    /**
     * Checking number
     * @param $data
     * @return int
     * @throws Alt_Exception
     */
    public function check($data){
        // validate
        Alt_Validation::instance()
            ->rule(Alt_Validation::required($data['numberid']), 'Numberid tidak boleh kosong')
            ->check();

        $dboNumber = new Queue_Number();
        return $dboNumber->retrieve(array('numberid' => $data['numberid']));
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

        $dboNumber = new Queue_Number();
        $list = $dboNumber->get(array('where' => 'date = ' . $dboNumber->quote($data['date'])));

        $res = 0;
        $dbo = new Queue_Archive();
        foreach($list as $item){
            $item['entryuser'] = $data['user'];
            $dbo->insert($item);
            $res += $dboNumber->delete(array('numberid' => $item['numberid']));
        }

        return $res;
    }
}