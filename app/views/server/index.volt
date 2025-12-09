{{ content() }}

<script type="text/javascript">
   var baseUrl = "{{ url() }}";
    var viewAccount = function () {
        location.href = baseUrl+"server/index";
    };
    var addAccount = function () {
        location.href = baseUrl+"server/add";
    };
</script>
<div class="page-content-wrapper">
    <!-- BEGIN CONTENT BODY -->
    <div class="page-content" >
        <div>            
            <div class="portlet-body">
                <div class="tab-content">
                    <div class="tab-pane fade active in" id="tab_1_1"> 
                    <h3>{{ lang._('account_tab_viewaccount') }}</h3>
                    <div class="div-view row">
                        <button id="accountAddNew" data-toggle="modal" href="#responsive">{{ lang._('account_tab_registernew') }}</button>
                        <button id="accountDelete" data-toggle="modal"  href="#deleteAdmin">{{ lang._('btn_delete') }}</button>       
                        <table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_1">
                            <thead>
                                <tr class="bg-info">
                                    <th width="1%" class="thNO"> <input type="checkbox" id="selectAllChk"> </th>
                                    <th width = "2%"> {{ lang._('no') }} </th>
                                    <th> {{ lang._('userid') }} </th>
                                    <th> {{ lang._('name') }} </th>
                                    <th> {{ lang._('account_thead_factory') }} </th>
                                    <th> {{ lang._('account_thead_count') }} </th>
                                    <th> {{ lang._('account_thead_date') }} </th>
                                    <th width = "3%"> {{ lang._('edit') }} </th>
                                    <th width = "3%"> {{ lang._('delete') }} </th>
                                </tr>
                            </thead>
                            <tbody>                                
                            {% for member in members %}
                                <tr class="odd gradeX loop">
                                    <td align="center" class="hasCheckTD"> 
                                        {% if member.memberLoginId == 'admin' %}
                                            <input type="checkbox" disabled> 
                                        {% else %}
                                            <input type="checkbox" class="childChecks"> 
                                            <input type="hidden" class="hidden" value="{{member.memberNo}}"> 
                                        {% endif %}
                                    </td>
                                    <td> {{ loop.index }}</td>
                                    <td class="loginIDClass"> {{ member.memberLoginId }} </td>
                                    <td id="membername"> {{ member.memberName }} </td>
                                    <td> {{ member.memberDepart }} </td>
                                    <td> {{ member.loginCounter }}  </td>
                                    <td> {{ member.lastedLoginDay }}  </td>
                                    <td class = "text-center">{{link_to("server/add/"~member.memberNo,"<img src='/adminpage/pages/img/edit.gif'>")}}</td>
                                    <td class = "text-center">
                                        {% if member.memberLoginId is not 'admin' %}
                                            <a><img id="deleteBtn" src='{{url('')}}/pages/img/delete.gif' href = "#delete" data-toggle="modal" value="{{member.memberNo}}"></a>
                                        {% endif %}
                                    </td>
                                </tr>
                            {% endfor %}
                            </tbody>
                        </table>    
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>  <!-- page-content -->

    <div id="delete" class="modal fade" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title">{{ lang._('account_modal_del') }}</h4>
                </div>
                <div class="modal-body">
                    <div class="scroller" id="delBody"  data-always-visible="1" data-rail-visible1="1">
                        <div class="row">
                            <h5>{{ lang._('adminUser') }}({{member.memberName}}){{ lang._('str_cancel') }}</h5>
                        </div>  
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" id="okBtn" onClick = "onDelete({{member.memberNo}},'{{ member.memberName }}')">{{ lang._('btn_ok') }}</button>
                    <button type="button" id="cancelBtn" data-dismiss="modal">{{ lang._('btn_cancel') }}</button>                    
                </div>
            </div>
        </div>
    </div>

    <div id="deleteAdmin" class="modal fade" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title">{{ lang._('account_modal_del') }}</h4>
                </div>
                <div class="modal-body">
                    <div class="scroller" id="delBody"  data-always-visible="1" data-rail-visible1="1">
                        <div class="row">
                            <h5>{{ lang._('account_msg_seldelete') }}</h5>
                        </div>  
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" id="okBtn" onclick="onSelDelete()">{{ lang._('btn_ok') }}</button>
                    <button type="button" id="cancelBtn" data-dismiss="modal">{{ lang._('btn_cancel') }}</button>                    
                </div>
            </div>
        </div>
    </div>

    <div id="responsive" class="modal fade" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title">{{ lang._('account_modal_add') }}</h4>
                </div>
                <div class="modal-body">
                    <div class="scroller" data-always-visible="1" data-rail-visible1="1">
                        <div class="row">
                            <h5>{{ lang._('account_modal_hint') }}</h4>
                            <div class="col-md-3" id="bodyText" align="right">
                                <label class="modal-label">{{ lang._('account_modal_id') }}</label>
                                <label class="modal-label">{{ lang._('name') }} :</label>
                                <label class="modal-label">{{ lang._('account_modal_factory') }}</label>
                                <label class="modal-label">{{ lang._('account_modal_password') }}</label>
                                <label class="modal-label">{{ lang._('account_modal_confirm') }}</label>
                                <label class="modal-label">{{ lang._('account_modal_access') }}</label>
                            </div>
                            <div class="col-md-9">
                                <input id="userID" type="text" class="col-md-12 form-control">
                                <input id="userName" type="text" class="col-md-12 form-control">
                                <input id="userOfficial" type="text" class="col-md-12 form-control">
                                <input id="newPassword" type="password" class="col-md-12 form-control">
                                <input id="confirmPassword" type="password" class="col-md-12 form-control">
                                <div id="branchSelect" class="col-md-12 form-control">
                                {% for i,acl in aclList %}
                                    <div class="hasChecks col-md-6 col-sm-6">
                                        <input type="checkbox" dataVal="{{ i }}">
                                        <label>{{ acl }}</label>
                                    </div>
                                {% endfor %}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" id="okBtn" onclick="submitUserInfo()">{{ lang._('btn_ok') }}</button>
                    <button type="button" data-dismiss="modal" id="cancelBtn">{{ lang._('btn_cancel') }}</button>                   
                </div>
            </div>
        </div>
    </div>

</div>