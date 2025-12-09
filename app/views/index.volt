<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        {{ get_title() }}
		{{ assets.outputCss() }}

	</head>
        <!--[if lt IE 9]>
		{{ javascript_include('global/plugins/respond.min.js') }}
		{{ javascript_include('global/plugins/excanvas.min.js') }}
	<![endif]-->
	{{ content() }}

    {{ assets.outputJs() }}
    </body>
</html>