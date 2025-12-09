<?php

use Phalcon\Mvc\Model;

class SipCycleModel extends Model
{
    public function initialize()
    {
    	$this->setConnectionService("kamailiodb");
        $this->setSource("cycle");
    }
}
