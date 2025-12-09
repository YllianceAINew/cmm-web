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
                    <h3>{{ lang._('registration_register') }}</h3>
                    <div class="div-view table-responsive">
                        <table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_1">
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
                                    <td> <a href="{{url('member/regDetail/')}}{{user.username}}"><i class="fa fa-edit"></i></a> </td>
                                </tr>
                                {% endfor %}
                            </tbody>
                        </table>   
                        <button id="accountAllow" data-toggle = "modal" href="#allowUser">{{ lang._('register_btn_allow') }}</button>
                        <button id="accountCancel" data-toggle = "modal" href="#cancelUser">{{ lang._('register_btn_cancel') }}</button>             
                    </div>
                </div>
            </div>
        </div>
    </div>  <!-- page-content -->

    <div id="allowUser" class="modal fade" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title">{{ lang._('register_modal_allow') }}</h4>
                </div>
                <div class="modal-body">
                    <div class="scroller" id="delBody"  data-always-visible="1" data-rail-visible1="1">
                        <div class="row">
                            <h5>{{ lang._('register_msg_allow') }}</h5>
                        </div>  
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" id="okBtn" onclick="onSelAllow()">{{ lang._('btn_ok') }}</button>
                    <button type="button" id="cancelBtn" data-dismiss="modal">{{ lang._('btn_cancel') }}</button>                    
                </div>
            </div>
        </div>
    </div>

    <div id="cancelUser" class="modal fade" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title">{{ lang._('register_modal_cancel') }}</h4>
                </div>
                <div class="modal-body">
                    <div class="scroller" id="delBody"  data-always-visible="1" data-rail-visible1="1">
                        <div class="row">
                            <h5>{{ lang._('register_msg_cancel') }}</h5>
                        </div>  
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" id="okBtn" onclick="onSelCancel()">{{ lang._('btn_ok') }}</button>
                    <button type="button" id="cancelBtn" data-dismiss="modal">{{ lang._('btn_cancel') }}</button>                    
                </div>
            </div>
        </div>
    </div>
</div>
