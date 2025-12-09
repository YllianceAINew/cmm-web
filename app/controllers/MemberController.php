<?php
require_once ('PHPOpenfireUchatservice/PHPOpenfireUchatservice.php');
use Jestillore\PHPOpenfireUchatservice\PHPOpenfireUchatservice;
use Phalcon\Config\Adapter\Ini as ConfigIni;
class MemberController extends ControllerUIBase
{
    public function initialize()
    {
        $this->tag->setTitle($this->lang['menu_registration']);
        $this->view->setLayout('adminlte');
        parent::initialize();
    	$this->prefix = "ub000000000";
    	$this->kamPrefix= "000000000";
        $this->g_rest_key = "wDM73kNo";

        $config = new ConfigIni(APP_PATH . 'app/config/config.ini');
        $this->sipServerAddr = $config->protocol->prefix . $config->setAddress->sipServerAddr;
        $this->userserviceAddr = $config->setAddress->userserviceAddr;
        $this->addSipUserUrl = $this->sipServerAddr.'/kamailio/addSIPUser.php';
        $this->delSipUserUrl = $this->sipServerAddr.'/kamailio/delSIPUser.php';
        $this->addGroupUrl = $this->sipServerAddr.'/kamailio/addGroup.php';
        $this->delGroupUrl = $this->sipServerAddr.'/kamailio/delGroup.php';
        $this->rest_url = "http://".$this->userserviceAddr.":9090/plugins/userService";
        $this->userservice = $this->getUserService();

    }
    public function indexAction ()
    {}

    public function summaryAction($sentFrom = "",$sentTo = "",$id = "",$name = "",$phone = "",$select = "all")
    {
        // AdminLTE3 DataTables libraries
        $this->assets->addJs("adminlte/plugins/datatables/jquery.dataTables.min.js");
        $this->assets->addJs("adminlte/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js");
        $this->assets->addJs("adminlte/plugins/datatables-responsive/js/dataTables.responsive.min.js");
        $this->assets->addJs("adminlte/plugins/datatables-responsive/js/responsive.bootstrap4.min.js");
        $this->assets->addJs("adminlte/plugins/datatables-buttons/js/dataTables.buttons.min.js");
        $this->assets->addJs("adminlte/plugins/datatables-buttons/js/buttons.bootstrap4.min.js");
        $this->assets->addJs("adminlte/plugins/jszip/jszip.min.js");
        $this->assets->addJs("adminlte/plugins/pdfmake/pdfmake.min.js");
        $this->assets->addJs("adminlte/plugins/pdfmake/vfs_fonts.js");
        $this->assets->addJs("adminlte/plugins/datatables-buttons/js/buttons.html5.min.js");
        $this->assets->addJs("adminlte/plugins/datatables-buttons/js/buttons.print.min.js");
        $this->assets->addJs("adminlte/plugins/datatables-buttons/js/buttons.colVis.min.js");
        
        $this->assets->addJs("global/plugins/bootstrap-datepicker/js/bootstrap-datepicker.min.js");
        $this->assets->addJs("pages/scripts/member_summary.js");
        $this->assets->addJs("pages/scripts/components-date-time-pickers.min.js");
        
        // AdminLTE3 DataTables CSS
        $this->assets->addCss("adminlte/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css");
        $this->assets->addCss("adminlte/plugins/datatables-responsive/css/responsive.bootstrap4.min.css");
        $this->assets->addCss("adminlte/plugins/datatables-buttons/css/buttons.bootstrap4.min.css");
        $this->assets->addCss("global/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css");
        $this->assets->addCss("pages/css/member_summary.css");

        $sentFrom = substr($sentFrom, 5, strlen($sentFrom) - 5);
        $sentTo = substr($sentTo, 3, strlen($sentTo) - 3);
        $id = substr($id, 3, strlen($id) - 3);
        $select = substr($select, 5, strlen($select) - 5);
        $name = substr($name, 5, strlen($name) - 5);
        $phone = substr($phone, 6, strlen($phone) - 6);
        
        $cond = "username != 'admin' AND state = 1 AND ";

        if ($sentFrom != "")
            $cond .= "created >= '" . $sentFrom . "' AND ";
        if ($sentTo != "")
            $cond .= "created <= '" . $sentTo . " 23:59:59' AND ";
        if ($id != "")
            $cond .= "userid LIKE '%".$id."%' AND ";
        if ($name != "")
            $cond .= "name LIKE '%".$name."%' AND ";
        if ($phone != "")
            $cond .= "phone LIKE '%".$phone."%' AND ";
        if($cond != "")
            $cond = substr($cond, 0, strlen($cond) - 4);

        $list = UserMemberModel::find(["conditions" => $cond]);

        if($select == "all" || $select == "")
            $members = $list;
        else{
            $members = [];
            foreach ($list as $member) {
                $splits = explode(":", $member->UserListModel->email);
                if($splits[0]== $select)
                    $members[] = $member;
            }
        }

        $this->view->members =$members;

    }
    
