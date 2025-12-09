<?php

use Phalcon\Mvc\Model;

class AlarmHistoryModel extends Model
{
    public function initialize()
    {
    	$this->setConnectionService("openfiredb");
        $this->setSource("ofAlarmHistory");
    }
}
