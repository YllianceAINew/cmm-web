var Dashboard = function() {

    return {
        initChartsReg: function() {
            if (!jQuery.plot) {
                return;
            }

            function showChartTooltip(x, y, xValue, yValue) {
                $('<div id="tooltip" class="chart-tooltip">' + yValue + '<\/div>').css({
                    position: 'absolute',
                    display: 'none',
                    top: y - 40,
                    left: x - 40,
                    border: '0px solid #ccc',
                    padding: '2px 6px',
                    'background-color': '#fff'
                }).appendTo("body").fadeIn(200);
            }

            var data = [];
            var totalPoints = 250;

            // random data generator for plot charts

            function getRandomData() {
                if (data.length > 0) data = data.slice(1);
                // do a random walk
                while (data.length < totalPoints) {
                    var prev = data.length > 0 ? data[data.length - 1] : 50;
                    var y = prev + Math.random() * 10 - 5;
                    if (y < 0) y = 0;
                    if (y > 100) y = 100;
                    data.push(y);
                }
                // zip the generated y values with the x values
                var res = [];
                for (var i = 0; i < data.length; ++i) res.push([i, data[i]])
                return res;
            }

            function randValue() {
                return (Math.floor(Math.random() * (1 + 50 - 20))) + 10;
            }

            if ($('#site_activities1').size() != 0) {
                //site activities
                var previousPoint2 = null;
                $('#site_activities_loading').hide();
                $('#site_activities_content1').show();

                var data1 = regProvider;

                var plot_statistics = $.plot($("#site_activities1"),

                    [{
                        data: data1,
                        lines: {
                            fill: 0.2,
                            lineWidth: 0,
                        },
                        color: ['#BAD9F5']
                    }, {
                        data: data1,
                        points: {
                            show: true,
                            fill: true,
                            radius: 4,
                            fillColor: "#9ACAE6",
                            lineWidth: 2
                        },
                        color: '#9ACAE6',
                        shadowSize: 1
                    }, {
                        data: data1,
                        lines: {
                            show: true,
                            fill: false,
                            lineWidth: 3
                        },
                        color: '#9ACAE6',
                        shadowSize: 0
                    }],

                    {

                        xaxis: {
                            tickLength: 0,
                            tickDecimals: 0,
                            mode: "categories",
                            min: 0,
                            font: {
                                lineHeight: 18,
                                style: "normal",
                                variant: "small-caps",
                                color: "#6F7B8A"
                            }
                        },
                        yaxis: {
                            ticks: 5,
                            tickDecimals: 0,
                            tickColor: "#eee",
                            min: 0,
                            font: {
                                lineHeight: 14,
                                style: "normal",
                                variant: "small-caps",
                                color: "#6F7B8A"
                            }
                        },
                        grid: {
                            hoverable: true,
                            clickable: true,
                            tickColor: "#eee",
                            borderColor: "#eee",
                            borderWidth: 1
                        }
                    });

                $("#site_activities1").bind("plothover", function(event, pos, item) {
                    $("#x").text(pos.x.toFixed(2));
                    $("#y").text(pos.y.toFixed(2));
                    if (item) {
                        if (previousPoint2 != item.dataIndex) {
                            previousPoint2 = item.dataIndex;
                            $("#tooltip").remove();
                            var x = item.datapoint[0].toFixed(2),
                                y = item.datapoint[1].toFixed(2);console.log(item.pageY);
                            showChartTooltip(item.pageX, item.pageY, item.datapoint[0], item.datapoint[1] + '명');
                        }
                    }
                });

                $('#site_activities1').bind("mouseleave", function() {
                    $("#tooltip").remove();
                });
            }
        },
        initChartsLog: function() {
            if (!jQuery.plot) {
                return;
            }

            function showChartTooltip(x, y, xValue, yValue) {
                $('<div id="tooltip" class="chart-tooltip">' + yValue + '<\/div>').css({
                    position: 'absolute',
                    display: 'none',
                    top: y - 40,
                    left: x - 40,
                    border: '0px solid #ccc',
                    padding: '2px 6px',
                    'background-color': '#eee'
                }).appendTo("body").fadeIn(200);
            }

            var data = [];
            var totalPoints = 250;

            // random data generator for plot charts

            function getRandomData() {
                if (data.length > 0) data = data.slice(1);
                // do a random walk
                while (data.length < totalPoints) {
                    var prev = data.length > 0 ? data[data.length - 1] : 50;
                    var y = prev + Math.random() * 10 - 5;
                    if (y < 0) y = 0;
                    if (y > 100) y = 100;
                    data.push(y);
                }
                // zip the generated y values with the x values
                var res = [];
                for (var i = 0; i < data.length; ++i) res.push([i, data[i]])
                return res;
            }

            function randValue() {
                return (Math.floor(Math.random() * (1 + 50 - 20))) + 10;
            }

            if ($('#site_activities2').size() != 0) {
                //site activities
                var previousPoint2 = null;
                $('#site_activities_loading').hide();
                $('#site_activities_content2').show();

                var data1 = logProvider;

                var plot_statistics = $.plot($("#site_activities2"),

                    [{
                        data: data1,
                        lines: {
                            fill: 0.2,
                            lineWidth: 0,
                        },
                        color: ['#BAD9F5']
                    }, {
                        data: data1,
                        points: {
                            show: true,
                            fill: true,
                            radius: 4,
                            fillColor: "#9ACAE6",
                            lineWidth: 2
                        },
                        color: '#9ACAE6',
                        shadowSize: 1
                    }, {
                        data: data1,
                        lines: {
                            show: true,
                            fill: false,
                            lineWidth: 3
                        },
                        color: '#9ACAE6',
                        shadowSize: 0
                    }],

                    {

                        xaxis: {
                            tickLength: 0,
                            tickDecimals: 0,
                            mode: "categories",
                            min: 0,
                            font: {
                                lineHeight: 18,
                                style: "normal",
                                variant: "small-caps",
                                color: "#6F7B8A"
                            }
                        },
                        yaxis: {
                            ticks: 5,
                            tickDecimals: 0,
                            tickColor: "#eee",
                            min: 0,
                            font: {
                                lineHeight: 14,
                                style: "normal",
                                variant: "small-caps",
                                color: "#6F7B8A"
                            }
                        },
                        grid: {
                            hoverable: true,
                            clickable: true,
                            tickColor: "#eee",
                            borderColor: "#eee",
                            borderWidth: 1
                        }
                    });

                $("#site_activities2").bind("plothover", function(event, pos, item) {
                    $("#x").text(pos.x.toFixed(2));
                    $("#y").text(pos.y.toFixed(2));
                    if (item) {
                        if (previousPoint2 != item.dataIndex) {
                            previousPoint2 = item.dataIndex;
                            $("#tooltip").remove();
                            var x = item.datapoint[0].toFixed(2),
                                y = item.datapoint[1].toFixed(2);//console.log(item.datapoint[1].toFixed(2));
                            showChartTooltip(item.pageX, item.pageY, item.datapoint[0], item.datapoint[1] + '명');
                        }
                    }
                });

                $('#site_activities2').bind("mouseleave", function() {
                    $("#tooltip").remove();
                });
            }
        },
        init: function() {
            this.initChartsReg();
            this.initChartsLog();
        }
    };
}();
if (App.isAngularJsApp() === false) {
    jQuery(document).ready(function() {
        Dashboard.init(); // init metronic core componets
    });
}
var ChartsAmcharts = function() {

    var initChartSample7 = function() {
        var chart = AmCharts.makeChart("chart_7", {
            "type": "pie",
            "theme": "light",

            "fontFamily": 'Open Sans',
            
            "color":    '#888',

            "dataProvider": [{
                "country": "남은용량",
                "value": ram[1]-ram[0]
            }, {
                "country": "사용한 용량",
                "value": ram[0]
            }],
            "valueField": "value",
            "titleField": "country",
            "outlineAlpha": 0.4,
            "depth3D": 15,
            "balloonText": "[[title]]<br><span style='font-size:14px'><b>[[value]]</b> ([[percents]]%)</span>",
            "angle": 30,
            "exportConfig": {
                menuItems: [{
                    icon: '/lib/3/images/export.png',
                    format: 'png'
                }]
            }
        });

        jQuery('.chart_7_chart_input').off().on('input change', function() {
            var property = jQuery(this).data('property');
            var target = chart;
            var value = Number(this.value);
            chart.startDuration = 0;

            if (property == 'innerRadius') {
                value += "%";
            }

            target[property] = value;
            chart.validateNow();
        });

        $('#chart_7').closest('.portlet').find('.fullscreen').click(function() {
            chart.invalidateSize();
        });
    }

    var initChartSample5 = function() {
        var chart = AmCharts.makeChart("chart_5", {
            "type": "pie",
            "theme": "light",

            "fontFamily": 'Open Sans',
            
            "color":    '#888',

            "dataProvider": [{
                "country": "free space",
                "value": 100 - cpu
            }, {
                "lineColor": "#fbd51a",
                "country": "used space", 
                "value": cpu
            }],
            "valueField": "value",
            "titleField": "country",
            "outlineAlpha": 0.4,
            "depth3D": 15,
            "balloonText": "[[title]]<br><span style='font-size:14px'><b>[[value]]</b> ([[percents]]%)</span>",
            "angle": 30,
            "exportConfig": {
                menuItems: [{
                    icon: '/lib/3/images/export.png',
                    format: 'png'
                }]
            }
        });

        jQuery('.chart_5_chart_input').off().on('input change', function() {
            var property = jQuery(this).data('property');
            var target = chart;
            var value = Number(this.value);
            chart.startDuration = 0;

            if (property == 'innerRadius') {
                value += "%";
            }

            target[property] = value;
            chart.validateNow();
        });

        $('#chart_5').closest('.portlet').find('.fullscreen').click(function() {
            chart.invalidateSize();
        });
    }

    var initChartSample6 = function() {
        var chart = AmCharts.makeChart("chart_6", {
            "type": "pie",
            "theme": "light",

            "fontFamily": 'Open Sans',
            
            "color":    '#888',

            "dataProvider": [{
                "country": "Free space",
                "value": memory[1]-memory[0]
            }, {
                "country": "Used space",
                "value": memory[0]
            }],
            "valueField": "value",
            "titleField": "country",
            "outlineAlpha": 0.4,
            "depth3D": 15,
            "balloonText": "[[title]]<br><span style='font-size:14px'><b>[[value]]</b> ([[percents]]%)</span>",
            "angle": 30,
            "exportConfig": {
                menuItems: [{
                    icon: '/lib/3/images/export.png',
                    format: 'png'
                }]
            }
        });

        jQuery('.chart_6_chart_input').off().on('input change', function() {
            var property = jQuery(this).data('property');
            var target = chart;
            var value = Number(this.value);
            chart.startDuration = 0;

            if (property == 'innerRadius') {
                value += "%";
            }

            target[property] = value;
            chart.validateNow();
        });

        $('#chart_6').closest('.portlet').find('.fullscreen').click(function() {
            chart.invalidateSize();
        });
    }
    
    return {
        //main function to initiate the module
        init: function() {
            initChartSample5();
            initChartSample6();
            initChartSample7();
        }

    };

}();
var onSelType1 = function(){
    selectType1 = $("#typeSelect1").val();
    selRegYear = $("#selRegYear").val();
    selRegMonth = $("#selRegMonth").val();
    selRegYearTo = $("#selRegYearTo").val();

    selectType2 = $("#typeSelect2").val();
    selLogYear = $("#selLogYear").val();
    selLogMonth = $("#selLogMonth").val();
    selLogYearTo = $("#selLogYearTo").val();
    location.href = baseUrl + "dashboard/index?RegType="+selectType1+"&selRegYear="+selRegYear+"&selRegMonth="+selRegMonth
                    +"&selRegYearTo="+selRegYearTo+"&logType="+selectType2+"&selLogYear="+selLogYear+"&selLogMonth="+selLogMonth
                    +"&selLogYearTo="+selLogYearTo;
}

