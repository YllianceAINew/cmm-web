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
        "order": [[3, "desc"]], // Sort by signtime column (4th column, index 3) descending
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
            "info": "Showing _START_ to _END_ of _TOTAL_ entries",
            "infoEmpty": "No data to display.",
            "infoFiltered": "",
            "lengthMenu": "Display&nbsp&nbsp_MENU_",
            "search": "",
            "searchPlaceholder": "Search···",
            "zeroRecords": "No matching records found.",
            "paginate": {
                "previous": "Previous",
                "next": "Next",
                "last": "Last",
                "first": "First"
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

function onDeleteSign()
{
    var id = $("#deleteSignId").text();
    if (id == -1)
        return;
    
    $.ajax({
        type: 'POST',
        url: baseUrl + 'log/deleteSign',
        data: {
            'ID' : id,
        },
        dataType: 'html',
        success: function(res){
            window.location.href = baseUrl + "log/signlog";        
        },
        error: function() {

        }
    }); 
   
}

var onSearchSign = function(){

    var user = $.trim($('#user').val());
    var intime = $.trim($('#intime').val());
    var outime = $.trim($('#outime').val());

    location.href = baseUrl + "log/signlog/user="+ user +"/in="+ intime +"/out="+ outime;

}

var onDeleteSignLog = function(){
    
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
            url: baseUrl + 'log/deleteSign',
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

    $("li#signlog").addClass("active");
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
            //alert("삭제하려는 가입리력을 선택하십시오.");
            location.href = location.href;
        }
        else
            $("#deleteLogMessage").text("Do you want to delete the selected sign logs?");
    });

     $(".deleteSignBtn").click(function(){
        var id = $(this).attr("data-id");
        $("#deleteSignId").text(id);
    });

});
