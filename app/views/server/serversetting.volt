<script type="text/javascript">
	var baseUrl = {{url('')}};
</script>
{{ content() }}

<!-- Main content -->
<div class="container-fluid">
    
    <!-- Server Time Setting Card -->
    <div class="row">
      <div class="col-12 col-md-8 offset-md-2">
        <div class="card card-primary">
          <div class="card-header">
            <h3 class="card-title">
              <i class="fas fa-clock mr-2"></i>{{ lang._('setserver_settime') }}
            </h3>
            <div class="card-tools">
              <button type="button" class="btn btn-tool" data-card-widget="collapse">
                <i class="fas fa-minus"></i>
              </button>
            </div>
          </div>
          <!-- /.card-header -->
          <div class="card-body">
            <form>
              <div class="row">
                <div class="col-md-8">
                  <div class="form-group">
                    <div class="form-check">
                      <input type="checkbox" class="form-check-input" id="selType">
                      <label class="form-check-label" for="selType">Time Server (NTP)</label>
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="setTimeServer">NTP Server IP</label>
                    <input type="text" id="setTimeServer" placeholder="10.76.5.31" class="form-control" value="{{ntpServerIP}}">
                  </div>
                  <div class="form-group">
                    <label for="setDate">Date</label>
                    <input type="text" id="setDate" data-date-format="yyyy-mm-dd" class="form-control date-picker" value="{{date}}">
                  </div>
                  <div class="form-group">
                    <label for="setTime">Time</label>
                    <input type="text" class="form-control timepicker timepicker-24" id="setTime" value="{{time}}">
                  </div>
                </div>
                <div class="col-md-4 d-flex align-items-center justify-content-center">
                  <button type="button" class="btn btn-primary btn-lg" id="setServerTime" onclick="onSetServerTime()">
                    <i class="fas fa-save mr-2"></i>{{ lang._('setserver_set') }}
                  </button>
                </div>
              </div>
            </form>
          </div>
          <!-- /.card-body -->
        </div>
        <!-- /.card -->
      </div>
    </div>

    <!-- Log Retention Period Setting Card -->
    <div class="row">
      <div class="col-12 col-md-8 offset-md-2">
        <div class="card card-info">
          <div class="card-header">
            <h3 class="card-title">
              <i class="fas fa-share-alt mr-2"></i>{{ lang._('setserver_setlog') }}
            </h3>
            <div class="card-tools">
              <button type="button" class="btn btn-tool" data-card-widget="collapse">
                <i class="fas fa-minus"></i>
              </button>
            </div>
          </div>
          <!-- /.card-header -->
          <div class="card-body">
            <form>
              <div class="row">
                <div class="col-md-8">
                  <div class="form-group">
                    <label for="textDate">{{ lang._('setserver_textdate') }}</label>
                    <select id="textDate" class="form-control">
                      <?php	
                      for($i=0;$i<6;$i++)
                        if($textTime == $selectType[$i])
                          echo "<option value='".$selectType[$i]."' selected>".$selectType[$i]."</option>";
                        else
                          echo "<option value='".$selectType[$i]."'>".$selectType[$i]."</option>";
                      ?>
                    </select>
                  </div>
                  <div class="form-group">
                    <label for="callDate">{{ lang._('setserver_calldate') }}</label>
                    <select id="callDate" class="form-control">
                      <?php	
                      for($i=0;$i<6;$i++)
                        if($callTime == $selectType[$i])
                          echo "<option value='".$selectType[$i]."' selected>".$selectType[$i]."</option>";
                        else
                          echo "<option value='".$selectType[$i]."'>".$selectType[$i]."</option>";
                      ?>
                    </select>
                  </div>
                  <div class="form-group">
                    <label for="logDate">{{ lang._('setserver_logdate') }}</label>
                    <select id="logDate" class="form-control">
                      <?php	
                      for($i=0;$i<6;$i++)
                        if($loginTime == $selectType[$i])
                          echo "<option value='".$selectType[$i]."' selected>".$selectType[$i]."</option>";
                        else
                          echo "<option value='".$selectType[$i]."'>".$selectType[$i]."</option>";
                      ?>
                    </select>
                  </div>
                  <div class="form-group">
                    <label for="alarmDate">{{ lang._('setserver_alarmdate') }}</label>
                    <select id="alarmDate" class="form-control">
                      <?php	
                      for($i=0;$i<6;$i++)
                        if($alarmTime == $selectType[$i])
                          echo "<option value='".$selectType[$i]."' selected>".$selectType[$i]."</option>";
                        else
                          echo "<option value='".$selectType[$i]."' >".$selectType[$i]."</option>";
                      ?>
                    </select>
                  </div>
                </div>
                <div class="col-md-4 d-flex align-items-center justify-content-center">
                  <button type="button" class="btn btn-info btn-lg" id="setServerIp" onclick="onSetLogTime()">
                    <i class="fas fa-save mr-2"></i>{{ lang._('setserver_set') }}
                  </button>
                </div>
              </div>
            </form>
          </div>
          <!-- /.card-body -->
        </div>
        <!-- /.card -->
      </div>
    </div>

    <!-- Allowed IP Address Setting Card -->
    <div class="row">
      <div class="col-12 col-md-8 offset-md-2">
        <div class="card card-warning">
          <div class="card-header">
            <h3 class="card-title">
              <i class="fas fa-power-off mr-2"></i>{{ lang._('setserver_setAllowAddr') }}
            </h3>
            <div class="card-tools">
              <button type="button" class="btn btn-tool" data-card-widget="collapse">
                <i class="fas fa-minus"></i>
              </button>
            </div>
          </div>
          <!-- /.card-header -->
          <div class="card-body">
            <div class="row">
              <div class="col-md-8">
                <div class="table-responsive" style="max-height: 300px;">
                  <table class="table table-bordered table-hover table-sm">
                    <thead class="thead-light">
                      <tr>
                        <th style="width: 50px;">
                          <input type="checkbox" id="selectAllChk" class="form-check-input">
                        </th>
                        <th>IP Address</th>
                        <th style="width: 80px;">{{ lang._('edit') }}</th>
                      </tr>
                    </thead>
                    <tbody>
                      {% for allowip in ipList %}
                      <tr data-allow-no="{{allowip['no']}}">
                        <td class="hasCheckTD">
                          <input type="checkbox" id="childChecks" checkVal="{{allowip['no']}}" class="form-check-input">
                        </td>
                        <td class="allowip">{{allowip['ip']}}</td>
                        <td>
                          <a href="#editIP" data-toggle="modal" class="editIP btn btn-sm btn-warning">
                            <i class="fas fa-edit"></i>
                          </a>
                        </td>
                      </tr>
                      {% endfor %}
                    </tbody>
                  </table>
                </div>
              </div>
              <div class="col-md-4 d-flex flex-column justify-content-center align-items-center">
                <button type="button" class="btn btn-success btn-block mb-2" data-toggle="modal" href="#addIP">
                  <i class="fas fa-plus mr-2"></i>{{ lang._('level_btn_add') }}
                </button>
                <button type="button" class="btn btn-danger btn-block" data-toggle="modal" id="ipDelete" href="#deleteIP">
                  <i class="fas fa-trash mr-2"></i>{{ lang._('btn_delete') }}
                </button>
              </div>
            </div>
          </div>
          <!-- /.card-body -->
        </div>
        <!-- /.card -->
      </div>
    </div>

