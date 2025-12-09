<?php

use Phalcon\Mvc\Model;

class SipServerModel extends Model
{
    public function initialize()
    {
    	$this->setConnectionService("kamailiodb");
        $this->setSource("server");
    }
}
