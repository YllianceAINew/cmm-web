{{ content() }}
<script type="text/javascript">
    var baseUrl = "{{ url() }}";
</script>

<!-- Text Log Card -->
<div class="card">
    <div class="card-header">
        <h3 class="card-title">
            <i class="fas fa-comments mr-1"></i>
            {{ lang._('menu_text') }}
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
                        <th style="width: 50px;">{{ lang._('no') }}</th>
                        <th style="width: 100px;">{{ lang._('textlog_thead_sender') }}</th>
                        <th style="width: 100px;">{{ lang._('textlog_thead_rcvd') }}</th>
                        <th style="width: 100px;">{{ lang._('textlog_modal_type') }}</th>
                        <th>{{ lang._('textlog_thead_body') }}</th>
                        <th style="width: 150px;">{{ lang._('textlog_thead_sendtime') }}</th>
                        <th style="width: 150px;">{{ lang._('textlog_thead_rcvdtime') }}</th>
                        <th style="width: 120px;">{{ lang._('textlog_thead_result') }}</th>
                        <th style="width: 80px;" class="text-center">{{ lang._('delete') }}</th>
                    </tr>
                </thead>
                <tbody>
                    {% for i, hist in histories %}
                    <?php
                        $splits = explode("_", $hist['Body']);
                        $body = "";
                        if(count($splits) >= 5)
                        {
                            for($j = 4;$j <= count($splits)-1;$j ++)
                                $body .= $splits[$j]."_";
                            $body = substr($body, 0,strlen($body)-1);
                        }
                        else
                            $body = $hist['Body'];
                    ?>
                    <tr>
                        <td class="hasCheckTD">
                            <input type="checkbox" class="childChecks" dataVal="{{hist['No']}}"/>
                            <input type="hidden" class="logno" value="{{hist['No']}}"/>
                        </td>
                        <td>{{ i + 1 }}</td>
                        <td>{{ hist['FromUser'] }}</td>
                        <td>{{ hist['ToUser'] }}</td>
                        <td>{{ fileType[ hist['Type'] ] }}</td>
                        <td>{{ body }}</td>
                        <td>{{ hist['SentTime'] }}</td>
                        <td>{{ hist['RcvdTime'] }}</td>
                        <td>{{ reason[hist['Reason']] }}</td>
                        <td class="text-center">
                            <a class="deleteTextBtn btn btn-sm btn-danger" data-toggle="modal" href="#delete" data-id="{{hist['No']}}" title="{{ lang._('delete') }}">
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
                    {{ lang._('textlog_modal_del') }}
                </h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="delBody">
                    <div class="alert alert-warning">
                        <i class="icon fas fa-exclamation-triangle"></i>
                        {{ lang._('textlog_msg_delete') }}
                    </div>
                    <label id="deleteTextId" hidden></label>
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
                    {{ lang._('textlog_modal_del') }}
                </h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="delBody">
                    <div class="alert alert-warning">
                        <i class="icon fas fa-exclamation-triangle"></i>
                        <span id="deleteLogMessage">{{ lang._('textlog_msg_multidel') }}</span>
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
                    {{ lang._('textlog_modal_search') }}
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
                    <div class="form-group">
                        <label for="text">{{ lang._('callog_modal_body') }}</label>
                        <textarea id="text" class="form-control" rows="3" placeholder="{{ lang._('callog_modal_body') }}"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="typeSelect">{{ lang._('textlog_modal_type') }}</label>
                        <select id="typeSelect" class="form-control">
                            <option value="all">{{ lang._('all') }}</option>
                            <option value="0">{{ lang._('messages') }}</option>
                            <option value="1">{{ lang._('voice') }}</option>
                            <option value="2">{{ lang._('videoRecord') }}</option>
                            <option value="3">{{ lang._('imageRecord') }}</option>
                            <option value="4">{{ lang._('music') }}</option>
                            <option value="5">{{ lang._('video') }}</option>
                            <option value="6">{{ lang._('image') }}</option>
                        </select>
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
