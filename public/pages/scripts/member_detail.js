var onSaveEdit = function(msg){
	if (!confirm(msg))
		return;
	
	// Get values
	var username = $("#editUserName").text().trim();
	var isBlockCheckbox = $("#isBlock");
	var levelSelect = $("#levelSelect");
	
	// Validate inputs
	if (!username) {
		alert("Error: Username not found.");
		return;
	}
	
	if (levelSelect.length === 0 || !levelSelect.val()) {
		alert("Error: Level select not found or no level selected.");
		return;
	}
	
	// Get checkbox value (default to false if checkbox doesn't exist)
	var isBlock = isBlockCheckbox.length > 0 ? isBlockCheckbox.is(":checked") : false;
	var level = levelSelect.val();
	
	// Convert boolean to string for server
	var isBlockValue = isBlock ? "true" : "false";
	
	console.log("Saving edit:", {
		username: username,
		isBlock: isBlockValue,
		level: level
	});
	
	$.ajax({
		type : 'POST',
		url : baseUrl + "member/saveEdit",
		data : {
			'username' : username,
			'isBlock' : isBlockValue,
			'level' : level
		},
		dataType : 'html',
		success : function(res){
			//location.href = baseUrl + "member/summary";
		},
		error : function(xhr, status, error){
			console.error("Error saving edit:", error);
			console.error("Response:", xhr.responseText);
			alert("An error occurred while saving. Please check the console for details.");
		}
	});
}

function onDeleteMember(){
	var memberId = $("#memberId").val();
	var memberName = $("#memberName").val();
	
	if (!memberId) {
		alert("Error: Member ID not found.");
		return;
	}
	
	$.ajax({
		type: 'POST',
		url: baseUrl + 'member/deleteMember',
		data: {
			ID: memberId,
			ids: ''
		},
		dataType: 'html',
		success: function(res){
			if (res == "error") {
				alert("Error: Failed to delete member.");
			} else {
				// Close modal
				$('#deleteMemberModal').modal('hide');
				// Redirect to summary page
				location.href = baseUrl + "member/summary";
			}
		},
		error: function(xhr, status, error){
			console.error("Error deleting member:", error);
			console.error("Response:", xhr.responseText);
			alert("An error occurred while deleting. Please check the console for details.");
		}
	});
}

$(document).ready(function(){
    $("li#summary").addClass("active");
    $(".btn-active").removeClass("btn-active");
    $("#mregister").addClass("btn-active");
    
    // Setup delete modal
    $('#deleteMemberModal').on('show.bs.modal', function (event) {
        var memberName = $("#memberName").val();
        $("#deleteMemberNameText").text(memberName || '');
    });
    
    // Handle delete confirmation
    $("#confirmDeleteMember").on('click', function() {
        onDeleteMember();
    });
});