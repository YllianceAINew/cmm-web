<?php

use Phalcon\Mvc\Model;

class UserMemberModel extends Model
{
    public function initialize()
    {
    	$this->setConnectionService("openfiredb");
        $this->setSource("ofUserDetail"); 
        $this->hasOne("username", "UserListModel", "username");
    }

    public function afterFetch()
    {
        $this->created = date("Y-m-d H:i:s", $this->created / 1000 );
    }

}
