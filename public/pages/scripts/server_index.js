var TableDatatablesManaged = function () {

    var initTable1 = function () {

        var table = $("#sample_1");

        // begin first table
        table.dataTable({

            // Internationalisation. For more info refer to http://datatables.net/manual/i18n
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
                "searchPlaceholder" : "Search···",
                "zeroRecords": "검색결과가 없습니다.",
                "paginate": {
                    "previous":"이전",
                    "next": "다음",
                    "last": "끝",
                    "first": "시작"
                }
            },

            // Or you can use remote translation file
            //"language": {
            //   url: '//cdn.datatables.net/plug-ins/3cfcc339e89/i18n/Portuguese.json'
            //},

            // Uncomment below line("dom" parameter) to fix the dropdown overflow issue in the datatable cells. The default datatable layout
            // setup uses scrollable div(table-scrollable) with overflow:auto to enable vertical scroll(see: assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js). 
            // So when dropdowns used the scrollable div should be removed. 
            "dom": "<'row'<'col-md-6 col-sm-12'><'col-md-6 col-sm-12'f>r><'table-scrollable't><'row'<'col-md-5 col-sm-5'l><'col-md-7 col-sm-7'p>>",

            "bStateSave": true, // save datatable state(pagination, sort, etc) in cookie.

            "columnDefs": [ {
                "targets": 0,
                "orderable": false,
                "searchable": false
            }],

            "lengthMenu": [
                [5, 10, 20, 50, 100],
                [5, 10, 20, 50, 100] // change per page values here
            ],
            // set the initial value
            "pageLength": 10,
            "pagingType": "bootstrap_full_number",
            "columnDefs": [{  // set default column settings
                'orderable': false,
                'targets': [0]
            }, {
                "searchable": false,
                "targets": [0,4,5,6,7]
            }],
            "order": [
                [0,"asc"]
            ] // set first column as a default sort by asc
        });

        var tableWrapper = jQuery('#sample_1_wrapper');

        table.find('.group-checkable').change(function () {
            var set = jQuery(this).attr("data-set");
            var checked = jQuery(this).is(":checked");
            jQuery(set).each(function () {
                if (checked) {
                    $(this).prop("checked", true);
                    $(this).parents('tr').addClass("active");
                } else {
                    $(this).prop("checked", false);
                    $(this).parents('tr').removeClass("active");
                }
            });
            jQuery.uniform.update(set);
        });

        table.on('change', 'tbody tr .checkboxes', function () {
            $(this).parents('tr').toggleClass("active");
        });
    }

    return {

        //main function to initiate the module
        init: function () {
            if (!jQuery().dataTable) {
                return;
            }
            initTable1();
        }

    };

}();
if (App.isAngularJsApp() === false) { 
    jQuery(document).ready(function() {
        TableDatatablesManaged.init();  
    });
}

function onSelDelete()
{
    var ids = [];
    $(".childChecks").each(function () {
        var checked = $(this).is(":checked");
        if (checked == true)
            ids.push ($(this).closest(".hasCheckTD").find(".hidden").val());
    });
//console.log(ids);return;
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

function onDelete(id,name)
{
    $.ajax({
        type: 'POST',
        url: baseUrl + 'server/delete',
        data: {
            'ID' : id,
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
        alertbox("","정보를 3문자이상 입력하여야 합니다.","warning");return;
    }
    if (newPassword.length < 6 || confirmPassword.length < 6) {
        alertbox ("","암호를 6문자이상 입력하여야 합니다.","warning");return;
    }
    if (newPassword != confirmPassword) {
        alertbox ("","입력된 암호가 불일치합니다.","warning");return;
    }
    $(".hasChecks").each(function(){
       child = $(this).find("[type='checkbox']");
       if($(child).is(":checked") == true)
       {
        selectVal.push($(child).attr("dataVal"));
       }
    });
    if(selectVal.length == 0){
        alertbox("","접근권한을 설정하십시오.","warning");return;
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
        success: function(res){console.log(res);
            if(res == "already"){
                alertbox("","id가 이미 존재합니다.","warning");return;
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

    $("#selectAllChk").change(function () {
        checked = $(this).is(":checked");

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
    $("#accountDelete").click(function(){
        flag = 0;
        $(".hasCheckTD").each(function(){
            child = $(this).find("[type='checkbox']");
            checked = $(child).is(":checked");
            if(checked == true)
                flag = 1;
        });
        if(flag == 0){
            location.href = location.href;
        }
    });
    $("#deleteBtn").click(function(){
        console.log($(this));
    });
});
