<script type="text/javascript">
    var xmppUrl = "{{url('server/xmppserver')}}";
</script>
{{ content() }}

<!-- HAProxy Server Card -->
<div class="row">
    <div class="col-12">
        <div class="card card-primary card-outline">
            <div class="card-header">
                <h3 class="card-title">
                    <i class="fas fa-server mr-1"></i>
                    {{ lang._('menu_servermanager_haproxy') }}
                </h3>
                <div class="card-tools">
                    <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                        <i class="fas fa-minus"></i>
                    </button>
                </div>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>{{ lang._('state_ip') }}</th>
                                <th>{{ lang._('dashboard_cpu') }}</th>
                                <th>{{ lang._('dashboard_ram') }}</th>
                                <th>{{ lang._('dashboard_memory') }}</th>
                                <th>{{ lang._('state_edit') }}</th>
                                <th>{{ lang._('state_link') }}</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>{{ haproxy['ip'] }}</td>
                                <td id="cpu_info">{{ haproxy['cpu'] }}</td>
                                <td id="ram_info">{{ haproxy['ram'] }}</td>
                                <td id="memory_info">{{ haproxy['memory'] }}</td>
                                <td>
                                    <button type="button" class="btn btn-sm btn-primary" id="edit_haproxy" data-toggle="modal" data-target="#editHaproxy">
                                        <i class="fas fa-edit"></i> {{ lang._('state_edit') }}
                                    </button>
                                </td>
                                <td>
                                    {% if haproxy['status'] == 'On' %}
                                        <span class="badge badge-success">{{ lang._('state_link') }}: On</span>
                                    {% else %}
                                        <span class="badge badge-danger">{{ lang._('state_link') }}: Off</span>
                                    {% endif %}
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- XMPP Servers Card -->
<div class="row">
    <div class="col-12">
        <div class="card card-info card-outline">
            <div class="card-header">
                <h3 class="card-title">
                    <i class="fas fa-network-wired mr-1"></i>
                    {{ lang._('menu_servermanager_xmppserver') }}
                </h3>
                <div class="card-tools">
                    <button type="button" class="btn btn-primary btn-sm" id="addServerBtn" data-toggle="modal" data-target="#addServer">
                        <i class="fas fa-plus"></i> {{ lang._('level_btn_add') }}
                    </button>
                    <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                        <i class="fas fa-minus"></i>
                    </button>
                </div>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-hover" id="xmppservers">
                        <thead>
                            <tr>
                                <th width="5%">{{ lang._('no') }}</th>
                                <th>{{ lang._('state_ip') }}</th>
                                <th>{{ lang._('state_time') }}</th>
                                <th>{{ lang._('dashboard_cpu') }}</th>
                                <th>{{ lang._('dashboard_ram') }}</th>
                                <th>{{ lang._('dashboard_memory') }}</th>
                                <th>{{ lang._('state_openfire_javamem') }}</th>
                                <th>{{ lang._('delete') }}</th>
                                <th>{{ lang._('state_link') }}</th>
                            </tr>
                        </thead>
                        <tbody>
                            {% for i,server in xmpps %}
                            <tr class="server_col">
                                <td>{{ i + 1 }}</td>
                                <td>{{ server['ip'] }}</td>
                                <td id="time_info{{i}}">{{ server['time'] }}</td>
                                <td id="cpu_info{{i}}">{{ server['cpu'] }}</td>
                                <td id="ram_info{{i}}">{{ server['ram'] }}</td>
                                <td id="memory_info{{i}}">{{ server['memory'] }}</td>
                                <td id="java_info{{i}}">{{ server['java'] }}</td>
                                <td>
                                    <button type="button" class="btn btn-sm btn-danger deleteXmpp" serverIp="{{server['ip']}}">
                                        <i class="fas fa-trash"></i> {{ lang._('delete') }}
                                    </button>
                                </td>
                                <td>
                                    {% if server['status'] == 'On' %}
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

