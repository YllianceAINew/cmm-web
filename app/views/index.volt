<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        {{ get_title() }}
		{{ stylesheet_link('global/plugins/font-awesome/css/font-awesome.min.css') }}
		{{ stylesheet_link('global/plugins/bootstrap/css/bootstrap.min.css') }}
		{{ stylesheet_link('global/plugins/bootstrap-switch/css/bootstrap-switch.min.css') }}
		{{ stylesheet_link('global/css/components.css') }}
		{{ stylesheet_link('global/css/plugins.css') }}
		{{ stylesheet_link('plugins/css/layout.css') }}
		{{ stylesheet_link('pages/css/common.css') }}
		{{ stylesheet_link('global/css/plugins.css') }}
		{{ stylesheet_link('admin/layout/css/layout.css') }}
		{{ stylesheet_link('pages/css/template.css') }}
		{{ stylesheet_link('global/plugins/bootstrap-toastr/toastr.min.css') }}

		<link rel="shortcut icon" src="{{url('')}}/pages/img/logo.png"/>
		{{ assets.outputCss() }}

	</head>
        <!--[if lt IE 9]>
		{{ javascript_include('global/plugins/respond.min.js') }}
		{{ javascript_include('global/plugins/excanvas.min.js') }}
	<![endif]-->
	{{ content() }}

	{{ javascript_include('global/plugins/jquery.min.js') }}
    {{ javascript_include('global/plugins/bootstrap/js/bootstrap.min.js') }}
    {{ javascript_include('global/plugins/js.cookie.min.js') }}
    {{ javascript_include('global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js') }}
    {{ javascript_include('global/plugins/jquery-slimscroll/jquery.slimscroll.min.js') }}
    {{ javascript_include('global/plugins/jquery.blockui.min.js') }}
	{{ javascript_include('global/plugins/bootstrap-switch/js/bootstrap-switch.min.js') }}
	{{ javascript_include('global/scripts/app.min.js') }}
	{{ javascript_include('plugins/scripts/layout.js') }}
	{{ javascript_include('pages/main.js') }}
	{{ javascript_include('pages/scripts/alert.js') }}
	{{ javascript_include('global/plugins/bootstrap-toastr/toastr.min.js') }}  
    {{ assets.outputJs() }}
    </body>
</html>