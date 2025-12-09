
var changeType = function(no){
    var arr = [];
    switch (no) {
    case 'first':
        arr = ["dashboard\/index"];
        break;
    case 'manager':
        arr = ["server\/index", "server\/serversetting", "server\/xmppserver", "server\/sipserver", "server\/proxyserver"];
        break;
    case 'register':
        arr = ["member\/register", "member\/summary", "member\/setlevel", "member\/levelList"];
        break;
    case 'log':
        arr = ["log\/calllog", "log\/textlog", "log\/signlog", "log\/xmppHistory", "log\/sipHistory"];
        break;
    }
    for (acl in acls) {
        for (item in arr) {
            if (arr[item] == acls[acl]) {
                location.href=baseUrl+ acls[acl];
                return;
            }
        }
    }
}

var LogOut = function () {
	location.href = "/adminpage/index";
};

var doGo = function (url) {
	location.href = url;
};

function startTime() {
    $.ajax({
        type: 'POST',
        url: baseUrl + 'session/getTime',
        data: {},
        dataType: 'html',
        success: function(res){
    		$(".clockLB").html (JSON.parse(res));
        },
        error: function() {
        }
    });
}

var d = new Date();
document.getElementById("demo").innerHTML = d.getFullYear();

$(document).ready (function () {
	//setInterval(startTime, 1000);
	$(".btn1.btn-primary1").click (function () {
		$(".btn1.btn-primary1").each (function () {
			$(this).removeClass ("btn-active");
		});
		$(this).addClass ("btn-active");
	});
});