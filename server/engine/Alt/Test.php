<?php defined('ALT_PATH') OR die('No direct script access.');

class Alt_Test extends PHPUnit_Framework_TestCase {
    public $url = ALT_URL;
    public $route = "";
    public $api;

    public $username = "";
    public $password = "";

    public function setUp(){
        if($this->username != "" && $this->password != ""){
            $this->login($this->username, $this->password);
        }
    }

    public function login($username, $password){
        $this->logout();
        $token = $this->connect('system/auth/login', array(
            'username' => $username,
            'password' => $password,
        ));
        System_Auth::save_token($token);
    }

    public function logout(){
        $this->connect('system/auth/logout');
    }

    public function connect($url, $data = array(), $header = array()){
        $this->api = new Alt_Api($this->url, $this->route);
        $this->api->url = $this->url;
        $this->api->route = $this->route;
        return $this->api->connect($url, $data, $header);
    }

    public function testDummy(){}

    public function tearDown() {
        if($this->username != "" && $this->password != "") {
            $this->logout();
        }
    }
}