$(function () {
    // Check if DataTable is already initialized and destroy it first
    if ($.fn.dataTable.isDataTable('#sample_1')) {
        $('#sample_1').DataTable().destroy();
    }
    
    // Initialize DataTable with AdminLTE3 style
    var table = $("#sample_1").DataTable({
        "responsive": true,
        "lengthChange": true,
        "autoWidth": false,
        "stateSave": true,
        "pageLength": 25,
        "lengthMenu": [[10, 25, 50, 100, 200, -1], [10, 25, 50, 100, 200, "All"]],
        "order": [[6, "desc"]], // Sort by sendtime column (7th column, index 6) descending
        "columnDefs": [{
            "targets": 0,
            "orderable": false,
            "searchable": false
        }, {
            "targets": 9, // Delete column
            "orderable": false,
            "searchable": false
        }, {
            "searchable": true,
            "targets": [1, 2, 3, 4, 5, 6, 7, 8]
        }],
        "language": {
            "aria": {
                "sortAscending": ": activate to sort column ascending",
                "sortDescending": ": activate to sort column descending"
            },
            "emptyTable": "No data.",
            "info": "총 _TOTAL_ 개중 _START_ 부터 _END_ 까지",
            "infoEmpty": "No data to display.",
            "infoFiltered": "",
            "lengthMenu": "Display&nbsp&nbsp_MENU_",
            "search": "",
            "searchPlaceholder": "Search···",
            "zeroRecords": "검색결과가 없습니다.",
            "paginate": {
                "previous": "이전",
                "next": "다음",
                "last": "끝",
                "first": "시작"
            }
        },
        "buttons": [
            {
                text: '<i class="fas fa-search mr-1"></i>Search',
                className: 'btn btn-primary btn-sm',
                action: function (e, dt, node, config) {
                    $("#searchLog").modal('show');
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
                        $("#deleteLog").modal('show');
                    } else {
                        location.href = location.href;
                    }
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

function onDeleteMsg()
{
    var id = $("#deleteTextId").text();
    if (id == -1)
        return;
    
    $.ajax({
        type: 'POST',
        url: baseUrl + 'log/deleteTextLog',
        data: {
            'ID' : id,
        },
        dataType: 'html',
        success: function(res){
            window.location.href = baseUrl + "/log/textlog";        
        },
        error: function() {

        }
    }); 
   
}

var onSearchLog = function(){
    var sentFrom =  $.trim ($('#sentFrom').val());
    var sentTo =  $.trim ($('#sentTo').val());
    var sender = $.trim ($('#sender').val());
    var receiver = $.trim($('#receiver').val());
    var text = $.trim($('#text').val());
    var type = $.trim($('#typeSelect').val());

    location.href = baseUrl + "/log/textlog/from="+ sentFrom +"/to="+ sentTo +"/snd="+ sender +"/rcvd="+ receiver + "/text=" +text+ "/type=" +type;

}

var onDeleteLog = function(){
    
    var ids = [];

    $(".hasCheckTD").each (function () {
        child = $(this).find("[type='checkbox']");
        checked = $(child).is(":checked");

        if (checked == true) 
            ids.push($(this).parent().find("[class='logno']").val());
    });

    if (ids.length > 0){
        $.ajax({
            type: 'POST',
            url: baseUrl + 'log/deleteTextLog',
            data: {
                'ids' : ids,
            },
            dataType: 'html',
            success: function(res){
                console.log(res);
            },
            error: function() {
                console.log("error");
            }
        }); 
    }
    location.href = location.href;
};

$(document).ready(function () {

    $("li#textlog").addClass("active");
    $(".btn-active").removeClass("btn-active");
    $("#mlog").addClass("btn-active");

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

    $("#deletelog").click(function(){
        flag = 0;
        $(".hasCheckTD").each (function () {
            child = $(this).find("[type='checkbox']");
            checked = $(child).is(":checked");
            if (checked == true)
                flag = 1;
        });
        if (flag == 0){
            //alert("삭제하려는 대화리력을 선택하십시오.");
            location.href = location.href;
        }
        else
            $("#deleteLogMessage").text("선택된 대화리력들을 삭제하겠습니까?");
    });

     $(".deleteTextBtn").click(function(){
        var id = $(this).attr("data-id");
        $("#deleteTextId").text(id);
    });

});