var onSelType2 = function(){
    selectType1 = $("#typeSelect1").val();
    selRegYear = $("#selRegYear").val();
    selRegMonth = $("#selRegMonth").val();
    selRegYearTo = $("#selRegYearTo").val();

    selectType2 = $("#typeSelect2").val();
    selLogYear = $("#selLogYear").val();
    selLogMonth = $("#selLogMonth").val();
    selLogYearTo = $("#selLogYearTo").val();
    location.href = baseUrl + "dashboard/index?RegType="+selectType1+"&selRegYear="+selRegYear+"&selRegMonth="+selRegMonth
                    +"&selRegYearTo="+selRegYearTo+"&logType="+selectType2+"&selLogYear="+selLogYear+"&selLogMonth="+selLogMonth
                    +"&selLogYearTo="+selLogYearTo;
}

var onRegisterChart = function(){
   selectType1 = $("#typeSelect1").val();
    selRegYear = $("#selRegYear").val();
    selRegMonth = $("#selRegMonth").val();
    selRegYearTo = $("#selRegYearTo").val();

    selectType2 = $("#typeSelect2").val();
    selLogYear = $("#selLogYear").val();
    selLogMonth = $("#selLogMonth").val();
    selLogYearTo = $("#selLogYearTo").val();
    location.href = baseUrl + "dashboard/index?RegType="+selectType1+"&selRegYear="+selRegYear+"&selRegMonth="+selRegMonth
                    +"&selRegYearTo="+selRegYearTo+"&logType="+selectType2+"&selLogYear="+selLogYear+"&selLogMonth="+selLogMonth
                    +"&selLogYearTo="+selLogYearTo;
}

var onLoginChart = function(){
    selectType1 = $("#typeSelect1").val();
    selRegYear = $("#selRegYear").val();
    selRegMonth = $("#selRegMonth").val();
    selRegYearTo = $("#selRegYearTo").val();

    selectType2 = $("#typeSelect2").val();
    selLogYear = $("#selLogYear").val();
    selLogMonth = $("#selLogMonth").val();
    selLogYearTo = $("#selLogYearTo").val();
    location.href = baseUrl + "dashboard/index?RegType="+selectType1+"&selRegYear="+selRegYear+"&selRegMonth="+selRegMonth
                    +"&selRegYearTo="+selRegYearTo+"&logType="+selectType2+"&selLogYear="+selLogYear+"&selLogMonth="+selLogMonth
                    +"&selLogYearTo="+selLogYearTo;
}
$(document).ready(function () {

    $(".btn-active").removeClass("btn-active");
    $("#mfirst").addClass("btn-active");
    ChartsAmcharts.init(); 

});