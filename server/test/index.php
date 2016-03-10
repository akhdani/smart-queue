<?php defined('ALT_PATH') or die('No direct script access.');

class IndexTest extends Alt_Test {
    public function testOutput() {
        $output = $this->connect('index');
        $this->assertEquals("Smart Queue is RUNNING!", $output, "Output harus menghasilkan 'Smart Queue is RUNNING!'");
    }
}