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
	        <ul id="servermanager">
	        	<?php if (in_array("server/index", $acceptAcl)){ ?>
	        	<li id="admin">
	        		<a  onclick="doGo('{{url('server/index')}}')">
	        		<div class = "page-leftbar-tag">{{ lang._('menu_servermanager_admin') }}</div>
	        		</a>
	        	</li>
	        	<?php }	?>
	        	<?php if (in_array("server/serversetting", $acceptAcl)){ ?>
	        	<li id="setserver">
	        		<a onclick="doGo('{{url('server/serversetting')}}')" tabindex="-1" data-toggle="tab">
	        		<div class = "page-leftbar-tag">{{ lang._('menu_servermanager_setserver') }}</div></a>
	        	</li>
	        	<?php }	?>
	        	<?php if (in_array("server/xmppserver", $acceptAcl)){ ?>
	        	<li id="xmppserver">
	        		<a onclick="doGo('{{url('server/xmppserver')}}')" tabindex="-1" data-toggle="tab">
	        		<div class = "page-leftbar-tag">{{ lang._('menu_servermanager_xmppserver') }}</div></a>
	        	</li>
	        	<?php }	?>
	        	<?php if (in_array("server/sipserver", $acceptAcl)){ ?>
	        	<li id="sipserver">
	        		<a onclick="doGo('{{url('server/sipserver')}}')" tabindex="-1" data-toggle="tab">
	        		<div class = "page-leftbar-tag">{{ lang._('menu_servermanager_sipserver') }}</div></a>
	        	</li>
	        	<?php }	?>
	        	<?php if (in_array("server/proxyserver", $acceptAcl)){ ?>
	        	<li id="proxyserver">
	        		<a onclick="doGo('{{url('server/proxyserver')}}')" tabindex="-1" data-toggle="tab">
	        		<div class = "page-leftbar-tag">{{ lang._('menu_servermanager_proxyserver') }}</div></a>
	        	</li>
	        	<?php }	?>
	        	<?php if (in_array("server/irregular", $acceptAcl)){ ?>
	        	<li id="irregular">
	        		<a onclick="doGo('{{url('server/irregular')}}')" tabindex="-1" data-toggle="tab">
	        		<div class = "page-leftbar-tag">{{ lang._('menu_servermanager_irregular') }}</div></a>
	        	</li>
	        	<?php }	?>
	        	<?php if (in_array("server/mimetype", $acceptAcl)){ ?>
	        	<li id="mimetype-link">
	        		<a onclick="doGo('{{url('server/mimetype')}}')" tabindex="-1" data-toggle="tab">
	        		<div class = "page-leftbar-tag">{{ lang._('menu_servermanager_mimetype') }}</div></a>
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
