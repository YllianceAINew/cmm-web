{{ content() }}
<script type="text/javascript">
    var baseUrl = "{{ url() }}";
    var levelSet = {{lvSet | json_encode}};
</script>

<!-- Set Level Matrix Card -->
<div class="card">
    <div class="card-header">
        <h3 class="card-title">
            <i class="fas fa-project-diagram mr-1"></i>
            {{ lang._('setlevel') }}
        </h3>
        <div class="card-tools">
            <button type="button" class="btn btn-tool" data-card-widget="collapse">
                <i class="fas fa-minus"></i>
            </button>
        </div>
    </div>
    <!-- /.card-header -->
    <div class="card-body">
        <div class="row mb-3">
            <div class="col-md-12">
                <button id="accountAdd" class="btn btn-primary" data-toggle="modal" href="#saveModal">
                    <i class="fas fa-save mr-1"></i>
                    {{ lang._('setlevel_save') }}
                </button>
            </div>
        </div>
        <div class="table-responsive">
            <table class="table table-bordered table-striped table-hover" id="levelMatrixTable">
                <thead>
                    <tr>
                        <th class="text-center" style="background-color: #6c757d; color: white; min-width: 100px;">
                            {{ lang._('setlevel_level') }}
                        </th>
                        {% for lv in lvSet %}
                            <th class="text-center calleeTD" style="background-color: #6c757d; color: white; min-width: 80px;">
                                {{lv}}
                            </th>
                        {% endfor %}
                    </tr>
                </thead>
                <tbody>
                    <input type="hidden" value='{{strArr}}' id="strArrs">
                    {% for lv in lvSet %}
                    <tr>
                        <td class="text-center font-weight-bold callerTD" callerdata="{{lv}}" style="background-color: #e9ecef; min-width: 100px;">
                            {{lv}}
                        </td>
                        {% for lv2 in lvSet %}
                            <td class="text-center">
                                <input type="checkbox" class="tdCheck" dataVal="{{lv2}}" style="width: 18px; height: 18px; cursor: pointer;">
                            </td>
                        {% endfor %}
                    </tr>
                    {% endfor %}
                </tbody>
            </table>
        </div>
        <div class="alert alert-info mt-3">
            <i class="icon fas fa-info-circle"></i>
            {{ lang._('setlevel_msg_save') }}
        </div>
    </div>
    <!-- /.card-body -->
</div>
<!-- /.card -->

<!-- Save Level Configuration Modal -->
<div id="saveModal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">
                    <i class="fas fa-save mr-1"></i>
                    {{ lang._('setlevel_modal_save') }}
                </h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="alert alert-warning">
                    <i class="icon fas fa-exclamation-triangle"></i>
                    {{ lang._('setlevel_msg_save') }}
                </div>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <i class="fas fa-times mr-1"></i>
                    {{ lang._('btn_cancel') }}
                </button>
                <button type="submit" id="okBtn" class="btn btn-primary" data-dismiss="modal" onclick="onSaveLevel()">
                    <i class="fas fa-check mr-1"></i>
                    {{ lang._('btn_ok') }}
                </button>
            </div>
        </div>
    </div>
</div>
