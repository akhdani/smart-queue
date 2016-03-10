<?php defined('ALT_PATH') or die('No direct script access.');

class QueueTest extends Alt_Test {
    public function testNormal(){
        $this->login('user1', '123');
        $number = $this->connect('user/take', array('clientid' => 1, 'queueid' => 1));
        $this->assertGreaterThan(0, $number['number'], 'Nomor antrian harus lebih dari 0');



    }
}