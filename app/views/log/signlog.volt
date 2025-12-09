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
                    <h3>{{ lang._('menu_signin') }}</h3>
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
                    <h4 class="modal-title">{{ lang._('signlog_modal_del') }}</h4>
                </div>
                <div class="modal-body">
                    <div class="scroller" id="delBody"  data-always-visible="1" data-rail-visible1="1">
                        <div class="row">
                            <h5>{{ lang._('signlog_msg_delete') }}</h5>
                        </div>  
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" id="okBtn" onClick="onDeleteSign({{sign['no']}})">{{ lang._('btn_ok') }}</button>
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
                    <h4 class="modal-title">{{ lang._('signlog_modal_del') }}</h4>
                </div>
                <div class="modal-body">
                    <div class="scroller" id="delBody"  data-always-visible="1" data-rail-visible1="1">
                        <div class="row">
                            <h5>{{ lang._('signlog_msg_multidel') }}</h5>
                        </div>  
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" id="okBtn" onclick="onDeleteSignLog()">{{ lang._('btn_ok') }}</button>
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
                    <h4 class="modal-title" >{{ lang._('signlog_modal_search') }}</h4>
                </div>
                <div class="modal-body">
                    <div class="scroller" id="searchBody" data-always-visible="1" data-rail-visible1="1">
                        <div class="row">
                            <div class="col-md-3" id = "bodyText" align="right">
                                <label class="modal-label">{{ lang._('signlog_modal_user') }}</label>
                                <label class="modal-label">{{ lang._('signlog_modal_signtime') }}</label>
                                <label class="modal-label">{{ lang._('signlog_modal_outtime') }}</label>
                            </div>
                            <div class="col-md-7">
                                <input id="user" type="text"  class="col-md-12 form-control">
                                <div class="input-group date-picker input-daterange"  data-date-format = "yyyy-mm-dd">
                                    <input type="text" class="form-control" id="intime" align="left">
                                    <input type="text" class="form-control" id="outime" align="left">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" id="okBtn" onclick="onSearchSign()">{{ lang._('btn_search') }}</button>
                    <button type="button" id="cancelBtn" data-dismiss="modal">{{ lang._('btn_cancel') }}</button>                    
                </div>
            </div>
        </div>
    </div>
</div>