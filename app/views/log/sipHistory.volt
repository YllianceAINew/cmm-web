{{ content() }}
<!-- BEGIN CONTENT -->
<script type="text/javascript">
    var baseUrl = "{{ url() }}";
</script>

<div class="page-content-wrapper">
    <!-- BEGIN CONTENT BODY -->
    <div class="page-content" >
        <div>                            <!-- class="portlet light bordered" -->
            <div class="portlet-body">
                <div class="tab-content">
                    <div class="tab-pane fade active in" id="tab_1_1"> 
                    <h3>{{ lang._('server_kamailiolog') }}</h3>
                        <div style="width:100%">
                            <button id="alertDel"data-toggle="modal" href = "#delete">{{ lang._('btn_delete') }} </button>
                            <button id="alertSearch" data-toggle="modal" href = "#search">{{ lang._('btn_search') }} </button>
                            <table class="errorCount" border="1" width="300px" cellpadding="1" cellspacing="0" bordercolor="#666666" bordercolordark="#FFFFFF" bgcolor="#FFFFFF">
                                <tbody>
                                    <tr align="center">
                                        <td id="alarm_error" width="30%" height="10" bgcolor="#FF9900">{{ lang._('error') }}:  <span>{{ countError }}</span></td>     
                                        <td id="alarm_warning" width="30%" height="10" bgcolor="#FFCC99">{{ lang._('alert') }}:  <span>{{ countAlert }}</td>      
                                        <td id="alarm_notice" width="30%" height="10" bgcolor="#FFFF99">{{ lang._('hint') }}:  <span>{{ countHint }}</td>     
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="div-view table-responsive">
                            <table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_1">
                            <thead>
                                <tr class="table-head">
                                    <th><input type= "checkbox" id="selectAllChk"></th>
                                    <th>{{ lang._('no') }}</th>
                                    <th>{{ lang._('alarm_thead_level') }}</th>
                                    <th>{{ lang._('alarm_thead_content') }}</th>
                                    <th>{{ lang._('alarm_thead_crttime') }}</th>
                                    <th>{{ lang._('delete') }}</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php 
                                    $i = 0;
                                ?>
                                {% for hist in histories %}
                                <?php
                                    $i++;
                                    $chkColor = "white";
                                    if($hist['level'] == 0){
                                        $chkColor = "yellow";
                                        echo "<tr class='odd gradeX' style = 'background-color:yellow'>";
                                    } else if($hist['level'] == 1){
                                        $chkColor = "rgba(255, 204, 51, 1)";
                                        echo "<tr class='odd gradeX' style = 'background-color:rgba(255, 204, 51, 1)'>";
                                    } else if($hist['level'] == 2){
                                        $chkColor = "rgba(255, 102, 102, 1)";
                                        echo "<tr class='odd gradeX' style = 'background-color:rgba(255, 102, 102, 1)'>";
                                    }
                                ?>
                                    
                                    <td class="hasCheckTD" style="background-color:{{chkColor}}">
                                        <input type= "checkbox" class="childChecks" dataVal="{{hist['id']}}"/>
                                    </td>
                                    <input type = "hidden" class="logno" value="{{hist['id']}}"/>
                                    <td>{{ i }}</td>
                                    <td class="loglevel">{{level[hist['level']]}}</td>
                                    <td class="logcontent">{{hist['log']}}</td>
                                    <td class="logdate">{{hist['time']}}</td>
                                    <td> <a><img src="{{url('')}}pages/img/delete.gif" data-toggle="modal" href = "#deleteHist"></a> </td>
                                </tr>
                                {% endfor %}

                            </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div> <!-- page-content -->

    <div id="deleteHist" class="modal fade" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title">{{ lang._('alarm_modal_del') }}</h4>
                </div>
                <div class="modal-body">
                    <div class="scroller" id="delBody" data-always-visible="1" data-rail-visible1="1">
                        <div class="row">
                            <h5>{{ lang._('alarm_msg_delete') }}</h5>
                        </div>  
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" id="okBtn" onClick="onDeleteHistory({{hist['id']}})">{{ lang._('btn_ok') }}</button>
                    <button type="button" data-dismiss="modal" id="cancelBtn">{{ lang._('btn_cancel') }}</button>                   
                </div>
            </div>
        </div>
    </div>

    <div id="delete" class="modal fade" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title">{{ lang._('alarm_modal_del') }}</h4>
                </div>
                <div class="modal-body">
                    <div class="scroller" id="delBody" data-always-visible="1" data-rail-visible1="1">
                        <div class="row">
                            <h5>{{ lang._('alarm_msg_multidelete') }}</h5>
                        </div>  
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" id="okBtn" onclick="onDeleteAlert()">{{ lang._('btn_ok') }}</button>
                    <button type="button" data-dismiss="modal" id="cancelBtn">{{ lang._('btn_cancel') }}</button>                   
                </div>
            </div>
        </div>
    </div>

    <div id="search" class="modal fade" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title">{{ lang._('alarm_modal_search') }}</h4>
                </div>
                <div class="modal-body">
                    <div class="scroller" id="searchBody" data-always-visible="1" data-rail-visible1="1">
                        <div class="row">
                            <div class="col-md-3" id="bodyText" align="right">
                                <label class="modal-label">{{ lang._('alarm_modal_crttime') }}</label>
                                <label class="modal-label">{{ lang._('alarm_modal_body') }}</label>
                                <label class="modal-label">&nbsp</label>
                                <label class="modal-label">{{ lang._('alarm_modal_level') }}</label>
                            </div>
                            <div class="col-md-7">
                                <div id="create" class="input-group date-picker input-daterange" data-date="10/11/2012" data-date-format = "yyyy-mm-dd">
                                    <input type="text" class="form-control" id="createFrom" name="from">
                                    <span class="input-group-addon"> {{ lang._('from') }} </span>
                                    <input type="text" class="form-control" id="createTo" name="to">
                                </div>
                                <textarea id="content" type="text" class="col-md-12 form-control" ></textarea>
                                <select class="col-md-12 form-control" id = "typeSelect">
                                    <option value="all">{{ lang._('alarm_modal_all') }}</option>
                                    <option value="0">{{ lang._('hint') }}</option>
                                    <option value="1">{{ lang._('alert') }}</option>
                                    <option value="2">{{ lang._('error') }}</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" id="okBtn" onclick="onSearchAlert()">{{ lang._('btn_search') }}</button>
                    <button type="button" data-dismiss="modal" id="cancelBtn">{{ lang._('btn_cancel') }}</button>                   
                </div>
            </div>
        </div>
    </div>
</div>