{{ content() }}
<script type="text/javascript">
    var baseUrl = "{{ url() }}";
</script>

<!-- Member Registration Requests Card -->
<div class="card">
    <div class="card-header">
        <h3 class="card-title">
            <i class="fas fa-user-plus mr-1"></i>
            {{ lang._('registration_register') }}
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
            <div class="col-md-12">
                <button type="button" id="accountAllow" class="btn btn-success" data-toggle="modal" data-target="#allowUser">
                    <i class="fas fa-check mr-1"></i>{{ lang._('register_btn_allow') }}
                </button>
                <button type="button" id="accountCancel" class="btn btn-danger" data-toggle="modal" data-target="#cancelUser">
                    <i class="fas fa-times mr-1"></i>{{ lang._('register_btn_cancel') }}
                </button>
            </div>
        </div>
        <div class="table-responsive">
            <table class="table table-bordered table-striped table-hover" id="sample_1">
                            <thead>
                                <tr class="table-head">
                                    <th> <input type="checkbox" class="checkAll"> </th>
                                    <th> {{ lang._('no') }} </th>
                                    <th> {{ lang._('register_thead_request') }} </th>
                                    <th> {{ lang._('name') }} </th>
                                    <th> {{ lang._('register_thead_userid') }} </th>
                                    <th> {{ lang._('register_thead_citizen') }} </th>       
                                    <th> {{ lang._('register_thead_phone') }} </th>
                                    <th> {{ lang._('register_thead_imsi') }} </th>
                                    <th> {{ lang._('register_thead_imei') }} </th>
                                    <th> {{ lang._('register_thead_level') }} </th>       
                                    <th> {{ lang._('register_thead_check') }} </th>
                                </tr>
                            </thead>
                            <tbody>
                                {% for i,user in users %}
                                <tr class="odd gradeX">
                                    <td> <input type="checkbox" class="hasCheckTD" checkVal="{{user.username}}"> </td>
                                    <td> {{i + 1}} </td>
                                    <td> {{ user.created }}</td>
                                    <td> {{user.name}} </td>
                                    <td> {{user.userid}} </td> 
                                    <td> {{user.citizenNum}}</td>
                                    <td> {{user.phone}} </td>
                                    <td> {{user.imsi}} </td>
                                    <td> {{user.imei}} </td>
                                    <td> {{user.level}} </td>       
                                    <td>
                                        <a href="{{url('member/regDetail/')}}{{user.username}}" class="btn btn-sm btn-info" title="{{ lang._('register_thead_check') }}">
                                            <i class="fas fa-edit"></i>
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

<!-- Allow User Modal -->
<div class="modal fade" id="allowUser" tabindex="-1" role="dialog" aria-labelledby="allowUserModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="allowUserModalLabel">
                    <i class="fas fa-check-circle mr-1"></i>{{ lang._('register_modal_allow') }}
                </h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>{{ lang._('register_msg_allow') }}</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">{{ lang._('btn_cancel') }}</button>
                <button type="button" class="btn btn-success" id="confirmAllowBtn" onclick="onSelAllow()">
                    <i class="fas fa-check mr-1"></i>{{ lang._('btn_ok') }}
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Cancel User Modal -->
<div class="modal fade" id="cancelUser" tabindex="-1" role="dialog" aria-labelledby="cancelUserModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="cancelUserModalLabel">
                    <i class="fas fa-times-circle mr-1"></i>{{ lang._('register_modal_cancel') }}
                </h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>{{ lang._('register_msg_cancel') }}</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">{{ lang._('btn_cancel') }}</button>
                <button type="button" class="btn btn-danger" id="confirmCancelBtn" onclick="onSelCancel()">
                    <i class="fas fa-times mr-1"></i>{{ lang._('btn_ok') }}
                </button>
            </div>
        </div>
    </div>
</div>
