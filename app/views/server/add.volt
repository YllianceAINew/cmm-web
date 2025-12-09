<script>
  var baseUrl = "{{ url() }}";
</script>
{{ content() }}
<div class="page-content-wrapper">
    <!-- BEGIN CONTENT BODY -->
    <div class="page-content" >
        <div>                            <!-- class="portlet light bordered" -->
            <div class="portlet-body">
                <div class="tab-content">
                    <div class="tab-pane fade active in" id="tab_1_1"> 
                    <h3>
                        {% if id is 0 %} {{ lang._('account_tab_registernew') }}
                        {% else %} {{ lang._('account_tab_editaccount') }} {% endif %}</h3>  
                        <div class="div-view table-responsive">
                            {% if id is 0 %}
                                <span> {{ lang._('account_registernew_comment') }} </span>
                            {% else %}
                                <span> {{ lang._('account_editaccount_comment') }} </span>
                            {% endif %}
                            <p>    
                            <div class="panel panel-info">
                                <div class="panel-heading">
                                    {% if id is 0 %}
                                        <b> {{ lang._('account_registernew_formhead') }} </b>
                                    {% else %}
                                        <b> {{ lang._('account_editaccount_formhead') }} </b>
                                    {% endif %}
                                </div>
                                <div class="panel-body table-responsive form-horizontal">          
                                    <input type="hidden" id="memId" value="{{ id }}">
                                    <div class="form-body">
                                        {{ flash.output() }}
                                        {% for element in form %}
                                            {% if is_a(element, 'Phalcon\Forms\Element\Hidden') %}
                                                {{ element }}
                                            {% else %}
                                                <div class="form-group">
                                                    {{ element.label(["class":"control-label col-md-3"]) }}
                                                    <div class="col-md-4">
                                                        <div class="input-icon right">
                                                            <i class='fa'></i>
                                                            {{ element.render(['class': 'form-control']) }}
                                                        </div>
                                                        
                                                    </div>
                                                </div>
                                            {% endif %}
                                        {% endfor %}
                                        <div class="form-group">
                                            <label for="memberAcl[]" class="control-label col-md-3"> {{ lang._('account_content_power') }} <span class="required" aria-required="true">*</span></label>
                                            <div class="col-md-4" style="border:1px solid #ddd; margin-left: 15px; width: 319px;">
                                                <div class="input-icon right" >
                                                    <i class="fa"></i>
                                                {% for index,label in resources %}
                                                    <div class="hasChecks col-md-6 col-sm-6">
                                                    <?php if($memberAcl[0] == "ALL"){ ?>
                                                        <input type="checkbox" dataVal="{{ index }}" checked>    
                                                    <?php }else if(in_array($index,$memberAcl)){?>
                                                        <input type="checkbox" dataVal="{{ index }}" checked>
                                                    <?php }else{ ?>
                                                        <input type="checkbox" dataVal="{{ index }}">    
                                                    <?php }?>
                                                        <label>{{ label }}</label>
                                                    </div>
                                                {% endfor %}
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-actions">
                                        <div class="row">
                                            <div class="col-md-offset-3 col-md-9">
                                                <button onclick="updateUserInfo()" class="btn btn-default" style = "width:80px;">
                                                    {% if id is 0 %}
                                                        {{ lang._('register') }} 
                                                    {% else %}
                                                         {{ lang._('update') }} 
                                                    {% endif %}
                                                </button>
                                                {{ link_to("server/index", lang._('btn_cancel') ,"class":"btn btn-default","style":"width:80px;") }}
                                            </div>
                                        </div>
                                    </div> 
                                </div>
                            </div>   
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>  <!-- page-content -->
</div>