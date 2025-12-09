<?php
use Phalcon\Mvc\Model;
class DashboardController extends ControllerUIBase
{
	public function initialize()
	{
		$this->tag->setTitle($this->lang['menu_dashboard']);
        $this->persistent->regUnit = "1 days";
        $this->persistent->selRegYear = date("Y");
        $this->persistent->selRegYearTo = date("Y");
        $this->persistent->selRegMonth = date("m");
        $date = $this->persistent->selRegYear."-".$this->persistent->selRegMonth."-01";
        $date = date_create($date);
        $this->persistent->regTo = $date->add(date_interval_create_from_date_string("1 months"));

        $this->persistent->logUnit = "1 days";
        $this->persistent->selLogYear = date("Y");
        $this->persistent->selLogYearTo = date("Y");
        $this->persistent->selLogMonth = date("m");
        $date = $this->persistent->selLogYear."-".$this->persistent->selLogMonth."-01";
        $date = date_create($date);
        $this->persistent->logTo = $date->add(date_interval_create_from_date_string("1 months"));
    	$yearList = array();
        $first = date_create("2018-01-01");
        $last = date_create(date("Y"));
        while ($first <= $last) {
            array_push($yearList, $first->format("Y"));
            $first->add(date_interval_create_from_date_string("1 years"));
            
        }
        $this->persistent->yearList = $yearList;
        parent::initialize();
	}

    public function system_mem()
    {
        $f = fopen("/proc/meminfo", "r");
        if (!$f)
        {
            return "Fail to read file(/proc/meminfo)!";
            exit;
        }
        
        $buf = fgets($f, 1024);
        $buf = str_replace("  ", " ", $buf);
        list($tmp, $total) = split(":", $buf);
        $buf = fgets($f, 1024);
        $buf = str_replace("  ", " ", $buf);
        list($tmp, $free) = split(":", $buf);
    #ifdef CONFIG_PIC_CENTOS7
        $buf = fgets($f, 1024);
        $buf = str_replace("  ", " ", $buf);
        list($tmp, $memavail) = split(":", $buf);
    #endif
        $buf = fgets($f, 1024);
        $buf = str_replace("  ", " ", $buf);
        list($tmp, $buffer) = split(":", $buf);
        $buf = fgets($f, 1024);
        $buf = str_replace("  ", " ", $buf);
        list($tmp, $cache) = split(":", $buf);
        fclose($f);
        $ret = 100 * (($total - $free - $buffer - $cache)/(double)$total);
        $used= (int)(($total - $free - $buffer - $cache)/1024);
        $total = (int)($total/1024);
        return $used."/".$total;

    }

    public function system_disk()
    {
        $f = popen("df -h", "r");
        if($f)
        {
            $buf = fgets($f, 1024);
            $buf = fgets($f, 1024);
            list($file_sys, $total, $used, $free, $load) = preg_split("/ /", $buf, -1, PREG_SPLIT_NO_EMPTY);
            $p = strstr($load, "%"); 
            if (!$p)
            {
                $buf = fgets($f, 1024);
                $buf = preg_split("/ /", $buf, -1, PREG_SPLIT_NO_EMPTY);
                list($total, $used, $free, $load) = split(" ", $buf);
            }
            pclose($f);
        }   
        return $used."/".$total;
    }


