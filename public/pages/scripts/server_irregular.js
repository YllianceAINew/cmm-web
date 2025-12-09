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
                "targets": [0,1,4,5,6]
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
    $("input.childChecks:checked").each(function() {
        ids.push($(this).val());
    });

    if(ids.length > 0)
    {
        $.ajax({
            type: 'POST',
            url: baseUrl + 'server/deleteRegular',
            data: {
                id : JSON.stringify(ids)
            },
            dataType: 'JSON',
            success: function(res){
                location.href = location.href;     
            },
            error: function(res) {
            }
        });
    }
}

function onDelete()
{
    var target_id = $(".modal#delete #delBody h5").attr("data");

    $.ajax({
        type: 'POST',
        url: baseUrl + 'server/deleteRegular',
        data: {
            id : target_id
        },
        dataType: 'JSON',
        success: function(res){
            location.href = location.href;
        },
        error: function() {

        }
    }); 
}

var submitIrregular = function() {
    var selectVal = [];
    var id = $("#id").val();
    var word = $("#word").val();
    var replace = $("#replace").val();
    if (word.length < 2) {
        alertbox("","정보를 2문자이상 입력하여야 합니다.","warning");return;
    }
    $.ajax({
        type: 'POST',
        url: baseUrl + 'server/saveregular',
        data: {
            'id' : id,
            'word' : word,
            'replace' : replace,
        },
        dataType: 'json',
        success: function(res) {
            location.href = location.href;
        },
        error: function() {

        }
    }); 
};


$(document).ready(function () {
    $("li#irregular").addClass("active");
    $(".btn-active").removeClass("btn-active");
    $("#msmanager").addClass("btn-active");

    $("#selectAllChk").change(function () {
        checked = $(this).is(":checked");
        $("input.childChecks").prop("checked", checked);
    });

    /**
     * 개별행삭제
     */
    $(".deleteBtn").click(function(){
        var target_name = $(this).attr("name");
        var target_value = $(this).attr("value");
        $(".modal#delete #delBody h5").attr("data", target_value);
        $(".modal#delete #delBody span").html("(" + target_name +")");
    });
    
    $(".changeBtn").click(function(){
        var target_id = $(this).attr("data-id");
        var target_name = $(this).attr("data-word");
        var target_replace = $(this).attr("data-replace");
        $(".modal#responsive .modal-title").text("비규범어 편집");
        $(".modal#responsive #id").val(target_id);
        $(".modal#responsive #word").val(target_name);
        $(".modal#responsive #replace").val(target_replace);
    });
});
