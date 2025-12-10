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
        "order": [[4, "desc"]], // Sort by crttime column (5th column, index 4) descending
        "columnDefs": [{
            "targets": 0,
            "orderable": false,
            "searchable": false
        }, {
            "targets": 5, // Delete column
            "orderable": false,
            "searchable": false
        }, {
            "searchable": true,
            "targets": [1, 2, 3, 4]
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
                    $("#search").modal('show');
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
                        $("#delete").modal('show');
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

function onDeleteHistory()
{
    var id = $("#deleteHistId").text();
    if (id == -1)
        return;
    
    $.ajax({
        type: 'POST',
        url: baseUrl + 'log/deleteAlert',
        data: {
            'ID' : id,
        },
        dataType: 'html',
        success: function(res){
            window.location.href = baseUrl + "/log/xmppHistory";        
        },
        error: function() {

        }
    }); 
   
}

var onDeleteAlert = function(){
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
            url: baseUrl + 'log/deleteAlert',
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

var onSearchAlert = function(){
    var crtFrom =  $.trim ($('#createFrom').val());
    var crtTo =  $.trim ($('#createTo').val());
    var contents = $.trim ($('#content').val());
    var select = $.trim($('#typeSelect').val());

    location.href = baseUrl + "log/xmppHistory/from="+ crtFrom +"/to="+ crtTo +"/cont="+ contents +"/type="+ select;

}

$(document).ready(function () {
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

    $("#alertDel").click(function(){
        flag = 0;
        $(".hasCheckTD").each (function () {
            child = $(this).find("[type='checkbox']");
            checked = $(child).is(":checked");
            if (checked == true)
                flag = 1;
        });
        if (flag == 0){
            //alert("삭제하려는 경보리력를 선택하십시오.");
            location.href = location.href;
        }
        else
            $("#deleteLogMessage").text("선택된 경보리력들을 삭제하겠습니까?");
    });

    $(".deleteHistBtn").click(function(){
        var id = $(this).attr("data-id");
        $("#deleteHistId").text(id);
    });

    $("li#xmppHistory").addClass("active");
});