    public function indexAction()
    {
        // Dashboard removed - redirect to server index
        return $this->response->redirect('server/index');
        $this->assets->addJs("global/plugins/datatables/plugins/bootstrap/datatables.bootstrap.js");
        $this->assets->addJs("global/plugins/amcharts/amcharts/amcharts.js");
        $this->assets->addJs("global/plugins/amcharts/amcharts/serial.js");
        $this->assets->addJs("global/plugins/amcharts/amcharts/pie.js");
        $this->assets->addJs("global/plugins/amcharts/amcharts/radar.js");
        $this->assets->addJs("global/plugins/amcharts/amcharts/themes/light.js");
        $this->assets->addJs("global/plugins/amcharts/amcharts/themes/patterns.js");
        $this->assets->addJs("global/plugins/amcharts/amcharts/themes/chalk.js");
        $this->assets->addJs("global/plugins/flot/jquery.flot.min.js");
        $this->assets->addJs("global/plugins/flot/jquery.flot.resize.min.js");
        $this->assets->addJs("global/plugins/flot/jquery.flot.categories.min.js");

        $this->assets->addJs("pages/scripts/components-date-time-pickers.min.js");
        $this->assets->addJs("global/plugins/bootstrap-datepicker/js/bootstrap-datepicker.min.js");
        $this->assets->addJs("pages/scripts/dashboard_index.js");
        $this->assets->addCss("global/plugins/datatables/datatables.css");
        $this->assets->addCss("global/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css");
        $this->assets->addCss("pages/css/dashboard_index.css");

        $members = UserMemberModel::find();
        $this->view->members = $members;


        $ram = $this->system_mem();
        $ram = explode("/", $ram);

        if($ram[1] > 1024){
            $ram[2] = ($ram[1]-$ram[0])/1024;
            $ram[0] = $ram[0]/1024;
            $ram[1] = $ram[1]/1024;   
            $ram[3] = "gb";
        }
        else{
            $ram[0] = $ram[0];
            $ram[1] = $ram[1];
            $ram[2] = $ram[1]-$ram[0];
            $ram[3] = "mb";
        }

        $memories = $this->system_disk();
        $memory = explode("/", $memories);

        $cpu = $this->system_cpu();

        $memory[0] = substr($memory[0], 0,strlen($memory[0]) - 1);
        $memory[1] = substr($memory[1], 0,strlen($memory[1]) - 1);

        $this->view->ram = $ram;
        $this->view->memory = $memory;
        $this->view->cpu = $cpu;

        $data = getdate();
    
        /////    사용장등록상태   /////
        if($this->request->hasQuery("selRegYear")) {
            if ($_GET["selRegYear"] != "")
                $this->persistent->selRegYear =$_GET["selRegYear"];
        }
        if($this->request->hasQuery("selRegMonth")){
            if (($_GET["selRegMonth"] != "")&&($_GET["selRegMonth"] != "undefined"))
                $this->persistent->selRegMonth = $_GET["selRegMonth"];
        }
        if($this->request->hasQuery("RegType")){
            if ($_GET["RegType"] != "")
                $this->persistent->regUnit = $_GET["RegType"];
        }
        if($this->request->hasQuery("selRegYearTo")){
            if (($_GET["selRegYearTo"] != "") && ($_GET["selRegYearTo"] != "undefined"))
                $this->persistent->selRegYearTo = $_GET["selRegYearTo"];
        }

        $this->view->selRegYear = $this->persistent->selRegYear;
        $this->view->selRegMonth = $this->persistent->selRegMonth;
        $this->view->regUnit = $this->persistent->regUnit;
        $this->view->selRegYearTo = $this->persistent->selRegYearTo;

        $registerData = $this->RegisterChart();//print_r($this->RegisterChart());exit;
        $this->view->registerData = $registerData;

        //////   사용자가입상태   /////
        if($this->request->hasQuery("selLogYear")) {
            if ($_GET["selLogYear"] != "")
                $this->persistent->selLogYear =$_GET["selLogYear"];
        }
        if($this->request->hasQuery("selLogMonth")){
            if (($_GET["selLogMonth"] != "")&&($_GET["selLogMonth"] != "undefined"))
                $this->persistent->selLogMonth = $_GET["selLogMonth"];
        }
        if($this->request->hasQuery("logType")){
            if ($_GET["logType"] != "")
                $this->persistent->logUnit = $_GET["logType"];
        }
        if($this->request->hasQuery("selLogYearTo")){
            if (($_GET["selLogYearTo"] != "") && ($_GET["selLogYearTo"] != "undefined"))
                $this->persistent->selLogYearTo = $_GET["selLogYearTo"];
	    if($this->persistent->selLogYear > $this->persistent->selLogYearTo){              
                $this->persistent->selLogYear = $this->persistent->selLogYearTo;
            }
        }

        $this->view->selLogYear = $this->persistent->selLogYear;
        $this->view->selLogMonth = $this->persistent->selLogMonth;
        $this->view->logUnit = $this->persistent->logUnit;
        $this->view->selLogYearTo = $this->persistent->selLogYearTo;
        $loginData = $this->LoginChart();
        $this->view->loginData = $loginData;
        $this->view->typeSelect = ["1 days", "1 weeks", "1 months", "1 years"];
        $this->view->typeName = [$this->lang['daily'],$this->lang['weekly'],$this->lang['monthly'],$this->lang['yearsly']];
        $this->view->years = $this->persistent->yearList;
        $this->view->months = ["1","2","3","4","5","6","7","8","9","10","11","12"];
    }
    
