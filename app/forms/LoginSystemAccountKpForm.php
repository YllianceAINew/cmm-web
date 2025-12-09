<?php

use Phalcon\Forms\Form;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\Password;

class LoginSystemAccountKpForm extends Form
{

    public function initialize($entity = null, $options = null)
    {
        // Login ID
        $loginId = new Text('memberLoginId',[
			"class"=> "form-control placeholder-no-fix",
			"placeholder" => "id",
			"autocomplete"=>"off"
		]);
        $loginId->setLabel('id');
		$loginId->setFilters(array('alpha'));
        $loginId->addValidators(array(
            new PresenceOf(array(
                'message' => ' input id. '
            ))
        ));
        $this->add($loginId);

        // Password
        $password = new Password('memberPassword',[
			"class"=> "form-control placeholder-no-fix",
			"placeholder" => "password",
			"autocomplete"=>"off"
		]);
        $password->setLabel('password');
        $password->addValidators(array(
            new PresenceOf(array(
                'message' => ' input password '
            ))
        ));
        $this->add($password);
    }
}