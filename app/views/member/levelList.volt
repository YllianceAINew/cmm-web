{{ content() }}
<script type="text/javascript">
    var baseUrl = "{{ url() }}";
</script>

<!-- Level List Card -->
<div class="card">
    <div class="card-header">
        <h3 class="card-title">
            <i class="fas fa-layer-group mr-1"></i>
            {{ lang._('levelist') }}
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
                <button id="insertLevel" class="btn btn-primary btn-sm" data-toggle="modal" href="#insertModal">
                    <i class="fas fa-plus mr-1"></i>
                    {{ lang._('level_btn_add') }}
                </button>
                <button id="removeLevel" class="btn btn-danger btn-sm" data-toggle="modal" href="#removeModal">
                    <i class="fas fa-trash mr-1"></i>
                    {{ lang._('btn_delete') }}
                </button>
            </div>
        </div>
        <div class="table-responsive">
            <table class="table table-bordered table-striped table-hover">
                <thead>
                    <tr>
                        <th style="width: 40px;">
                            <input type="checkbox" id="selectAllChk"/>
                        </th>
                        <th>{{ lang._('level_thead_levelno') }}</th>
                        <th>{{ lang._('level_thead_levelname') }}</th>
                        <th>{{ lang._('level_thead_intro') }}</th>
                        <th style="width: 100px;">{{ lang._('level_thead_stop') }}</th>
                        <th style="width: 80px;" class="text-center">{{ lang._('edit') }}</th>
                        <th style="width: 80px;" class="text-center">{{ lang._('delete') }}</th>
                    </tr>
                </thead>
                <tbody>
                    {% for level in levels %}
                    <tr>
                        <td class="hasCheckTD">
                            <input type="checkbox" class="childChecks" dataVal="{{level['level']}}"/>
                            <label class="levelId" hidden>{{level['id']}}</label>
                        </td>
                        <td class="levelNums">{{level['level']}}</td>
                        <td class="levelNames">{{level['levelName']}}</td>
                        <td class="levelDescs">{{level['levelDescription']}}</td>
                        <td class="text-center">
                            {% if level['levelState'] == 0 %}
                                <input type="checkbox" class="blockChecks" dataVal="{{ level['level'] }}">
                            {% else %}
                                <input type="checkbox" class="blockChecks" dataVal="{{ level['level']}}" checked>
                                <input type="hidden" class="hidden" value="{{level['level']}}">
                            {% endif %}
                        </td>
                        <td class="text-center">
                            <a class="editLevel btn btn-sm btn-warning" data-toggle="modal" href="#editModal" title="{{ lang._('edit') }}">
                                <i class="fas fa-edit"></i>
                            </a>
                        </td>
                        <td class="text-center">
                            <a class="deleteLevel btn btn-sm btn-danger" data-toggle="modal" href="#delete" title="{{ lang._('delete') }}">
                                <i class="fas fa-trash"></i>
                            </a>
                        </td>
                    </tr>
                    {% endfor %}
                </tbody>
            </table>
        </div>
    </div>
    <!-- /.card-body -->
</div>
<!-- /.card -->

<!-- Insert Level Modal -->
<div id="insertModal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">
                    <i class="fas fa-plus mr-1"></i>
                    {{ lang._('level_modal_add') }}
                </h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="alert alert-info">
                    <i class="icon fas fa-info"></i>
                    {{ lang._('level_modal_hint') }}
                </div>
                <div class="form-group">
                    <label for="insertLevelNo">{{ lang._('level_modal_levelno') }}</label>
                    <input id="levelNo" type="number" min="0" class="form-control" placeholder="{{ lang._('level_modal_levelno') }}">
                </div>
                <div class="form-group">
                    <label for="insertLevelName">{{ lang._('level_modal_levelname') }}</label>
                    <input id="levelName" type="text" class="form-control" placeholder="{{ lang._('level_modal_levelname') }}">
                </div>
                <div class="form-group">
                    <label for="insertLevelDesc">{{ lang._('level_modal_intro') }}</label>
                    <textarea id="levelDesc" class="form-control" rows="3" placeholder="{{ lang._('level_modal_intro') }}"></textarea>
                </div>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <i class="fas fa-times mr-1"></i>
                    {{ lang._('btn_cancel') }}
                </button>
                <button type="submit" id="okBtn" class="btn btn-primary" onclick="onInsertLevel()">
                    <i class="fas fa-check mr-1"></i>
                    {{ lang._('btn_ok') }}
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Edit Level Modal -->
<div id="editModal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">
                    <i class="fas fa-edit mr-1"></i>
                    {{ lang._('level_modal_edit') }}
                </h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="alert alert-info">
                    <i class="icon fas fa-info"></i>
                    {{ lang._('level_modal_hint') }}
                </div>
                <div class="form-group">
                    <label for="editLevelNo">{{ lang._('level_modal_levelno') }}</label>
                    <input id="levelNo" type="text" class="form-control" readonly style="background-color: #e9ecef;">
                </div>
                <div class="form-group">
                    <label for="editLevelName">{{ lang._('level_modal_levelname') }}</label>
                    <input id="levelName" type="text" class="form-control" placeholder="{{ lang._('level_modal_levelname') }}">
                </div>
                <div class="form-group">
                    <label for="editLevelDesc">{{ lang._('level_modal_intro') }}</label>
                    <textarea id="levelDesc" class="form-control" rows="3" placeholder="{{ lang._('level_modal_intro') }}"></textarea>
                </div>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <i class="fas fa-times mr-1"></i>
                    {{ lang._('btn_cancel') }}
                </button>
                <button type="submit" id="okBtn" class="btn btn-primary" onclick="onEditLevel()">
                    <i class="fas fa-check mr-1"></i>
                    {{ lang._('btn_ok') }}
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Delete Level Modal -->
<div id="delete" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">
                    <i class="fas fa-exclamation-triangle mr-1"></i>
                    {{ lang._('level_modal_delete') }}
                </h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <label id="deleteLevelId" hidden></label>
                <div class="alert alert-warning">
                    <i class="icon fas fa-exclamation-triangle"></i>
                    {{ lang._('level') }} (<strong id="deleteLevelName"></strong>) {{ lang._('str_cancel') }}
                </div>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <i class="fas fa-times mr-1"></i>
                    {{ lang._('btn_cancel') }}
                </button>
                <button type="submit" id="okBtn" class="btn btn-danger" onClick="onDeleteLevel()">
                    <i class="fas fa-trash mr-1"></i>
                    {{ lang._('btn_ok') }}
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Remove Selected Levels Modal -->
<div id="removeModal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">
                    <i class="fas fa-exclamation-triangle mr-1"></i>
                    {{ lang._('level_modal_delete') }}
                </h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="alert alert-warning">
                    <i class="icon fas fa-exclamation-triangle"></i>
                    <span id="removeModalMessage"></span>
                </div>
            </div>
            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <i class="fas fa-times mr-1"></i>
                    {{ lang._('btn_cancel') }}
                </button>
                <button type="submit" id="okBtn" class="btn btn-danger" onclick="onRemoveLevel()">
                    <i class="fas fa-trash mr-1"></i>
                    {{ lang._('btn_ok') }}
                </button>
            </div>
        </div>
    </div>
</div>
