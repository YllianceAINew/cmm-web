<?php
use Phalcon\Config\Adapter\Ini as ConfigIni;

class LogController extends ControllerUIBase
{
    public function initialize()
    {
        $this->tag->setTitle($this->lang['menu_account']);
        $this->view->setLayout('adminlte');
        parent::initialize();
        
        $config = new ConfigIni(APP_PATH . 'app/config/config.ini');
        $this->g_db_host = $config->kamailioDB->host;
        $this->g_db_user = $config->kamailioDB->username;
        $this->g_db_pass = $config->kamailioDB->password;
        $this->g_db_name = $config->kamailioDB->dbname;

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

    //          가입리력         //
    public function signlogAction($user = "",$intime = "",$outime = ""){
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
        $this->assets->addJs("pages/scripts/components-date-time-pickers.min.js");
        $this->assets->addJs("pages/scripts/log_signlog.js");
        
        // AdminLTE3 DataTables CSS
        $this->assets->addCss("adminlte/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css");
        $this->assets->addCss("adminlte/plugins/datatables-responsive/css/responsive.bootstrap4.min.css");
        $this->assets->addCss("adminlte/plugins/datatables-buttons/css/buttons.bootstrap4.min.css");
        $this->assets->addCss("global/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css");
        $this->assets->addCss("pages/css/log_signlog.css");

        $user = substr($user, 5,strlen($user) - 5);
        $intime = substr($intime, 3,strlen($intime) - 3);
        $outime = substr($outime, 4,strlen($outime) - 4);
        $cond = "";

        if($user != "")
            $cond .= "username LIKE '%".$user."%' AND ";
        if($intime != "")
            $cond .= "LoginTime >= '".$intime."' AND ";
        if($outime != "")
            $cond .= "LogoutTime <= '".$outime." 23:59:59' AND";
        if($cond != "")
            $cond = substr($cond, 0 , strlen($cond) - 4);

        $signlog = SignlogModel::find([
            "conditions"   =>   $cond,
            "order"        =>   "LoginTime DESC"
            ]);
    
        $this->view->signlogs = $signlog->toArray();

    }

    public function textlogAction($sentFrom = "",$sentTo = "",$sender = "",$receiver = "",$text = "",$select = ""){
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
        $this->assets->addJs("pages/scripts/components-date-time-pickers.min.js");
        $this->assets->addJs("pages/scripts/log_textlog.js");
        
        // AdminLTE3 DataTables CSS
        $this->assets->addCss("adminlte/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css");
        $this->assets->addCss("adminlte/plugins/datatables-responsive/css/responsive.bootstrap4.min.css");
        $this->assets->addCss("adminlte/plugins/datatables-buttons/css/buttons.bootstrap4.min.css");
        $this->assets->addCss("global/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css");
        $this->assets->addCss("pages/css/log_textlog.css");
        $reason = [$this->lang['ok'],$this->lang['notexist'],$this->lang['nothave'],$this->lang['sendstop'],$this->lang['rcvdstop'],$this->lang['sndlevel'],$this->lang['rcvdlevel']];
        $fileType = [$this->lang['messages'],$this->lang['voice'],$this->lang['videoRecord'],$this->lang['imageRecord'],$this->lang['music'],$this->lang['video'],$this->lang['image']];

        $sentFrom = substr($sentFrom, 5, strlen($sentFrom) - 5);
        $sentTo = substr($sentTo, 3, strlen($sentTo) - 3);
        $text = substr($text, 5, strlen($text) - 5);
        $select = substr($select, 5, strlen($select) - 5);
        $sender = substr($sender, 4, strlen($sender) - 4);
        $receiver = substr($receiver, 5, strlen($receiver) - 5);
        $cond = "";

        if ($text != "") 
            $cond .= "Body LIKE '%".$text."%' AND ";
        if ($select != "" && $select != "all") 
            $cond .= "Type = '".$select."' AND ";
        if ($sentFrom != "")
            $cond .= "SentTime >= '" . $sentFrom . "' AND ";
        if ($sentTo != "")
            $cond .= "SentTime <= '" . $sentTo . " 23:59:59' AND ";
        if ($sender != "")
            $cond .= "FromUser LIKE '%".$sender."%' AND ";
        if ($receiver != "")
            $cond .= "ToUser LIKE '%".$receiver."%' AND";
        if ($cond != "")
            $cond = substr($cond, 0, strlen($cond) - 4);

        $histories = LogHistoryModel::find([
            "conditions" =>    $cond,
            "order"      =>    "SentTime DESC"]);
        $this->view->histories = $histories->toArray();
        $this->view->reason = $reason;
        $this->view->fileType = $fileType;
    }

    public function xmppHistoryAction($crtFrom = "", $crtTo = "", $content = "",$type = "") {
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
        $this->assets->addJs("pages/scripts/components-date-time-pickers.min.js");
        $this->assets->addJs("pages/scripts/log_xmppHistory.js");
        
        // AdminLTE3 DataTables CSS
        $this->assets->addCss("adminlte/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css");
        $this->assets->addCss("adminlte/plugins/datatables-responsive/css/responsive.bootstrap4.min.css");
        $this->assets->addCss("adminlte/plugins/datatables-buttons/css/buttons.bootstrap4.min.css");
        $this->assets->addCss("global/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css");
        $level = [$this->lang['hint'],$this->lang['alert'] ,$this->lang['error'] ];

        $crtFrom = substr($crtFrom, 5, strlen($crtFrom) - 5);
        $crtTo = substr($crtTo, 3, strlen($crtTo) - 3);
        $content = substr($content, 5, strlen($content) - 5);
        $type = substr($type, 5, strlen($type) - 5);
        $cond = "";

        if ($content != "") 
            $cond .= "logContent LIKE '%".$content."%' AND ";
        if ($type != "" && $type != "all") 
            $cond .= "logLevel = '".$type."' AND ";
        if ($crtFrom != "")
            $cond .= "logDate >= '" . $crtFrom . "' AND ";
        if ($crtTo != "")
            $cond .= "logDate <= '" . $crtTo . " 23:59:59' AND ";
        if ($cond != "")
            $cond = substr($cond, 0, strlen($cond) - 4);

        $histories = AlarmHistoryModel::find([
        "conditions" =>    $cond,
            "order" => "logDate DESC",]);
        $this->view->histories = $histories->toArray();
        $this->view->level = $level;

        $hint = AlarmHistoryModel::find("logLevel = 0");
        $this->view->countHint = count($hint);
        $alert = AlarmHistoryModel::find("logLevel = 1");
        $this->view->countAlert = count($alert);
        $error = AlarmHistoryModel::find("logLevel = 2");
        $this->view->countError = count($error);

    }
    public function sipHistoryAction($crtFrom = "", $crtTo = "", $content = "",$type = "") {
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
        
        // $this->assets->addJs("global/plugins/bootstrap-datepicker/js/bootstrap-datepicker.min.js");
        // $this->assets->addJs("pages/scripts/components-date-time-pickers.min.js");
        $this->assets->addJs("pages/scripts/log_sipHistory.js");
        
        // AdminLTE3 DataTables CSS
        $this->assets->addCss("adminlte/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css");
        $this->assets->addCss("adminlte/plugins/datatables-responsive/css/responsive.bootstrap4.min.css");
        $this->assets->addCss("adminlte/plugins/datatables-buttons/css/buttons.bootstrap4.min.css");
        // $this->assets->addCss("global/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css");
        $level = [$this->lang['hint'],$this->lang['alert'] ,$this->lang['error'] ];

        $crtFrom = substr($crtFrom, 5, strlen($crtFrom) - 5);
        $crtTo = substr($crtTo, 3, strlen($crtTo) - 3);
        $content = substr($content, 5, strlen($content) - 5);
        $type = substr($type, 5, strlen($type) - 5);
        $cond = "";
        if($content =="" && ($type =="" || $type =="all") && $crtFrom =="" && $crtTo =="")
            $sql = "select * from alertlog order by time desc limit 5000";
        else{
            if ($content != "") 
                $cond .= "logContent LIKE '%".$content."%' AND ";
            if ($type != "" && $type != "all") 
                $cond .= "logLevel = '".$type."' AND ";
            if ($crtFrom != "")
                $cond .= "logDate >= '" . $crtFrom . "' AND ";
            if ($crtTo != "")
                $cond .= "logDate <= '" . $crtTo . " 23:59:59' AND ";
            if ($cond != "")
                $cond = substr($cond, 0, strlen($cond) - 4);
            $sql = "select * from alertlog where".$cond;
        }
        $conn = $this->connectKamailioDB();
        if($conn){    
            $result = $this->executeSQL($sql,$conn);
            if (mysqli_num_rows($result) > 0) {
                $i = 0;
                while($row = mysqli_fetch_assoc($result)) {
                    $histories[$i] = $row;
                    $i ++;
                }
            }
        }
        $this->view->histories = $histories;
        $this->view->level = $level;
        if($conn){
            $sql0 = "select level from alertlog where level = 0";
            $res0 = $this->executeSQL($sql,$conn);
            $this->view->countHint = mysqli_num_rows($res0);
            $sql1 = "select level from alertlog where level = 1";
            $res1 = $this->executeSQL($sql,$conn);
            $this->view->countAlert = mysqli_num_rows($res1);
            $sql2 = "select level from alertlog where level = 2";
            $res2 = $this->executeSQL($sql,$conn);
            $this->view->countError = mysqli_num_rows($res2);
        }
    }

    public function calllogAction($sentFrom = "",$sentTo = "",$sender = "",$receiver = "") {
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
        $this->assets->addJs("pages/scripts/components-date-time-pickers.min.js");
        $this->assets->addJs("pages/scripts/log_callog.js");
        
        // AdminLTE3 DataTables CSS
        $this->assets->addCss("adminlte/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css");
        $this->assets->addCss("adminlte/plugins/datatables-responsive/css/responsive.bootstrap4.min.css");
        $this->assets->addCss("adminlte/plugins/datatables-buttons/css/buttons.bootstrap4.min.css");
        $this->assets->addCss("global/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css");
        $this->assets->addCss("pages/css/log_calllog.css");
        $reason = [$this->lang['ok'],$this->lang['notexist'],$this->lang['nothave'],$this->lang['sendstop'],$this->lang['rcvdstop'],$this->lang['sndlevel'],$this->lang['rcvdlevel']];
 
        $conn = $this->connectKamailioDB();
        $histories = [];

        $sentFrom = substr($sentFrom, 5, strlen($sentFrom) - 5);
        $sentTo = substr($sentTo, 3, strlen($sentTo) - 3);
        $sender = substr($sender, 4, strlen($sender) - 4);
        $receiver = substr($receiver, 5, strlen($receiver) - 5);
        $cond = "";

        if($conn)
        {   
            if($sentFrom == "" && $sentTo == "" && $sender == "" && $receiver == "")
                $sql = "select * from cdrs ORDER BY call_start_time DESC";
            else{
                if ($sentFrom != "")
                    $cond .= "call_start_time >= '" . $sentFrom . "' AND ";
                if ($sentTo != "")
                    $cond .= "call_start_time <= '" . $sentTo . " 23:59:59' AND ";
                if ($sender != "")
                    $cond .= "src_username LIKE '%".$sender."%' AND ";
                if ($receiver != "")
                    $cond .= "dst_username LIKE '%".$receiver."%' AND";
                if ($cond != "")
                    $cond = substr($cond, 0, strlen($cond) - 4);
                $sql = "select * from cdrs where ".$cond." ORDER BY call_start_time DESC";
            }
            $result = $this->executeSQL($sql,$conn);

            if (mysqli_num_rows($result) > 0) {
                $i = 0;
                while($row = mysqli_fetch_assoc($result)) {
                    $histories[$i] = $row;
                    $i ++;
                }
            }
        }
        $this->view->histories = $histories;
        $this->view->reason = $reason;
    }

    public function deleteAlertAction(){
        if ($this->request->hasPost("ID")){
            $no = $this->request->getPost("ID");
            $log = AlarmHistoryModel::findFirstByid($no);
            if($log){
                if ($log->delete())
                    echo "success";
                else
                    echo "error";
            }
            exit;
        } else if($this->request->hasPost("ids")){
            $ids = $this->request->getPost("ids");
            foreach ($ids as $id) {
                $log = AlarmHistoryModel::findFirstByid($id);
                if($log)
                    $log->delete();
            }
            echo "success";
            exit;
        }
        echo "error";
        exit;
    }

    public function deleteKamAlertAction(){
        if ($this->request->hasPost("ID")){
            $no = $this->request->getPost("ID");
            $log = AlarmHistoryModel::findFirstByid($no);
            if($log){
                if ($log->delete())
                    echo "success";
                else
                    echo "error";
            }
            exit;
        } else if($this->request->hasPost("ids")){
            $ids = $this->request->getPost("ids");
            foreach ($ids as $id) {
                $log = AlarmHistoryModel::findFirstByid($id);
                if($log)
                    $log->delete();
            }
            echo "success";
            exit;
        }
        echo "error";
        exit;
    }
    public function deleteLogAction(){
          if ($this->request->hasPost("ID")){
            $no = $this->request->getPost("ID");
            $conn = $this->connectKamailioDB();
            if($conn){
                $sql = "delete from cdrs where cdr_id = '".$no."'";
                $this->executeSQL($sql, $conn);
            }
        } else if($this->request->hasPost("ids")){
            $ids = $this->request->getPost("ids");
            $conn = $this->connectKamailioDB();
            if($conn){
                foreach ($ids as $id) {
                    $sql = "delete from cdrs where cdr_id = '".$id."'";
                    $this->executeSQL($sql, $conn);          
                }
            }
            echo "success";
            exit;
        }
        echo "error";
        exit;
    }

    public function deleteTextLogAction(){
        if ($this->request->hasPost("ID")){
            $no = $this->request->getPost("ID");
            $log = LogHistoryModel::findFirstByNo($no);
            if($log){
                if ($log->delete())
                    echo "success";
                else
                    echo "error";
            }
            exit;
        } else if($this->request->hasPost("ids")){
            $ids = $this->request->getPost("ids");
            foreach ($ids as $id) {
                $log = LogHistoryModel::findFirstByNo($id);
                if($log)
                    $log->delete();
            }
            echo "success";
            exit;
        }
        echo "error";
        exit;
    }

    public function deleteSignAction(){
        if ($this->request->hasPost("ID")){
            $no = $this->request->getPost("ID");
            $log = SignlogModel::findFirstByNo($no);
            if($log){
                if ($log->delete())
                    echo "success";
                else
                    echo "error";
            }
            exit;
        } else if($this->request->hasPost("ids")){
            $ids = $this->request->getPost("ids");
            foreach ($ids as $id) {
                $log = SignlogModel::findFirstByNo($id);
                if($log)
                    $log->delete();
            }
            echo "success";
            exit;
        }
        echo "error";
        exit;
    }

}
