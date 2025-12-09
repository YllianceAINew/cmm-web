
function onBackBtn(){
    history.go(-1);
}

$(document).ready(function(){

	$("#regCancel").click(function(){
		if (!confirm("가입자등록을 거절하겠습니까?"))
			return;
		$.ajax({
			type : 'POST',
			url : baseUrl + "member/regCancel",
			data : {
				'userid' : $("#userid").text()
			},
			dataType : 'html',
			success : function(res){
				location.href = baseUrl + "member/register";
			},
			error : function(res){
			}
		});
	});

	$("#regAllow").click(function(){
		if (!confirm("가입자등록을 승인하겠습니까?"))
			return;
		$.ajax({
			type : 'POST',
			url : baseUrl + "member/regAllow",
			data : {
				'userid' : $("#userid").text(),
				'groupid' :　$(".bs-select").val()
			},
			dataType : 'html',
			success : function(res){
				location.href = baseUrl + "member/register";
			},
			error : function(res){
			}
		});
	});

	$("li#register").addClass("active");
    $(".btn-active").removeClass("btn-active");
    $("#mregister").addClass("btn-active");


});