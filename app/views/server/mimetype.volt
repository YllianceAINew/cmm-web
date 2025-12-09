{{ content() }}

<div class="page-content-wrapper">
    <!-- BEGIN CONTENT BODY -->
    <div class="page-content" >
        <div>            
            <div class="portlet-body">
                <div class="tab-content">
                    <div class="tab-pane fade active in" id="tab_1_1"> 
                    <h3>{{ lang._('menu_servermanager_mimetype') }}</h3>
                    <div class="div-view row">
                        <button id="accountAddNew" data-toggle="modal" href="#responsive">{{ lang._('account_tab_registernew') }}</button>
                        <button id="accountDelete" data-toggle="modal"  href="#deleteAll">{{ lang._('btn_delete') }}</button>       
                        <table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_1">
                            <thead>
                                <tr class="bg-info">
                                    <th width="1%" class="thNO"> <input type="checkbox" id="selectAllChk"> </th>
                                    <th width = "2%"> {{ lang._('no') }} </th>
                                    <th> {{ lang._('mimetype_type') }} </th>
                                    <th> {{ lang._('mimetype_desc') }} </th>
                                    <th> {{ lang._('mimetype_size') }} </th>
                                    <th> {{ lang._('mimetype_allow') }} </th>
                                    <th width = "3%"> {{ lang._('edit') }} </th>
                                    <th width = "3%"> {{ lang._('delete') }} </th>
                                </tr>
                            </thead>
                            <tbody>                                
                            {% for mimetype in mimetypes %}
                                <tr class="odd gradeX loop">
                                    <td align="center" class="hasCheckTD"> 
                                        <input type="checkbox" class="childChecks" value="{{mimetype.id}}"> 
                                    </td>
                                    <td> {{ loop.index }}</td>
                                    <td id="membername"> {{ mimetype.mimetype }} </td>
                                    <td> {{ mimetype.extension }} </td>
                                    <td> {{ mimetype.maxSize }}  </td>
                                    <td>
                                        {% if mimetype.allow == "N" %}
                                            {{ check_field("class" : 'allow_check', "value" : mimetype.id) }}
                                        {% else %}
                                            {{ check_field("class" : 'allow_check', "checked" : "checked", "value" : mimetype.id ) }}
                                        {% endif %}
                                    </td>
                                    <td class="text-center"><img class="changeBtn" src='/adminpage/pages/img/edit.gif' href="#responsive" data-toggle="modal" data-id={{mimetype.id}}></td>
                                    <td class = "text-center">
                                        <a><img class="deleteBtn" src='{{url('')}}/pages/img/delete.gif' href = "#delete" data-toggle="modal" value="{{mimetype.id}}"></a>
                                    </td>
                                </tr>
                            {% endfor %}
                            </tbody>
                        </table>    
                            
                        </div>
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
                    <h4 class="modal-title">{{ lang._('mimetype_del') }}</h4>
                </div>
                <div class="modal-body">
                    <div class="scroller" id="delBody"  data-always-visible="1" data-rail-visible1="1">
                        <div class="row">
                            <h5 data=''>{{ lang._('mimetype_type') }}{{ lang._('str_cancel') }}</h5>
                        </div>  
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" id="okBtn" onClick = "onDelete()">{{ lang._('btn_ok') }}</button>
                    <button type="button" id="cancelBtn" data-dismiss="modal">{{ lang._('btn_cancel') }}</button>                    
                </div>
            </div>
        </div>
    </div>

    <div id="deleteAll" class="modal fade" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title">{{ lang._('mimetype_del') }}</h4>
                </div>
                <div class="modal-body">
                    <div class="scroller" id="delBody"  data-always-visible="1" data-rail-visible1="1">
                        <div class="row">
                            <h5>{{ lang._('mimetype_message_del') }}</h5>
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

    <div id="responsive" class="modal fade" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title">{{ lang._('mimetype_type') }}</h4>
                </div>
                <div class="modal-body">
                    <div class="scroller" data-always-visible="1" data-rail-visible1="1">
                        <div class="row">
                            <h5>{{ lang._('account_modal_hint') }}</h4>
                            <div class="col-md-3" id="bodyText" align="right">
                                <label class="modal-label">{{ lang._('mimetype_type') }} :</label>
                                <label class="modal-label">{{ lang._('mimetype_desc') }} :</label>
                                <label class="modal-label">{{ lang._('mimetype_size') }} :</label>
                                <label class="modal-label">{{ lang._('mimetype_allow') }} :</label>
                            </div>
                            <div class="col-md-9">
                                <input id="id" type="hidden">
                                <input id="mimetype" type="text" class="col-md-12 form-control">
                                <input id="desc" type="text" class="col-md-12 form-control">
                                <input id="maxsize" type="text" class="col-md-12 form-control">
                                <input id="allow" type="checkbox" class="col-md-12 form-control">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" id="okBtn" onclick="submitMimeType()">{{ lang._('btn_ok') }}</button>
                    <button type="button" data-dismiss="modal" id="cancelBtn">{{ lang._('btn_cancel') }}</button>                   
                </div>
            </div>
        </div>
    </div>
</div>
