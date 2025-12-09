<div id="topDiv">
	<img src = "/adminpage/login/top.png">
	<ul class="nav nav-tabs" style="margin:0;padding-left:20px;">
    	<?php if (in_array("dashboard/index", $acceptAcl) || in_array("dashboard/graph", $acceptAcl)){ ?>
		<li>
			<button id="mfirst" class="btn1 btn-primary1 " style="padding-left: 4px; border:none; width:100px;" onclick="changeType('first')">{{ lang._('menu_first') }}</button>
		</li>
    	<?php } ?>
    	<?php if (in_array("server/index", $acceptAcl) || in_array("server/serversetting", $acceptAcl) || in_array("server/xmppserver", $acceptAcl) || in_array("server/sipserver", $acceptAcl) || in_array("server/proxyserver", $acceptAcl)){ ?>
		<li>
			<button id = "msmanager" class="btn1 btn-primary1 " style="padding-left: 4px; border:none; width:100px;" onclick="changeType('manager')">{{ lang._('menu_servermanager') }}</button>
		</li>
    	<?php } ?>
    	<?php if (in_array("member/register", $acceptAcl) || in_array("member/summary", $acceptAcl) || in_array("member/setlevel", $acceptAcl) || in_array("member/levelList", $acceptAcl)){ ?>
		<li>
			<button id="mregister" class="btn1 btn-primary1" style="padding-left: 4px; border:none;width:100px;" onclick="changeType('register')">{{ lang._('menu_registration') }}</button>
		</li>
    	<?php } ?>
    	<?php if (in_array("log/calllog", $acceptAcl) || in_array("log/textlog", $acceptAcl) || in_array("log/signlog", $acceptAcl) || in_array("log/xmppHistory", $acceptAcl) || in_array("log/sipHistory", $acceptAcl)){ ?>
		<li>
			<button id="mlog" class="btn1 btn-primary1" style="padding-left: 4px; border:none;width:100px;" onclick="changeType('log')">{{ lang._('menu_log') }}</button>
		</li>
    	<?php } ?>
		<label class="setMember" onclick="LogOut()">[ {{ authAdmin['name'] }} ] {{ lang._('menu_logout') }} </label>
	</ul>
</div>