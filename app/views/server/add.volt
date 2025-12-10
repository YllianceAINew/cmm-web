<script>
  var baseUrl = "{{ url() }}";
</script>
{{ content() }}

<!-- Account Registration/Edit Card -->
<div class="card card-primary card-outline">
    <div class="card-header">
        <h3 class="card-title">
            <i class="fas fa-user-shield mr-1"></i>
            {% if id is 0 %} 
                {{ lang._('account_tab_registernew') }}
            {% else %} 
                {{ lang._('account_tab_editaccount') }} 
            {% endif %}
        </h3>
        <div class="card-tools">
            <button type="button" class="btn btn-tool" data-card-widget="collapse">
                <i class="fas fa-minus"></i>
            </button>
        </div>
    </div>
    <!-- /.card-header -->
    <div class="card-body">
        <!-- Info Message -->
        <div class="alert alert-info">
            <i class="icon fas fa-info-circle"></i>
            {% if id is 0 %}
                {{ lang._('account_registernew_comment') }}
            {% else %}
                {{ lang._('account_editaccount_comment') }}
            {% endif %}
        </div>

        <!-- Form -->
        <form id="form_sample_2" role="form">
            <input type="hidden" id="memId" value="{{ id }}">
            
            {{ flash.output() }}
            
            <div class="row">
                <div class="col-md-8">
                    <!-- Form Fields -->
                    {% for element in form %}
                        {% if is_a(element, 'Phalcon\Forms\Element\Hidden') %}
                            {{ element }}
                        {% else %}
                            <div class="form-group">
                                {{ element.label(["class":"form-label"]) }}
                                <div class="input-icon right">
                                    <i class="fa"></i>
                                    {{ element.render(['class': 'form-control']) }}
                                </div>
                            </div>
                        {% endif %}
                    {% endfor %}
                    
                    <!-- Access Control Section -->
                    <div class="form-group">
                        <label for="memberAcl[]" class="form-label">
                            {{ lang._('account_content_power') }} 
                            <span class="text-danger">*</span>
                        </label>
                        <div class="border rounded p-3 bg-light">
                            <div class="row">
                                {% for index,label in resources %}
                                    <div class="col-md-6 col-sm-6 mb-2 hasChecks">
                                        <div class="form-check">
                                            <?php if(isset($memberAcl) && $memberAcl[0] == "ALL"){ ?>
                                                <input type="checkbox" class="form-check-input" dataVal="{{ index }}" id="acl_{{ index }}" checked>
                                            <?php }else if(isset($memberAcl) && in_array($index,$memberAcl)){?>
                                                <input type="checkbox" class="form-check-input" dataVal="{{ index }}" id="acl_{{ index }}" checked>
                                            <?php }else{ ?>
                                                <input type="checkbox" class="form-check-input" dataVal="{{ index }}" id="acl_{{ index }}">
                                            <?php }?>
                                            <label class="form-check-label" for="acl_{{ index }}">
                                                {{ label }}
                                            </label>
                                        </div>
                                    </div>
                                {% endfor %}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <!-- /.card-body -->
    <div class="card-footer">
        <div class="row">
            <div class="col-md-12 text-right">
                <button onclick="updateUserInfo()" class="btn btn-primary">
                    <i class="fas fa-save mr-1"></i>
                    {% if id is 0 %}
                        {{ lang._('register') }} 
                    {% else %}
                        {{ lang._('update') }} 
                    {% endif %}
                </button>
                {{ link_to("server/index", lang._('btn_cancel'), "class": "btn btn-secondary ml-2") }}
            </div>
        </div>
    </div>
    <!-- /.card-footer -->
</div>
<!-- /.card -->
