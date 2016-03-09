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
            "clientid"          => "",
            "name"              => "",
            "description"       => "",
            "numberid"          => "",
            "entrytime"         => "",
            "entryuser"         => "",
            "modifiedtime"      => "",
            "modifieduser"      => "",
            "deletedtime"       => "",
            "deleteduser"       => "",
            "isdeleted"         => "",
        );
    }

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
            'where' => 'numberid > ' . $data['numberid'],
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

        return $this->update(array(
            'counterid' => $data['counterid'],
            'numberid' => $next['numberid'],
        ));
    }

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
        return $this->update(array(
            'counterid' => $data['counterid'],
            'number' => '0',
        ));
    }
}