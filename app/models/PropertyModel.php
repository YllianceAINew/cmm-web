<?php

use Phalcon\Mvc\Model;

class PropertyModel extends Model
{
    public function initialize()
    {
    	$this->setConnectionService("openfiredb");
        $this->setSource("ofProperty");
    }
}
