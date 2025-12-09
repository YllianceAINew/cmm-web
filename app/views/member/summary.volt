{{ content() }}
<script type="text/javascript">
    var baseUrl = "{{ url() }}";
</script>

<!-- Member Summary Card -->
<div class="card">
    <div class="card-header">
        <h3 class="card-title">
            <i class="fas fa-users mr-1"></i>
            {{ lang._('userlist') }}
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
                <button id="searchAccount" class="btn btn-primary btn-sm" data-toggle="modal" href="#searchModal">
                    <i class="fas fa-search mr-1"></i>{{ lang._('btn_search') }}
                </button>
                <button id="removeAccount" class="btn btn-danger btn-sm" data-toggle="modal" href="#deleteSelected">
                    <i class="fas fa-trash mr-1"></i>{{ lang._('btn_delete') }}
                </button>
            </div>
        </div>
        <div class="table-responsive">
            <table class="table table-striped table-bordered table-hover" id="sample_1">
                            <thead>
                                <tr class="table-head">
                                    <th> <input type="checkbox" class="checkAll"> </th>
                                    <th> {{ lang._('no') }} </th>
                                    <th> {{ lang._('summary_thead_state') }} </th>
                                    <th> {{ lang._('summary_thead_id') }} </th>
                                    <th> {{ lang._('summary_thead_phone') }} </th>
                                    <th> {{ lang._('summary_thead_imei') }} </th>
                                    <th> {{ lang._('summary_thead_imsi') }} </th>        
                                    <th> {{ lang._('summary_thead_name') }} </th>       
                                    <th> {{ lang._('summary_thead_level') }} </th>
                                    <th> {{ lang._('summary_thead_stop') }} </th>
                                    <th> {{ lang._('edit') }} </th>
                                    <th> {{ lang._('delete') }} </th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php
                                    $i=0;
                                    foreach ($members as $member) {
                                        $i++;
                                        $offline = 1;
                                        $presence = PresencesModel::findFirstByusername($member->username);
                                        if($presence)
                                            $offline = 0;
                                        if($member->state != 1)
                                            $offline = 0;
                                        $userlist = UserListModel::findFirstByusername($member->username);
                                        if(!$userlist)
                                            $offline = 0;

                                        if($offline == 0)
                                            $img_name = "offline.gif";
                                        else
                                            $img_name = "online.gif";

                                        $splits = explode(":", $member->UserListModel->email);
                                ?>
                                    <tr class="odd gradeX">
                                        <td width="1%" class="hasCheckTD">
                                        {% if member.username == 'admin' %}
                                            <input type="checkbox" disabled> 
                                        {% else %}
                                            <input type="checkbox" class="childChecks"> 
                                            <input type="hidden" class="hidden" value="{{member.id}}"> 
                                        {% endif %}</td>
                                        <td width="2%"> <?php echo $i; ?> </td>
                                        <td width="1%">
                                            <img src="{{url('')}}/pages/img/<?php echo $img_name;?>"> 
                                        </td>
                                        <td class="loginIDClass"> {{ member.username }} </td>
                                        <td> {{ member.phone }} </td>
                                        <td> {{ member.imei }} </td>
                                        <td> 
                                            {% if member.username != 'admin' %}
                                            {{ member.imsi }}
                                            {% endif %} </td>
                                        <td> {{ member.name }} </td>
                                        <td> 
                                            {% if member.username != 'admin' %}
                                            <?php echo $splits[1]; ?>
                                            {% endif %} </td>
                                        <td> 
                                            {% if member.username != 'admin' %}
                                            {% if splits[0] == '0' %}
                                                {{lang._('member_no')}}
                                            {% else %}
                                                {{lang._('member_yes')}}
                                            {% endif %}
                                            {% endif %}
                                        </td>
                                        <td>
                                            {% if member.username != 'admin' %}<a class="editLevel" href = "{{url('member/detail/')}}{{member.username}}"><img src='{{url('')}}/pages/img/edit.gif'></a>
                                            {% endif %}
                                        </td>
                                        <td class="text-center">
                                            {% if member.username != 'admin' %}
                                            <a  class="deleteMember" memberid="{{member.id}}" membername="{{member.name}}"><img src="{{url('')}}/pages/img/delete.gif" data-toggle="modal" href="#delete"></a>
                                            {% endif %}
                                         </td>
                                    </tr>
                                <?php
                                    }
                                ?>
                            </tbody>
                        </table>
        </div>
    </div>
    <!-- /.card-body -->
</div>
<!-- /.card -->

<!-- Delete Member Modal -->
<div id="delete" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">{{ lang._('summary_modal_del') }}</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="delBody">
                    <div class="row">
                        <label id="deleteMemberId" hidden></label>
                        <p>{{ lang._('logUser') }}(<label id="deleteMemberName"></label>){{ lang._('str_cancel') }}</p>
                    </div>  
                </div>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">{{ lang._('btn_cancel') }}</button>
                <button type="submit" id="okBtn" class="btn btn-danger" onClick="onDeleteMember()">{{ lang._('btn_ok') }}</button>
            </div>
        </div>
    </div>
</div>

<!-- Delete Selected Members Modal -->
<div id="deleteSelected" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">{{ lang._('summary_modal_del') }}</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="delBody">
                    <div class="row">
                        <p>{{ lang._('summary_msg_multisel') }}</p>
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

<!-- Search Modal -->
<div id="searchModal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">{{ lang._('summary_modal_search') }}</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="searchBody">
                    <div class="row">
                        <div class="col-md-3 text-right">
                            <div class="form-group">
                                <label class="form-label">{{ lang._('summary_modal_date') }}</label>
                            </div>
                            <div class="form-group">
                                <label class="form-label">{{ lang._('userid') }} :</label>
                            </div>
                            <div class="form-group">
                                <label class="form-label">{{ lang._('name') }} :</label>
                            </div>
                            <div class="form-group">
                                <label class="form-label">{{ lang._('summary_modal_phone') }}</label>
                            </div>
                            <div class="form-group">
                                <label class="form-label">{{ lang._('summary_modal_stop') }}</label>
                            </div>
                        </div>
                        <div class="col-md-9">
                            <div class="form-group">
                                <div id="sent" class="input-group date-picker input-daterange" data-date="10/11/2012" data-date-format="yyyy-mm-dd">
                                    <input type="text" class="form-control" id="sentFrom" name="from">
                                    <span class="input-group-addon">{{ lang._('from') }}</span>
                                    <input type="text" class="form-control" id="sentTo" name="to">
                                </div>
                            </div>
                            <div class="form-group">
                                <input id="id" type="text" class="form-control" placeholder="{{ lang._('userid') }}">
                            </div>
                            <div class="form-group">
                                <input id="name" type="text" class="form-control" placeholder="{{ lang._('name') }}">
                            </div>
                            <div class="form-group">
                                <input id="phone" type="text" class="form-control" placeholder="{{ lang._('summary_modal_phone') }}">
                            </div>
                            <div class="form-group">
                                <select id="typeSelect" class="form-control">
                                    <option value="all">전체</option>
                                    <option value="1">차단</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">{{ lang._('btn_cancel') }}</button>
                <button type="submit" id="okBtn" class="btn btn-primary" onclick="onSearchAccount()">
                    <i class="fas fa-search mr-1"></i>{{ lang._('btn_search') }}
                </button>
            </div>
        </div>
    </div>
</div>