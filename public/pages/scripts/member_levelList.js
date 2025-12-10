var onInsertLevel = function(){
    levNo = $("#insertModal #levelNo").val();
    levName = $("#insertModal #levelName").val();
    levDesc = $("#insertModal #levelDesc").val();
    if (!levNo || !levName || !levDesc) {
        alertbox("","Please enter the information correctly.","warning");
    } else {
        $.ajax({
            type: 'POST',
            url: baseUrl + 'member/insertLevel',
            data: {
                'levNo' : levNo,
                'levName' : levName,
                'levDesc' : levDesc,
            },
            dataType: 'html',
            success: function(res){
                if (res == "error")
                    alertbox("","This level already exists.","warning");
                else
                    location.href = location.href;
            },
            error: function() {
            }
        }); 
    }
};
var onEditLevel = function(){
    levNo = $("#editModal #levelNo").val();
    levName = $("#editModal #levelName").val();
    levDesc = $("#editModal #levelDesc").val();
    if (!levNo || !levName || !levDesc) {
        alertbox("","Please enter the information correctly.","warning");
    } else {
        $.ajax({
            type: 'POST',
            url: baseUrl + 'member/editLevel',
            data: {
                'levNo' : levNo,
                'levName' : levName,
                'levDesc' : levDesc,
            },
            dataType: 'html',
            success: function(res){
                if (res == "error")
                    alert("Operation failed.");
                location.href = location.href;
            },
            error: function() {
            }
        }); 
    }
};
var onRemoveLevel = function(){
    var levNos = [];
    $(".hasCheckTD").each (function () {
        child = $(this).find("[type='checkbox']");
        checked = $(child).is(":checked");
        if (checked == true) 
            levNos.push($(this).parent().find("[class='levelNums']").text());
    });
    if (levNos.length > 0){
        $.ajax({
            type: 'POST',
            url: baseUrl + 'member/removeLevel',
            data: {
                'levNos' : levNos
            },
            dataType: 'html',
            success: function(res){
            },
            error: function() {
            }
        }); 
    }
    location.href = location.href;
};
function onDeleteLevel(){

    $.ajax({
        type: 'POST',
        url: baseUrl+'member/removeLevel',
        data: {
            'levNo' : $("#deleteLevelId").text()
        },
        dataType: 'html',
        success: function(res){
        },
        error: function() {
        }
    });
    location.href = location.href;
}

$(document).ready(function () {

    $(".blockChecks").click(function(){
        var id = $(this).attr("dataval");
        var state = $(this).is(":checked");
        if (!confirm(state==false?"Do you want to restore the level?":"Do you want to block the level?")) {
            $(this).prop("checked", !state);
            return;
        }
        $.ajax({
            type: 'POST',
            url: baseUrl+'member/Block',
            data: {
                'levNo' : id,
                'levelState' : state,
            },
            dataType: 'html',
            success: function(res){
            },
            error: function() {
                console.log("Operation failed.");
            }
        });
    });

    $("#selectAllChk").change(function () {
        checked = $(this).is(":checked");
        $(".hasCheckTD").each (function () {
            $(this).find("[type='checkbox']").remove();
            html = $(this).html();
            if (checked == false) {
                html += "<input type='checkbox' class='childChecks'>";
            } else {
                html += "<input type='checkbox' class='childChecks' checked>";
            }
            $(this).html (html);
        });
    });

    $(".editLevel").click(function(){
        $("#editModal #levelNo").val($(this).parent().parent().find("[class='levelNums']").text());
        $("#editModal #levelName").val($(this).parent().parent().find("[class='levelNames']").text());
        $("#editModal #levelDesc").val($(this).parent().parent().find("[class='levelDescs']").text());
    });

    $(".deleteLevel").click(function(){
        $("#deleteLevelId").text($(this).parent().parent().find("[class='levelId']").text());
        $("#deleteLevelName").text($(this).parent().parent().find("[class='levelNames']").text());
    });

    $("#removeLevel").click(function(){
        flag = 0;
        $(".hasCheckTD").each (function () {
            child = $(this).find("[type='checkbox']");
            checked = $(child).is(":checked");
            if (checked == true)
                flag = 1;
        });
        if (flag == 0){
            //alert("삭제하려는 급수를 선택하시오.");
            location.href = location.href;
        }
        else
            $("#removeModalMessage").text("Do you want to delete the selected levels?");
    });

    $("li#levelist").addClass("active");
    $(".btn-active").removeClass("btn-active");
    $("#mregister").addClass("btn-active");
});