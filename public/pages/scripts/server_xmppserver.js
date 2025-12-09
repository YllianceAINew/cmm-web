
function onEditHaproxy() {
    var newIpExt = $("#input_haproxy_ip_ext").val();
    var newIpInt = $("#input_haproxy_ip_int").val();
    $.ajax({
        type: 'POST',
        url: baseUrl + 'server/editHaproxyServer',
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
                location.href = xmppUrl;
        },
        error: function() {
        }
    });
}

function onEditFileserver() {
    var newIpExt = $("#input_fileserver_ip_ext").val();
    var newIpInt = $("#input_fileserver_ip_int").val();
    $.ajax({
        type: 'POST',
        url: baseUrl + 'server/editFileServer',
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
                location.href = xmppUrl;
        },
        error: function() {
        }
    });
}

function onAddServer() {
    var newIp = $("#input_server_ip").val();
    $.ajax({
        type: 'POST',
        url: baseUrl + 'server/addXmppServer',
        data: {
            serverIp: newIp
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
                location.href = xmppUrl;
        },
        error: function() {
        }
    });
}

function refreshInfo() {
    $.ajax({
        type: 'POST',
        url: baseUrl + 'server/updateServerInfo',
        data: {},
        dataType: 'json',
        success: function(res){
            for (var i = 0; i < res.length; i++) {
                if (i == 0) {
                    $("#cpu_info").text(res[i]['cpu']);
                    $("#ram_info").text(res[i]['ram']);
                    $("#memory_info").text(res[i]['memory']);
                } else if (i == (res.length - 1)) {
                    $("#f_cpu_info").text(res[i]['cpu']);
                    $("#f_ram_info").text(res[i]['ram']);
                    $("#f_memory_info").text(res[i]['memory']);
                } else {
                    $("#time_info"+(i-1)).text(res[i]['time']);
                    $("#cpu_info"+(i-1)).text(res[i]['cpu']);
                    $("#ram_info"+(i-1)).text(res[i]['ram']);
                    $("#memory_info"+(i-1)).text(res[i]['memory']);
                }
            }
        },
        error: function() {
        }
    });
}

$(document).ready(function () {
    $("li#xmppserver").addClass("active");
    $(".btn-active").removeClass("btn-active");
    $("#msmanager").addClass("btn-active");

    $(".deleteXmpp").click(function(){
        var serverip = $(this).attr("serverIp");
        if (confirm("부분봉사기(" + serverip + ")를 삭제하겠습니까?")) {
            $.ajax({
                type: 'POST',
                url: baseUrl + 'server/deleteXmpp',
                data: {
                    serverip: serverip
                },
                dataType: 'html',
                success: function(res){
                    if (res == "success")
                        location.href = xmppUrl;
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