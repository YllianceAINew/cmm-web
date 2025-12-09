<script type="text/javascript">
	var sipUrl = "{{url('server/sipserver')}}";
</script>
{{ content() }}
<div class="page-content-wrapper">
<div class="page-content">
	<div class="portlet-body">
	    <div class="tab-content">
	        <div class="tab-pane fade active in" id="tab_1_1"> 
                <h3> {{ lang._('menu_servermanager_haproxy') }} </h3>
                <div class="row" id="sipservers">
                    <table class="table table-striped table-bordered table-hover table-checkable order-column">
                        <thead>
                            <tr class="bg-info">
                                <th rowspan="2"> {{ lang._('state_ip') }} </th>
                                <th rowspan="2"> {{ lang._('state_time') }} </th>
                                <th colspan="3"> {{ lang._('account_edit_serverstate') }} </th>
                                <th rowspan="2"> {{ lang._('state_edit') }} </th>
                                <th rowspan="2"> {{ lang._('state_link') }} </th>
                            </tr>
                            <tr class="bg-info">
                                <th>{{ lang._('dashboard_cpu') }}</th>
                                <th>{{ lang._('dashboard_ram') }}</th>
                                <th>{{ lang._('dashboard_memory') }}</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td> {{ haproxy['ip'] }} </td>
                                <td id="start_time"> {{ haproxy['start_time'] }} </td>
                                <td id="cpu_info"> {{ haproxy['cpu'] }} </td>
                                <td id="ram_info"> {{ haproxy['ram'] }} </td>
                                <td id="memory_info"> {{ haproxy['memory'] }} </td>
                                <td> <i class="fa fa-edit" id="edit_haproxy" data-toggle="modal" href="#editHaproxy" style="cursor:pointer"></i> </td>
                                <td>{% if haproxy['status'] == 'on' %}
                                        <img id="locate" src="/adminpage/pages/img/on.gif">
                                    {% else %}
                                        <img id="locate" src="/adminpage/pages/img/off.gif">
                                    {% endif %} </td>
                            </tr>
                        </tbody>
                    </table>  
                </div>

                <div class="row" pull-right>
                    <button id="addServerBtn" data-toggle="modal" href="#addServer">{{ lang._('level_btn_add') }}</button>
                </div>

				<h3> {{ lang._('menu_servermanager_sipserver_sub') }} </h3>
				<div class="row" id="sipservers">
					<table class="table table-striped table-bordered table-hover table-checkable order-column">
                        <thead>
                            <tr class="bg-info">
                                <th rowspan="2" width = "5%"> {{ lang._('no') }} </th>
                                <th rowspan="2"> {{ lang._('state_ip') }} </th>
                                <th rowspan="2"> {{ lang._('state_time') }} </th>
                                <th colspan="4"> {{ lang._('account_edit_serverstate') }} </th>
                                <th rowspan="2"> {{ lang._('delete') }} </th>
                                <th rowspan="2"> {{ lang._('state_link') }} </th>
                            </tr>
                            <tr>
                                <th>{{ lang._('dashboard_cpu') }}</th>
                                <th>{{ lang._('dashboard_ram') }}</th>
                                <th>{{ lang._('dashboard_memory') }}</th>
                                <th > {{ lang._('state_kamailio_call') }} </th>
                            </tr>
                        </thead>
                        <tbody>
                            {% for i,server in sips %}
                            <tr class = "server_col">
                                <td width = "5%">{{ i + 1 }}</td>
                                <td> {{ server['ip'] }} </td>
                                <td id="start_time{{i+1}}"> {{ server['start_time'] }} </td>
                                <td id="cpu{{i+1}}"> {{ server['cpu'] }} </td>
                                <td id="ram{{i+1}}"> {{ server['ram'] }} </td>
                                <td id="memory{{i+1}}"> {{ server['memory'] }} </td>
                                <td id="sync_call{{i+1}}"> {{ server['sync_call'] }} </td>
                                <td> <a  class="deleteSip" serverIp="{{server['ip']}}"><img src="{{url('')}}/pages/img/delete.gif"></a> </td>
                                <td>{% if server['status'] == 'on' %}
                                        <img id="locate" src="/adminpage/pages/img/on.gif">
                                    {% else %}
                                        <img id="locate" src="/adminpage/pages/img/off.gif">
                                    {% endif %} </td>
                            </tr>
                            {% endfor %}
                        </tbody>
                    </table>  
				</div>
			</div>
		</div>
	</div>
</div>

<div id="editHaproxy" class="modal fade" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog" style="width:320px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                <h4 class="modal-title">{{ lang._('state_edit') }}</h4>
            </div>
            <div class="modal-body">
                <div class="scroller" id="delBody"  data-always-visible="1" data-rail-visible1="1">
                    <div class="row">
                        <div class="col-md-4"><h5>{{ lang._('state_edit_ext') }}</h5></div>
                        <div class="col-md-8">
                            <input type="text" class="form-control" id="input_haproxy_ip_ext" placeholder="172.16.41.22">
                        </div>
                    </div> 
                    <div class="row">
                        <div class="col-md-4"><h5>{{ lang._('state_edit_int') }}</h5></div>
                        <div class="col-md-8">
                            <input type="text" class="form-control" id="input_haproxy_ip_int" placeholder="192.168.1.22">
                        </div>
                    </div>  
                </div>
            </div>
            <div class="modal-footer">
                <button type="submit" id="okBtn" onclick="onEditHaproxy()" data-dismiss="modal">{{ lang._('btn_ok') }}</button>
                <button type="button" id="cancelBtn" data-dismiss="modal">{{ lang._('btn_cancel') }}</button>                  
            </div>
        </div>
    </div>
</div>

<div id="addServer" class="modal fade" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog" style="width:320px">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                <h4 class="modal-title">{{ lang._('addServer') }}</h4>
            </div>
            <div class="modal-body">
                <div class="scroller" id="delBody"  data-always-visible="1" data-rail-visible1="1">
                    <div class="row">
                        <div class="col-md-4"><h5>{{ lang._('state_edit_ext') }}</h5></div>
                        <div class="col-md-8">
                            <input type="text" class="form-control" id="input_server_ip_ext" placeholder="172.16.41.22">
                        </div>
                    </div>  
                    <div class="row">
                        <div class="col-md-4"><h5>{{ lang._('state_edit_int') }}</h5></div>
                        <div class="col-md-8">
                            <input type="text" class="form-control" id="input_server_ip_int" placeholder="192.168.1.22">
                        </div>
                    </div>  
                </div>
            </div>
            <div class="modal-footer">
                <button type="submit" id="okBtn" onclick="onAddServer()" data-dismiss="modal">{{ lang._('btn_ok') }}</button>
                <button type="button" id="cancelBtn" data-dismiss="modal">{{ lang._('btn_cancel') }}</button>                  
            </div>
        </div>
    </div>
</div>