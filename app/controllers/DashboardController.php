<?php
use Phalcon\Mvc\Model;
class DashboardController extends ControllerUIBase
{
	public function initialize()
	{
		$this->tag->setTitle($this->lang['menu_dashboard']);
		$this->view->setLayout('adminlte');
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
        // Load Chart.js
        $this->assets->addJs("adminlte/plugins/chart.js/Chart.min.js");
        
        // Mock server data
        $servers = [
            [
                'name' => 'XMPP Server',
                'status' => 'online',
                'cpu' => 45.2,
                'ram' => 62.8,
                'disk' => 34.5,
                'network_in' => '125.4 MB/s',
                'network_out' => '98.7 MB/s',
                'uptime' => '15 days, 8 hours',
                'last_check' => date('Y-m-d H:i:s', strtotime('-2 minutes'))
            ],
            [
                'name' => 'HAProxy',
                'status' => 'online',
                'cpu' => 28.5,
                'ram' => 41.3,
                'disk' => 12.2,
                'network_in' => '89.2 MB/s',
                'network_out' => '76.5 MB/s',
                'uptime' => '22 days, 14 hours',
                'last_check' => date('Y-m-d H:i:s', strtotime('-1 minute'))
            ],
            [
                'name' => 'SIP Server',
                'status' => 'online',
                'cpu' => 52.7,
                'ram' => 58.9,
                'disk' => 28.4,
                'network_in' => '156.8 MB/s',
                'network_out' => '142.3 MB/s',
                'uptime' => '8 days, 3 hours',
                'last_check' => date('Y-m-d H:i:s', strtotime('-3 minutes'))
            ],
            [
                'name' => 'RTP Server',
                'status' => 'offline',
                'cpu' => 0.0,
                'ram' => 0.0,
                'disk' => 18.7,
                'network_in' => '0 MB/s',
                'network_out' => '0 MB/s',
                'uptime' => '0 days, 0 hours',
                'last_check' => date('Y-m-d H:i:s', strtotime('-15 minutes'))
            ]
        ];
        
        // Mock user metrics
        $userMetrics = [
            'total_users' => 12547,
            'active_today' => 3421,
            'new_signups_week' => 187,
            'users_online' => 892
        ];
        
        // Mock user growth chart data (last 12 months)
        $userGrowthData = [
            'labels' => ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
            'data' => [8500, 9200, 9800, 10200, 10800, 11200, 11500, 11800, 12000, 12200, 12350, 12547]
        ];
        
        // Pass data to view
        $this->view->servers = $servers;
        $this->view->userMetrics = $userMetrics;
        $this->view->userGrowthData = $userGrowthData;
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

}
