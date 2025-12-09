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
	        <ul id="first">
	        	<?php if (in_array("dashboard/index", $acceptAcl)){ ?>
	        	<li id="admin" class="active">
	        		<a  onclick="doGo('{{url('dashboard/index')}}')">
	        		<div class = "page-leftbar-tag">{{ lang._('menu_first') }}</div>
	        		</a>
	        	</li>
	        	<?php }	?>

	        </ul>
        </div>
	<div class="page-container">
		{{ content() }}
	</div>

    <!-- BEGIN FOOTER -->
    <div class="page-footer">
    	{{ partial("partials/footer") }}
    </div>