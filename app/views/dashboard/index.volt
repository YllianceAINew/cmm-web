{{ content() }}

<script type="text/javascript">
    var memory = {{ memory | json_encode }};
    var ram = {{ ram | json_encode }};
    var cpu = {{ cpu |json_encode }};

    var regProvider = [];
    var registerData = {{ registerData | json_encode }};
        for(date in registerData){
            regProvider.push([date,registerData[date]]);
        }

    var logProvider = [];
    var loginData = {{ loginData | json_encode }};
        for(date in loginData){
            logProvider.push([date, loginData[date]]);
        }
</script>

<!-- BEGIN CONTENT -->
<div class="page-content-wrapper">
    <!-- BEGIN CONTENT BODY -->
    <div class="page-content" >
    <div class="row">
        <div class="col-md-6 chartbody">
            <h4 align="left">{{ lang._('dashboard_register') }}</h4>
            <div class="div-view">
                <div class="col-md-4 col-sm-4">
                    <label>{{ lang._('dashboard_sort') }}</label>
                    <select id="typeSelect1" onchange="onSelType1()">
                    <?php
                        $i = 0;
                        for($i = 0;$i < 4;$i ++){
                            if($regUnit == $typeSelect[$i])
                                echo "<option value = '".$typeSelect[$i]."' selected>".$typeName[$i]."</option>";
                            else
                                echo "<option value = '".$typeSelect[$i]."'>".$typeName[$i]."</option>";
                        }
                    ?>
                    </select>
                </div>
                <div class="col-md-8 col-sm-8">
                    <div id="create" class="input-group date-picker input-daterange" data-date="10/11/2012" data-date-format = "yyyy-mm-dd">
                        <label>{{ lang._('dashboard_day') }}&nbsp</label>
                        <select id="selRegYear">
                        <?php
                        $i = 0;
                        for($i=0;$i<count($years);$i++)
                            if($selRegYear == $years[$i])
                                echo "<option value='".$years[$i]."' selected>".$years[$i]."</option>";
                            else
                                echo "<option value='".$years[$i]."'>".$years[$i]."</option>";
                        ?>
                        </select><label>년</label>
                        {% if regUnit == "1 days" or regUnit == "1 weeks"%}
                            <select id="selRegMonth">
                            <?php
                            $i = 0;
                            for($i=0;$i<count($months);$i++)
                                if($selRegMonth == $months[$i])
                                    echo "<option value='".$months[$i]."' selected>".$months[$i]."</option>";
                                else
                                    echo "<option value='".$months[$i]."'>".$months[$i]."</option>";
                            ?>
                            </select><label>월</label>
                        {% elseif regUnit == "1 years" %}
                            <label>&nbsp-&nbsp</label>
                            <select id="selRegYearTo">
                            <?php
                            $i = 0;
                            for($i=0;$i<count($years);$i++)
                                if($selRegYearTo == $years[$i])
                                    echo "<option value='".$years[$i]."' selected>".$years[$i]."</option>";
                                else
                                    echo "<option value='".$years[$i]."'>".$years[$i]."</option>";
                            ?>
                            </select><label>년</label>
                        {% endif %}
                        <button id="seeChart" onclick="onRegisterChart()">Reload</button>
                    </div>
                </div>
                <div id="site_activities_content1" class="display-none">
                    <div id="site_activities1" style="height: 288px;margin-top:42px"> </div>
                </div>

            </div>
        </div>

        <div class="col-md-6 chartbody">
            <h4 align="left">{{ lang._('dashboard_login') }}</h4>
            <div class="div-view">
                <div class="col-md-4 col-sm-4">
                    <label>{{ lang._('dashboard_sort') }}</label>
                    <select id="typeSelect2" onchange ="onSelType2()">
                        <?php
                        $i = 0;
                        for($i = 0;$i < 4;$i ++){
                            if($logUnit == $typeSelect[$i])
                                echo "<option value = '".$typeSelect[$i]."' selected>".$typeName[$i]."</option>";
                            else
                                echo "<option value = '".$typeSelect[$i]."'>".$typeName[$i]."</option>";
                        }
                    ?>
                    </select>
                </div>
                <div class="col-md-8 col-sm-8">
                    <div id="create" class="input-group date-picker input-daterange" data-date="10/11/2012" data-date-format = "yyyy-mm-dd">
                        <label>{{ lang._('dashboard_day') }}&nbsp</label>
                        <select id="selLogYear">
                        <?php
                        $i = 0;
                        for($i=0;$i<count($years);$i++)
                            if($selLogYear == $years[$i])
                                echo "<option value='".$years[$i]."' selected>".$years[$i]."</option>";
                            else
                                echo "<option value='".$years[$i]."'>".$years[$i]."</option>";
                        ?>
                        </select><label>년</label>
                        {% if logUnit == "1 days" or logUnit == "1 weeks"%}
                            <select id="selLogMonth">
                            <?php
                            $i = 0;
                            for($i=0;$i<count($months);$i++)
                                if($selLogMonth == $months[$i])
                                    echo "<option value='".$months[$i]."' selected>".$months[$i]."</option>";
                                else
                                    echo "<option value='".$months[$i]."'>".$months[$i]."</option>";
                            ?>
                            </select><label>월</label>
                        {% elseif logUnit == "1 years" %}
                            <label>&nbsp-&nbsp</label>
                            <select id="selLogYearTo">
                            <?php
                            $i = 0;
                            for($i=0;$i<count($years);$i++)
                                if($selLogYearTo == $years[$i])
                                    echo "<option value='".$years[$i]."' selected>".$years[$i]."</option>";
                                else
                                    echo "<option value='".$years[$i]."'>".$years[$i]."</option>";
                            ?>
                            </select><label>년</label>
                        {% endif %}
                        <button id="seeChart" onclick="onLoginChart()">Reload</button>
                    </div>
                </div>
                <div id="site_activities_content2" class="display-none">
                    <div id="site_activities2" style="height: 288px;margin-top:42px"> </div>
                </div>

            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 usebody">
            <h4 align="left">{{ lang._('dashboard_cpu') }}</h4>
            <div class="div-view">
                <div id="chart_5" class="chart" style="height: 295px;padding-top: 30px;position: absolute;left: 4px;"> </div>
            </div>
        </div>
        <div class="col-md-4 usebody">
            <h4 align="left">{{ lang._('dashboard_ram') }}</h4>
            <div class="div-view">
                <div class="row">
                    <div class="col-md-12 row" pull-right>
                        <div class="col-md-7" align="right">
                            <p>{{ lang._('dashboard_used') }}</p>
                            <p>{{ lang._('dashboard_free') }}</p>
                            <p>{{ lang._('dashboard_all') }}</p>
                        </div>
                        <div class="col-md-5">
                        {% if ram[3]=="gb" %}
                            <p>{{ "%.2f"|format(ram[0])}} GB</p>
                            <p>{{ "%.2f"|format(ram[2])}} GB</p>
                            <p>{{ "%.2f"|format(ram[1])}} GB</p>
                        {% elseif ram[3]=="mb" %}
                            <p>{{ ram[0] }} MB</p>
                            <p>{{ ram[2] }} MB</p>
                            <p>{{ ram[1] }} MB</p>
                        {% endif %}                 
                        </div>
                    </div>
                </div>
                <div id="chart_7" class="chart" style="height: 250px;position: absolute;left: 4px;"> </div>
            </div>
        </div>
        <div class="col-md-4 usebody">
            <h4 align="left">{{ lang._('dashboard_memory') }}</h4>
            <div class="div-view">
                <div class="row">
                    <div class="col-md-12" pull-right>
                        <div class="col-md-7" align="right">
                            <p>{{ lang._('dashboard_used') }}</p>
                            <p>{{ lang._('dashboard_free') }}</p>
                            <p>{{ lang._('dashboard_all') }}</p>
                        </div>
                        <div class="col-md-5">
                            <p> {{memory[0]}} GB</p>
                            <p>{{memory[1]-memory[0]}} GB</p>
                            <p>{{memory[1]}} GB</p>
                        </div>
                    </div>
                </div>
                <div id="chart_6" class="chart" style="height: 250px;position: absolute;left: 4px;"> </div>

            </div>
        </div>
    </div>
    </div>  <!-- page-content -->
</div>