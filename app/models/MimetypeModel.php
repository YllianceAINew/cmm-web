<?php

use Phalcon\Mvc\Model;

class MimetypeModel extends Model
{
    public function initialize()
    {
    	$this->setConnectionService("openfiredb");
        $this->setSource("ofMimetypes");
    }
}
