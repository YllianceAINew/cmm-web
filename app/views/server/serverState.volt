{{ content() }}
<script type="text/javascript">
    var baseUrl = "{{ url() }}";
    var kamCall = {{ kamCall }};
</script>
<!-- BEGIN CONTENT -->
<div class="page-content-wrapper">
    <!-- BEGIN CONTENT BODY -->
    <div class="page-content" >
        <div>                            <!-- class="portlet light bordered" -->
            <div class="portlet-body">
                <div class="tab-content">
                    <div class="tab-pane fade active in" id="tab_1_1"> 
                    <h3>{{ lang._('server_state') }}</h3>
                        <div class="div-view table-responsive">
                            <div class="portlet-title tabbable-line">
                                <ul class="nav nav-tabs" style="background-image: initial;" id="serverType">
                                    <li class="active">
                                        <a href="#openfire" data-toggle="tab"> {{ lang._('state_openfire') }} </a>
                                    </li>
                                    <li>
                                        <a href="#kamailio" data-toggle="tab">{{ lang._('state_kamailio') }} </a>
                                    </li>
                                </ul>
                            </div>
                            <div class="tab-content">
                                <div class="tab-pane active" id="openfire">
                                    <div id = "subpanel" >{{ lang._('state_info') }}</div>
                                    <div class="serverInfo">
                                    <?php
                                        if($openfireState == "On")
                                            $locate = "/adminpage/pages/img/on.gif";
                                        elseif($openfireState == "Off"){
                                            $locate = "/adminpage/pages/img/off.gif";
                                        }
                                    ?>
                                        <label>{{ lang._('state_ip') }} </label>
                                        <span>{{ openfireIP }}</span><br>
                                        <label>{{ lang._('state_link') }} </label>
                                        <span><img id="locate" src="{{ locate }}"></span><br>
                                    {% if views == "true" %}
                                        <label>{{ lang._('state_time') }}</label>
                                        <span>{{ runtime }} {{ lang._('state_runfrom') }}</span><br>
                                        <label>{{ lang._('state_version') }}</label>
                                        <span>{{ version }}</span><br>
                                        <label>{{ lang._('state_openfire_dir') }}</label>
                                        <span>{{ dir }}</span><br>
                                        <label>{{ lang._('state_openfire_java') }}</label>
                                        <span>{{jversion}}</span><br>
                                        <label>{{ lang._('state_openfire_system') }} </label>
                                        <span>{{ os }}</span><br>
                                        <label>{{ lang._('state_openfire_javamem') }} </label>
                                        <span>{{ jmemory }}{{ lang._('state_used') }}</span><br>
                                    {% endif %}
                                    </div>
                                    <div  id = "subpanel" >{{ lang._('state_state') }}</div>
                                    <div class="serverState">
                                        <label>{{ lang._('state_cpu') }}</label>
                                        <span>{{ openfireCpu }} %</span><br>
                                        <label>{{ lang._('state_ram') }}</label>
                                        <span>{{ lang._('all') }} {{ "%.2f"|format(opentotalMem)}} GB {{ lang._('of') }} {{ openusedMem }} MB {{ lang._('used') }}</span><br>
                                        <label>{{ lang._('state_memmory') }} </label>
                                        <span>{{ lang._('all') }} {{ opentotaldisk }} GB {{ lang._('of') }} {{ openuseddisk }} GB {{ lang._('used') }}</span><br>
                                    </div>
                                </div>

                                <div class="tab-pane" id="kamailio">
                                    <div  id = "subpanel" >{{ lang._('state_info') }}</div>
                                    <div class="serverInfo">
                                    <?php
                                        if($kamState == "On")
                                            $locate = "/adminpage/pages/img/on.gif";
                                        elseif($kamState == "Off"){
                                            $locate = "/adminpage/pages/img/off.gif";
                                            $kamUptime = "0초 ";
                                        }
                                    ?>
                                        <label>{{ lang._('state_ip') }}</label>
                                        <span>{{ kamailioIP }}</span><br>
                                        <label>{{ lang._('state_link') }}</label>
                                        <span><img id="locate" src="{{ locate }}"></span><br>
                                        <label>{{ lang._('state_time') }} </label>
                                        <span>{{ kamUptime }}</span><br>
                                        <label>{{ lang._('state_version') }}</label>
                                        <span>{{ sysos }}</span><br>
                                    </div>
                                    <div  id = "subpanel" >{{ lang._('state_state') }}</div>
                                    <div class="serverState">
                                        <label>{{ lang._('state_cpu') }}</label>
                                        <span>{{ kamCpu }} %</span><br>
                                        <label>{{ lang._('state_ram') }} </label>
                                        <span>{{ lang._('all') }} {{ "%.2f"|format(memTotal)}} GB {{ lang._('of') }} {{ memUsed }} MB {{ lang._('used') }}</span><br>
                                        <label>{{ lang._('state_kamailio_call') }} </label><br>
                                        <div>
                                            <div class="progress" style="height:50px">
                                        <?php    
                                            if($kamCall>=0 && $kamCall <= 300)
                                                $type = "progress-bar";
                                            if($kamCall > 300 && $kamCall <=500)
                                                $type = "progress-bar progress-bar-success";
                                            if($kamCall > 500 && $kamCall <= 750)
                                                $type = "progress-bar progress-bar-warning";
                                            if($kamCall > 750 )
                                                $type = "progress-bar progress-bar-danger";
                                        ?>
                                                <div class="{{ type }}" id="probar" role="progressbar" aria-valuemin="0" aria-valuemax="100" style="width:{{kamCall/10}}% ">
                                                {{ kamCall }}
                                                </div>
                                            </div>
                                            <img src="{{url('')}}pages/img/success.png" id="success">
                                            <img src="{{url('')}}pages/img/warn.png" id="warn">
                                            <img src="{{url('')}}pages/img/danger.png" id="danger">
                                    	    <i id="successi">{{ lang._('state_kamailio_success') }}</i>
                                		    <i id="warni">{{ lang._('state_kamailio_warn') }}</i>
                                		    <i id="dangeri">{{ lang._('state_kamailio_danger') }}</i>
                                        </div>
                                        <label>{{ lang._('state_memmory') }}</label>
                                        <span>{{ lang._('all') }} {{ diskTotal }} GB {{ lang._('of') }} {{ diskUsed }} GB {{ lang._('used') }}</span><br>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div> 
 <!-- page-content -->
</div>