<!-- File Server Card -->
<div class="row">
    <div class="col-12">
        <div class="card card-success card-outline">
            <div class="card-header">
                <h3 class="card-title">
                    <i class="fas fa-file-alt mr-1"></i>
                    {{ lang._('menu_servermanager_fileserver') }}
                </h3>
                <div class="card-tools">
                    <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                        <i class="fas fa-minus"></i>
                    </button>
                </div>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>{{ lang._('state_ip') }}</th>
                                <th>{{ lang._('dashboard_cpu') }}</th>
                                <th>{{ lang._('dashboard_ram') }}</th>
                                <th>{{ lang._('dashboard_memory') }}</th>
                                <th>{{ lang._('state_edit') }}</th>
                                <th>{{ lang._('state_link') }}</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>{{ fileserver['ip'] }}</td>
                                <td id="f_cpu_info">{{ fileserver['cpu'] }}</td>
                                <td id="f_ram_info">{{ fileserver['ram'] }}</td>
                                <td id="f_memory_info">{{ fileserver['memory'] }}</td>
                                <td>
                                    <button type="button" class="btn btn-sm btn-primary" id="edit_fileserver" data-toggle="modal" data-target="#editFileserver">
                                        <i class="fas fa-edit"></i> {{ lang._('state_edit') }}
                                    </button>
                                </td>
                                <td>
                                    {% if fileserver['status'] == 'On' %}
                                        <span class="badge badge-success">{{ lang._('state_link') }}: On</span>
                                    {% else %}
                                        <span class="badge badge-danger">{{ lang._('state_link') }}: Off</span>
                                    {% endif %}
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Edit HAProxy Modal -->
<div class="modal fade" id="editHaproxy" tabindex="-1" role="dialog" aria-labelledby="editHaproxyLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <h5 class="modal-title" id="editHaproxyLabel">
                    <i class="fas fa-edit mr-2"></i>{{ lang._('state_edit') }}
                </h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="editHaproxyForm">
                    <div class="form-group">
                        <label for="input_haproxy_ip_ext">{{ lang._('state_edit_ext') }}</label>
                        <input type="text" class="form-control" id="input_haproxy_ip_ext" placeholder="172.16.41.22">
                    </div>
                    <div class="form-group">
                        <label for="input_haproxy_ip_int">{{ lang._('state_edit_int') }}</label>
                        <input type="text" class="form-control" id="input_haproxy_ip_int" placeholder="192.168.1.22">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">{{ lang._('btn_cancel') }}</button>
                <button type="button" class="btn btn-primary" onclick="onEditHaproxy()" data-dismiss="modal">{{ lang._('btn_ok') }}</button>
            </div>
        </div>
    </div>
</div>

<!-- Edit File Server Modal -->
<div class="modal fade" id="editFileserver" tabindex="-1" role="dialog" aria-labelledby="editFileserverLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header bg-success">
                <h5 class="modal-title" id="editFileserverLabel">
                    <i class="fas fa-edit mr-2"></i>{{ lang._('state_edit') }}
                </h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="editFileserverForm">
                    <div class="form-group">
                        <label for="input_fileserver_ip_ext">{{ lang._('state_edit_ext') }}</label>
                        <input type="text" class="form-control" id="input_fileserver_ip_ext" placeholder="172.16.41.22">
                    </div>
                    <div class="form-group">
                        <label for="input_fileserver_ip_int">{{ lang._('state_edit_int') }}</label>
                        <input type="text" class="form-control" id="input_fileserver_ip_int" placeholder="192.168.1.22">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">{{ lang._('btn_cancel') }}</button>
                <button type="button" class="btn btn-success" onclick="onEditFileserver()" data-dismiss="modal">{{ lang._('btn_ok') }}</button>
            </div>
        </div>
    </div>
</div>

<!-- Add Server Modal -->
<div class="modal fade" id="addServer" tabindex="-1" role="dialog" aria-labelledby="addServerLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header bg-info">
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
                        <label for="input_server_ip">{{ lang._('state_ip') }}</label>
                        <input type="text" class="form-control" id="input_server_ip" placeholder="172.16.41.22">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">{{ lang._('btn_cancel') }}</button>
                <button type="button" class="btn btn-info" onclick="onAddServer()" data-dismiss="modal">{{ lang._('btn_ok') }}</button>
            </div>
        </div>
    </div>
</div>
