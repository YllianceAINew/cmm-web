<?php
/**
 * SessionController
 *
 * Allows to authenticate users
 */
use Phalcon\Mvc\Controller;
class SessionController extends ControllerUIBase
{
    protected function initialize()
    {
		$this->tag->setTitle($this->lang['session_page_title']);
		parent::initialize();
	}

    public function indexAction()
    {
		$this->view->setLayout('login-adminlte');
		$this->view->pick('session/index-adminlte');
		$this->assets->addJs("global/plugins/jquery-validation/js/jquery.validate.min.js");
		$this->assets->addJs("global/plugins/jquery-validation/js/additional-methods.min.js");
		$this->assets->addJs("global/plugins/backstretch/jquery.backstretch.min.js");
		$this->assets->addCss("pages/css/session_index.css");
		$this->assets->addJs("pages/scripts/session_index.js");
		$this->view->cleanTemplateAfter();
		$this->session->remove('authAdmin');
		$this->session->destroy();
		if (isset($_SERVER['SSL_CLIENT_S_DN_CN'])) {
			$this->view->caFlag = 1;
			$this->view->userId = $_SERVER['SSL_CLIENT_S_DN_CN'];
		} else {
			$this->view->caFlag = 0;
		}

		$this->view->form = new LoginSystemAccountKpForm;
    }

    /**
     * Register an authenticated user into session data
     *
     * @param Users $user
     */
    private function _registerSession(AdminMemberModel $admin)
    {
		$this->session->set('authAdmin', array(
        	'id' => $admin->memberNo,
        	'name' => $admin->memberName,
			'loginId' => $admin->memberLoginId,
			'acl' => $admin->memberAcl,
        ));
    }

    /**
     * This action authenticate and logs an user into the application
     *
     */
    public function startAction()
    {
		$this->view->caFlag = 0;
		if ($this->request->isPost()) {
			$loginId = $this->request->getPost('memberLoginId');
			$password = $this->request->getPost('memberPassword');
			$memberip = $_SERVER['REMOTE_ADDR'];
			$admin = AdminMemberModel::findFirst(array(
				"memberLoginId = :loginId:",
				'bind' => array('loginId' => $loginId)
			));	
			if ($admin != false) {
				if ($admin->memberIP=="" ||$memberip == $admin->memberIP) {
					if ($this->security->checkHash($password, $admin->memberPassword)) {
						$this->_registerSession($admin);
						$admin->loginCounter = $admin->loginCounter*1 + 1;
						$admin->lastedLoginDay = new \Phalcon\Db\RawValue('now()');
						$admin->save();
						if($admin->memberAcl=="ALL")
						{
							return $this->response->redirect('member/summary');
						}else{
							$memberAcl = json_decode($admin->memberAcl);
							return $this->response->redirect($memberAcl[0]);
						}
					} else
						$this->flash->error($this->lang['content_messages_password']);
				 } else
				 	$this->flash->error($this->lang['content_messages_ip']);
			} else
				$this->flash->error($this->lang['content_messages_username']);
		}
		$this->dispatcher->forward(
            array(
                "controller" => "session",
                "action"     => "index"
            )
        );
        echo 'session/index';
        exit;
    }

    public function endAction()
    {
        $this->session->remove('authAdmin');
		$this->session->destroy();
		return $this->response->redirect('');
    }

    public function getTimeAction () {
	/*$months = ['', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
	$ret = system("date", $retval);
	$dateInfo = explode(" ", $ret);
	$month = 0;
	$isMonth = 0;
	foreach ($months as $mon) {
	    if (!strcmp ($mon, $dateInfo[1]))
		$isMonth = $month;
	    $month++;
	}
	$day = $dateInfo[2];
	$year = $dateInfo[5];
	$time = $dateInfo[3];

	echo $year.".".$isMonth.".".$month." ".$time;
	exit;*/
	// date_default_timezone_set('');

	$date = date("Y.m.d h:i:s");
	echo json_encode ("봉사기시간: " . $date);
	exit;
    }
}
