<?php

use Phalcon\Mvc\Model;

class LoginCountModel extends Model
{
    public function initialize()
    {
    	$this->setConnectionService("openfiredb");
        $this->setSource("ofLoginCount");
    }
}