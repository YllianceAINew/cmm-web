{{ content() }}
<script type="text/javascript">
    var baseUrl = "{{ url() }}";
</script>

<!-- Alarm Count Summary Cards -->
<div class="row mb-3">
    <div class="col-lg-4 col-md-6 col-sm-6">
        <div class="small-box bg-warning">
            <div class="inner">
                <h3 id="alarm_error">{{ countError }}</h3>
                <p>{{ lang._('error') }}</p>
            </div>
            <div class="icon">
                <i class="fas fa-exclamation-triangle"></i>
            </div>
        </div>
    </div>
    <div class="col-lg-4 col-md-6 col-sm-6">
        <div class="small-box bg-info">
            <div class="inner">
                <h3 id="alarm_warning">{{ countAlert }}</h3>
                <p>{{ lang._('alert') }}</p>
            </div>
            <div class="icon">
                <i class="fas fa-info-circle"></i>
            </div>
        </div>
    </div>
    <div class="col-lg-4 col-md-6 col-sm-6">
        <div class="small-box bg-success">
            <div class="inner">
                <h3 id="alarm_notice">{{ countHint }}</h3>
                <p>{{ lang._('hint') }}</p>
            </div>
            <div class="icon">
                <i class="fas fa-check-circle"></i>
            </div>
        </div>
    </div>
</div>

<!-- SIP History Card -->
<div class="card">
    <div class="card-header">
        <h3 class="card-title">
            <i class="fas fa-server mr-1"></i>
            {{ lang._('server_kamailiolog') }}
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
                <button id="alertSearch" class="btn btn-primary btn-sm" data-toggle="modal" href="#search">
                    <i class="fas fa-search mr-1"></i>
                    {{ lang._('btn_search') }}
                </button>
                <button id="alertDel" class="btn btn-danger btn-sm" data-toggle="modal" href="#delete">
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
                        <th>{{ lang._('alarm_thead_level') }}</th>
                        <th>{{ lang._('alarm_thead_content') }}</th>
                        <th>{{ lang._('alarm_thead_crttime') }}</th>
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
                        if($hist['level'] == 0){
                            $chkColor = "#d4edda";
                            $rowClass = "table-success";
                        } else if($hist['level'] == 1){
                            $chkColor = "#d1ecf1";
                            $rowClass = "table-info";
                        } else if($hist['level'] == 2){
                            $chkColor = "#fff3cd";
                            $rowClass = "table-warning";
                        }
                    ?>
                    <tr class="<?php echo $rowClass; ?>">
                        <td class="hasCheckTD">
                            <input type="checkbox" class="childChecks" dataVal="{{hist['id']}}"/>
                            <input type="hidden" class="logno" value="{{hist['id']}}"/>
                        </td>
                        <td><?php echo $i; ?></td>
                        <td class="loglevel">{{level[hist['level']]}}</td>
                        <td class="logcontent">{{hist['log']}}</td>
                        <td class="logdate">{{hist['time']}}</td>
                        <td class="text-center">
                            <a class="deleteHistBtn btn btn-sm btn-danger" data-toggle="modal" href="#deleteHist" data-id="{{hist['id']}}" title="{{ lang._('delete') }}">
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

<!-- Delete Single History Modal -->
<div id="deleteHist" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">
                    <i class="fas fa-exclamation-triangle mr-1"></i>
                    {{ lang._('alarm_modal_del') }}
                </h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="delBody">
                    <div class="alert alert-warning">
                        <i class="icon fas fa-exclamation-triangle"></i>
                        {{ lang._('alarm_msg_delete') }}
                    </div>
                    <label id="deleteHistId" hidden></label>
                </div>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <i class="fas fa-times mr-1"></i>
                    {{ lang._('btn_cancel') }}
                </button>
                <button type="submit" id="okBtn" class="btn btn-danger" onClick="onDeleteHistory()">
                    <i class="fas fa-trash mr-1"></i>
                    {{ lang._('btn_ok') }}
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Delete Multiple Histories Modal -->
<div id="delete" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">
                    <i class="fas fa-exclamation-triangle mr-1"></i>
                    {{ lang._('alarm_modal_del') }}
                </h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="delBody">
                    <div class="alert alert-warning">
                        <i class="icon fas fa-exclamation-triangle"></i>
                        <span id="deleteLogMessage">{{ lang._('alarm_msg_multidelete') }}</span>
                    </div>
                </div>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <i class="fas fa-times mr-1"></i>
                    {{ lang._('btn_cancel') }}
                </button>
                <button type="submit" id="okBtn" class="btn btn-danger" onclick="onDeleteAlert()">
                    <i class="fas fa-trash mr-1"></i>
                    {{ lang._('btn_ok') }}
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Search History Modal -->
<div id="search" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">
                    <i class="fas fa-search mr-1"></i>
                    {{ lang._('alarm_modal_search') }}
                </h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="searchBody">
                    <div class="form-group">
                        <label for="createFrom">{{ lang._('alarm_modal_crttime') }}</label>
                        <div id="create" class="input-group date-picker input-daterange" data-date="10/11/2012" data-date-format="yyyy-mm-dd">
                            <input type="text" class="form-control" id="createFrom" name="from" placeholder="{{ lang._('from') }}">
                            <span class="input-group-addon">{{ lang._('from') }}</span>
                            <input type="text" class="form-control" id="createTo" name="to" placeholder="{{ lang._('to') }}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="content">{{ lang._('alarm_modal_body') }}</label>
                        <textarea id="content" class="form-control" rows="3" placeholder="{{ lang._('alarm_modal_body') }}"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="typeSelect">{{ lang._('alarm_modal_level') }}</label>
                        <select id="typeSelect" class="form-control">
                            <option value="all">{{ lang._('alarm_modal_all') }}</option>
                            <option value="0">{{ lang._('hint') }}</option>
                            <option value="1">{{ lang._('alert') }}</option>
                            <option value="2">{{ lang._('error') }}</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <i class="fas fa-times mr-1"></i>
                    {{ lang._('btn_cancel') }}
                </button>
                <button type="submit" id="okBtn" class="btn btn-primary" onclick="onSearchAlert()">
                    <i class="fas fa-search mr-1"></i>
                    {{ lang._('btn_search') }}
                </button>
            </div>
        </div>
    </div>
</div>
