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
                    <div class="tab-pane fade active in" id="tab_1_1"> 
                    <h3>{{ lang._('levelist') }}</h3>
                        <div class="row" pull-right>
                            <button id="insertLevel" data-toggle="modal" href = "#insertModal">{{ lang._('level_btn_add') }}</button>
                            <button id="removeLevel" data-toggle="modal" href = "#removeModal">{{ lang._('btn_delete') }} </button>
                        </div>
                        <div class="div-view table-responsive">
                            <table class="table table-striped table-bordered">
                            <thead>
                                <tr class="table-head">
                                    <th >
                                        <input type= "checkbox" id="selectAllChk"/>
                                    </th>
                                    <th >{{ lang._('level_thead_levelno') }}</th>
                                    <th >{{ lang._('level_thead_levelname') }}</th>
                                    <th >{{ lang._('level_thead_intro') }}</th>
                                    <th >{{ lang._('level_thead_stop') }}</th>
                                    <th >{{ lang._('edit') }}</th>
                                    <th >{{ lang._('delete') }}</th>
                                </tr>
                            </thead>
                            <tbody>
                                {% for level in levels %}
                                <tr class="odd gradeX">
                                    <td class="hasCheckTD">
                                        <input type= "checkbox" class="childChecks"  dataVal="{{level['level']}}"/>
                                        <label class="levelId" hidden>{{level['id']}}</label>
                                    </td>
                                    <td class="levelNums">{{level['level']}}</td>
                                    <td class="levelNames">{{level['levelName']}}</td>
                                    <td class="levelDescs">{{level['levelDescription']}}</td>
                                    <td> 
                                        {% if level['levelState'] == 0 %}
                                            <input type="checkbox" class="blockChecks" dataVal="{{ level['level'] }}" > 
                                        {% else %}
                                            <input type="checkbox" class="blockChecks" dataVal="{{ level['level']}}" checked> 
                                            <input type="hidden" class="hidden" value="{{level['level']}}"> 
                                        {% endif %}</td>
                                    <td class = "text-center"><a class="editLevel" data-toggle="modal" href = "#editModal"><img src='{{url("")}}/pages/img/edit.gif'></a></td>
                                    <td > <a class="deleteLevel"><img src="{{ url('') }}/pages/img/delete.gif" data-toggle="modal" href = "#delete"></a> </td>
                                </tr>
                                {% endfor %}
                            </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div> 
 <!-- page-content -->

    <div id="insertModal" class="modal fade" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title">{{ lang._('level_modal_add') }}</h4>
                </div>
                <div class="modal-body">
                    <div class="scroller" data-always-visible="1" data-rail-visible1="1">
                        <div class="row">
                            <h5>{{ lang._('level_modal_hint') }}</h5>
                            <div class="col-md-3" id="bodyText" align="right">
                                <p>{{ lang._('level_modal_levelno') }}</p>
                                <p>{{ lang._('level_modal_levelname') }}</p>
                                <p>{{ lang._('level_modal_intro') }}</p>
                            </div>
                            <div class="col-md-9">
                                <input id="levelNo" type="number" min="0" class="col-md-12 form-control">
                                <input id="levelName" type="text" class="col-md-12 form-control">
                                <textarea id="levelDesc" type="text" class="col-md-12 form-control"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" id="okBtn" onclick="onInsertLevel()">{{ lang._('btn_ok') }}</button>
                    <button type="button" id="cancelBtn" data-dismiss="modal" >{{ lang._('btn_cancel') }}</button>
                </div>
            </div>
        </div>
    </div>

    <div id="editModal" class="modal fade" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title">{{ lang._('level_modal_edit') }}</h4>
                </div>
                <div class="modal-body">
                    <div class="scroller" data-always-visible="1" data-rail-visible1="1">
                        <div class="row">
                            <h5>{{ lang._('level_modal_hint') }}</h5>
                            <div class="col-md-3" id="bodyText" align="right">
                                <p>{{ lang._('level_modal_levelno') }}</p>
                                <p>{{ lang._('level_modal_levelname') }}</p>
                                <p>{{ lang._('level_modal_intro') }}</p>
                            </div>
                            <div class="col-md-9">
                                <label id="levelNo" class="col-md-12 form-control" ></label>
                                <input id="levelName" type="text" class="col-md-12 form-control" >
                                <textarea id="levelDesc" type="text" class="col-md-12 form-control"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" data-dismiss="modal" id="okBtn" onclick="onEditLevel()">{{ lang._('btn_ok') }}</button>
                    <button type="button" data-dismiss="modal" id="cancelBtn" >{{ lang._('btn_cancel') }}</button>
                    
                </div>
            </div>
        </div>
    </div>

    <div id="delete" class="modal fade" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title">{{ lang._('level_modal_delete') }}</h4>
                </div>
                <div class="modal-body">
                    <div class="scroller" data-always-visible="1" data-rail-visible1="1">
                        <div class="row">
                            <label id="deleteLevelId" hidden></label>
                            <h5>{{ lang._('level') }}(<label id="deleteLevelName"></label>){{ lang._('str_cancel') }}</h5>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" data-dismiss="modal" id="okBtn" onClick="onDeleteLevel()">{{ lang._('btn_ok') }}</button>
                    <button type="button" data-dismiss="modal" id="cancelBtn" >{{ lang._('btn_cancel') }}</button>
                    
                </div>
            </div>
        </div>
    </div>

    <div id="removeModal" class="modal fade" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title">{{ lang._('level_modal_delete') }}</h4>
                </div>
                <div class="modal-body">
                    <div class="scroller" data-always-visible="1" data-rail-visible1="1">
                        <div class="row">
                            <h5></h5>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" data-dismiss="modal" id="okBtn" onclick="onRemoveLevel()">{{ lang._('btn_ok') }}</button>
                    <button type="button" data-dismiss="modal" id="cancelBtn" >{{ lang._('btn_cancel') }}</button>
                    
                </div>
            </div>
        </div>
    </div>

</div>