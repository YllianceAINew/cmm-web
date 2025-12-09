<script type="text/javascript">
	var baseUrl = "{{ url() }}";
	var acls = {{acceptAcl | json_encode}};
</script>
<body>
    <div id="bannerDiv">
        <img class="logo-icon" src="/adminpage/login/logo.svg"/>
        <img class="logo-title" src="/adminpage/login/title.svg"/>
    </div>

    <div class="clockLB"></div>
	<!-- BEGIN MAIN LAYOUT -->
		<!-- Header BEGIN -->
		{{ partial("partials/menu") }}
        <div id="accordiandiv">
	        <ul id="log">
	        	<?php if (in_array("log/calllog", $acceptAcl)){ ?>
	        	<li id="callog">
	        		<a  onclick="doGo('{{url('log/calllog')}}')" tabindex="-1" data-toggle="tab">
	        		<div class = "page-leftbar-tag">{{ lang._('menu_call') }}</div></a>
	        	</li>
	        	<?php }	?>
	        	<?php if (in_array("log/signlog", $acceptAcl)){ ?>
	        	<li id="signlog">
	        		<a onclick="doGo('{{url('log/signlog')}}')" tabindex="-1" data-toggle="tab">
	        		<div class = "page-leftbar-tag">{{ lang._('menu_signin') }}</div></a>
	        	</li>
	        	<?php }	?>
	        	<?php if (in_array("log/xmppHistory", $acceptAcl)){ ?>
	        	<li id="xmppHistory">
	        		<a onclick="doGo('{{url('log/xmppHistory')}}')" tabindex="-1" data-toggle="tab">
	        		<div class = "page-leftbar-tag">{{ lang._('menu_serverstate_alarmlog') }}</div></a>
	        	</li>
	        	<?php }	?>
	        	<?php if (in_array("log/sipHistory", $acceptAcl)){ ?>
	        	<li id="sipHistory">
	        		<a onclick="doGo('{{url('log/sipHistory')}}')" tabindex="-1" data-toggle="tab">
	        		<div class = "page-leftbar-tag">{{ lang._('menu_serverstate_kamailiolog') }}</div></a>
	        	</li>
	        	<?php }	?>
	        	<li style="height:1px;border-bottom:none;"></li>
	        </ul>
        </div>
	<div class="page-container">
		{{ content() }}
	</div>

    <!-- BEGIN FOOTER -->
    <div class="page-footer">
    	{{ partial("partials/footer") }}
    </div>
