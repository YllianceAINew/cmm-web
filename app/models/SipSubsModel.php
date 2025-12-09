<?php

use Phalcon\Mvc\Model;

class SipSubsModel extends Model
{
    public function initialize()
    {
    	$this->setConnectionService("kamailiodb");
        $this->setSource("dispatcher");
    }
}
