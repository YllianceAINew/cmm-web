{{ content() }}
<script type="text/javascript">
    var baseUrl = '{{url("")}}';
</script>

<!-- BEGIN CONTENT -->
<div class="page-content-wrapper">
    <!-- BEGIN CONTENT BODY -->
    <div class="page-content" >
        <div>                            <!-- class="portlet light bordered" -->
            <div class="portlet-body">
                <div class="tab-content">
                    <h3>{{ lang._('summary_detail_title') }}</h3>
                    <div class="div-view row">
                        <div class="member-normal col-md-5 col-sm-5">
                            <div class="row">
                                <span id="normalinfo">{{ lang._('summary_detail_mormal') }}</span>
                            </div>
                            <div class="col-md-5 col-sm-5 left-pane">
                                <label>{{ lang._('name') }} :</label><br>
                                <label>{{ lang._('detail_gender') }} </label><br>
                                <label>{{ lang._('detail_birth') }} </label><br>
                                <label>{{ lang._('detail_address') }} </label><br>
                                <label>{{ lang._('detail_factory') }} </label><br>
                                <label>{{ lang._('detail_citynum') }} </label><br>
                                <label>{{ lang._('detail_region') }}</label><br>
                                <label>{{ lang._('detail_type') }} </label><br>
                                <label>{{ lang._('detail_phone') }} </label><br>
                                <label>{{ lang._('detail_imsi') }}</label><br>
                                <label>{{ lang._('detail_imei') }}</label>
                            </div>
                            <div class="col-md-7 col-sm-7 right-pane">
                                <label>{{member.name}}</label><br>
                                <label>{% if member.gender == 0 %}{{ lang._('register_boy') }}{% else %}{{ lang._('register_girl') }}{% endif %}</label><br>
                                <label>{% if member.birthday != '' %}{{member.birthday}}{% else %}<span style="font-style:italic;color:#aaa">{{ lang._('detail_undefined') }}</span>{% endif %}</label><br>
                                <label>{% if member.address != '' %}{{member.address}}{% else %}<span style="font-style:italic;color:#aaa">{{ lang._('detail_undefined') }}</span>{% endif %}</label><br>
                                <label>{% if member.job != '' %}{{member.job}}{% else %}<span style="font-style:italic;color:#aaa">{{ lang._('detail_undefined') }}</span>{% endif %}</label><br>
                                <label>{% if member.citizenNum != '' %}{{member.citizenNum}}{% else %}<span style="font-style:italic;color:#aaa">{{ lang._('detail_undefined') }}</span>{% endif %}</label><br>
                                <label>{% if member.region != '' %}{{member.region}}{% else %}<span style="font-style:italic;color:#aaa">{{ lang._('detail_undefined') }}</span>{% endif %}</label><br>
                                <label>{% if member.phoneType != '' %}{{member.phoneType}}{% else %}<span style="font-style:italic;color:#aaa">{{ lang._('detail_undefined') }}</span>{% endif %}</label><br>
                                <label>{{member.phone}}</label><br>
                                <label>{{member.imsi}}</label><br>
                                <label>{{member.imei}}</label>
                            </div>
                        </div>
                        <div class="member-detail col-md-6 col-sm-6">
                            <div class="row">
                                <span id="loginfo">{{ lang._('summary_detail_loginfo') }}</span>
                            </div>
                            <div class="col-md-5 col-sm-5 left-pane">
                                <label>{{ lang._('summary_detail_state') }}</label><br>
                                <label>{{ lang._('summary_detail_id') }} </label><br>
                                <label>{{ lang._('userid') }}:</label><br>
                                <label>{{ lang._('summary_detail_date') }} </label><br>
                                <label>{{ lang._('summary_detail_lastdate') }} </label><br>
                                <label>{{ lang._('summary_detail_stop') }} </label><br>
                                <label>{{ lang._('summary_detail_group') }}</label>
                            </div>
                            <div class="col-md-7 col-sm-7 right-pane">
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
                                ?>
                                <label><img src="{{url('')}}/pages/img/<?php echo $img_name;?>"></label><br>
                                <label id="editUserName">{{member.username}}</label><br>
                                <label>{{member.userid}}</label><br>
                                <label><?php echo date("Y.m.d H:i:s", $member->UserListModel->creationDate/1000) ?></label><br>
                                <label><?php echo date("Y.m.d H:i:s", $member->UserListModel->modificationDate/1000) ?></label><br>
                                <label><?php
                                    $splits = explode(":", $member->UserListModel->email);
                                    if ($member->UserListModel->username != 'admin'){
                                        if ($splits[0] == '0')
                                            echo "<input type='checkbox'/>";
                                        else
                                            echo "<input type='checkbox' checked/>";
                                    }?></label><br>
                                <label>{% if member.username != 'admin' %}
                                    <select class="bs-select">
                                        {% for level in lvSet %}
                                        <?php
                                        if (count($splits) > 1) {
                                            if ($splits[1] == $level)
                                                echo '<option id="'.$level.'" value="'.$level.'" selected>'.$level.'</option>';
                                            else
                                                echo '<option id="'.$level.'" value="'.$level.'">'.$level.'</option>';
                                        } else
                                            echo '<option id="'.$level.'" value="'.$level.'">'.$level.'</option>';
                                        ?>
                                        {% endfor %}
                                    </select>
                                {% endif %}</label>
                            </div>
                        </div>
                            <div class="member-button row">
                                <a id="cancel" href="{{url('member/summary')}}">{{ lang._('btn_cancel') }}</a>
                                <button id="saveEdit" onclick="onSaveEdit('{{ lang._('setlevel_msg_save') }}')">{{ lang._('btn_allow') }}</button><br>
                            </div>
                    </div>
                </div>
            </div>
        </div>
    </div> 
 <!-- page-content -->
</div>