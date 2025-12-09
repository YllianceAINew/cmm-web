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
	        <ul id="usermanager">
	        	<?php if (in_array("member/register", $acceptAcl)){ ?>
	        	<li id="register">
	        		<a onclick="doGo('{{url('member/register')}}')" tabindex="-1">
	        		<div class = "page-leftbar-tag">{{ lang._('menu_registration_request') }}</div></a>
	        	</li>
	        	<?php }	?>
	        	<?php if (in_array("member/summary", $acceptAcl)){ ?>
	        	<li id="summary">
	        		<a onclick="doGo('{{url('member/summary')}}')" tabindex="-1">
	        		<div class = "page-leftbar-tag">{{ lang._('userlist') }}</div></a>
	        	</li>
	        	<?php }	?>
	        	<?php if (in_array("member/levelList", $acceptAcl)){ ?>
	        	<li id="levelist">
	        		<a onclick="doGo('{{url('member/levelList')}}')" tabindex="-1">
	        		<div class = "page-leftbar-tag">{{ lang._('levelist') }}</div></a>
	        	</li>
	        	<?php }	?>
	        	<?php if (in_array("member/setlevel", $acceptAcl)){ ?>
	        	<li id="edit">
	        		<a onclick="doGo('{{url('member/setlevel')}}')" tabindex="-1">
	        		<div class = "page-leftbar-tag">{{ lang._('setlevel') }}</div></a>
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
