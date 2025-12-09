{{ content() }}
<!-- BEGIN CONTENT -->
<script type="text/javascript">
    var baseUrl = "{{ url() }}";
    var levelSet = {{lvSet | json_encode}};
</script>

<div class="page-content-wrapper">
    <!-- BEGIN CONTENT BODY -->
    <div class="page-content" >
        <div>                            <!-- class="portlet light bordered" -->
            <div class="portlet-body">
                <div class="tab-content">
                    <h3>{{ lang._('setlevel') }}</h3>
                    <div class="div-view table-responsive">
                        <button id="accountAdd"  data-toggle="modal" href = "#saveModal">{{ lang._('setlevel_save') }}</button><br>
                        <table class="table table-striped table-bordered" >
                        <thead>
                            <tr class="table-head">
                                <td id="theadid">{{ lang._('setlevel_level') }}</td>
                                {% for lv in lvSet %}
                                    <td class="calleeTD" id="theadid"> {{lv}} </td>
                                {% endfor %}
                            </tr>
                        </thead>
                        <tbody>
                            <input type="hidden" value='{{strArr}}' id="strArrs">
                            {% for lv in lvSet %}
                            <tr>
                                <td class="callerTD" id="theadid" callerData="{{lv}}">{{lv}}</td>
                                {% for lv in lvSet %}
                                    <td> <input type= "checkbox" class="tdCheck" dataVal="{{lv}}"/> </td>
                                {% endfor %}
                            </tr>
                            {% endfor %}

                        </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div> 
 <!-- page-content -->

    <div id="saveModal" class="modal fade" tabindex="-1" aria-hidden="true" style="margin-top:100px;">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title">{{ lang._('setlevel_modal_save') }}</h4>
                </div>
                <div class="modal-body">
                    <div class="scroller" id="delBody" data-always-visible="1" data-rail-visible1="1">
                        <div class="row">
                            <h5>{{ lang._('setlevel_msg_save') }}</h5>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" id="okBtn" data-dismiss="modal" onclick="onSaveLevel()">{{ lang._('btn_ok') }}</button>
                    <button type="button" id="cancelBtn" data-dismiss="modal" >{{ lang._('btn_cancel') }}</button>                    
                </div>
            </div>
        </div>
    </div>

</div>