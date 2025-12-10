var TableDatatablesManaged = function () {
    var table;

    var initTable1 = function () {

        table = $("#sample_1");

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
                'targets': [0,1,2,3,4,5,6,7,8]
            }, {
                "searchable": false,
                "targets": []
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

        table.on('change', 'tbody tr .hasCheckTD', function () {
            if ($(this).is(":checked")) {
                $(this).parents('tr').addClass("active");
            } else {
                $(this).parents('tr').removeClass("active");
            }
        });
    }

    return {

        //main function to initiate the module
        init: function () {
            if (!jQuery().dataTable) {
                return;
            }
            initTable1();
            return table;
        }

    };

}();

function onSelAllow()
{
    var ids = [];
    $(".hasCheckTD").each(function () {
        var checked = $(this).is(":checked");
        if (checked)
            ids.push($(this).attr("checkVal"));
    });
    
    if (ids.length === 0) {
        alert("Please select at least one member to allow.");
        return;
    }
    
    $.ajax({
        type: 'POST',
        url: baseUrl + "member/regSelAllow",
        data: {
            "ids": ids
        },
        dataType: 'html',
        success: function(data, status) {
            if (data == "success") {
                $('#allowUser').modal('hide');
                location.href = location.href;
            } else {
                alert("Error: Failed to allow selected members.");
            }
        },
        error: function(xhr, status, error) {
            console.error("Error allowing members:", error);
            alert("An error occurred while allowing members. Please try again.");
        }
    });
}

function onSelCancel(){
    var ids = [];
    $(".hasCheckTD").each(function () {
        var checked = $(this).is(":checked");
        if (checked)
            ids.push($(this).attr("checkVal"));
    });
    
    if (ids.length === 0) {
        alert("Please select at least one member to cancel.");
        return;
    }
    
    $.ajax({
        type: 'POST',
        url: baseUrl + "member/regSelCancel",
        data: {
            "ids": ids
        },
        dataType: 'html',
        success: function(data, status) {
            if (data == "success") {
                $('#cancelUser').modal('hide');
                location.href = location.href;
            } else {
                alert("Error: Failed to cancel selected members.");
            }
        },
        error: function(xhr, status, error) {
            console.error("Error canceling members:", error);
            alert("An error occurred while canceling members. Please try again.");
        }
    });
}

function onBackBtn(){
    history.go(-1);
}

$(document).ready(function () {

    var table = TableDatatablesManaged.init();

    $(".checkAll").change(function () {
        var checked = $(this).is(":checked");
        $(".hasCheckTD").each(function () {
            $(this).prop("checked", checked);
            if (checked) {
                $(this).parents('tr').addClass("active");
            } else {
                $(this).parents('tr').removeClass("active");
            }
        });
    });

    $("#accountAllow").click(function(){
        var flag = 0;
        $(".hasCheckTD").each(function(){
            var checked = $(this).is(":checked");
            if(checked == true)
                flag = 1;
        });
        if(flag == 0){
            alert("Please select at least one member to allow.");
            return false;
        }
    });

    $("#accountCancel").click(function(){
        var flag = 0;
        $(".hasCheckTD").each(function(){
            var checked = $(this).is(":checked");
            if(checked == true)
                flag = 1;
        });
        if(flag == 0) {
            alert("Please select at least one member to cancel.");
            return false;
        }
    });

    $("li#register").addClass("active");
    $(".btn-active").removeClass("btn-active");
    $("#mregister").addClass("btn-active");

});