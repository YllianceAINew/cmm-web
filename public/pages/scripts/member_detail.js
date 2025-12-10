var onSaveEdit = function(msg){
	if (!confirm(msg))
		return;
	isBlock = $("#isBlock").is(":checked");
	level = $("#levelSelect").val();
	$.ajax({
		type : 'POST',
		url : baseUrl + "member/saveEdit",
		data : {
			'username' : $("#editUserName").text(),
			'isBlock' : isBlock,
			'level' : level
		},
		dataType : 'html',
		success : function(res){
			location.href = baseUrl + "member/summary";
		},
		error : function(res){
		}
	});
}

$(document).ready(function(){
    $("li#summary").addClass("active");
    $(".btn-active").removeClass("btn-active");
    $("#mregister").addClass("btn-active");
});