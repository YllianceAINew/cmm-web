<?php
use Phalcon\Mvc\Controller;
class IndexController extends ControllerBase
{
    public function indexAction()
    {
	   $this->dispatcher->forward(
            array(
                "controller" => "session",
                "action"     => "index"
            )
        );
    }
}
