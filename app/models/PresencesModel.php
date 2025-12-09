<?php

use Phalcon\Mvc\Model;

class PresencesModel extends Model
{
    public function initialize()
    {
    	$this->setConnectionService("openfiredb");
        $this->setSource("ofPresence");
    }
}
