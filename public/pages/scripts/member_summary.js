$(function () {
    // Initialize DataTable with AdminLTE3 style
    var table = $("#sample_1").DataTable({
        "responsive": true,
        "lengthChange": false,
        "autoWidth": false,
        "stateSave": true,
        "pageLength": 10,
        "lengthMenu": [[5, 10, 20, 50, 100], [5, 10, 20, 50, 100]],
        "order": [[1, "asc"]],
        "columnDefs": [{
            "targets": 0,
            "orderable": false,
            "searchable": false
        }, {
            "searchable": true,
            "targets": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
        }],
        "language": {
            "aria": {
                "sortAscending": ": activate to sort column ascending",
                "sortDescending": ": activate to sort column descending"
            },
            "emptyTable": "No data.",
            "info": "_TOTAL_ from _START_ to _END_",
            "infoEmpty": "No data to display.",
            "infoFiltered": "",
            "lengthMenu": "Display&nbsp&nbsp_MENU_",
            "search": "",
            "searchPlaceholder": "Search···",
            "zeroRecords": "No display.",
            "paginate": {
                "previous": "Prev",
                "next": "Next",
                "last": "End",
                "first": "Start"
            }
        },
        "buttons": [
            {
                text: '<i class="fas fa-plus mr-1"></i>Add',
                className: 'btn btn-primary btn-sm',
                action: function (e, dt, node, config) {
                    // Add button action - can be customized
                    window.location.href = baseUrl + 'member/register';
                }
            },
            {
                text: '<i class="fas fa-trash mr-1"></i>Delete',
                className: 'btn btn-danger btn-sm',
                action: function (e, dt, node, config) {
                    // Check if any rows are selected
                    var hasSelected = false;
                    $(".childChecks").each(function () {
                        if ($(this).is(":checked")) {
                            hasSelected = true;
                            return false;
                        }
                    });
                    if (hasSelected) {
                        $("#deleteSelected").modal('show');
                    } else {
                        alert("Please select at least one member to delete.");
                    }
                }
            },
            {
                text: '<i class="fas fa-search mr-1"></i>Search',
                className: 'btn btn-info btn-sm',
                action: function (e, dt, node, config) {
                    $("#searchModal").modal('show');
                }
            },
            "copy",
            "csv",
            "excel",
            "pdf",
            "print",
            "colvis"
        ]
    });

    // Append buttons to the DataTable wrapper
    table.buttons().container().appendTo('#sample_1_wrapper .col-md-6:eq(0)');
    
    // Handle checkbox changes
    table.on('change', 'tbody tr .childChecks', function () {
        $(this).parents('tr').toggleClass("active");
    });
});

function onSelDelete()
{
    var ids = [];
    $(".childChecks").each(function () {
        var checked = $(this).is(":checked");
        if (checked)
            ids.push ($(this).closest(".hasCheckTD").find(".hidden").val());
    });

    $.ajax({
        type: 'POST',
        url: baseUrl+'member/deleteMember',
        data: {
            ID: '',
            ids: ids
        },
        dataType: 'html',
        success: function(res){
            location.href = location.href ;
        },
        error: function() {
            console.log ("error");
        }
    });
}

var onSearchAccount = function(){
    var sentFrom =  $.trim ($('#sentFrom').val());
    var sentTo =  $.trim ($('#sentTo').val());
    var id = $.trim ($('#id').val());
    var name = $.trim($('#name').val());
    var phone = $.trim($('#phone').val());
    var type = $.trim($('#typeSelect').val());

    location.href = baseUrl + "member/summary/from="+ sentFrom +"/to="+ sentTo +"/id="+ id +"/name="+ name + "/phone=" + phone + "/type=" +type;

}

function onDeleteMember(){
    $.ajax({
        type: 'POST',
        url: baseUrl+'member/deleteMember',
        data: {
            ID: $("#deleteMemberId").text(),
            ids: ''
        },
        dataType: 'html',
        success: function(res){
            if (res == "error")
                alertbox("","조작이 실패했습니다.","warning");
            else
                location.href = location.href ;
        },
        error: function() {
            console.log ("error");
        }
    });
} 

function doFilterCheckbox() {
    var str = $.trim($("#strArrs").val());
    if (!str) return;
    var arr = JSON.parse(str);
    var i = 0;
    var tmp = -1;
    $(".tdCheck").each (function (index, tag) {
        index = index % 10;
        
        if (arr[i][index]) {
            tmp = arr[i][index];
            console.log (tmp);
            $(this).parent().parent().find("[dataval="+tmp+"]").prop("checked", true);
        }
        tmp = -1;
        if (index == 9)
            i += 1;
    });
}

$(document).ready(function () {
    
    $("li#summary").addClass("active");
    $(".btn-active").removeClass("btn-active");
    $("#mregister").addClass("btn-active");

    $(".checkAll").change(function () {
        var checked = $(this).is(":checked");
        $(".hasCheckTD").each (function () {
            if  ($.trim($(this).parent().find(".loginIDClass").text()) == "admin") return;
            $(this).find("[type='checkbox']").remove();
            html = $(this).html();
            
            if (checked == false) {
                html += "<input type='checkbox'>";
            } else {
                html += "<input type='checkbox' class='childChecks' checked>";
            }
            $(this).html (html);
        });
    });

    $(".tdCheck").change(function () {
        var checked = $(this).is(":checked");
        var level = $.trim ($(this).attr("dataVal"));
        var caller = $.trim ($(this).parent().siblings(".callerTD").attr("callerData"));
        console.log (checked);
        console.log (level);
        console.log (caller);
        $.ajax({
            type: 'POST',
            url: baseUrl + 'member/levelChanged',
            data: {
                'level' : level,
                'caller' : caller,
                'checked' : checked ? "true" : "false"
            },
            dataType: 'html',
            success: function(res){
                console.log (res);
            },
            error: function() {
                console.log ("error");
            }
        }); 
    });

    doFilterCheckbox();

    // Keep search button handler for backward compatibility if button exists in DOM
    if ($("#searchAccount").length) {
        $("#searchAccount").on('click', function(){
            $("#searchModal").modal('show');
        });
    }

    $(".deleteMember").click(function(){
        $memberid = $(this).attr("memberid");
        $membername = $(this).attr("membername");
        $("#deleteMemberId").text($memberid);
        $("#deleteMemberName").text($membername);
    });

});