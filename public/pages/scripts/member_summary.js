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
                },
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
                "searchable": true
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
                "searchable": true,
                "targets": [0,1,2,3,4,5,6,7,8,9]
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
        var table = $('#sample_1');
    });
}

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

    $("#removeAccount").click(function(){
        flag = 0;
        $(".hasCheckTD").each(function(){
            child = $(this).find("[type='checkbox']");
            checked = $(child).is(":checked");
            if(checked == true)
                flag = 1; 
        });
    });

    $(".deleteMember").click(function(){
        $memberid = $(this).attr("memberid");
        $membername = $(this).attr("membername");
        $("#deleteMemberId").text($memberid);
        $("#deleteMemberName").text($membername);
    });

});