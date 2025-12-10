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
                'targets': [0,1,2,3,4,5]
            }, {
                "searchable": true,
                "targets": [0,1,2,3,4,5]
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

function onDeleteHistory()
{
    var id = $("#deleteHistId").text();
    if (id == -1 || id == "")
        return;
    
    $.ajax({
        type: 'POST',
        url: baseUrl + 'log/deleteKamAlert',
        data: {
            'ID' : id,
        },
        dataType: 'html',
        success: function(res){
            window.location.href = baseUrl + "/log/sipHistory";        
        },
        error: function() {

        }
    }); 
   
}

var selectVal = [];

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
            url: baseUrl + 'log/deleteKamAlert',
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

    location.href = baseUrl + "log/sipHistory/from="+ crtFrom +"/to="+ crtTo +"/cont="+ contents +"/type="+ select;

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

    $("#branchSelect").change(function () {
        var val = $(this).val();
        if (val.length > 1)
            selectVal = val;
        else {
            selectVal = [];
            selectVal = val;
        }
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

    $("li#sipHistory").addClass("active");
});