    public function system_cpu()
    {
        $handle = popen("top -b -n 1 | grep %Cpu | awk '{print $2 + $4 + $6}'","r");   
        $ret = fread($handle, 64);
        pclose($handle);
        return $ret;
    }   
    public function RegisterChart(){
        $data = array();

        $regUnit = $this->persistent->regUnit;
        $year = $this->persistent->selRegYear;
        $month = $this->persistent->selRegMonth;
        $yearTo = $this->persistent->selRegYearTo;
        if($regUnit == "1 days"){
            $searchFrom = $year."-".$month."-01";
            $searchFrom = date_create($searchFrom);
            $regTo = date_create($year."-".$month."-01");
            $regTo->add(date_interval_create_from_date_string("1 months"));
            $calender = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"];
        }
        if($regUnit == "1 months"){
            $searchFrom = $year."-01-01";
            $searchFrom = date_create($searchFrom);
            $regTo = date_create($year."-01-01");
            $regTo->add(date_interval_create_from_date_string("1 years"));
            $calender = ["1","2","3","4","5","6","7","8","9","10","11","12"];
        }
        if($regUnit == "1 weeks"){
            $searchFrom = $year."-".$month."-01";
            $timeStamp = strtotime($searchFrom);
            $week = getdate($timeStamp);
            $wday = $week['wday']." days";
            $searchFrom = date_create($searchFrom);
            $searchFrom = date_sub($searchFrom, date_interval_create_from_date_string($wday));
            $regTo = date_create($year."-".$month."-01");
            $regTo->add(date_interval_create_from_date_string("1 months"));
            $calender = ["1","2","3","4","5"]; 
        }
        if($regUnit == "1 years"){
            $searchFrom = $year."-01-01";
            $searchFrom = date_create($searchFrom);
            $regTo = date_create($yearTo."-01-01");
            $regTo->add(date_interval_create_from_date_string("1 years"));
            $calender=$this->persistent->yearList;
        }
        $searchTo = date_create($searchFrom->format("Y-m-d"));
        $searchTo->add(date_interval_create_from_date_string($regUnit));
        //echo $searchTo->format("Y-m-d");exit;
        for ($i = 0 ; $i < 31 ; $i ++) {
            if($searchFrom < $regTo){
                $cond = "Date >= '".$searchFrom->format("Y-m-d")."' and Date < '".$searchTo->format("Y-m-d")."'";
                $res = RegisteredCountModel::average([
                    "conditions" => $cond,
                    "order" => "UserCount DESC",
                    "column" => "UserCount"]);
                if ($res)
                    $data[$calender[$i]] = floor($res);
		else
			$data[$calender[$i]] = 0;
                $searchFrom->add(date_interval_create_from_date_string($regUnit));
                $searchTo->add(date_interval_create_from_date_string($regUnit));
            }
        }
        return $data;
    }

    public function LoginChart(){
        $data = array();

        $logUnit = $this->persistent->logUnit;
        $year = $this->persistent->selLogYear;
        $month = $this->persistent->selLogMonth;
        $yearTo = $this->persistent->selLogYearTo;
        if($logUnit == "1 days"){
            $searchFrom = $year."-".$month."-01";
            $searchFrom = date_create($searchFrom);
            $logTo = date_create($year."-".$month."-01");
            $logTo->add(date_interval_create_from_date_string("1 months"));
            $calender = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"];
        }
        if($logUnit == "1 months"){
            $searchFrom = $year."-01-01";
            $searchFrom = date_create($searchFrom);
            $logTo = date_create($year."-01-01");
            $logTo->add(date_interval_create_from_date_string("1 years"));
            $calender = ["1","2","3","4","5","6","7","8","9","10","11","12"];
        }
        if($logUnit == "1 weeks"){
            $searchFrom = $year."-".$month."-01";
            $timeStamp = strtotime($searchFrom);
            $week = getdate($timeStamp);
            $wday = $week['wday']." days";
            $searchFrom = date_create($searchFrom);
            $searchFrom = date_sub($searchFrom, date_interval_create_from_date_string($wday));
            $logTo = date_create($year."-".$month."-01");
            $logTo->add(date_interval_create_from_date_string("1 months")); 
            $calender = ["1","2","3","4","5"]; 
        }
        if($logUnit == "1 years"){
            $searchFrom = $year."-01-01";
            $searchFrom = date_create($searchFrom);
            $logTo = date_create($yearTo."-01-01");
            $logTo->add(date_interval_create_from_date_string("1 years"));
            $calender=$this->persistent->yearList;
        }
        $searchTo = date_create($searchFrom->format("Y-m-d"));
        $searchTo->add(date_interval_create_from_date_string($logUnit));
        //echo $logTo->format("Y-m-d");exit;
        for ($i = 0 ; $i < 31 ; $i ++) {
            if($searchFrom < $logTo ){
                $cond = "LoginDate >= '".$searchFrom->format("Y-m-d")."' and LoginDate < '".$searchTo->format("Y-m-d")."'";
                $res = LoginCountModel::average([
                    "conditions" => $cond,
                    "column" => "LoginCount",
                    "column" => "LoginCount",]);
                if ($res)
                    $data[$calender[$i]] = floor($res);
		else
			$data[$calender[$i]] = 0;
                $searchFrom->add(date_interval_create_from_date_string($logUnit));
                $searchTo->add(date_interval_create_from_date_string($logUnit));
            }
        }
        return $data;
    }
}
