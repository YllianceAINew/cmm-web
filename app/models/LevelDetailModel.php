<?php

use Phalcon\Mvc\Model;

class LevelDetailModel extends Model
{
    public function initialize()
    {
    	$this->setConnectionService("openfiredb");
        $this->setSource("ofLevelDetails");
    }
}
