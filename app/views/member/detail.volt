{{ content() }}
<script type="text/javascript">
    var baseUrl = '{{url("")}}';
</script>

<!-- Member Detail Page -->
<div class="row">
    <!-- Normal Information Card -->
    <div class="col-md-6">
        <div class="card card-primary">
            <div class="card-header">
                <h3 class="card-title">
                    <i class="fas fa-user mr-1"></i>
                    {{ lang._('summary_detail_mormal') }}
                </h3>
                <div class="card-tools">
                    <button type="button" class="btn btn-tool" data-card-widget="collapse">
                        <i class="fas fa-minus"></i>
                    </button>
                </div>
            </div>
            <!-- /.card-header -->
            <div class="card-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label>{{ lang._('name') }}</label>
                            <div class="form-control-plaintext">{{ member.name }}</div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>{{ lang._('detail_gender') }}</label>
                            <div class="form-control-plaintext">
                                {% if member.gender == 0 %}{{ lang._('register_boy') }}{% else %}{{ lang._('register_girl') }}{% endif %}
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>{{ lang._('detail_birth') }}</label>
                            <div class="form-control-plaintext">
                                {% if member.birthday != '' %}{{ member.birthday }}{% else %}<span class="text-muted font-italic">{{ lang._('detail_undefined') }}</span>{% endif %}
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label>{{ lang._('detail_address') }}</label>
                            <div class="form-control-plaintext">
                                {% if member.address != '' %}{{ member.address }}{% else %}<span class="text-muted font-italic">{{ lang._('detail_undefined') }}</span>{% endif %}
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>{{ lang._('detail_factory') }}</label>
                            <div class="form-control-plaintext">
                                {% if member.job != '' %}{{ member.job }}{% else %}<span class="text-muted font-italic">{{ lang._('detail_undefined') }}</span>{% endif %}
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>{{ lang._('detail_citynum') }}</label>
                            <div class="form-control-plaintext">
                                {% if member.citizenNum != '' %}{{ member.citizenNum }}{% else %}<span class="text-muted font-italic">{{ lang._('detail_undefined') }}</span>{% endif %}
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>{{ lang._('detail_region') }}</label>
                            <div class="form-control-plaintext">
                                {% if member.region != '' %}{{ member.region }}{% else %}<span class="text-muted font-italic">{{ lang._('detail_undefined') }}</span>{% endif %}
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>{{ lang._('detail_type') }}</label>
                            <div class="form-control-plaintext">
                                {% if member.phoneType != '' %}{{ member.phoneType }}{% else %}<span class="text-muted font-italic">{{ lang._('detail_undefined') }}</span>{% endif %}
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>{{ lang._('detail_phone') }}</label>
                            <div class="form-control-plaintext">{{ member.phone }}</div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>{{ lang._('detail_imsi') }}</label>
                            <div class="form-control-plaintext">{{ member.imsi }}</div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>{{ lang._('detail_imei') }}</label>
                            <div class="form-control-plaintext">{{ member.imei }}</div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- /.card-body -->
        </div>
        <!-- /.card -->
    </div>
    <!-- /.col-md-6 -->

    <!-- Login Information Card -->
    <div class="col-md-6">
        <div class="card card-info">
            <div class="card-header">
                <h3 class="card-title">
                    <i class="fas fa-info-circle mr-1"></i>
                    {{ lang._('summary_detail_loginfo') }}
                </h3>
                <div class="card-tools">
                    <button type="button" class="btn btn-tool" data-card-widget="collapse">
                        <i class="fas fa-minus"></i>
                    </button>
                </div>
            </div>
            <!-- /.card-header -->
            <div class="card-body">
                <?php
                    $offline = 1;
                    $presence = PresencesModel::findFirstByusername($member->username);
                    if($presence)
                        $offline = 0;
                    if($member->state != 1)
                        $offline = 0;
                    if(!$member->UserListModel)
                        $offline = 0;

                    if($offline == 0)
                        $img_name = "offline.gif";
                    else
                        $img_name = "online.gif";
                    
                    // Initialize $splits safely
                    $splits = array();
                    if($member->UserListModel && isset($member->UserListModel->email)) {
                        $splits = explode(":", $member->UserListModel->email);
                    }
                ?>
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label>{{ lang._('summary_detail_state') }}</label>
                            <div class="form-control-plaintext">
                                <img src="{{url('')}}/pages/img/<?php echo $img_name;?>" alt="Status" style="height: 20px;">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>{{ lang._('summary_detail_id') }}</label>
                            <div class="form-control-plaintext" id="editUserName">{{ member.username }}</div>
                            <input type="hidden" id="memberId" value="{{ member.id }}">
                            <input type="hidden" id="memberName" value="{{ member.name }}">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>{{ lang._('userid') }}</label>
                            <div class="form-control-plaintext">{{ member.userid }}</div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>{{ lang._('summary_detail_date') }}</label>
                            <div class="form-control-plaintext">
                                <?php echo date("Y.m.d H:i:s", $member->UserListModel->creationDate/1000) ?>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>{{ lang._('summary_detail_lastdate') }}</label>
                            <div class="form-control-plaintext">
                                <?php echo date("Y.m.d H:i:s", $member->UserListModel->modificationDate/1000) ?>
                            </div>
                        </div>
                    </div>
                </div>
                {% if member.username != 'admin' %}
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label>{{ lang._('summary_detail_stop') }}</label>
                            <div class="form-check">
                                <?php
                                if ($member->UserListModel && $member->UserListModel->username != 'admin'){
                                    if (isset($splits[0]) && $splits[0] == '0')
                                        echo '<input type="checkbox" class="form-check-input" id="isBlock">';
                                    else
                                        echo '<input type="checkbox" class="form-check-input" id="isBlock" checked>';
                                } else {
                                    // Default to unchecked if UserListModel doesn't exist
                                    echo '<input type="checkbox" class="form-check-input" id="isBlock">';
                                }
                                ?>
                                <label class="form-check-label" for="isBlock">
                                    {{ lang._('summary_detail_stop') }}
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label for="levelSelect">{{ lang._('summary_detail_group') }}</label>
                            <select class="form-control" id="levelSelect">
                                {% for level in lvSet %}
                                <?php
                                if (isset($splits) && count($splits) > 1) {
                                    if ($splits[1] == $level)
                                        echo '<option value="'.$level.'" selected>'.$level.'</option>';
                                    else
                                        echo '<option value="'.$level.'">'.$level.'</option>';
                                } else
                                    echo '<option value="'.$level.'">'.$level.'</option>';
                                ?>
                                {% endfor %}
                            </select>
                        </div>
                    </div>
                </div>
                {% endif %}
            </div>
            <!-- /.card-body -->
        </div>
        <!-- /.card -->
    </div>
    <!-- /.col-md-6 -->
