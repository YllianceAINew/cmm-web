{{ content() }}

<script type="text/javascript">
    var baseUrl = "{{ url() }}";
</script>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<body marginwidth="0" marginheight="0" class="login">
        <div align="center" class="contents">
            <div class="logo">
                {# <img class="logo-title" src="./login/title.svg"/> #}
            </div>
            <table class="tb_login">
                <tbody><tr>
                    <td><label class="label_m">id:&nbsp;</label></td>
                    <td><input class="form-control" type="text" id="username" autocomplete="off" onkeyup="submitOnEnter(event)"></td>
                </tr>
                <tr>
                    <td><label class="label_m">password</label></td>
                    <td><input class="form-control" type="password" id="secret" autocomplete="off" onkeyup="submitOnEnter(event)"></td>
                </tr>
                <tr><td></td>
                    <td><input class="btn-green-pull-right" type="button" id="login_button" name="loginbutton" value="">
                        <input class="btn-green-pull-end" type="button" id="login_close" name="loginbutton" value="">
                    </td>
                </tr>
            </tbody></table>
        </div>
</body>
