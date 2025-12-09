<?php

use Phalcon\Mvc\Model;

class LogHistoryModel extends Model
{
    public function initialize()
    {
    	$this->setConnectionService("openfiredb");
        $this->setSource("ofMessageLog");
    }
}