    public function detailAction($username = "") {
        $this->assets->addCss("global/plugins/bootstrap-select/css/bootstrap-select.min.css");
        $this->assets->addCss("pages/css/member_detail.css");
        $this->assets->addJs("global/plugins/bootstrap-select/js/bootstrap-select.min.js");
        $this->assets->addJs("pages/scripts/member_detail.js");
        if ($username == "")
            $this->request->forward("member/summary");
        $member = UserMemberModel::findFirstByusername($username);
        $this->view->member = $member;
        $levels = LevelDetailModel::find(["order" => "level"]);
        $levelSet = [];
        foreach ($levels as $level) {
            $levelSet[] = $level->level;
        }
        $this->view->lvSet = $levelSet;
    }
    public function getUserService() {
        $us = new PHPOpenfireUchatservice;
        $us->setEndpoint($this->rest_url);
        $us->setAuthType(PHPOpenfireUchatservice::AUTH_SHARED_KEY)->setSharedKey($this->g_rest_key);
        return $us;
    }
    public function saveEditAction() {
        $username = $this->request->getPost("username");
        $level = $this->request->getPost("level");
        $isblock = $this->request->getPost("isBlock");

        if (!$level || !$isblock)
            exit;

        /////////////////////    UserDetail     ////////////
        $member = UserMemberModel::findFirstByusername($username);
        $member->level = $level;
        $member->save();

        $email = ($isblock == "true" ? "1" : "0");
        $email = $email . ":" . $level;

        ////////////////////   UserService   ///////////////////////
        $user = $this->userservice->getUser($username);
        $user["email"] = $email;
        $this->userservice->updateUser($username, $user);

        $splits = explode("/", $user["name"]);
        if (count($splits) == 4) {
            $msi = $splits[2];
            $phone = $splits[1];
            $imei = $splits[3];
            $nickname = $splits[0];
            $lastuid = substr($username, 2, strlen($username) - 2);
            $data = array('user' => $lastuid,'secret' => $lastuid,'realm' => $this->sipServerAddr,'phone'=> $phone, 'imsi' => $msi, 'userinfo' => $nickname,'groupid' => $level);
            $params = http_build_query($data);
            $s = curl_init();
            curl_setopt($s, CURLOPT_HEADER, 1);
            curl_setopt($s, CURLOPT_SSL_VERIFYPEER, FALSE);
            curl_setopt($s, CURLOPT_URL, $this->addSipUserUrl);
            curl_setopt($s, CURLOPT_POST, 1);
            curl_setopt($s, CURLOPT_POSTFIELDS, $params);
            curl_setopt($s, CURLOPT_RETURNTRANSFER, 1);
            curl_exec($s);
            curl_close($s);
        }
        exit;
    }

