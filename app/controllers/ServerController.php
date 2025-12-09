<?php
//include_once "../../ubchat/systeminfo.php";
require_once ('PHPOpenfireUchatservice/PHPOpenfireUchatservice.php');
use Jestillore\PHPOpenfireUchatservice\PHPOpenfireUchatservice;
use Phalcon\Config\Adapter\Ini as ConfigIni;
use Phalcon\Db\RawValue;
class ServerController extends ControllerUIBase
{
    public function initialize()
    {
        $this->tag->setTitle($this->lang['menu_account']);
        $this->view->setLayout('adminlte');
        parent::initialize();

        $this->aclList = array("0" => array(),
                               "1" => array("server/index", "server/serversetting", "server/xmppserver", "server/sipserver", "server/proxyserver", "server/irregular", "server/mimetype"),
                               "2" => array("member/register", "member/summary", "member/setlevel", "member/levelList"),
                               "3" => array("log/calllog", "log/textlog", "log/signlog", "log/xmppHistory","log/sipHistory"));
        
        $this->prefix = "ub000000000";
        $this->kamPrefix= "000000000";
        $this->g_rest_key = "wDM73kNo";

        $config = new ConfigIni(APP_PATH . 'app/config/config.ini');
        $this->sipServerAddr = $config->protocol->prefix . $config->setAddress->sipServerAddr;
        $this->userserviceAddr  = $config->setAddress->userserviceAddr;
        $this->kamInfoUrl = $this->sipServerAddr."/kamailio/systeminfo.php";
        $this->kamSetting = $this->sipServerAddr."/kamailio/restart.php";
        $this->rest_url = "http://".$this->userserviceAddr.":9090/plugins/userService";
        $this->userservice = $this->getUserService();
        $this->kamSetUrl = $this->sipServerAddr."/kamailio/setDispatcher.php";
        $this->proxySetUrl = $this->sipServerAddr."/kamailio/setRTPEngine.php";
        
        $this->g_db_host = $config->kamailioDB->host;
        $this->g_db_user = $config->kamailioDB->username;
        $this->g_db_pass = $config->kamailioDB->password;
        $this->g_db_name = $config->kamailioDB->dbname;

    }
    
    public function getUserService() {
        $us = new PHPOpenfireUchatservice;
        $us->setEndpoint($this->rest_url);
        $us->setAuthType(PHPOpenfireUchatservice::AUTH_SHARED_KEY)->setSharedKey($this->g_rest_key);
        return $us;
    }

    public function connectKamailioDB(){
        $conn = @mysqli_connect($this->g_db_host, $this->g_db_user, $this->g_db_pass, $this->g_db_name, 3306);
        if($conn)
        {
            @mysqli_set_charset($conn, "utf8mb4");
            $charset = $conn->character_set_name();
            if($charset != "utf8mb4"){
                @mysqli_set_charset($conn,"utf8");
            }
        }
        else{
           $this->view->error = "error";
        }
        return $conn;
    }   

    public function executeSQL($sql,$conn){
        $result = @mysqli_query($conn, $sql) or die($sql."error:".db_error($sql, $conn));
        return $result;
    }

