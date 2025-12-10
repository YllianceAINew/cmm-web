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
                    <i class="fas fa-search mr-1"></i>
                    {{ lang._('btn_search') }}
                </button>
                <button id="deletelog" class="btn btn-danger btn-sm" data-toggle="modal" href="#deleteLog">
                    <i class="fas fa-trash mr-1"></i>
                    {{ lang._('btn_delete') }}
                </button>
            </div>
        </div>
        <div class="table-responsive">
            <table id="sample_1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th style="width: 40px;">
                            <input type="checkbox" id="selectAllChk">
                        </th>
                        <th style="width: 60px;">{{ lang._('no') }}</th>
                        <th>{{ lang._('callog_thead_sender') }}</th>
                        <th>{{ lang._('callog_thead_rcvd') }}</th>
                        <th>{{ lang._('callog_thead_sendtime') }}</th>
                        <th>{{ lang._('callog_thead_rcvdtime') }}</th>
                        <th>{{ lang._('callog_thead_result') }}</th>
                        <th style="width: 80px;" class="text-center">{{ lang._('delete') }}</th>
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
                            $time = $hour." hour ".$min." min ".$sec." sec ";
                        elseif($min != 0)
                            $time = $min." min ".$sec." sec ";
                        else
                            $time = $sec." sec ";
                    ?>
                    <tr>
                        <td class="hasCheckTD">
                            <input type="checkbox" class="childChecks" dataVal="{{hist['cdr_id']}}"/>
                            <input type="hidden" class="logno" value="{{hist['cdr_id']}}"/>
                        </td>
                        <td><?php echo $i; ?></td>
                        <td>{{ hist['src_username'] }}</td>
                        <td>{{ hist['dst_username'] }}</td>
                        <td>{{ hist['call_start_time'] }}</td>
                        <td><?php echo $time; ?></td>
                        <td>{{ hist['disposition'] }}</td>
                        <td class="text-center">
                            <a class="deleteCallBtn btn btn-sm btn-danger" data-toggle="modal" href="#delete" data-id="{{hist['cdr_id']}}" title="{{ lang._('delete') }}">
                                <i class="fas fa-trash"></i>
                            </a>
                        </td>
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
                <h4 class="modal-title">
                    <i class="fas fa-exclamation-triangle mr-1"></i>
                    {{ lang._('callog_modal_del') }}
                </h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="delBody">
                    <div class="alert alert-warning">
                        <i class="icon fas fa-exclamation-triangle"></i>
                        {{ lang._('callog_msg_delete') }}
                    </div>
                    <label id="deleteCallId" hidden></label>
                </div>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <i class="fas fa-times mr-1"></i>
                    {{ lang._('btn_cancel') }}
                </button>
                <button type="submit" id="okBtn" class="btn btn-danger" onClick="onDeleteMsg()">
                    <i class="fas fa-trash mr-1"></i>
                    {{ lang._('btn_ok') }}
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Delete Multiple Logs Modal -->
<div id="deleteLog" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">
                    <i class="fas fa-exclamation-triangle mr-1"></i>
                    {{ lang._('callog_modal_del') }}
                </h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="delBody">
                    <div class="alert alert-warning">
                        <i class="icon fas fa-exclamation-triangle"></i>
                        <span id="deleteLogMessage">{{ lang._('callog_msg_multidel') }}</span>
                    </div>
                </div>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <i class="fas fa-times mr-1"></i>
                    {{ lang._('btn_cancel') }}
                </button>
                <button type="submit" id="okBtn" class="btn btn-danger" onclick="onDeleteLog()">
                    <i class="fas fa-trash mr-1"></i>
                    {{ lang._('btn_ok') }}
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Search Log Modal -->
<div id="searchLog" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">
                    <i class="fas fa-search mr-1"></i>
                    {{ lang._('callog_modal_search') }}
                </h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="searchBody">
                    <div class="form-group">
                        <label for="sentFrom">{{ lang._('callog_modal_sendtime') }}</label>
                        <div id="sent" class="input-group date-picker input-daterange" data-date="10/11/2012" data-date-format="yyyy-mm-dd">
                            <input type="text" class="form-control" id="sentFrom" name="from" placeholder="{{ lang._('from') }}">
                            <span class="input-group-addon">{{ lang._('from') }}</span>
                            <input type="text" class="form-control" id="sentTo" name="to" placeholder="{{ lang._('to') }}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="sender">{{ lang._('callog_modal_sender') }}</label>
                        <input id="sender" type="text" class="form-control" placeholder="{{ lang._('callog_modal_sender') }}">
                    </div>
                    <div class="form-group">
                        <label for="receiver">{{ lang._('callog_modal_rcvd') }}</label>
                        <input id="receiver" type="text" class="form-control" placeholder="{{ lang._('callog_modal_rcvd') }}">
                    </div>
                </div>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <i class="fas fa-times mr-1"></i>
                    {{ lang._('btn_cancel') }}
                </button>
                <button type="submit" id="okBtn" class="btn btn-primary" onclick="onSearchLog()">
                    <i class="fas fa-search mr-1"></i>
                    {{ lang._('btn_search') }}
                </button>
            </div>
        </div>
    </div>
</div>