    public function deleteMemberAction() {
        $id = $this->request->getPost("ID");
        if ($id) {
            $member = UserMemberModel::findFirstByid($id);
            if (!$this->userservice->getUser($member->username)){
                echo "error";
                exit;
            }

            /////////////     delete sip user    ///////////
            $kamId = $member->username; // $this->kamPrefix . trim ($id);
            if (empty ($kamId)) {
               $errcode = '1';
            } else {
                $data = array('user' => $kamId);
                $params = http_build_query($data);
                $s = curl_init();
                curl_setopt($s, CURLOPT_HEADER, 1);
                curl_setopt($s, CURLOPT_SSL_VERIFYPEER, FALSE);
                curl_setopt($s, CURLOPT_URL, $this->delSipUserUrl);
                curl_setopt($s, CURLOPT_POST, 1);
                curl_setopt($s, CURLOPT_POSTFIELDS, $params);
                curl_setopt($s, CURLOPT_RETURNTRANSFER, 1);
                $ret = curl_exec($s);
                curl_close($s);
            }

            /////////////     delete xmpp user    ///////////
            if ($member->username != "admin") {
                $this->userservice->deleteUser($member->username);
                $member->delete();
            }
            exit;
        } else {
            $ids = $this->request->getPost("ids");
            foreach ($ids as $id) {
                $member = UserMemberModel::findFirstByid($id);

                if (!$this->userservice->getUser($member->username)){
                    echo "error";
                    exit;
                }
                /////////////     delete sip user    ///////////
                $kamId = $member->username; // $this->kamPrefix . trim ($id);

                if (empty ($kamId)) {
                   $errcode = '1';
                } else {
                    // $data = array('user' => $kamId);
                    $data = array('user' => $member->username);
                    $params = http_build_query($data);
                    $s = curl_init();
                    curl_setopt($s, CURLOPT_HEADER, 1);
                    curl_setopt($s, CURLOPT_SSL_VERIFYPEER, FALSE);
                    curl_setopt($s, CURLOPT_URL, $this->delSipUserUrl);
                    curl_setopt($s, CURLOPT_POST, 1);
                    curl_setopt($s, CURLOPT_POSTFIELDS, $params);
                    curl_setopt($s, CURLOPT_RETURNTRANSFER, 1);
                    $ret = curl_exec($s);
                    curl_close($s);
                }

                /////////////     delete xmpp user    ///////////
                if ($member->username != "admin") {
                    $this->userservice->deleteUser($member->username);
                    $member->delete();
                }
            }
        }
        exit;
    }

    public function setlevelAction()
    {   
        $this->assets->addCss("pages/css/member_setlevel.css");

        $levels = LevelDetailModel::find(["order" => "level"]);
        $levelSet = [];
        foreach ($levels as $level) {
            $levelSet[] = $level->level;
        }

        $this->view->lvSet = $levelSet;
        
        $this->assets->addJs("pages/scripts/member_setlevel.js");
        $strArr = [];
        foreach ($levels as $level) {
            $strArr[] = explode(",", $level->callableLevel);
        }

        $this->view->strArr = json_encode($strArr);
    }

