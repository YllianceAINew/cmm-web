<?php

use Phalcon\Forms\Form;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\StringLength;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\TextArea;
use Phalcon\Forms\Element\Select;
use Phalcon\Forms\Element\Password;

class RegisterSystemAccountKpForm extends Form
{
	public function RegisterSystemAccountKpForm($memId)
	{
		$this->initialize($memId);
	}
    public function initialize($memId)
    {
    // ID
        $item = new Text('memberLoginId',[
			"class"=> "form-control placeholder-no-fix",
			"placeholder" => "id",
			"autocomplete"=>"off"
		]);
        $item->setLabel('id<span class="required"> * </span>');
		$item->setFilters(array('alpha'));
        $item->addValidators(array(
            new PresenceOf(array(
                'message' => 'input id.'
            )),new StringLength(
		[
		    "min" => 3,
		    "messageMinimum" => "incorrect id",
		]
	    )
        ));
		$this->add($item);
	// NAME
        $item = new Text('memberName',[
			"class"=> "form-control placeholder-no-fix",
			"placeholder" => "name",
			"autocomplete"=>"off"
		]);
        $item->setLabel('name<span class="required"> * </span>');
		$item->addValidators(array(
            new PresenceOf(array(
                'message' => 'input admin name.'
            ))
        ));
        $this->add($item);
	// 
        $item = new Text('memberDepart',[
			"class"=> "form-control placeholder-no-fix",
			"placeholder" => "job"
		]);
        $item->setLabel('job<span class="required"> * </span>');
		$item->addValidators(array(
            new PresenceOf(array(
                'message' => 'input job'
            ))
        ));
        $this->add($item);
    //old password    
        $item = new Password('oldPassword',[
			"class"=> "form-control placeholder-no-fix",
			"placeholder" => "",
			"autocomplete"=>"off"
		]);
        $item->setLabel('old password<span class="required"> * </span>');
        $this->add($item);
    //new password    
        $item = new Password('memberPassword',[
			"class"=> "form-control placeholder-no-fix",
			"placeholder" => "password",
			"autocomplete"=>"off"
		]);
        if($memId==0){
			$item->setLabel('password<span class="required"> * </span>');
			$item->addValidators(array(
            new PresenceOf(array(
                'message' => 'input password.'
            )),new StringLength(
			[
				"min" => 6,
				"messageMinimum" => "incorrect password.",
			]
	    )
        ));
		}else{
			$item->setLabel('password');
			$item->addValidators(array(
				new StringLength(
				[
					"min" => 6,
					"messageMinimum" => "incorrect password.",
				]
			)
        ));
		}
        
        $this->add($item);
	// Confirm Password
        $item = new Password('repeatPassword',[
			"class"=> "form-control placeholder-no-fix",
			"placeholder" => 'password confirm',
			"autocomplete"=>"off"
		]);
		if($memId==0){
			$item->setLabel('password confirm<span class="required"> * </span>');
			$item->addValidators(array(
				new PresenceOf(array(
					'message' => 'password confirm.'
				))
			));
		}else{
			$item->setLabel('password confirm');
		}
        $this->add($item);
    }
}