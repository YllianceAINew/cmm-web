<?php

use Phalcon\Mvc\Model;

class IrregularModel extends Model
{
    public function initialize()
    {
    	$this->setConnectionService("openfiredb");
        $this->setSource("ofIrregularWords");
    }
}
