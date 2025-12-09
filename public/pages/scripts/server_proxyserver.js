
function onAddServer() {
    var newIpExt = $("#input_server_ip_ext").val();
    var newIpInt = $("#input_server_ip_int").val();
    $.ajax({
        type: 'POST',
        url: baseUrl + 'server/addProxyServer',
        data: {
            serverIpExt: newIpExt,
            serverIpInt: newIpInt
        },
        dataType: 'html',
        success: function(res){
            if (res == "error")
                $.bootstrapGrowl("조작이 실패하였습니다", {
                    ele: 'body',
                    type: 'danger',
                    offset: {
                        from: 'top',
                        amount: 100
                    },
                    align: 'right',
                    width: 'auto',
                    delay: '3000',
                    stackup_spacing: 10
                });
            else
                location.href = proxyUrl;
        },
        error: function() {
        }
    });
}

function refreshInfo() {
    $.ajax({
        type: 'POST',
        url: baseUrl + 'server/updateProxyServerInfo',
        data: {
            type: 3
        },
        dataType: 'json',
        success: function(res){
            for (var i = 0; i < res.length; i++) {
                $("#start_time"+i).text(res[i]["start_time"]);
                $("#cpu"+i).text(res[i]["cpu"]);
                $("#ram"+i).text(res[i]["ram"]);
                $("#memory"+i).text(res[i]["memory"]);
                if (res[i]["status"] == "on")
                    $("#locate"+i)[0].src = "../pages/img/on.gif";
                else
                    $("#locate"+i)[0].src = "../pages/img/off.gif";
            }
        },
        error: function() {
        }
    });
}

$(document).ready(function () {
    $("li#proxyserver").addClass("active");
    $(".btn-active").removeClass("btn-active");
    $("#msmanager").addClass("btn-active");

    $(".deleteProxy").click(function(){
        var serverip = $(this).attr("serverIp");
        if (confirm("부분봉사기(" + serverip + ")를 삭제하겠습니까?")) {
            $.ajax({
                type: 'POST',
                url: baseUrl + 'server/deleteProxy',
                data: {
                    serverip: serverip
                },
                dataType: 'html',
                success: function(res){
                    console.log(res);
                    if (res == "success")
                        location.href = proxyUrl;
                    else {
                        $.bootstrapGrowl("조작이 실패하였습니다", {
                            ele: 'body',
                            type: 'danger',
                            offset: {
                                from: 'top',
                                amount: 100
                            },
                            align: 'right',
                            width: 'auto',
                            delay: '3000',
                            stackup_spacing: 10
                        });
                    }
                },
                error: function() {
                }
            });
        }
    });

    setInterval(refreshInfo, 5000);
});