</div>
<!-- /.container-fluid -->

<!-- Add IP Modal -->
<div id="addIP" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header bg-success">
        <h4 class="modal-title">{{ lang._('addIP') }}</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="form-group">
          <label for="input_ipv4">IP Address</label>
          <input type="text" class="form-control" id="input_ipv4" placeholder="192.168.1.1">
        </div>
      </div>
      <div class="modal-footer justify-content-between">
        <button type="button" class="btn btn-default" data-dismiss="modal">{{ lang._('btn_cancel') }}</button>
        <button type="button" class="btn btn-success" id="okBtn" onclick="onAddAddr()">
          <i class="fas fa-check mr-2"></i>{{ lang._('btn_ok') }}
        </button>
      </div>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<!-- Edit IP Modal -->
<div id="editIP" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header bg-warning">
        <h4 class="modal-title">{{ lang._('addIP') }}</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="form-group">
          <label for="input">IP Address</label>
          <input type="text" class="form-control" id="input" placeholder="192.168.1.1">
          <input type="hidden" id="allowNo">
        </div>
      </div>
      <div class="modal-footer justify-content-between">
        <button type="button" class="btn btn-default" data-dismiss="modal">{{ lang._('btn_cancel') }}</button>
        <button type="button" class="btn btn-warning" id="okBtn" onclick="onEditAddr()">
          <i class="fas fa-check mr-2"></i>{{ lang._('btn_ok') }}
        </button>
      </div>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<!-- Delete IP Modal -->
<div id="deleteIP" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header bg-danger">
        <h4 class="modal-title">Confirm Delete</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p class="mb-0">Do you want to delete the selected IP addresses?</p>
      </div>
      <div class="modal-footer justify-content-between">
        <button type="button" class="btn btn-default" data-dismiss="modal">{{ lang._('btn_cancel') }}</button>
        <button type="button" class="btn btn-danger" id="okBtn" onclick="onDeleteAddr()">
          <i class="fas fa-trash mr-2"></i>{{ lang._('btn_ok') }}
        </button>
      </div>
    </div>
    <!-- /.modal-content -->
  </div>
  <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
