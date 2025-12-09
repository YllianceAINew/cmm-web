{{ content() }}
<script type="text/javascript">
    var baseUrl = "{{ url() }}";
</script>

<!-- BEGIN CONTENT -->
<div class="page-content-wrapper">
    <!-- BEGIN CONTENT BODY -->
    <div class="page-content" >
        <div>                            <!-- class="portlet light bordered" -->
            <div class="portlet-body">
                <div class="tab-content">
                    <h3>{{ lang._('detail_title') }}</h3>
                    <div class="div-view table-responsive">
                        <div class="tab-content">                               
                            <div class="row">
                                <button id="return" onclick="onBackBtn()">{{ lang._('detail_return') }}</button>
                            </div>                            
                            <div class="regInfo row">
                                <div class="col-md-4 col-sm-4 left-pane">
                                    <label>{{ lang._('name') }} :</label><br>
                                    <label>{{ lang._('account_modal_id') }}</label><br>
                                    <!-- <label>{{ lang._('detail_gender') }}</label><br>
                                    <label>{{ lang._('detail_birth') }} </label><br>
                                    <label>{{ lang._('detail_address') }}</label><br>
                                    <label>{{ lang._('detail_factory') }} </label><br> -->
                                    <label>{{ lang._('detail_citynum') }} </label><br>
                                    <!-- <label>{{ lang._('detail_region') }} </label><br>
                                    <label>{{ lang._('detail_type') }} </label><br> -->
                                    <label>{{ lang._('detail_phone') }} </label><br>
                                    <label>{{ lang._('detail_imsi') }} </label><br>
                                    <label>{{ lang._('detail_imei') }} </label><br>
                                    <label>{{ lang._('detail_group') }}</label>
                                </div>
                                <div class="col-md-6 col-sm-6 right-pane">
                                    <label>{{user.name}}</label><br>
                                    <label id="userid">{% if user.userid != '' %}{{user.userid}}{% else %}<span style="font-style:italic;color:#aaa">{{ lang._('detail_undefined') }}</span>{% endif %}</label><br>
                                    <!-- <label>{% if user.gender == 0 %}{{ lang._('register_boy') }}{% else %}{{ lang._('register_girl') }}{% endif %}</label><br>
                                    <label>{% if user.birthday != '' %}{{user.birthday}}{% else %}<span style="font-style:italic;color:#aaa">{{ lang._('detail_undefined') }}</span>{% endif %}</label><br>
                                    <label>{% if user.address != '' %}{{user.address}}{% else %}<span style="font-style:italic;color:#aaa">{{ lang._('detail_undefined') }}</span>{% endif %}</label><br>
                                    <label>{% if user.job != '' %}{{user.job}}{% else %}<span style="font-style:italic;color:#aaa">{{ lang._('detail_undefined') }}</span>{% endif %}</label><br> -->
                                    <label>{% if user.citizenNum != '' %}{{user.citizenNum}}{% else %}<span style="font-style:italic;color:#aaa">{{ lang._('detail_undefined') }}</span>{% endif %}</label><br>
                                    <!-- <label>{% if user.region != '' %}{{user.region}}{% else %}<span style="font-style:italic;color:#aaa">{{ lang._('detail_undefined') }}</span>{% endif %}</label><br>
                                    <label>{% if user.phoneType != '' %}{{user.phoneType}}{% else %}<span style="font-style:italic;color:#aaa">{{ lang._('detail_undefined') }}</span>{% endif %}</label><br> -->
                                    <label>{{user.phone}}&nbsp</label><br>
                                    <label>{{user.imsi}}&nbsp</label><br>
                                    <label>{{user.imei}}&nbsp</label><br>
                                    <label>
                                    {% if user.username != 'admin' %}
                                        <select class="bs-select">
                                            {% for level in lvSet %}
                                            <?php
                                                echo '<option id="'.$level.'" value="'.$level.'">'.$level.'</option>';
                                            ?>
                                            {% endfor %}
                                        </select>
                                    {% endif %}</label>
                                </div>
                            </div>
                            <div class="row regBtns">
                                <button id="regCancel">{{ lang._('register_btn_cancel') }}</button>
                                <button id="regAllow">{{ lang._('register_btn_allow') }}</button><br>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div> 
 <!-- page-content -->
</div>