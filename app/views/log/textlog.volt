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
                    <h3>{{ lang._('menu_text') }}</h3>
                        <div id="logbtn">
                            <button id="deletelog" data-toggle="modal" href = "#deleteLog">{{ lang._('btn_delete') }} </button>
                            <button id="searchlog" data-toggle="modal" href = "#searchLog">{{ lang._('btn_search') }} </button>
                        </div>
                        <div class="div-view row">                          
                            <table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_1">
                            <thead>
                                <tr class="table-head">
                                    <th width='3%'>
                                        <input type= "checkbox" id="selectAllChk">
                                    </th>
                                    <th width='3%'>{{ lang._('no') }}</th>
                                    <th  width='7%'>{{ lang._('textlog_thead_sender') }}</th>
                                    <th  width='7%'>{{ lang._('textlog_thead_rcvd') }}</th>
                                    <th  width='7%'>{{ lang._('textlog_modal_type') }}</th>
                                    <th  width='25%'>{{ lang._('textlog_thead_body') }}</th>
                                    <th  width='10%'>{{ lang._('textlog_thead_sendtime') }}</th>
                                    <th  width='10%'>{{ lang._('textlog_thead_rcvdtime') }}</th>
                                    <th  width='13%'>{{ lang._('textlog_thead_result') }}</th>
                                    <th  width='3%'>{{ lang._('delete') }}</th>
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
                                <tr class="odd gradeX">
                                    <td class="hasCheckTD">
                                        <input type= "checkbox" class="childChecks" dataVal="{{hist['No']}}"/>
                                    </td>
                                     <input type = "hidden" class="logno" value="{{hist['No']}}"/>
                                    <td>{{ i + 1 }}</td>
                                    <td>{{ hist['FromUser'] }}</td>
                                    <td>{{ hist['ToUser'] }}</td>
                                    <td>{{ fileType[ hist['Type'] ] }}</td>
                                    <td>{{ body }}</td>
                                    <td>{{ hist['SentTime'] }}</td>
                                    <td>{{ hist['RcvdTime'] }}</td>
                                    <td>{{ reason[hist['Reason']] }}</td>
                                    <td> <a><img src="{{url('')}}pages/img/delete.gif" data-toggle="modal" href = "#delete"></a> </td>
                                </tr>
                                {% endfor %}

                            </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div> 
 <!-- page-content -->
    <div id="delete" class="modal fade" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title">{{ lang._('textlog_modal_del') }}</h4>
                </div>
                <div class="modal-body">
                    <div class="scroller" id="delBody"  data-always-visible="1" data-rail-visible1="1">
                        <div class="row">
                            <h5>{{ lang._('textlog_msg_delete') }}</h5>
                        </div>  
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" id="okBtn" onClick="onDeleteMsg({{hist['No']}})">{{ lang._('btn_ok') }}</button>
                    <button type="button" id="cancelBtn" data-dismiss="modal">{{ lang._('btn_cancel') }}</button>                    
                </div>
            </div>
        </div>
    </div>

    <div id="deleteLog" class="modal fade" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title">{{ lang._('textlog_modal_del') }}</h4>
                </div>
                <div class="modal-body">
                    <div class="scroller" id="delBody"  data-always-visible="1" data-rail-visible1="1">
                        <div class="row">
                            <h5>{{ lang._('textlog_msg_multidel') }}</h5>
                        </div>  
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" id="okBtn" onclick="onDeleteLog()">{{ lang._('btn_ok') }}</button>
                    <button type="button" id="cancelBtn" data-dismiss="modal">{{ lang._('btn_cancel') }}</button>                    
                </div>
            </div>
        </div>
    </div>

    <div id="searchLog" class="modal fade" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title" >{{ lang._('textlog_modal_search') }}</h4>
                </div>
                <div class="modal-body">
                    <div class="scroller" id="searchBody" data-always-visible="1" data-rail-visible1="1">
                        <div class="row">
                            <div class="col-md-3" id = "bodyText" align="right">
                                <label class="modal-label">{{ lang._('callog_modal_sendtime') }}</label>
                                <label class="modal-label">{{ lang._('callog_modal_sender') }}</label>
                                <label class="modal-label">{{ lang._('callog_modal_rcvd') }}</label>
                                <label class="modal-label">{{ lang._('callog_modal_body') }}</label>

                            </div>
                            <div class="col-md-7">
                                <div id="sent" class="input-group date-picker input-daterange" data-date="10/11/2012" data-date-format = "yyyy-mm-dd">
                                    <input type="text" class="form-control" id="sentFrom" name="from">
                                    <span class="input-group-addon"> {{ lang._('from') }} </span>
                                    <input type="text" class="form-control" id="sentTo" name="to">
                                </div>
                                <input id="sender" type="text"  class="col-md-12 form-control">
                                <input id="receiver" type="text"  class="col-md-12 form-control " >
                                <textarea id="text" type="text" class="col-md-12 form-control"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" id="okBtn" onclick="onSearchLog()">{{ lang._('btn_search') }}</button>
                    <button type="button" id="cancelBtn" data-dismiss="modal">{{ lang._('btn_cancel') }}</button>                  
                </div>
            </div>
        </div>
    </div>
</div>