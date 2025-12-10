<script type="text/javascript">
    var proxyUrl = "{{url('server/proxyserver')}}";
</script>
{{ content() }}

<!-- Proxy Servers Card -->
<div class="row">
    <div class="col-12">
        <div class="card card-warning card-outline">
            <div class="card-header">
                <h3 class="card-title">
                    <i class="fas fa-network-wired mr-1"></i>
                    {{ lang._('menu_servermanager_proxyserver') }}
                </h3>
                <div class="card-tools">
                    <button type="button" class="btn btn-warning btn-sm" id="addServerBtn" data-toggle="modal" data-target="#addServer">
                        <i class="fas fa-plus"></i> {{ lang._('level_btn_add') }}
                    </button>
                    <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                        <i class="fas fa-minus"></i>
                    </button>
                </div>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-hover" id="proxyservers">
                        <thead>
                            <tr>
                                <th width="5%">{{ lang._('no') }}</th>
                                <th>{{ lang._('state_ip') }}</th>
                                <th>{{ lang._('state_time') }}</th>
                                <th>{{ lang._('dashboard_cpu') }}</th>
                                <th>{{ lang._('dashboard_ram') }}</th>
                                <th>{{ lang._('dashboard_memory') }}</th>
                                <th>{{ lang._('delete') }}</th>
                                <th>{{ lang._('state_link') }}</th>
                            </tr>
                        </thead>
                        <tbody>
                            {% for i,server in proxys %}
                            <tr class="server_col">
                                <td>{{ i + 1 }}</td>
                                <td>{{ server['ip'] }}</td>
                                <td id="start_time{{i}}">{{ server['start_time'] }}</td>
                                <td id="cpu{{i}}">{{ server['cpu'] }}</td>
                                <td id="ram{{i}}">{{ server['ram'] }}</td>
                                <td id="memory{{i}}">{{ server['memory'] }}</td>
                                <td>
                                    <button type="button" class="btn btn-sm btn-danger deleteProxy" serverIp="{{server['ip']}}">
                                        <i class="fas fa-trash"></i> {{ lang._('delete') }}
                                    </button>
                                </td>
                                <td>
                                    {% if server['status'] == 'on' %}
                                        <span class="badge badge-success">On</span>
                                    {% else %}
                                        <span class="badge badge-danger">Off</span>
                                    {% endif %}
                                </td>
                            </tr>
                            {% endfor %}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Add Proxy Server Modal -->
<div class="modal fade" id="addServer" tabindex="-1" role="dialog" aria-labelledby="addServerLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header bg-warning">
                <h5 class="modal-title" id="addServerLabel">
                    <i class="fas fa-plus mr-2"></i>{{ lang._('addServer') }}
                </h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="addServerForm">
                    <div class="form-group">
                        <label for="input_server_ip_ext">{{ lang._('state_edit_ext') }}</label>
                        <input type="text" class="form-control" id="input_server_ip_ext" placeholder="172.16.41.22">
                    </div>
                    <div class="form-group">
                        <label for="input_server_ip_int">{{ lang._('state_edit_int') }}</label>
                        <input type="text" class="form-control" id="input_server_ip_int" placeholder="192.168.1.22">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">{{ lang._('btn_cancel') }}</button>
                <button type="button" class="btn btn-warning" onclick="onAddServer()" data-dismiss="modal">{{ lang._('btn_ok') }}</button>
            </div>
        </div>
    </div>
</div>
