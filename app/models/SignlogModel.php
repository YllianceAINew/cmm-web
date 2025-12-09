<?php

use Phalcon\Mvc\Model;

class SignlogModel extends Model
{
    public function initialize()
    {
    	$this->setConnectionService("openfiredb");
        $this->setSource("ofLoginHistory");
    }
}
