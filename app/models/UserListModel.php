<?php

use Phalcon\Mvc\Model;

class UserListModel extends Model
{
    public function initialize()
    {
    	$this->setConnectionService("openfiredb");
        $this->setSource("ofUser");
    }
}
