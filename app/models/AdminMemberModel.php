<?php

use Phalcon\Mvc\Model;

class AdminMemberModel extends Model
{
 
    public function initialize()
    {
    	$this->setConnectionService("openfiredb");
        $this->setSource("ofAdminMember");
    }

}
