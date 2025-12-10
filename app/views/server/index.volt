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

<!-- Account Management Card -->
<div class="card">
    <div class="card-header">
        <h3 class="card-title">
            <i class="fas fa-user-shield mr-1"></i>
            {{ lang._('account_tab_viewaccount') }}
        </h3>
        <div class="card-tools">
            <button type="button" class="btn btn-tool" data-card-widget="collapse">
                <i class="fas fa-minus"></i>
            </button>
        </div>
    </div>
    <!-- /.card-header -->
    <div class="card-body">
        <div class="table-responsive">
            <table id="sample_1" class="table table-bordered table-striped">
                <thead>
                    <tr class="table-head">
                        <th width="1%"> <input type="checkbox" class="checkAll"> </th>
                        <th width="2%"> {{ lang._('no') }} </th>
                        <th> {{ lang._('userid') }} </th>
                        <th> {{ lang._('name') }} </th>
                        <th> {{ lang._('account_thead_factory') }} </th>
                        <th> {{ lang._('account_thead_count') }} </th>
                        <th> {{ lang._('account_thead_date') }} </th>
                        <th width="3%"> {{ lang._('edit') }} </th>
                        <th width="3%"> {{ lang._('delete') }} </th>
                    </tr>
                </thead>
                <tbody>                                
                {% for member in members %}
                    <tr class="odd gradeX">
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
                        <td class="text-center">
                            {{link_to("server/add/"~member.memberNo,"<i class='fas fa-edit text-primary'></i>", "class": "btn btn-sm")}}
                        </td>
                        <td class="text-center">
                            {% if member.memberLoginId is not 'admin' %}
                                <a class="deleteAccount" href="#" data-toggle="modal" data-target="#delete" data-id="{{member.memberNo}}" data-name="{{member.memberName}}">
                                    <i class="fas fa-trash text-danger"></i>
                                </a>
                            {% endif %}
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

<!-- Delete Account Modal -->
<div id="delete" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">{{ lang._('account_modal_del') }}</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="delBody">
                    <div class="row">
                        <label id="deleteAccountId" hidden></label>
                        <p>{{ lang._('adminUser') }}(<label id="deleteAccountName"></label>){{ lang._('str_cancel') }}</p>
                    </div>  
                </div>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">{{ lang._('btn_cancel') }}</button>
                <button type="submit" id="okBtn" class="btn btn-danger" onClick="onDelete()">{{ lang._('btn_ok') }}</button>
            </div>
        </div>
    </div>
</div>

<!-- Delete Selected Accounts Modal -->
<div id="deleteAdmin" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">{{ lang._('account_modal_del') }}</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="delBody">
                    <div class="row">
                        <p>{{ lang._('account_msg_seldelete') }}</p>
                    </div>  
                </div>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">{{ lang._('btn_cancel') }}</button>
                <button type="submit" id="okBtn" class="btn btn-danger" onclick="onSelDelete()">{{ lang._('btn_ok') }}</button>
            </div>
        </div>
    </div>
</div>

<!-- Add Account Modal -->
<div id="responsive" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">{{ lang._('account_modal_add') }}</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <p class="text-muted">{{ lang._('account_modal_hint') }}</p>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label for="userID">{{ lang._('account_modal_id') }}</label>
                            <input id="userID" type="text" class="form-control" placeholder="{{ lang._('account_modal_id') }}">
                        </div>
                        <div class="form-group">
                            <label for="userName">{{ lang._('name') }}</label>
                            <input id="userName" type="text" class="form-control" placeholder="{{ lang._('name') }}">
                        </div>
                        <div class="form-group">
                            <label for="userOfficial">{{ lang._('account_modal_factory') }}</label>
                            <input id="userOfficial" type="text" class="form-control" placeholder="{{ lang._('account_modal_factory') }}">
                        </div>
                        <div class="form-group">
                            <label for="newPassword">{{ lang._('account_modal_password') }}</label>
                            <input id="newPassword" type="password" class="form-control" placeholder="{{ lang._('account_modal_password') }}">
                        </div>
                        <div class="form-group">
                            <label for="confirmPassword">{{ lang._('account_modal_confirm') }}</label>
                            <input id="confirmPassword" type="password" class="form-control" placeholder="{{ lang._('account_modal_confirm') }}">
                        </div>
                        <div class="form-group">
                            <label>{{ lang._('account_modal_access') }}</label>
                            <div id="branchSelect" class="row">
                            {% for i,acl in aclList %}
                                <div class="col-md-6 col-sm-6">
                                    <div class="form-check">
                                        <input type="checkbox" class="form-check-input" dataVal="{{ i }}" id="acl_{{ i }}">
                                        <label class="form-check-label" for="acl_{{ i }}">{{ acl }}</label>
                                    </div>
                                </div>
                            {% endfor %}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">{{ lang._('btn_cancel') }}</button>
                <button type="button" id="okBtn" class="btn btn-primary" onclick="submitUserInfo()">
                    <i class="fas fa-save mr-1"></i>{{ lang._('btn_ok') }}
                </button>
            </div>
        </div>
    </div>
</div>
