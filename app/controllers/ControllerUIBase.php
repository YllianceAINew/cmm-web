<?php

use Phalcon\Mvc\Controller;

class ControllerUIBase extends Controller
{

    protected function initialize()
    {
        $this->tag->prependTitle($this->lang['site_title'].'| ');
		// Add some local CSS resources
        $this->view->lang = $this->lang;

		$auth = $this->session->get("authAdmin");
		if ($auth) {
            $this->view->authAdmin = $auth;
            if ($auth['acl'] == 'ALL')
                $this->view->acceptAcl = array(
                                "server/index", "server/serversetting", "server/xmppserver", "server/sipserver", "server/proxyserver", "server/irregular", "server/mimetype",
                                "log/calllog", "log/textlog", "log/signlog", "log/xmppHistory","log/sipHistory", 
                                "member/register", "member/summary", "member/setlevel", "member/levelList");
            else
                $this->view->acceptAcl = json_decode($auth['acl']);
		}		
    }
    protected function forward($uri)
    {
        $uriParts = explode('/', $uri);
        $params = array_slice($uriParts, 2);
    	return $this->dispatcher->forward(
    		array(
    			'controller' => $uriParts[0],
    			'action' => $uriParts[1],
                'params' => $params
    		)
    	);
    }
}
