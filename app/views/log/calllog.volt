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
                    <h3>{{ lang._('menu_call') }}</h3>
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
                    <h4 class="modal-title">{{ lang._('callog_modal_del') }}</h4>
                </div>
                <div class="modal-body">
                    <div class="scroller" id="delBody"  data-always-visible="1" data-rail-visible1="1">
                        <div class="row">
                            <h5>{{ lang._('callog_msg_delete') }}</h5>
                        </div>  
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" id="okBtn" onClick="onDeleteMsg({{hist['cdr_id']}})">{{ lang._('btn_ok') }}</button>
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
                    <h4 class="modal-title">{{ lang._('callog_modal_del') }}</h4>
                </div>
                <div class="modal-body">
                    <div class="scroller" id="delBody"  data-always-visible="1" data-rail-visible1="1">
                        <div class="row">
                            <h5>{{ lang._('callog_msg_multidel') }}</h5>
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
                    <h4 class="modal-title" >{{ lang._('callog_modal_search') }}</h4>
                </div>
                <div class="modal-body">
                    <div class="scroller" id="searchBody" data-always-visible="1" data-rail-visible1="1">
                        <div class="row">
                            <div class="col-md-3" id = "bodyText" align="right">
                                <label class="modal-label">{{ lang._('callog_modal_sendtime') }}</label>
                                <label class="modal-label">{{ lang._('callog_modal_sender') }}</label>
                                <label class="modal-label">{{ lang._('callog_modal_rcvd') }}</label>
                            </div>
                            <div class="col-md-7">
                                <div id="sent"class="input-group date-picker input-daterange" data-date="10/11/2012" data-date-format = "yyyy-mm-dd">
                                    <input type="text" class="form-control" id="sentFrom" name="from">
                                    <span class="input-group-addon"> {{ lang._('from') }} </span>
                                    <input type="text" class="form-control" id="sentTo" name="to">
                                </div>
                                <input id="sender" type="text"  class="col-md-12 form-control">
                                <input id="receiver" type="text"  class="col-md-12 form-control " >
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