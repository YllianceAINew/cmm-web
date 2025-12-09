function loginStart() {
	var username = $.trim ($("#username").val());
	var secret = $.trim ($("#secret").val());
	$.ajax({
        type: 'POST',
        url: baseUrl + 'session/start',
        data: {
            'memberLoginId' : username,
            'memberPassword' : secret,
        },
        dataType: 'html',
        success: function(res){
            location.href = baseUrl + res;
        },
        error: function() {

        }
    }); 
}

function submitOnEnter(event) {
	if (event.which == 13) {
		loginStart();
	}
}

jQuery(document).ready(function() {
    $("#username").focus();
	$("#login_button").click(function () {
		loginStart();
	});

	$("#login_close").click(function () {
		$("#username").val("");
		$("#secret").val("");
	});
});