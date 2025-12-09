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
                    <h3>{{ lang._('userlist') }}</h3>
                    <div class="div-view row">
                        <table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_1">
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

                        <button id="removeAccount" align="right" data-toggle="modal" href="#deleteSelected">{{ lang._('btn_delete') }} </button>
                        <button id="searchAccount" align="right" data-toggle="modal" href = "#searchModal">{{ lang._('btn_search') }} </button>
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
                    <h4 class="modal-title">{{ lang._('summary_modal_del') }}</h4>
                </div>
                <div class="modal-body">
                    <div class="scroller" id="delBody"  data-always-visible="1" data-rail-visible="1">
                        <div class="row">
                            <label id="deleteMemberId" hidden></label>
                            <h5>{{ lang._('logUser') }}(<label id="deleteMemberName"></label>){{ lang._('str_cancel') }}</h5>
                        </div>  
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" id="okBtn" onClick="onDeleteMember()">{{ lang._('btn_ok') }}</button>
                    <button type="button" id="cancelBtn" data-dismiss="modal">{{ lang._('btn_cancel') }}</button>                    
                </div>
            </div>
        </div>
    </div>

    <div id="deleteSelected" class="modal fade" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title">{{ lang._('summary_modal_del') }}</h4>
                </div>
                <div class="modal-body">
                    <div class="scroller" id="delBody"  data-always-visible="1" data-rail-visible="1">
                        <div class="row">
                            <h5>{{ lang._('summary_msg_multisel') }}</h5>
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

    <div id="searchModal" class="modal fade" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title" >{{ lang._('summary_modal_search') }}</h4>
                </div>
                <div class="modal-body">
                    <div class="scroller" id="searchBody" data-always-visible="1" data-rail-visible1="1">
                        <div class="row">
                            <div class="col-md-3" id = "bodyText" align="right">
                                <label class="modal-label">{{ lang._('summary_modal_date') }}</label>
                                <label class="modal-label">{{ lang._('userid') }} :</label>
                                <label class="modal-label">{{ lang._('name') }} :</label>
                                <label class="modal-label">{{ lang._('summary_modal_phone') }}</label>
                                <label class="modal-label">{{ lang._('summary_modal_stop') }}</label>
                            </div>
                            <div class="col-md-7">
                                <div id="sent" class="input-group date-picker input-daterange" data-date="10/11/2012" data-date-format = "yyyy-mm-dd">
                                    <input type="text" class="form-control" id="sentFrom" name="from">
                                    <span class="input-group-addon"> {{ lang._('from') }} </span>
                                    <input type="text" class="form-control" id="sentTo" name="to">
                                </div>

                                <input id="id" type="text"  class="col-md-12 form-control">
                                <input id="name" type="text"  class="col-md-12 form-control " >
                                <input id="phone" type="text"  class="col-md-12 form-control " >
                                <select id="typeSelect" class="col-md-12 form-control ">
                                    <option value="all">전체</option>
                                    <option value="1">차단</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" id="okBtn" onclick="onSearchAccount()">{{ lang._('btn_search') }}</button>
                    <button type="button" id="cancelBtn" data-dismiss="modal">{{ lang._('btn_cancel') }}</button>
                    
                </div>
            </div>
        </div>
    </div>
</div>