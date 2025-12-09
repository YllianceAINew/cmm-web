<?php

use Phalcon\Mvc\Model;

class ManagerIPListModel extends Model
{
    public function initialize()
    {
    	$this->setConnectionService("openfiredb");
        $this->setSource("ofManagerIPList");
    }
}
