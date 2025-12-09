{{ content() }}
<script type="text/javascript">
    var baseUrl = "{{ url() }}";
</script>

<!-- Sign Log Card -->
<div class="card">
    <div class="card-header">
        <h3 class="card-title">
            <i class="fas fa-sign-in-alt mr-1"></i>
            {{ lang._('menu_signin') }}
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
            <div class="col-md-12 text-right">
                <button id="searchlog" class="btn btn-primary btn-sm" data-toggle="modal" href="#searchLog">
                    <i class="fas fa-search mr-1"></i>{{ lang._('btn_search') }}
                </button>
                <button id="deletelog" class="btn btn-danger btn-sm" data-toggle="modal" href="#deleteLog">
                    <i class="fas fa-trash mr-1"></i>{{ lang._('btn_delete') }}
                </button>
            </div>
        </div>
        <div class="table-responsive">
            <table class="table table-striped table-bordered table-hover" id="sample_1">
                            <thead>
                                <tr class="table-head">
                                    <th width='3%'>
                                        <input type= "checkbox" id="selectAllChk">
                                    </th>
                                    <th width='5%'>{{ lang._('no') }}</th>
                                    <th>{{ lang._('signlog_thead_user') }}</th>
                                    <th>{{ lang._('signlog_thead_signtime') }}</th>
                                    <th>{{ lang._('signlog_thead_outtime') }}</th>
                                    <th width='5%'>{{ lang._('delete') }}</th>
                                </tr>
                            </thead>
                            <tbody>
                                {% for i, sign in signlogs %}
                            
                                <tr class="odd gradeX">
                                    <td class="hasCheckTD">
                                        <input type= "checkbox" class="childChecks" dataVal="{{sign['no']}}"/>
                                    </td>
                                     <input type = "hidden" class="logno" value="{{sign['no']}}"/>
                                    <td>{{ i+1 }}</td>
                                    <td>{{ sign['username'] }}</td>
                                    <td>{{ sign['LoginTime'] }}</td>
                                    <td>{{ sign['LogoutTime'] }}</td>
                                    <td> <a><img src="{{url('')}}pages/img/delete.gif" data-toggle="modal" href = "#delete"></a> </td>
                                </tr>
                                {% endfor %}

                            </tbody>
            </table>
        </div>
    </div>
    <!-- /.card-body -->
</div>
<!-- /.card -->

<!-- Delete Single Log Modal -->
<div id="delete" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">{{ lang._('signlog_modal_del') }}</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="delBody">
                    <p>{{ lang._('signlog_msg_delete') }}</p>
                </div>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">{{ lang._('btn_cancel') }}</button>
                <button type="submit" id="okBtn" class="btn btn-danger" onClick="onDeleteSign({{sign['no']}})">{{ lang._('btn_ok') }}</button>
            </div>
        </div>
    </div>
</div>

<!-- Delete Multiple Logs Modal -->
<div id="deleteLog" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">{{ lang._('signlog_modal_del') }}</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="delBody">
                    <p>{{ lang._('signlog_msg_multidel') }}</p>
                </div>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">{{ lang._('btn_cancel') }}</button>
                <button type="submit" id="okBtn" class="btn btn-danger" onclick="onDeleteSignLog()">{{ lang._('btn_ok') }}</button>
            </div>
        </div>
    </div>
</div>

<!-- Search Log Modal -->
<div id="searchLog" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">{{ lang._('signlog_modal_search') }}</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="searchBody">
                    <div class="row">
                        <div class="col-md-3 text-right">
                            <div class="form-group">
                                <label class="form-label">{{ lang._('signlog_modal_user') }}</label>
                            </div>
                            <div class="form-group">
                                <label class="form-label">{{ lang._('signlog_modal_signtime') }}</label>
                            </div>
                            <div class="form-group">
                                <label class="form-label">{{ lang._('signlog_modal_outtime') }}</label>
                            </div>
                        </div>
                        <div class="col-md-9">
                            <div class="form-group">
                                <input id="user" type="text" class="form-control" placeholder="{{ lang._('signlog_modal_user') }}">
                            </div>
                            <div class="form-group">
                                <div class="input-group date-picker input-daterange" data-date-format="yyyy-mm-dd">
                                    <input type="text" class="form-control" id="intime" placeholder="{{ lang._('signlog_modal_signtime') }}">
                                    <span class="input-group-addon">{{ lang._('from') }}</span>
                                    <input type="text" class="form-control" id="outime" placeholder="{{ lang._('signlog_modal_outtime') }}">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">{{ lang._('btn_cancel') }}</button>
                <button type="submit" id="okBtn" class="btn btn-primary" onclick="onSearchSign()">
                    <i class="fas fa-search mr-1"></i>{{ lang._('btn_search') }}
                </button>
            </div>
        </div>
    </div>
</div>