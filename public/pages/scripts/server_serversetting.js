var onRestartService = function(){
	$.ajax({
		type : "POST",
		url : baseUrl + "server/serversetting",
		data : {
			"restart" : "restart",
		},
		dataType : "html",
		success : function(res) {console.log(res)},
		error : function () {}
	});
}

var onStopService = function(){
	var type = "";
	var text = "";
	if($("#stopButton").text() == "봉사기중지"){
		type = "stop";
		text = "봉사기기동";		
	}
	else if($("#stopButton").text() == "봉사기기동"){
		type = "start";
		text = "봉사기중지";
	}
	$.ajax({
		type : "POST",
		url : baseUrl + "server/serversetting",
		data : {
			"setType" : type,
		},
		dataType : "html",
		success : function(res) {$("#stopButton").text(text);
	},
		error : function () {}
	});
}
var onSetServerTime = function(){ 
	if($("#setTimeServer").attr("disabled")=="disabled")
	{
		$.ajax({
			type : "POST",
			url : baseUrl + "server/setServerTime",
			data : {
				"setDate" : $("#setDate").val(),
				"setTime" : $("#setTime").val()
			},
			dataType : "html",
			success : function(res) {
				alertbox("","정확히 설정되였습니다.","success");
				//location.href = location.href
			},
			error : function () {}
		});
	}else{
		if($("#setTimeServer").val() == ""){
			alertbox("","시간봉사기주소를 입력하여주십시오.","warning");return;
		}else{
			$.ajax({
				type : "POST",
				url : baseUrl + "server/setServerTime",
				data : {
					"setTimeServer":$("#setTimeServer").val()
				},
				dataType : "html",
				success : function(res) {
					alertbox("","정확히 설정되였습니다.","success");
					//location.href = location.href
				},
				error : function () {}
			});
		}
	}
};
var onSetServerIp = function(){
	$.ajax({
		type : 'POST',
		url : baseUrl + 'server/setServerIp',
		data : {
			"ip" : $("#serverip").val(),
			"netmask" : $("#servernetmask").val(),
			"gateway" : $("#servergateway").val()
		},
		dataType : "html",
		success : function(res) {console.log(res)},
		error : function () {}
	});
};
function compare(type){
	switch(type){
		case "":return 0;break;
		case "1주": return 7;break;
		case "1달": return 31;break;
		case "1년": return 365;break;
		case "2년": return 365*2;break;
		case "3년": return 365*3;break;
		case "5년": return 365*5;break;
	}
}
var onSetLogTime = function(){
	var text = $("#textDate").val();
	var log = $("#logDate").val();
	var alarm = $("#alarmDate").val();
    var call = $("#callDate").val();
    text = compare(text);
    log = compare(log);
    alarm = compare(alarm);  
    call = compare(call);

	$.ajax({
        type: 'POST',
        url: baseUrl + 'server/setLogTime',
        data: {
            'textDate' : text,
			'logDate' : log,
			'alarmDate' : alarm,
			'callDate' : call
        },
        dataType: 'html',
        success: function(res){ 
        	//location.href = location.href;
         alertbox("","정확히 설정되였습니다.","success");  
        },
        error: function() {

        }
    }); 
}

var onAddAddr = function(){
	$.ajax({
		type : "POST",
		url : baseUrl + "server/addAllowAddr",
		data : {
			"allowIP":$("#input_ipv4").val(),
		},
		dataType : "html",
		success : function(res) {
			if(res =="error"){
				alertbox("","이미 존재하는 IP주소입니다.","warning");return;
			}
			else
				location.href = baseUrl + "server/serversetting";
		},
		error : function () {}
	});
}

var onEditAddr = function(){
	$.ajax({
		type : "POST",
		url : baseUrl + "server/editAllowAddr",
		data : {
			"id": $("#allowNo").val(),
			"allowIP":$("#input").val(),
		},
		dataType : "html",
		success : function(res) {
			if(res == "error")
				alertbox("","이미 존재하는 IP주소입니다.","warning");
			else
				location.href = location.href;
		},
		error : function () {}
	});
}
var onDeleteAddr = function(){
	var ipList = [];
    $(".hasCheckTD").each(function () {
    	child = $(this).find("[type='checkbox']");
        var checked = $(child).is(":checked");
        if (checked)
            ipList.push ($(child).attr("checkVal"));
    });console.log(ipList);
    if (ipList.length > 0){
        $.ajax({
            type: 'POST',
            url: baseUrl + 'server/deleteAddr',
            data: {
                'ipList' : ipList
            },
            dataType: 'html',
            success: function(res){console.log(res);
            },
            error: function() {
            }
        }); 
    }
    location.href = location.href;
}

$(document).ready(function () {
    $("li#setserver").addClass("active");
    $(".btn-active").removeClass("btn-active");
    $("#msmanager").addClass("btn-active");
    $("#setTimeServer").prop("disabled",true);

    $("#selType").change(function(){
    	checked = $(this).is(":checked");
    	if(checked == true){
    		$(this).prop("checked",true);
    		$("#setDate").prop("disabled",true);
    		$("#setTime").prop("disabled",true);
    		$("#setTimeServer").prop("disabled",false);
		}
		else{
			$(this).prop("checked",false);
    		$("#setTimeServer").prop("disabled",true);
    		$("#setDate").prop("disabled",false);
    		$("#setTime").prop("disabled",false);
		}
    });

    $("#selectAllChk").change(function () {
        var checked = $(this).is(":checked");
        $(".hasCheckTD").each (function () {
        	child = $(this).find("[type='checkbox']");
            if (checked == true)
                $(child).prop("checked", true);
            else
                $(child).prop("checked", false);
        });
    });

    $(".editIP").click(function(){
    	$("#editIP h4").text("IP편집");
    	$("#editIP #input").val($(this).parent().parent().find("[class='allowip']").text());
    	$("#editIP #allowNo").val($(this).parent().parent().find("[class='allowNo']").val());
    });

    $("#ipDelete").click(function(){
    	flag = 0;
    	$(".hasCheckTD").each(function(){
    		child = $(this).find("[type='checkbox']");
            checked = $(child).is(":checked");
            if(checked == true)
                flag = 1;
    	});
    	if(flag == 0){
    		//alert("삭제하려는 IP주소들을 선택하십시오.");
    		location.href = location.href;
    	}
    });
    $("#input_ip_1").change(function() {
	    var min = $(this).attr("min");
	    var max = $(this).attr("max");
	    var value = this.valueAsNumber;
	    if(value < min)
	        value = min;
	    else if(value > max)
	        value = max;
	    $(this).val(value.toFixed(2)); 
	 });
});