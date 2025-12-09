
function onEditHaproxy() {
    var newIpExt = $("#input_haproxy_ip_ext").val();
    var newIpInt = $("#input_haproxy_ip_int").val();
    $.ajax({
        type: 'POST',
        url: baseUrl + 'server/editSipHaproxyServer',
        data: {
            serverIpExt: newIpExt,
            serverIpInt: newIpInt
        },
        dataType: 'html',
        success: function(res){
            if (res == "error"){
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
            else
                location.href = sipUrl;
        },
        error: function() {
        }
    });
}

function onAddServer() {
    var newIpExt = $("#input_server_ip_ext").val();
    var newIpInt = $("#input_server_ip_int").val();
    $.ajax({
        type: 'POST',
        url: baseUrl + 'server/addSipServer',
        data: {
            serverIpExt: newIpExt,
            serverIpInt: newIpInt
        },
        dataType: 'html',
        success: function(res){
            if (res == "error"){
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
            } else
                location.href = sipUrl;
        },
        error: function() {
        }
    });
}

function refreshInfo() {
    $.ajax({
        type: 'POST',
        url: baseUrl + 'server/updateKamServerInfo',
        data: {
            type: 2
        },
        dataType: 'json',
        success: function(res){
            if (res) {
                $("#start_time").text(res[0]["start_time"]);
                $("#cpu_info").text(res[0]["cpu"]);
                $("#ram_info").text(res[0]["ram"]);
                $("#memory_info").text(res[0]["memory"]);
            }

            for (var i = 1; i < res.length; i++) {
                $("#start_time"+i).text(res[i]["start_time"]);
                $("#cpu"+i).text(res[i]["cpu"]);
                $("#ram"+i).text(res[i]["ram"]);
                $("#memory"+i).text(res[i]["memory"]);
                $("#sync_call"+i).text(res[i]["sync_call"]);
            }
        },
        error: function() {
        }
    });
}

$(document).ready(function () {
    $("li#sipserver").addClass("active");
    $(".btn-active").removeClass("btn-active");
    $("#msmanager").addClass("btn-active");

    $(".deleteSip").click(function(){
        var serverip = $(this).attr("serverIp");
        if (confirm("부분봉사기(" + serverip + ")를 삭제하겠습니까?")) {
            $.ajax({
                type: 'POST',
                url: baseUrl + 'server/deleteSip',
                data: {
                    serverip: serverip
                },
                dataType: 'html',
                success: function(res){
                    if (res == "success")
                        location.href = sipUrl;
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