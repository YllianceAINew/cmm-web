<?php

use Phalcon\Mvc\Model;

class RegisteredCountModel extends Model
{
    public function initialize()
    {
    	$this->setConnectionService("openfiredb");
        $this->setSource("ofUserCount");
    }
}