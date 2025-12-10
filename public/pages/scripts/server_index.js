$(function () {
    // Check if DataTable is already initialized and destroy it first
    if ($.fn.dataTable.isDataTable('#sample_1')) {
        $('#sample_1').DataTable().destroy();
    }
    
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
            "targets": [7, 8],
            "orderable": false,
            "searchable": false
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
                    $("#responsive").modal('show');
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
                        $("#deleteAdmin").modal('show');
                    } else {
                        alert("Please select at least one account to delete.");
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

function onSelDelete()
{
    var ids = [];
    $(".childChecks").each(function () {
        var checked = $(this).is(":checked");
        if (checked)
            ids.push ($(this).closest(".hasCheckTD").find(".hidden").val());
    });

    if(ids.length > 0)
    {
        $.ajax({
            type: 'POST',
            url: baseUrl + 'server/delete',
            data: {
                'ID' : '',
                'ids' : JSON.stringify(ids)
            },
            dataType: 'html',
            success: function(res){
                location.href = location.href;     
            },
            error: function() {

            }
        });
    }
}

var deleteAccountId = null;

function onDelete()
{
    if (!deleteAccountId) {
        alert("Error: Account ID not found.");
        return;
    }
    
    $.ajax({
        type: 'POST',
        url: baseUrl + 'server/delete',
        data: {
            'ID' : deleteAccountId,
            'ids' : ''
        },
        dataType: 'html',
        success: function(res){
            location.href = location.href;
        },
        error: function() {

        }
    }); 
}

var submitUserInfo = function() {
    var selectVal = [];
    var userID = $.trim ($("#userID").val());
    var userName = $.trim ($("#userName").val());
    var userOfficial = $.trim ($("#userOfficial").val());
    var newPassword = $.trim ($("#newPassword").val());
    var confirmPassword = $.trim ($("#confirmPassword").val());
    if (userID.length < 3 || userName.length<3 ||userOfficial.length<3) {
        alertbox("","Please enter at least 3 characters.","warning");return;
    }
    if (newPassword.length < 6 || confirmPassword.length < 6) {
        alertbox ("","Please enter a password with at least 6 characters.","warning");return;
    }
    if (newPassword != confirmPassword) {
        alertbox ("","The entered passwords do not match.","warning");return;
    }
    $("#branchSelect [type='checkbox']").each(function(){
       if($(this).is(":checked") == true)
       {
        selectVal.push($(this).attr("dataVal"));
       }
    });
    if(selectVal.length == 0){
        alertbox("","Please set access permissions.","warning");return;
    }
    $.ajax({
        type: 'POST',
        url: baseUrl + 'server/savenew',
        data: {
            'userID' : userID,
            'userName' : userName,
            'userOfficial' : userOfficial,
            'newPassword' : newPassword,
            'selectVal' : JSON.stringify(selectVal)
        },
        dataType: 'html',
        success: function(res){
            if(res == "already"){
                alertbox("","This ID already exists.","warning");return;
            }
            else
                location.href = location.href;
        },
        error: function() {

        }
    }); 
};

$(document).ready(function () {
    $("li#admin").addClass("active");
    $(".btn-active").removeClass("btn-active");
    $("#msmanager").addClass("btn-active");

    $(".checkAll").change(function () {
        var checked = $(this).is(":checked");
        $(".hasCheckTD").each (function () {
            if  ($.trim($(this).parent().find(".loginIDClass").text()) == "admin") return;
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
    
    // Handle delete account click
    $(".deleteAccount").click(function(){
        deleteAccountId = $(this).attr("data-id");
        var accountName = $(this).attr("data-name");
        $("#deleteAccountId").text(deleteAccountId);
        $("#deleteAccountName").text(accountName);
    });
});
