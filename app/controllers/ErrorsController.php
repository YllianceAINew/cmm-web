<?php

class ErrorsController extends ControllerBase
{
    public function initialize()
    {
        $this->tag->setTitle('Oops!');
        parent::initialize();
    }

    public function show404Action()
    {
		$this->assets->addCss("pages/css/error.min.css");
    }

    public function show401Action()
    {
		$this->view->cleanTemplateAfter();
		$this->assets->addCss("pages/css/error.min.css");
    }

    public function show500Action()
    {
	$this->view->cleanTemplateAfter();
	$this->assets->addCss("pages/css/error.min.css");		
    }
}
