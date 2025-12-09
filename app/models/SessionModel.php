<?php

use Phalcon\Mvc\Model;

class SessionModel extends Model
{
    public function initialize()
    {
    	$this->setConnectionService("openfiredb");
        $this->setSource("ofSessions");
    }
}