    public function levelChangedAction() {
        $chks = $this->request->getPost("chks");
        $levelNo = $this->request->getPost("level");
        if (!$levelNo) exit;
        $string = "";
        for ($i = 0 ; $i < count($chks) ; $i ++)
            $string = $string . $chks[$i] . ',';
        $string = substr($string, 0, strlen($string)-1);

        $level = LevelDetailModel::findFirstBylevel($levelNo);
        if ($level) {
            $level->callableLevel = $string;
            if ($level->save())
                echo "success";
        }
        else
            echo "error";
        ///     change level traff of kamailio server  ///
        $data = array('groupid' => $levelNo, 'traff' => $string);
        $params = http_build_query($data);
        $s = curl_init();
        curl_setopt($s, CURLOPT_HEADER, 1);
        curl_setopt($s, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($s, CURLOPT_URL, $this->addGroupUrl);
        curl_setopt($s, CURLOPT_POST, 1);
        curl_setopt($s, CURLOPT_POSTFIELDS, $params);
        curl_setopt($s, CURLOPT_RETURNTRANSFER, 1);
        curl_exec($s);
        curl_close($s);
        $this->userservice->reloadLevel();
        exit;
    }

    //          ici 2018.6.19          //
    //          급수목록                //
    public function levelListAction() {
        $this->assets->addCss("pages/css/member_levelist.css");

        $this->assets->addJs("pages/scripts/member_levelList.js");
        $levels = LevelDetailModel::find(["order" => "level"]);
        $this->view->levels = $levels->toArray();
    }

    public function BlockAction(){
        $no = $this->request->getPost("levNo");
        $levState = $this->request->getPost("levelState");

        $level = LevelDetailModel::findFirstBylevel($no);
        if($level){
            $level->levelState = $levState == "true" ? 1 : 0;
            if($level->save()){
                $this->userservice->reloadLevel();
                echo "success";
                exit;
            }
        }
        echo "error";
        exit;
    }
    //     ici 2018.6.20      //
    //        급수추가        //
    public function insertLevelAction(){
        $no = $this->request->getPost("levNo");
        $name = $this->request->getPost("levName");
        $desc = $this->request->getPost("levDesc");
        if (!$no || !$name || !$desc)
            exit;
        $level = LevelDetailModel::findFirstBylevel($no);
        if ($level){
            echo "error";   // level already exist
            exit;
        }
        $level = new LevelDetailModel();
        $level->level = $no;
        $level->levelName = $name;
        $level->levelDescription = $desc;
        $level->callableLevel = $no;
        if ($level->save()) {
            echo "success";
        }
        ////     add level to kamailio server  ///
        $data = array('groupid' => $no, 'traff' => $no);
        $params = http_build_query($data);
        $s = curl_init();
        curl_setopt($s, CURLOPT_HEADER, 1);
        curl_setopt($s, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($s, CURLOPT_URL, $this->addGroupUrl);
        curl_setopt($s, CURLOPT_POST, 1);
        curl_setopt($s, CURLOPT_POSTFIELDS, $params);
        curl_setopt($s, CURLOPT_RETURNTRANSFER, 1);
        curl_exec($s);
        curl_close($s);

        $this->userservice->reloadLevel();
        exit;
    }
    //     ici 2018.6.20      //
    //        급수편집        //
    public function editLevelAction(){
        $no = $this->request->getPost("levNo");
        $name = $this->request->getPost("levName");
        $desc = $this->request->getPost("levDesc");
        if (!$no || !$name || !$desc)
            exit;
        $level = LevelDetailModel::findFirstBylevel($no);

        if (!$level){
            echo "error";   // level no exist
            exit;
        }
        $level->levelName = $name;
        $level->levelDescription = $desc;
        if ($level->save())
            echo "success";
        else
            echo "error";
        $this->userservice->reloadLevel(); 
        exit;
    }
    //     ici 2018.6.20      //
    //        급수삭제        //
    public function removeLevelAction(){
        if ($this->request->hasPost("levNo")){
            $no = $this->request->getPost("levNo");
            if (!$no)
                exit;
            $level = LevelDetailModel::findFirstBylevel($no);
            if ($level->delete())
                echo "success";
            else
                echo "error";
            ///     remove level to kamailio server  ///
            $data = array('groupid' => $no);
            $params = http_build_query($data);
            $s = curl_init();
            curl_setopt($s, CURLOPT_HEADER, 1);
            curl_setopt($s, CURLOPT_SSL_VERIFYPEER, FALSE);
            curl_setopt($s, CURLOPT_URL, $this->delGroupUrl);
            curl_setopt($s, CURLOPT_POST, 1);
            curl_setopt($s, CURLOPT_POSTFIELDS, $params);
            curl_setopt($s, CURLOPT_RETURNTRANSFER, 1);
            curl_exec($s);
            curl_close($s);
        }else if ($this->request->hasPost("levNos")){
            $levels = $this->request->getPost("levNos");
            if (count($levels) == 0)
                exit;
            foreach ($levels as $no) {
                $level = LevelDetailModel::findFirstBylevel($no);
                if ($level->delete())
                    echo "success";
                else
                    echo "error";
                ///     remove level to kamailio server  ///
                $data = array('groupid' => $no);
                $params = http_build_query($data);
                $s = curl_init();
                curl_setopt($s, CURLOPT_HEADER, 1);
                curl_setopt($s, CURLOPT_SSL_VERIFYPEER, FALSE);
                curl_setopt($s, CURLOPT_URL, $this->delGroupUrl);
                curl_setopt($s, CURLOPT_POST, 1);
                curl_setopt($s, CURLOPT_POSTFIELDS, $params);
                curl_setopt($s, CURLOPT_RETURNTRANSFER, 1);
                curl_exec($s);
                curl_close($s);
            }
        }

        $this->userservice->reloadLevel();
        exit;
    }
    //          ici 2018.6.19          //
    //          가입자등록신청접수        //
    public function registerAction() {
        $this->assets->addCss("pages/css/member_register.css");
        $this->assets->addCss("global/plugins/datatables/datatables.css");

        $this->assets->addJs("global/plugins/datatables/datatables.js");
        $this->assets->addJs("global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.js");
        $this->assets->addJs("pages/scripts/member_register.js");
        $users = UserMemberModel::findBystate("-1");
        $this->view->users = $users;
    }

    //          ici 2018.6.19          //
    //          가입자등록상세정보        //
    public function regDetailAction($id = -1) {
        $this->assets->addCss("pages/css/member_regdetail.css");
        $this->assets->addJs("pages/scripts/member_regdetail.js");
        if ($id == -1)
            $this->request->forward("member/register");
        $user = UserMemberModel::findFirstByusername($id);
        $this->view->user = $user;
        $levels = LevelDetailModel::find(["order" => "level"]);
        $levelSet = [];
        foreach ($levels as $level) {
            $levelSet[] = $level->level;
        }
        $this->view->lvSet = $levelSet;
        $this->persistent->regID = $id;
    }

    public function regCancelAction() {
        if ($this->persistent->regID) {
            $user = UserMemberModel::findFirstByusername($this->persistent->regID);
            if($user){
                if ($user->delete())
                    echo "success";
                else
                    echo "error";
            }
            exit;
        }
    }

    public function regAllowAction() {
        if ($this->request->isPost()) {
            $groupid = $this->request->getPost("groupid");
            $userid = $this->request->getPost("userid");
            $regUser = UserMemberModel::findFirstByusername($userid);

            $presence = new PresencesModel();
            $presence->username = $regUser->username;
            $presence->offlinePresence = NULL;
            $presence->offlineDate = -1;
            $presence->save();

            $res = $this->connect_KamandOpenfire($regUser,$groupid);
            echo $res;
            exit;
        }
    }

    public function regSelCancelAction(){
        if($this->request->hasPost("ids")){
            $ids = $this->request->getPost("ids");
            foreach ($ids as $id) {
                $user = UserMemberModel::findFirstByusername($id);
                if($user)
                    $user->delete();
            }
            echo "success";
            exit;
        }
        echo "error";
        exit;
    }

    public function regSelAllowAction(){
        if($this->request->hasPost("ids")){
            $ids = $this->request->getPost("ids");
            foreach ($ids as $id) {
                $regUser = UserMemberModel::findFirstByusername($id);

                $presence = new PresencesModel();
                $presence->username = $regUser->username;
                $presence->offlinePresence = NULL;
                $presence->offlineDate = -1;
                $presence->save();

                $this->connect_KamandOpenfire($regUser, 1);    
            }
            echo "success";
            exit;
        }

    }

    public function connect_KamandOpenfire($regUser,$groupid){
        ////////        create xmpp user     //////////////

            $us = $this->userservice;
            $user = $us->getUser($regUser->username);
            $allname = $regUser->name."/".$regUser->phone."/".$regUser->imsi."/".$regUser->imei;
            $email = "0:" . $groupid;

            if (empty($user['exception'])) {
                $user['password'] = $regUser->apikey;
                $res1 = $us->updateUser($regUser->username,$user);
            } else {
                $user = array(
                    'username' => $regUser->username,
                    'password' => $regUser->apikey,
                    'name' => $allname,
                    'email' => $email,
                );
                $res1 = $us->createUser($user);
            }

        ////////        create sip user     ///////////////

            $kamId = $regUser->username; // $this->kamPrefix . trim ($regUser->id);

            $data = array('user' => $kamId, 'secret' => $regUser->password, 'realm' => $this->sipServerAddr, 'phone'=> $regUser->phone, 'imsi' => $regUser->imsi, 'userinfo' => $regUser->name, 'groupid' => $groupid);
            $params = http_build_query($data);

            $s = curl_init();
            curl_setopt($s, CURLOPT_HEADER, 1);
            curl_setopt($s, CURLOPT_SSL_VERIFYPEER, FALSE);
            curl_setopt($s, CURLOPT_URL, $this->addSipUserUrl);
            curl_setopt($s, CURLOPT_POST, 1);
            curl_setopt($s, CURLOPT_POSTFIELDS, $params);
            curl_setopt($s, CURLOPT_RETURNTRANSFER, 1);
            $res2 = curl_exec($s);
            curl_close($s);

        /////////////     update user state in db    /////////////
            $regUser->state = 1;
            $regUser->level = $groupid;
            $regUser->created = /*'unix_timestamp'*/time();
            $regUser->save();

            foreach ($regUser->getMessages() as $message) {
                echo $message;
            }
    }
}
