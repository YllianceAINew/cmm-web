<?php

use Phalcon\Forms\Form;
use Phalcon\Validation\Validator\PresenceOf;
use Phalcon\Validation\Validator\StringLength;
use Phalcon\Forms\Element\Text;
use Phalcon\Forms\Element\TextArea;
use Phalcon\Forms\Element\Select;
use Phalcon\Forms\Element\Password;

class RegisterSystemAccountForm extends Form
{
	public function RegisterSystemAccountForm($memId)
	{
		$this->initialize($memId);
	}
    public function initialize($memId)
    {
    // ID
        $item = new Text('memberLoginId',[
			"class"=> "form-control placeholder-no-fix",
			"placeholder" => "ID",
			"autocomplete"=>"off"
		]);
        $item->setLabel('ID<span class="required"> * </span>');
		$item->setFilters(array('alpha'));
        $item->addValidators(array(
            new PresenceOf(array(
                'message' => '. '
            )),new StringLength(
		[
		    "min" => 3,
		    "messageMinimum" => "",
		]
	    )
        ));
		$this->add($item);
	// NAME
        $item = new Text('memberName',[
			"class"=> "form-control placeholder-no-fix",
			"placeholder" => "Name",
			"autocomplete"=>"off"
		]);
        $item->setLabel('Name<span class="required"> * </span>');
		$item->addValidators(array(
            new PresenceOf(array(
                'message' => ' '
            ))
        ));
        $this->add($item);
	// 
        $item = new Text('memberDepart',[
			"class"=> "form-control placeholder-no-fix",
			"placeholder" => "Job"
		]);
        $item->setLabel('Job<span class="required"> * </span>');
		$item->addValidators(array(
            new PresenceOf(array(
                'message' => ''
            ))
        ));
        $this->add($item);
    /*
        $item = new Text('memberIP',[
			"class"=> "form-control placeholder-no-fix",
			"placeholder" => "Account IP",
			"autocomplete"=>"off"
		]);
        $item->setLabel('IP');
	
        $this->add($item);

	//
        $item = new TextArea('memberDescription',[
			"class"=> "form-control placeholder-no-fix",
			"placeholder" => "Other"
		]);
        $item->setLabel('Other');
        $this->add($item);*/
    //
        $item = new Password('memberPassword',[
			"class"=> "form-control placeholder-no-fix",
			"placeholder" => "Password",
			"autocomplete"=>"off"
		]);
        if($memId==0){
			$item->setLabel('Password<span class="required"> * </span>');
			$item->addValidators(array(
            new PresenceOf(array(
                'message' => ''
            )),new StringLength(
			[
				"min" => 6,
				"messageMinimum" => "",
			]
	    )
        ));
		}else{
			$item->setLabel('Password');
			$item->addValidators(array(
				new StringLength(
				[
					"min" => 6,
					"messageMinimum" => "",
				]
			)
        ));
		}
        
        $this->add($item);
	// Confirm Password
        $item = new Password('repeatPassword',[
			"class"=> "form-control placeholder-no-fix",
			"placeholder" => 'Confirm',
			"autocomplete"=>"off"
		]);
		if($memId==0){
			$item->setLabel('Confirm<span class="required"> * </span>');
			$item->addValidators(array(
				new PresenceOf(array(
					'message' => ''
				))
			));
		}else{
			$item->setLabel('Confirm');
		}
        $this->add($item);
    }
}