</div>
<!-- /.row -->

<!-- Action Buttons -->
<div class="row">
    <div class="col-12">
        <div class="card">
            <div class="card-footer">
                <a href="{{url('member/summary')}}" class="btn btn-secondary">
                    <i class="fas fa-times mr-1"></i>{{ lang._('btn_cancel') }}
                </a>
                {% if member.username != 'admin' %}
                <button type="button" id="deleteMember" class="btn btn-danger" data-toggle="modal" data-target="#deleteMemberModal">
                    <i class="fas fa-trash mr-1"></i>{{ lang._('btn_delete') }}
                </button>
                <button type="button" id="saveEdit" class="btn btn-primary float-right" onclick="onSaveEdit('{{ lang._('setlevel_msg_save') }}')">
                    <i class="fas fa-save mr-1"></i>{{ lang._('btn_allow') }}
                </button>
                {% endif %}
            </div>
        </div>
    </div>
</div>

<!-- Delete Member Modal -->
{% if member.username != 'admin' %}
<div class="modal fade" id="deleteMemberModal" tabindex="-1" role="dialog" aria-labelledby="deleteMemberModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteMemberModalLabel">{{ lang._('summary_modal_del') }}</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>{{ lang._('logUser') }}(<strong id="deleteMemberNameText"></strong>){{ lang._('str_cancel') }}</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">{{ lang._('btn_cancel') }}</button>
                <button type="button" class="btn btn-danger" id="confirmDeleteMember">{{ lang._('btn_ok') }}</button>
            </div>
        </div>
    </div>
</div>
{% endif %}
