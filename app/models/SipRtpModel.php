<?php

use Phalcon\Mvc\Model;

class SipRtpModel extends Model
{
    public function initialize()
    {
    	$this->setConnectionService("kamailiodb");
        $this->setSource("rtpengine");
    }
}