    public function getKamState($index){
        $ret = "";
        $data = array('sysinfo' => $index);
        $params = http_build_query($data);
        $s = curl_init();
        curl_setopt($s, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($s, CURLOPT_HEADER, 0);
        curl_setopt($s, CURLOPT_URL, $this->kamInfoUrl);
        curl_setopt($s, CURLOPT_POST, 1);
        curl_setopt($s, CURLOPT_POSTFIELDS, $params);
        curl_setopt($s, CURLOPT_RETURNTRANSFER, 1);
        $ret =  curl_exec($s);
        curl_close($s);
        return $ret;
    }

    public function setKamAction($index){
        $ret = "";
        $data = array('kamailio_action' => $index);
        $params = http_build_query($data);
        $s = curl_init();
        curl_setopt($s, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($s, CURLOPT_HEADER, 0);
        curl_setopt($s, CURLOPT_URL, $this->kamSetting);
        curl_setopt($s, CURLOPT_POST, 1);
        curl_setopt($s, CURLOPT_POSTFIELDS, $params);
        curl_setopt($s, CURLOPT_RETURNTRANSFER, 1);
        $ret =  curl_exec($s);
        curl_close($s);
        return $ret;
    }

    public function getServerInfo($ip, $port){

        /*if (!exec("/bin/ping -c 1 -W 1 " . $ip))
            return "error";*/

        $ret = "";
        $config = new ConfigIni(APP_PATH . 'app/config/config.ini');
        $s = curl_init();
        curl_setopt($s, CURLOPT_SSL_VERIFYPEER, FALSE);
        if ($port == 443)
            curl_setopt($s, CURLOPT_URL, $config->protocol->prefix . $ip . ':' . $port . "/rsvcs/systeminfo.php");
        else
            curl_setopt($s, CURLOPT_URL, $ip . ':' . $port . "/rsvcs/systeminfo.php");
        curl_setopt($s, CURLOPT_RETURNTRANSFER, 1);
        $ret =  curl_exec($s);
        curl_close($s);
        return $ret;
    }

    public function getKamServerInfo($ip, $type){

        /*if (!exec("/bin/ping -c 1 -W 1 " . $ip))
            return "error";*/

        $config = new ConfigIni(APP_PATH . 'app/config/config.ini');

        $ret = "";
        $s = curl_init();
        curl_setopt($s, CURLOPT_SSL_VERIFYPEER, FALSE);
        if ($type == 1)
            curl_setopt($s, CURLOPT_URL, $config->protocol->prefix . $ip . "/kamailio/systeminfo.php");
        else
            curl_setopt($s, CURLOPT_URL, $config->protocol->prefix . $ip . "/kamailio/rtpengine.php");
        curl_setopt($s, CURLOPT_RETURNTRANSFER, 1);
        $ret =  curl_exec($s);
        curl_close($s);
        return $ret;
    }

    public function indexAction()
    {
        $this->assets->addJs("global/plugins/datatables/datatables.js");
        $this->assets->addJs("global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.js");
        $this->assets->addJs("global/plugins/bootstrap-datepicker/js/bootstrap-datepicker.min.js");
        $this->assets->addJs("global/plugins/bootstrap-toastr/toastr.min.js");
        $this->assets->addJs("pages/scripts/localization.js");
        $this->assets->addJs("pages/scripts/server_index.js");

        // $this->assets->addCss("pages/css/server_index.css");
        // $this->assets->addCss("global/plugins/datatables/datatables.css");
        // $this->assets->addCss("global/plugins/bootstrap-toastr/toastr.min.css");
        // $this->assets->addCss("global/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css");

        $adminMembers = AdminMemberModel::find();
        $this->view->members = $adminMembers;
        $this->view->aclList = array("첫 페지", "봉사기관리", "가입자관리", "리력관리");
    }

    public function addAction($id = 0)
    {
        $this->assets->addJs("global/plugins/jquery-validation/js/jquery.validate.min.js");
        $this->assets->addJs("global/plugins/jquery-validation/js/additional-methods.min.js");
        $this->assets->addJs("pages/scripts/server_add.js");

        $registerForm = new RegisterSystemAccountKpForm($id);
        $this->view->resources = array(
                "0" => "첫 페지", 
                "1" =>"봉사기관리", 
                "2" => "가입자관리", 
                "3" => "리력관리");
        $list = array("server/index","member/register","log/calllog");
        $this->view->form = $registerForm;
        $this->view->id = $id;

        $admin = AdminMemberModel::findFirst('memberNo='.$id);
   
        $memberAcl = [];
        if($admin){
            $this->tag->setDefault("memberLoginId", $admin->memberLoginId);
            $this->tag->setDefault("memberName", $admin->memberName);
            $this->tag->setDefault("memberDepart", $admin->memberDepart);
            $this->tag->setDefault("memberIP", $admin->memberIP);
            $this->tag->setDefault("memberDescription", $admin->memberDescription);
            if ($admin->memberAcl != "ALL"){
                $acls = json_decode($admin->memberAcl);
                $i=0;
                foreach ($list as $value) {
                    if(in_array($value, $acls))
                        array_push($memberAcl, "$i");
                    $i++;
                } 
                $this->view->memberAcl = $memberAcl;
            }
            else
                $this->view->memberAcl = ["ALL"];
        }
    }
    public function serversettingAction(){
        $this->assets->addCss("pages/css/serversetting.css");
        $this->assets->addCss("global/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css");
        $this->assets->addCss("global/plugins/bootstrap-timepicker/css/bootstrap-timepicker.min.css");
        
        $this->assets->addJs("global/plugins/bootstrap-timepicker/js/bootstrap-timepicker.min.js");
        $this->assets->addJs("global/plugins/bootstrap-datepicker/js/bootstrap-datepicker.min.js");
        $this->assets->addJs("global/plugins/jquery.input-ip-address-control-1.0.min.js");
        $this->assets->addJs("global/plugins/jquery-inputmask/jquery.inputmask.bundle.min.js");
        $this->assets->addJs("/global/plugins/jquery.blockui.min.js");
        $this->assets->addJs("pages/scripts/components-date-time-pickers.min.js");
        $this->assets->addJs("pages/scripts/form-input-mask.js");
        $this->assets->addJs("pages/scripts/ui-blockui.js");
        $this->assets->addJs("pages/scripts/server_serversetting.js");
//봉사기상태
        if($this->request->isPost()){
            $restart = $this->request->getPost("restart");
            $setType = $this->request->getPost("setType");
            $serverActions = PropertyModel::findFirstByname("server.actions");
            if($restart == "restart"){
                @ fopen("/var/www/html/watchService/system.reboot","a");
                $out = $this->setKamAction("kamailio_restart");
		        echo $out;exit;
            }
            if($setType == "stop"){
                @ fopen("/var/www/html/watchService/server.stop","a");
                $out = $this->setKamAction("kamailio_stop");
                $serverActions->propValue = "start";
                $serverActions->save();
		        echo $out;exit;
            }
            if($setType == "start"){
                @ fopen("/var/www/html/watchService/server.start","a");
                $out = $this->setKamAction("kamailio_start");
                $serverActions->propValue = "stop";
                $serverActions->save();
		        echo $out;exit;
            }
        }

        $actions = PropertyModel::findFirstByname("server.actions");
        if($actions->propValue == "" || $actions->propValue =="stop"){
            $text = "봉사기중지";
        }
        else
            $text = "봉사기기동";
        $this->view->actions = $text;
//허용IP설정        
        $ipList = ManagerIPListModel::find();
        $this->view->ipList = $ipList->toArray();
//시간설정        
        date_default_timezone_set('Asia/Pyongyang');
        $this->view->date = date("Y-m-d");
        $this->view->time = date("H:i:s");
        $ntpServerIP = PropertyModel::findFirstByname("ntp.server.ip");
        $this->view->ntpServerIP = $ntpServerIP->propValue;
//리력보관기일설정
        $text = PropertyModel::findFirstByname("xmpp.messagelog.validtime");
        $this->view->textTime = $this->compare($text->propValue);
        $login = PropertyModel::findFirstByname("xmpp.loginhistory.validtime");
        $this->view->loginTime =$this->compare($login->propValue);
        $alarm = PropertyModel::findFirstByname("xmpp.alarmhistory.validtime");
        $this->view->alarmTime = $this->compare($alarm->propValue);
        $row = SipCycleModel::findFirstBytype('1');
        $this->view->callTime = $this->compare($row->remain);
        $this->view->selectType = ["","1주","1달","1년","2년","3년","5년"];
        
    }
    
    public function compare($type=0){
        switch ($type) {
            case 0: return "";break;
            case 7: return "1주";break;
            case 31: return "1달";break;
            case 365: return "1년";break;
            case 365*2: return "2년";break;
            case 365*3: return "3년";break;
            case 365*5: return "5년";break;
        }
    }
    
    public function deleteAction()
    {
        if ($this->request->isPost()) {
            $id = trim ($this->request->getPost("ID"));
            $ids = json_decode (trim ($this->request->getPost('ids')));
            if (strcmp ($id, '')) {
                $adminMember = AdminMemberModel::findFirstBymemberNo($id);
                if ($adminMember->memberLoginId != 'admin')
                    $adminMember->delete();
                echo json_encode("ok");
                exit;
            } else if (count($ids) > 0) {
                foreach ($ids as $No) {
                    $adminMember = AdminMemberModel::findFirstBymemberNo($No);
                    if ($adminMember->memberLoginId != 'admin')
                           $adminMember->delete();
                }
                echo json_encode("ok");
                exit;
            }
        }
    }
    public function savenewAction(){
        if ($this->request->isPost()) {
            $userID = trim ($this->request->getPost('userID'));
            $userName = trim ($this->request->getPost('userName'));
            $userOfficial = trim ($this->request->getPost('userOfficial'));
            $newPassword = trim ($this->request->getPost('newPassword'));
            $selectVal = json_decode(trim ($this->request->getPost('selectVal')));
            $allowedAcls = [];
            for ($i = 0; $i < count($selectVal); $i++) {
                $acls = $this->aclList[$selectVal[$i]];
                for( $j = 0; $j < count($acls); $j++)
                    $allowedAcls[] = $acls[$j];
            }
            $adminMember = AdminMemberModel::findFirstBymemberLoginId($userID);
            if ($adminMember) {
                echo "already";exit;
            }
            $adminMember = new AdminMemberModel();
            $adminMember->memberLoginId = $userID;
            $adminMember->memberName = $userName;
            $adminMember->memberPassword=$this->security->hash($newPassword);
            $adminMember->memberDepart = $userOfficial;
            $adminMember->memberAcl = json_encode($allowedAcls);
            $success = $adminMember->save();
            if($success){
                echo "thanks for registering!";
            }
            else{
                echo "error:not found:";
                }
           echo json_encode(array('result' => true, 'str' => $this->lang['success']));
            exit;
        }
    }
    public function saveAction()
    {
        $id = $this->request->getPost('memId');
        $oldPassword = $this->request->getPost('oldPassword');
        if((int)$id==0)
           $adminMember = new AdminMemberModel();
        else
            $adminMember = AdminMemberModel::findFirstBymemberNo($id);
        if($adminMember){
            $adminMember->memberLoginId=$this->request->getPost('memberLoginId');
            if($this->security->checkHash($oldPassword,$adminMember->memberPassword)){
                if($this->request->getPost('memberPassword')!="" && (int)$id>0){
                    $adminMember->memberPassword=$this->security->hash($this->request->getPost('memberPassword'));
                }else if((int)$id == 0){
                    $adminMember->memberPassword=$this->security->hash($this->request->getPost('memberPassword'));
                }
                $adminMember->memberName=$this->request->getPost('memberName');
                $adminMember->memberDepart=$this->request->getPost('memberDepart');
                $adminMember->memberIP=$this->request->getPost('memberIP');
                $adminMember->memberDescription=$this->request->getPost('memberDescription');
                $memberAcl = json_decode($this->request->getPost('memberAcl'));
                $allowedAcls = [];
                for ($i = 0; $i < count($memberAcl); $i++) {
                    $acls = $this->aclList[$memberAcl[$i]];
                    for( $j = 0; $j < count($acls); $j++)
                        $allowedAcls[] = $acls[$j];
                }
                $adminMember->memberAcl = json_encode($allowedAcls);
                if ($adminMember->save() == false) {
                    echo "error";
                    exit;
                }
            }
            else{
                echo "false";exit;
            }
        }
        return $this->response->redirect('server/index');
    }

    public function setServerTimeAction() {
        if (!$this->request->isPost()) {
            echo "error";
            exit;
        }
        $setDate = $this->request->getPost("setDate");
        $setTime = $this->request->getPost("setTime");
        $setTimeServer = $this->request->getPost("setTimeServer");

        $serverip = PropertyModel::findFirstByname("ntp.server.ip");
        $serverip->propValue = $setTimeServer;
        $serverip->save();

        if($setTimeServer)
            $str = "ntpdate -4 ".$setTimeServer;
        else if($setDate)
            $str = "date -s ".$setDate."\n".
                   "date -s ".$setTime.":00";

        if($fp=fopen("/var/www/html/watchService/settingTime.conf","w")){
            fwrite($fp, $str);
        }
        fclose($fp);
        echo "success";
        exit;
    }

    public function setServerIpAction() {
        if (!$this->request->isPost()) {
            echo "error";
            exit;
        }
        $ip = $this->request->getPost("ip");
        $netmask = $this->request->getPost("netmask");
        $gateway = $this->request->getPost("gateway");
        if ($ip == null || $netmask == null || $gateway == null) {
            echo "error";
            exit;
        }
        ////////////////////
        ////////////////////
        echo "success";
        exit;
    }

    public function setLogTimeAction(){
        if($this->request->isPost()){
            $textDate = $this->request->getPost("textDate");
            $logDate = $this->request->getPost("logDate");
            $alarmDate = $this->request->getPost("alarmDate");
            $callDate = $this->request->getPost("callDate");
            $text = PropertyModel::findFirstByname("xmpp.messagelog.validtime");
            $text->propValue = $textDate;
            $text->save();
            foreach ($text->getMessages() as $message) {
                echo $message;
            }
            $login = PropertyModel::findFirstByname("xmpp.loginhistory.validtime");
            $login->propValue = $logDate;
            $login->save();
            $alarm = PropertyModel::findFirstByname("xmpp.alarmhistory.validtime");
            $alarm->propValue = $alarmDate;
            $alarm->save();

            $record = SipCycleModel::findFirstBytype('1');
            if(!$record) {
                $record = new SipCycleModel();
                $record->type = 1;
                $record->period = 1;
                $record->month = 1;
                $record->day = 1;
                $record->weekday = 1;
                $record->hour = 0;
                $record->min = 0;
            }
            $record->remain = $callDate;
            $record->save();
        }
        exit;
    }

    public function addAllowAddrAction(){
        if($this->request->isPost()){
            $allowIP = $this->request->getPost("allowIP");
            if($allowIP =="___.___.___.___"){echo "error";exit;}
            $ipList = ManagerIPListModel::findFirstByip($allowIP);
            if($ipList){
                echo "error";exit;
            }

            $ipList = new ManagerIPListModel();
            $ipList->ip = $allowIP;
            if($ipList->save()){
                echo "success";
            }        
        }

        $this->ipToFile();
    }

    public function editAllowAddrAction(){
        if($this->request->isPost()){
            $allowIP = $this->request->getPost("allowIP");
            $id=$this->request->getPost("id");
            $ipList = ManagerIPListModel::findFirstByip($allowIP);
            if($ipList){
                echo "error";exit;
            }
            $ipList = ManagerIPListModel::findFirstByno($id);
            if($ipList){
                $ipList->ip = $allowIP;
                if($ipList->save())
                    echo "success";
            }      
        }

        $this->ipToFile();
    }

    public function deleteAddrAction(){
        if($this->request->hasPost("ipList")){
            $ipList = $this->request->getPost("ipList");

            if(count($ipList) == 0)exit;
            foreach ($ipList as $delip) {
                $delete = ManagerIPListModel::findFirstByno($delip);
                if($delete->delete())
                    echo "success";
                else
                    echo "error";
            }
        }

        $this->ipToFile();
    }

    public function ipToFile(){
        $str = "<Directory '/var/www/html/adminpage'>
                    Options Indexes FollowSymLinks MultiViews
                    AllowOverride All
                    Order allow,deny \n";
        $ipList = ManagerIPListModel::find();
        $ipList = $ipList->toArray();
        foreach ($ipList as $value) {
            $str .= "\n Allow from ".$value['ip']."\n"; 
        }
        $str .= "</Directory>";
        if($fp1=fopen("/var/www/html/watchService/adminpage.conf","w")){
            fwrite($fp1, $str);
            fclose($fp1);
        }
    }
 
    public function xmppserverAction() {
        $this->assets->addJs("pages/scripts/server_xmppserver.js");
        $this->assets->addCss("pages/css/server_xmppserver.css");

        $this->assets->addJs("global/plugins/bootstrap-growl/jquery.bootstrap-growl.min.js");

        $haproxy = PropertyModel::findFirstByname("xmpp.haproxy.server");
        if (!$haproxy)
            $this->view->haproxy = array('ip' => "",
                                        'cpu' => "",
                                        'ram' => "",
                                        'memory' => "",
                                        'status' => "");
        else {
            $haproxyIP = $haproxy->propValue;
            $this->persistent->haproxyIP = $haproxyIP;

            $haproxyInt = PropertyModel::findFirstByname("xmpp.haproxy.server.internal");
            $haproxyIPInt = $haproxyInt->propValue;
            $this->persistent->haproxyIPInt = $haproxyIPInt;

            $info = json_decode($this->getServerInfo($haproxyIPInt, "81"), true);

            $this->view->haproxy = array('ip' => "$haproxyIP<br/>($haproxyIPInt)",
                                        'cpu' => $info['cpu'],
                                        'ram' => $info['ram'],
                                        'memory' => $info['memory'],
                                        'status' => $info['status']);
        }

        $fileserver = PropertyModel::findFirstByname("xmpp.file.server");
        if (!$fileserver)
            $this->view->fileserver = array('ip' => "",
                                        'cpu' => "",
                                        'ram' => "",
                                        'memory' => "",
                                        'status' => "");
        else {
            $fileserverIP = $fileserver->propValue;
            $this->persistent->fileserverIP = $fileserverIP;

            $fileserverInt = PropertyModel::findFirstByname("xmpp.file.server.internal");
            $fileserverIPInt = $fileserverInt->propValue;
            $this->persistent->fileserverIPInt = $fileserverIPInt;

            $info = json_decode($this->getServerInfo($fileserverIPInt, "443"), true);

            $this->view->fileserver = array('ip' => "$fileserverIP<br/>($fileserverIPInt)",
                                        'cpu' => $info['cpu'],
                                        'ram' => $info['ram'],
                                        'memory' => $info['memory'],
                                        'status' => $info['status']);
        }

        $subservers = PropertyModel::findFirstByname("xmpp.haproxy.sub.servers");
        $servers = explode(",", $subservers->propValue);
        foreach ($servers as $i => $server) {
            if ($server == "")
                unset($servers[$i]);
        }
        $this->persistent->servers = $servers;
        $xmpps = array();
        for ($i = 0 ; $i < count($servers) ; $i ++)
        {
            $res = $this->getServerInfo($servers[$i], "443");
            if ($res == "error")
                continue;
            $info = json_decode($res, true);
            $xmpps[] = ['ip' => $servers[$i],
                        'time' => $info['start_time'],
                        'cpu' => $info['cpu'],
                        'ram' => $info['ram'],
                        'memory' => $info['memory'],
                        'java' => $info['java'],
                        'status' => $info['status']];
        }
        $this->view->xmpps = $xmpps;
    }

    public function sipserverAction() {
        $this->assets->addJs("pages/scripts/server_sipserver.js");
        $this->assets->addCss("pages/css/server_sipserver.css");

        $this->assets->addJs("global/plugins/bootstrap-growl/jquery.bootstrap-growl.min.js");

        $kamIP = SipServerModel::findFirstByname("sip_main");
        $this->persistent->kamIP = $kamIP;
        if ($kamIP) {
            $info = json_decode($this->getKamServerInfo($kamIP->pubip, 1), true);
            $this->view->haproxy = array('ip' => "$kamIP->url<br/>($kamIP->pubip)",
                            'start_time' => $info['start_time'],
                            'cpu' => $info['cpu'],
                            'ram' => $info['ram'],
                            'memory' => $info['memory'],
                            'status' => $info['status']);
        } else {
            $this->view->haproxy = array('ip' => "",
                            'start_time' => "",
                            'cpu' => "",
                            'ram' => "",
                            'memory' => "",
                            'status' => "");
        }

        $subs = SipSubsModel::find();
        $this->persistent->subs = $subs;

        $sips = array();

        if ($subs) {
            foreach ($subs as $subserver) {
                $ip = explode(':', $subserver->destination)[1];
                $info = json_decode($this->getKamServerInfo($subserver->pubip, 1), true);
                $sips[] = array('ip' => "$ip<br/>($subserver->pubip)",
                                            'start_time' => $info['start_time'],
                                            'cpu' => $info['cpu'],
                                            'ram' => $info['ram'],
                                            'memory' => $info['memory'],
                                            'sync_call' => $info['sync_call'],
                                            'status' => $info['status']);
            }
        }

        $this->view->sips = $sips;
    }

    public function proxyserverAction() {
        $this->assets->addJs("pages/scripts/server_proxyserver.js");
        $this->assets->addCss("pages/css/server_proxyserver.css");

        $this->assets->addJs("global/plugins/bootstrap-growl/jquery.bootstrap-growl.min.js");

        $rtpengines = SipRtpModel::find();
        $this->persistent->rtpengines = $rtpengines;

        $proxys = array();

        if ($rtpengines) {
            foreach ($rtpengines as $rtpengine) {
                $ip = explode(':', $rtpengine->url)[1];
                $info = json_decode($this->getKamServerInfo($ip, 2), true);
                $proxys[] = array('ip' => "$ip<br/>($rtpengine->pubip)",
                                'start_time' => $info['start_time'],
                                'cpu' => $info['cpu'],
                                'ram' => $info['ram'],
                                'memory' => $info['memory'],
                                'status' => $info['status']);
            }
        }

        $this->view->proxys = $proxys;
    }

    public function updateServerInfoAction() {
        $result = array();

        if ($this->persistent->haproxyIP) {
            $haproxyIP = $this->persistent->haproxyIP;
            $haproxyIPInt = $this->persistent->haproxyIPInt;
            $info = json_decode($this->getServerInfo($haproxyIPInt, "81"));
            $result[] = array('ip' => "$haproxyIP<br/>($haproxyIPInt)",
                            'cpu' => $info->cpu,
                            'ram' => $info->ram,
                            'memory' => $info->memory,
                            'status' => $info->status);
        }

        if ($this->persistent->servers) {
            $servers = $this->persistent->servers;
            for ($i = 0 ; $i < count($servers) ; $i ++)
            {
                $info = json_decode($this->getServerInfo($servers[$i], "443"));
                $result[] = ['ip' => $servers[$i],
                            'time' => $info->start_time,
                            'cpu' => $info->cpu,
                            'ram' => $info->ram,
                            'memory' => $info->memory,
                            'java' => $info->java,
                            'status' => $info->status];
            }
        }

        if ($this->persistent->fileserverIP) {
            $fileserverIP = $this->persistent->fileserverIP;
            $fileserverIPInt = $this->persistent->fileserverIPInt;
            $info = json_decode($this->getServerInfo($fileserverIPInt, "443"));

            $result[] = array('ip' => "$fileserverIP<br/>($fileserverIPInt)",
                            'cpu' => $info->cpu,
                            'ram' => $info->ram,
                            'memory' => $info->memory,
                            'status' => $info->status);
        }

        echo json_encode($result);
        exit;
    }

    public function updateKamServerInfoAction() {
        $result = array();

        if ($this->persistent->kamIP) {
            $info = json_decode($this->getKamServerInfo($this->persistent->kamIP->url, 1), true);
            $result[] = array('ip' => $this->persistent->kamIP->url,
                                        'start_time' => $info['start_time'],
                                        'cpu' => $info['cpu'],
                                        'ram' => $info['ram'],
                                        'memory' => $info['memory'],
                                        'status' => $info['status']);
        }

        if ($this->persistent->subs) {
            foreach ($this->persistent->subs as $subserver) {
                $ip = explode(':', $subserver->destination)[1];
                $info = json_decode($this->getKamServerInfo($ip, 1), true);
                $result[] = array('ip' => $ip,
                                            'start_time' => $info['start_time'],
                                            'cpu' => $info['cpu'],
                                            'ram' => $info['ram'],
                                            'memory' => $info['memory'],
                                            'sync_call' => $info['sync_call'],
                                            'status' => $info['status']);
            }
        }

        echo json_encode($result);
        exit;
    }

    public function updateProxyServerInfoAction() {
        $proxys = array();

        if ($this->persistent->rtpengines) {
            foreach ($this->persistent->rtpengines as $rtpengine) {
                $ip = explode(':', $rtpengine->url)[1];
                $info = json_decode($this->getKamServerInfo($ip, 2), true);
                $proxys[] = array('ip' => $ip,
                                'start_time' => $info['start_time'],
                                'cpu' => $info['cpu'],
                                'ram' => $info['ram'],
                                'memory' => $info['memory'],
                                'status' => $info['status']);
            }
        }

        echo json_encode($proxys);
        exit;
    }

    public function addXmppServerAction() {
        $serverIp = $this->request->getPost("serverIp");
        $splits = explode(".", $serverIp);
        $res = "error";
        if (count($splits) == 4) {
            foreach ($splits as $split) {
                if (intval($split) < 0 || intval($split) > 255) {
                    echo $res;exit;
                }
            }
            $xmppServer = PropertyModel::findFirstByname("xmpp.haproxy.sub.servers");
            if (!$xmppServer) {
                $xmppServer = new PropertyModel();
                $xmppServer->name = "xmpp.haproxy.sub.servers";
                $xmppServer->propValue = $serverIp;
            } else {
                if (!strstr($xmppServer->propValue, $serverIp)) {
                    if ($xmppServer->propValue != "")
                        $xmppServer->propValue = $xmppServer->propValue . ',' . $serverIp;
                    else
                        $xmppServer->propValue = $xmppServer->propValue . $serverIp;
                }
            }
            if ($xmppServer->save())
                $res = "success";
        }
        echo $res;
        exit;
    }

    public function editHaproxyServerAction() {
        $serverIpExt = $this->request->getPost("serverIpExt");
        $serverIpInt = $this->request->getPost("serverIpInt");
        $splits1 = explode(".", $serverIpExt);
        $splits2 = explode(".", $serverIpInt);
        $res = "error";
        if (count($splits1) == 4 && count($splits2) == 4) {
            foreach ($splits1 as $split) {
                if (intval($split) < 0 || intval($split) > 255) {
                    echo $res;
                    exit;
                }
            }
            foreach ($splits2 as $split) {
                if (intval($split) < 0 || intval($split) > 255) {
                    echo $res;
                    exit;
                }
            }
            
            $haproxyServer = PropertyModel::findFirstByname("xmpp.haproxy.server");
            if (!$haproxyServer) {
                $haproxyServer = new PropertyModel();
                $haproxyServer->name = "xmpp.haproxy.server";
            }
            $haproxyServer->propValue = $serverIpExt;
            if ($haproxyServer->save()){
                $haproxyServerInt = PropertyModel::findFirstByname("xmpp.haproxy.server.internal");
                if (!$haproxyServerInt) {
                    $haproxyServerInt = new PropertyModel();
                    $haproxyServerInt->name = "xmpp.haproxy.server.internal";
                }
                $haproxyServerInt->propValue = $serverIpInt;
                if ($haproxyServerInt->save())
                    $res = "success";
            }
        }
        echo $res;
        exit;
    }

    public function editFileServerAction() {
        $serverIpExt = $this->request->getPost("serverIpExt");
        $serverIpInt = $this->request->getPost("serverIpInt");
        $splits1 = explode(".", $serverIpExt);
        $splits2 = explode(".", $serverIpInt);
        $res = "error";
        if (count($splits1) == 4 && count($splits2) == 4) {
            foreach ($splits1 as $split) {
                if (intval($split) < 0 || intval($split) > 255) {
                    echo $res;
                    exit;
                }
            }
            foreach ($splits2 as $split) {
                if (intval($split) < 0 || intval($split) > 255) {
                    echo $res;
                    exit;
                }
            }
            $xmppServer = PropertyModel::findFirstByname("xmpp.file.server");
            if (!$xmppServer) {
                $xmppServer = new PropertyModel();
                $xmppServer->name = "xmpp.file.server";
            }
            $xmppServer->propValue = $serverIpExt;
            if ($xmppServer->save()) {
                $xmppServerInt = PropertyModel::findFirstByname("xmpp.file.server.internal");
                if (!$xmppServerInt) {
                    $xmppServerInt = new PropertyModel();
                    $xmppServerInt->name = "xmpp.file.server.internal";
                }
                $xmppServerInt->propValue = $serverIpInt;
                if ($xmppServerInt->save())
                    $res = "success";
            }
        }
        echo $res;
        exit;
    }

    public function editSipHaproxyServerAction() {
        $serverIpExt = $this->request->getPost("serverIpExt");
        $serverIpInt = $this->request->getPost("serverIpInt");
        $splits1 = explode(".", $serverIpExt);
        $splits2 = explode(".", $serverIpInt);
        $res = "error";
        if (count($splits1) == 4 && count($splits2) == 4) {
            foreach ($splits1 as $split) {
                if (intval($split) < 0 || intval($split) > 255) {
                    echo $res;
                    exit;
                }
            }
            foreach ($splits2 as $split) {
                if (intval($split) < 0 || intval($split) > 255) {
                    echo $res;
                    exit;
                }
            }
            $sipServer = SipServerModel::findFirstByname("sip_main");
            if (!$sipServer) {
                $sipServer = new SipServerModel();
                $sipServer->name = "sip_main";
            }
            $sipServer->url = $serverIpExt;
            $sipServer->pubip = $serverIpInt;
            if ($sipServer->save())
                $res = "success";
            foreach ($sipServer->getMessages() as $message) {
                echo $message;
            }
        }
        echo $res;
        exit;
    }

    public function addSipServerAction() {
        $serverIpExt = $this->request->getPost("serverIpExt");
        $serverIpInt = $this->request->getPost("serverIpInt");
        $splits1 = explode(".", $serverIpExt);
        $splits2 = explode(".", $serverIpInt);
        $res = "error";
        if (count($splits1) == 4 && count($splits2) == 4) {
            foreach ($splits1 as $split) {
                if (intval($split) < 0 || intval($split) > 255) {
                    echo $res;exit;
                }
            }
            foreach ($splits2 as $split) {
                if (intval($split) < 0 || intval($split) > 255) {
                    echo $res;exit;
                }
            }
            $destination = "sip:" . $serverIpExt;
            /*
            $sipServer = SipSubsModel::findFirstBydestination($destination);
            if (!$sipServer) {
                $sipServer = new SipSubsModel();
                $sipServer->setid = 1;
                $sipServer->destination = $destination;
                $sipServer->pubip = $serverIpInt;
                if ($sipServer->save())
                    $res = "success";
                foreach ($sipServer->getMessages() as $message) {
                    echo $message;
                }
            }*/
            $ret = "";
            $data = array('action' => "insert",
                        'setid' => "1",
                        'destination' => $destination,
                        'pubip' => $serverIpInt);
            $params = http_build_query($data);
            $s = curl_init();
            curl_setopt($s, CURLOPT_SSL_VERIFYPEER, FALSE);
            curl_setopt($s, CURLOPT_HEADER, 0);
            curl_setopt($s, CURLOPT_URL, $this->kamSetUrl);
            curl_setopt($s, CURLOPT_POST, 1);
            curl_setopt($s, CURLOPT_POSTFIELDS, $params);
            curl_setopt($s, CURLOPT_RETURNTRANSFER, 1);
            $ret =  curl_exec($s);
            curl_close($s);
        }
        if ($ret == "Y")
            $res = "success";
        echo $res;
        exit;
    }

    public function deleteXmppAction() {
        $serverIp = $this->request->getPost("serverip");
        $servers = PropertyModel::findFirstByname("xmpp.haproxy.sub.servers");
        $res = "error";
        if ($servers && strstr($servers->propValue, $serverIp)) {
            $splits = explode(',', $servers->propValue);
            $newValue = "";
            foreach ($splits as $i => $split) {
                if ($split == "")
                    unset($splits[$i]);
                else if (strcmp($split, $serverIp) != 0)
                    $newValue .= ($split . ',');
            }
            if ($newValue != "")
                $newValue = substr($newValue, 0, -1);
            $servers->propValue = $newValue;
            if ($servers->save())
                $res = "success";
            foreach ($servers->getMessages() as $message)
                echo $message;
        }
        echo $res;
        exit;
    }

    public function deleteSipAction() {
        $serverIp = $this->request->getPost("serverip");
        $splits1 = explode("<br/>", $serverIp);
        $destination = "sip:" . $splits1[0];
        //$destination = "sip:" . $serverIp;
        /*$sipServer = SipSubsModel::findFirstByname($destination);
        $res = "error";
        if ($sipServer) {
            if ($sipServer->delete())
                $res = "success";
            foreach ($sipServer->getMessages() as $message)
                echo $message;
        }
        echo $res;
        exit;*/

        $data = array('action' => "delete",
                    'destination' => $destination);
        $params = http_build_query($data);
        $s = curl_init();
        curl_setopt($s, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($s, CURLOPT_HEADER, 0);
        curl_setopt($s, CURLOPT_URL, $this->kamSetUrl);
        curl_setopt($s, CURLOPT_POST, 1);
        curl_setopt($s, CURLOPT_POSTFIELDS, $params);
        curl_setopt($s, CURLOPT_RETURNTRANSFER, 1);
        $ret =  curl_exec($s);
        curl_close($s);
        $res = "error";
        if ($ret == "Y")
            $res = "success";
        echo $res;
        exit;
    }

    public function addProxyServerAction() {
        $serverIpExt = $this->request->getPost("serverIpExt");
        $serverIpInt = $this->request->getPost("serverIpInt");
        $splits1 = explode(".", $serverIpExt);
        $splits2 = explode(".", $serverIpInt);
        $res = "error";
        if (count($splits1) == 4 && count($splits2) == 4) {
            foreach ($splits1 as $split) {
                if (intval($split) < 0 || intval($split) > 255) {
                    echo $res;exit;
                }
            }
            foreach ($splits2 as $split) {
                if (intval($split) < 0 || intval($split) > 255) {
                    echo $res;exit;
                }
            }
            
            $url = "udp:" . $serverIpExt . ":2223";echo $url;
            /*$proxyServer = SipRtpModel::findFirstByurl($url);
            if (!$proxyServer) {
                $proxyServer = new SipRtpModel();
                $proxyServer->setid = 0;
                $proxyServer->url = $url;
                $proxyServer->weight = 1;
                $proxyServer->disabled = 0;
                $proxyServer->pubip = $serverIpInt;
                if ($proxyServer->save())
                    $res = "success";
                foreach ($proxyServer->getMessages() as $message)
                    echo $message;
            }*/

            $ret = "";
            $data = array('action' => "insert",
                        'setid' => "0",
                        'url' => $url,
                        'weight' => "1",
                        'disabled' => "0",
                        'pubip' => $serverIpInt);
            $params = http_build_query($data);
            $s = curl_init();
            curl_setopt($s, CURLOPT_SSL_VERIFYPEER, FALSE);
            curl_setopt($s, CURLOPT_HEADER, 0);
            curl_setopt($s, CURLOPT_URL, $this->proxySetUrl);
            curl_setopt($s, CURLOPT_POST, 1);
            curl_setopt($s, CURLOPT_POSTFIELDS, $params);
            curl_setopt($s, CURLOPT_RETURNTRANSFER, 1);
            $ret =  curl_exec($s);
            curl_close($s);
            if ($ret == "Y")
                $res = "success";
        }
        echo $res;
        exit;
    }

    public function deleteProxyAction() {
        $serverIp = $this->request->getPost("serverip");
        $splits1 = explode("<br/>", $serverIp);
        $url = "udp:" . $splits1[0] . ":2223";
        /*$proxyServer = SipRtpModel::findFirstByurl($url);
        $res = "error";
        if ($proxyServer) {
            if ($proxyServer->delete())
                $res = "success";
            foreach ($proxyServer->getMessages() as $message)
                echo $message;
        }
        echo $res;
        exit;*/
        
        $data = array('action' => "delete",
                    'url' => $url);
        $params = http_build_query($data);
        $s = curl_init();
        curl_setopt($s, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($s, CURLOPT_HEADER, 0);
        curl_setopt($s, CURLOPT_URL, $this->proxySetUrl);
        curl_setopt($s, CURLOPT_POST, 1);
        curl_setopt($s, CURLOPT_POSTFIELDS, $params);
        curl_setopt($s, CURLOPT_RETURNTRANSFER, 1);
        $ret =  curl_exec($s);
        curl_close($s);
        $res = "error";
        if ($ret == "Y")
            $res = "success";
        echo $res;
        exit;
    }

    public function irregularAction() {
        $this->assets->addJs("global/plugins/datatables/datatables.js");
        $this->assets->addJs("global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.js");
        $this->assets->addJs("global/plugins/bootstrap-datepicker/js/bootstrap-datepicker.min.js");
        $this->assets->addJs("pages/scripts/localization.js");
        
        $this->assets->addJs("pages/scripts/server_irregular.js");
        $this->assets->addCss("pages/css/server_irregular.css");
        $this->assets->addCss("global/plugins/datatables/datatables.css");

        $this->assets->addJs("global/plugins/bootstrap-growl/jquery.bootstrap-growl.min.js");

        $regular_list = IrregularModel::find();
        $this->view->words = $regular_list;
    }

    public function saveregularAction() {
        $this->view->disable();
        if ($this->request->isPost()) {
            $id = $this->request->getPost('id', 'int');
            $word = trim($this->request->getPost('word', 'striptags'));
            $replace = trim($this->request->getPost('replace', 'striptags'));
            $word_data = IrregularModel::findFirstById($id);
            if ($word_data) {
                $word_data->word = $word;
                $word_data->replace = $replace;
                $word_data->date = new RawValue('now()');
                $result = $word_data->save();
            } else {
                $word_data = new IrregularModel();
                $word_data->word = $word;
                $word_data->replace = $replace;
                $word_data->date = new RawValue('now()');
                $result = $word_data->save();
            }
            echo json_encode(array('result' => $result));
        }
    }

    public function deleteRegularAction()
    {
        $this->view->disable();
        if ($this->request->isPost()) {
            $id = $this->request->getPost("id");
            $ids = json_decode($id);
            if (is_array($ids)) {
                foreach ($ids as $index) {
                    $word_data = IrregularModel::findFirstById($index);
                    $word_data->delete();
                }
            } else {
                $word_data = IrregularModel::findFirstById($id);
                $word_data->delete();
            }
            echo json_encode(true);
        }
    }
  
    public function mimetypeAction() {
        $this->assets->addJs("global/plugins/datatables/datatables.js");
        $this->assets->addJs("global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.js");
        $this->assets->addJs("global/plugins/bootstrap-datepicker/js/bootstrap-datepicker.min.js");
        $this->assets->addJs("pages/scripts/localization.js");
        
        $this->assets->addJs("pages/scripts/server_mimetype.js");
        $this->assets->addCss("pages/css/server_mimetype.css");
        $this->assets->addCss("global/plugins/datatables/datatables.css");

        $this->assets->addJs("global/plugins/bootstrap-growl/jquery.bootstrap-growl.min.js");
        $mimetype_list = MimetypeModel::find();
        $this->view->mimetypes = $mimetype_list;
    }

    public function getmimetypeAction()
    {
        $this->view->disable();
        if ($this->request->isPost()) {
            $target_id = $this->request->getPost("target_id", "int");
            $target = MimetypeModel::findFirstById($target_id);
            if ($target) {
                $list = array(
                    "id" => $target->id,
                    "mimetype" => $target->mimetype,
                    "desc" => $target->extension,
                    "maxsize" => $target->maxSize,
                    "allow" => $target->allow
                );
                echo json_encode($list);
            }
        }
    }

    public function allowmimetypeAction()
    {
        $this->view->disable();
        if ($this->request->isPost()) {
            $allow_flag = $this->request->getPost("allow_flag");
            $target_id = $this->request->getPost("target_id", "int");
            $target = MimetypeModel::findFirstById($target_id);
            if ($target) {
                $target->allow = ($allow_flag == 'true') ? "Y" : "N";
                $target->save();
            }
        }
    }

    public function savemimetypeAction() {
        $this->view->disable();
        if ($this->request->isPost()) {
            $id = $this->request->getPost('id', 'int');
            $mimetype = trim($this->request->getPost('mimetype', 'striptags'));
            $extension = trim($this->request->getPost('extension', 'striptags'));
            $maxsize = trim($this->request->getPost('maxsize', 'int'));
            $allow = $this->request->getPost('allow');
            $mimetype_data = MimetypeModel::findFirstById($id);
            if ($mimetype_data) {
                $mimetype_data->mimetype = $mimetype;
                $mimetype_data->extension = $extension;
                $mimetype_data->maxSize = $maxsize;
                $mimetype_data->allow = $allow;
                $result = $mimetype_data->save();
            } else {
                $mimetype_data = new MimetypeModel();
                $mimetype_data->mimetype = $mimetype;
                $mimetype_data->extension = $extension;
                $mimetype_data->maxSize = $maxsize;
                $mimetype_data->allow = $allow;
                $result = $mimetype_data->save();
            }
            echo json_encode(array('result' => $result));
        }
    }

    public function deleteMimetypeAction()
    {
        $this->view->disable();
        if ($this->request->isPost()) {
            $id = $this->request->getPost("id");
            $ids = json_decode($id);
            if (is_array($ids)) {
                foreach ($ids as $index) {
                    $mimetype_data = MimetypeModel::findFirstById($index);
                    $mimetype_data->delete();
                }
            } else {
                $mimetype_data = MimetypeModel::findFirstById($id);
                $mimetype_data->delete();
            }
            echo json_encode(true);
        }
    }
}
