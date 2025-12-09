<?php

use Phalcon\Forms\Form;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\Password;

class LoginSystemAccountForm extends Form
{

    public function initialize($entity = null, $options = null)
    {
        // Login ID
        $loginId = new Text('memberLoginId',[
			"class"=> "form-control placeholder-no-fix",
			"placeholder" => "Username",
			"autocomplete"=>"off"
		]);
        $loginId->setLabel('Username');
		$loginId->setFilters(array('alpha'));
        $loginId->addValidators(array(
            new PresenceOf(array(
                'message' => ' Username is required. '
            ))
        ));
        $this->add($loginId);

        // Password
        $password = new Password('memberPassword',[
			"class"=> "form-control placeholder-no-fix",
			"placeholder" => "Password",
			"autocomplete"=>"off"
		]);
        $password->setLabel('Password');
        $password->addValidators(array(
            new PresenceOf(array(
                'message' => ' Password is required. '
            ))
        ));
        $this->add($password);
    }
}