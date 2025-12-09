
var onSaveLevel = function(){
    for (var row = 0 ; row < levelSet.length ; row ++) {
        callees = $("tbody").find("[callerdata='"+(levelSet[row])+"']").parent().find("td");
        var chks = [];
        for (var i = 1 ; i < levelSet.length + 1 ; i ++) {
            if ($(callees[i]).children().is(":checked"))
                chks.push(levelSet[i-1]);
        }
        
        $.ajax({
            type: 'POST',
            url: baseUrl + 'member/levelChanged',
            data: {
                'level' : levelSet[row],
                'chks'  : chks
            },
            dataType: 'html',
            success: function(res){
            },
            error: function() {
                console.log ("error");
            }
        });
    }
//    $("#saveModal").fadeOut();
}

function doFilterCheckbox() {
    var str = $.trim($("#strArrs").val());
    if (!str) return;
    var arr = JSON.parse(str);
    for (var i = 0 ; i < arr.length ; i ++){
        for (var j = 0 ; j < arr[i].length ; j ++){
            ///         (i + 1, arr[i][j])    ////
            callees = $("tbody").find("[callerdata='"+(levelSet[i])+"']").parent().find("td");
            for (var col = 0 ; col < levelSet.length ; col ++) {
                if (levelSet[col] == arr[i][j])
                    break;
            } col += 1;
            $(callees[col]).children().prop("checked", true);
        }
    }
}

$(document).ready(function () {
    doFilterCheckbox();
    $("li#edit").addClass("active");
    $(".btn-active").removeClass("btn-active");
    $("#mregister").addClass("btn-active");
});