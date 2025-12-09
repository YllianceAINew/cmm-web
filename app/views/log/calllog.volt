{{ content() }}
<script type="text/javascript">
    var baseUrl = "{{ url() }}";
</script>

<!-- Call Log Card -->
<div class="card">
    <div class="card-header">
        <h3 class="card-title">
            <i class="fas fa-phone mr-1"></i>
            {{ lang._('menu_call') }}
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
                                    <th>{{ lang._('callog_thead_sender') }}</th>
                                    <th>{{ lang._('callog_thead_rcvd') }}</th>
                                    <th>{{ lang._('callog_thead_sendtime') }}</th>
                                    <th>{{ lang._('callog_thead_rcvdtime') }}</th>
                                    <th>{{ lang._('callog_thead_result') }}</th>
                                    <th  width='5%'>{{ lang._('delete') }}</th>
                                </tr>
                            </thead>
                            <tbody>
                            <?php
                                $i = 0;
                            ?>
                                {% for hist in histories %}
                                <?php
                                    $i++;
                                    $sec = $hist['duration'] % 60;
                                    $min = (int)($hist['duration'] / 60);
                                    $hour = 0;
                                    if($min >= 60){
                                        $hour = (int)($min / 60);
                                        $min = $min - $hour*60;
                                    }
                                    
                                    if($hour != 0)
                                        $time = $hour." 시간 ".$min." 분 ".$sec." 초 ";
                                    elseif($min != 0)
                                        $time = $min." 분 ".$sec." 초 ";
                                    else
                                        $time = $sec." 초 ";
                                ?>
                                <tr class="odd gradeX">
                                    <td class="hasCheckTD">
                                        <input type= "checkbox" class="childChecks" dataVal="{{hist['cdr_id']}}"/>
                                    </td>
                                     <input type = "hidden" class="logno" value="{{hist['cdr_id']}}"/>
                                    <td>{{ i }}</td>
                                    <td>{{ hist['src_username'] }}</td>
                                    <td>{{ hist['dst_username'] }}</td>
                                    <td>{{ hist['call_start_time'] }}</td>
                                    <td>{{ time }}</td>
                                    <td>{{ hist['disposition'] }}</td>
                                    <td> <a><img src="{{url('')}}pages/img/delete.gif" data-toggle="modal" href = "#deleteLog"></a> </td>
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
                <h4 class="modal-title">{{ lang._('callog_modal_del') }}</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="delBody">
                    <p>{{ lang._('callog_msg_delete') }}</p>
                </div>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">{{ lang._('btn_cancel') }}</button>
                <button type="submit" id="okBtn" class="btn btn-danger" onClick="onDeleteMsg({{hist['cdr_id']}})">{{ lang._('btn_ok') }}</button>
            </div>
        </div>
    </div>
</div>

<!-- Delete Multiple Logs Modal -->
<div id="deleteLog" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">{{ lang._('callog_modal_del') }}</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="delBody">
                    <p>{{ lang._('callog_msg_multidel') }}</p>
                </div>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">{{ lang._('btn_cancel') }}</button>
                <button type="submit" id="okBtn" class="btn btn-danger" onclick="onDeleteLog()">{{ lang._('btn_ok') }}</button>
            </div>
        </div>
    </div>
</div>

<!-- Search Log Modal -->
<div id="searchLog" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">{{ lang._('callog_modal_search') }}</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="searchBody">
                    <div class="row">
                        <div class="col-md-3 text-right">
                            <div class="form-group">
                                <label class="form-label">{{ lang._('callog_modal_sendtime') }}</label>
                            </div>
                            <div class="form-group">
                                <label class="form-label">{{ lang._('callog_modal_sender') }}</label>
                            </div>
                            <div class="form-group">
                                <label class="form-label">{{ lang._('callog_modal_rcvd') }}</label>
                            </div>
                        </div>
                        <div class="col-md-9">
                            <div class="form-group">
                                <div id="sent" class="input-group date-picker input-daterange" data-date="10/11/2012" data-date-format="yyyy-mm-dd">
                                    <input type="text" class="form-control" id="sentFrom" name="from">
                                    <span class="input-group-addon">{{ lang._('from') }}</span>
                                    <input type="text" class="form-control" id="sentTo" name="to">
                                </div>
                            </div>
                            <div class="form-group">
                                <input id="sender" type="text" class="form-control" placeholder="{{ lang._('callog_modal_sender') }}">
                            </div>
                            <div class="form-group">
                                <input id="receiver" type="text" class="form-control" placeholder="{{ lang._('callog_modal_rcvd') }}">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">{{ lang._('btn_cancel') }}</button>
                <button type="submit" id="okBtn" class="btn btn-primary" onclick="onSearchLog()">
                    <i class="fas fa-search mr-1"></i>{{ lang._('btn_search') }}
                </button>
            </div>
        </div>
    </div>
</div>