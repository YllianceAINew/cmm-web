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
            //"dom": "<'row'<'col-md-6 col-sm-12'l><'col-md-6 col-sm-12'>r>t<'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>",

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
                'orderable': true,
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

function onSelDelete(msg)
{
    var ids = [];
    $(".childChecks").each(function () {
        var checked = $(this).is(":checked");
        if (checked == true)
            ids.push ($(this).closest(".hasCheckTD").find(".hidden").val());
    });

    if(confirm(msg))
    {
        $.ajax({
            type: 'POST',
            url: baseUrl + 'account/delete',
            data: {
                'ID' : '',
                'ids' : JSON.stringify(ids)
            },
            dataType: 'html',
            success: function(res){
                window.location.href="/adminpage/account/index";        
            },
            error: function() {

            }
        });
    }
}

function onDelete(id,msg)
{
    if(confirm(msg))
    {
        $.ajax({
            type: 'POST',
            url: baseUrl + 'account/delete',
            data: {
                'ID' : id,
                'ids' : ''
            },
            dataType: 'html',
            success: function(res){
                window.location.href="/adminpage/account/index";        
            },
            error: function() {

            }
        }); 
    }
}
var selectVal = [];
var submitUserInfo = function() {
    var userID = $.trim ($("#userID").val());
    var userName = $.trim ($("#userName").val());
    var userOfficial = $.trim ($("#userOfficial").val());
    var newPassword = $.trim ($("#newPassword").val());
    var confirmPassword = $.trim ($("#confirmPassword").val());
    if (userID.length < 3 || userName.length<3 ||userOfficial.length<3) alertbox ("","정보를 3문자이상 입력하여야 합니다.","warning");
    if (newPassword.length < 6 || confirmPassword.length < 6) alert ("","암호를 3문자이상 입력하여야 합니다.","warning");
    if (newPassword != confirmPassword) alert ("","입력된 암호가 불일치합니다.","warning");

    $.ajax({
        type: 'POST',
        url: baseUrl + 'account/savenew',
        data: {
            'userID' : userID,
            'userName' : userName,
            'userOfficial' : userOfficial,
            'newPassword' : newPassword,
            'selectVal' : JSON.stringify(selectVal)
        },
        dataType: 'html',
        success: function(res){
            location.href = location.href;
        },
        error: function() {

        }
    }); 
};

$(document).ready(function () {
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

    $("#branchSelect").change(function () {
        var val = $(this).val();
        if (val.length > 1)
            selectVal = val;
        else {
            selectVal = [];
            selectVal = val;
        }
    });
});