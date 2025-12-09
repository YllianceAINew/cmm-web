<script type="text/javascript">
	var baseUrl = {{url('')}};
</script>
{{ content() }}
<div class="page-content-wrapper">
<div class="page-content">
	<div class="portlet-body">
	    <div class="tab-content">
	        <div class="tab-pane fade active in" id="tab_1_1"> 
				<h3> {{ lang._('setserver_title') }} </h3>

				<div class="row">
					<div class="col-sm-3"></div>
					<div class="col-sm-6 ">
						<div class="portlet box blue">
							<div class="portlet-title">
								<div class="caption">
									<i class="fa fa-clock-o"></i>{{ lang._('setserver_settime') }}
								</div>
								<div class="tools">
									<a href="javascript:;" class="collapse">
									</a>
								</div>
							</div>
							<div class="portlet-body portlet-notop">
								<div class="row">
									<div align="center" class="col-sm-8">
										<table align="center" class="netclass">
										<tbody>
											<tr>
												<td><input type="checkbox" id="selType">시간봉사기 :</td>
												<td><input type="text" id="setTimeServer" placeholder="10.76.5.31" class="form-control" value="{{ntpServerIP}}"></td>
											</tr>
											<tr>
												<td align="right" id="dev0"><p>날자 :</p></td>
												<td ><input type="text"  id="setDate" data-date-format="yyyy-mm-dd" class="form-control date-picker" value="{{date}}" ></td>
											</tr>
											<tr>
												<td id="dev0"><p>시간 :</p></td>
												<td><input type="text" class="form-control timepicker timepicker-24"  id="setTime" value="{{time}}"></td>
											</tr>
											
										</tbody>
										</table>
									</div>
									<div class="col-sm-4" align="center" style="margin-top: 20px">
										<button class="settingButton" id="setServerTime" onclick="onSetServerTime()">{{ lang._('setserver_set') }}</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-3"></div>
					<div class="col-sm-6">
						<div class="portlet box blue">
							<div class="portlet-title">
								<div class="caption">
									<i class="fa fa-share-alt"></i>{{ lang._('setserver_setlog') }}
								</div>
								<div class="tools">
									<a href="javascript:;" class="collapse">
									</a>
								</div>
							</div>
							<div class="portlet-body portlet-notop">
								<div class="row">
									<div class="col-sm-8" align="center">
										<table align="center" class="netclass">
										<tbody>
											<tr>
												<td id="dev1"><p>{{ lang._('setserver_textdate') }}</p></td>
												<td>
												<select id="textDate">
												<?php	
												for($i=0;$i<6;$i++)
													if($textTime == $selectType[$i])
														echo "<option value='".$selectType[$i]."' selected>".$selectType[$i]."</option>";
													else
														echo "<option value='".$selectType[$i]."'>".$selectType[$i]."</option>";
												?>
												</select>
												</td>
											</tr>
											<tr>
												<td align="right" id="dev1"><p>{{ lang._('setserver_calldate') }}</p></td>
												<td >
												<select id="callDate">
												<?php	
												for($i=0;$i<6;$i++)
													if($callTime == $selectType[$i])
														echo "<option value='".$selectType[$i]."' selected>".$selectType[$i]."</option>";
													else
														echo "<option value='".$selectType[$i]."'>".$selectType[$i]."</option>";
												?>
												</select>
												</td>
											</tr>
											<tr>
												<td align="right" id="dev1"><p>{{ lang._('setserver_logdate') }}</p></td>
												<td>
												<select id="logDate">
												<?php	
												for($i=0;$i<6;$i++)
													if($loginTime == $selectType[$i])
														echo "<option value='".$selectType[$i]."' selected>".$selectType[$i]."</option>";
													else
														echo "<option value='".$selectType[$i]."'>".$selectType[$i]."</option>";
												?>
												</select>
												</td>
											</tr>
											<tr>
												<td align="right" id="dev1"><p>{{ lang._('setserver_alarmdate') }}</p></td>
												<td>
												<select id="alarmDate">
												<?php	
												for($i=0;$i<6;$i++)
													if($alarmTime == $selectType[$i])
														echo "<option value='".$selectType[$i]."' selected>".$selectType[$i]."</option>";
													else
														echo "<option value='".$selectType[$i]."' >".$selectType[$i]."</option>";
												?>
												</select>
												</td>
											</tr>
										</tbody>
										</table>
									</div>
									<div class="col-sm-4" align="center" style="margin-top: 20px">
										<button class="settingButton" id="setServerIp" onclick="onSetLogTime()">{{ lang._('setserver_set') }}</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-sm-3"></div>
					<div class="col-sm-6 col-md-6">
						<div class="portlet box blue">
							<div class="portlet-title">
								<div class="caption">
									<i class="fa fa-power-off"></i>{{ lang._('setserver_setAllowAddr') }}
								</div>
								<div class="tools">
									<a href="javascript:;" class="collapse">
									</a>
								</div>
							</div>
							<div class="portlet-body portlet-notop">
								<div class="row">
								<div class="col-md-8">
									<div class=" table-scrollable">	
										<div class="dataTables_scroll" style="height:100px;">
											<table class="table table-bordered ">
											<thead>
												<th><input type="checkbox" id="selectAllChk"></th>
												<th>ip</th>
												<th>{{ lang._('edit') }}</th>	
											</thead>
											<tbody>
											{% for allowip in ipList %}
												<tr>
													<td class="hasCheckTD">
														<input type="checkbox" id="childChecks" checkVal="{{allowip['no']}}">											
													</td>
													<input type="hidden" class="allowNo" value="{{allowip['no']}}">	
													<td class="allowip">{{allowip['ip']}}</td>
													<td>
														<a href="#editIP" data-toggle="modal" class="editIP"><img src='{{url('')}}/pages/img/edit.gif'></a>
													</td>
												</tr>
											{% endfor %}
											</tbody>									
											</table>
										</div>
									</div>
								</div>
								<div align="center" class="col-md-4 col-sm-4" style="margin-top: 20px">
									<button class="settingButton" data-toggle="modal"  href="#addIP">{{ lang._('level_btn_add') }}</button> <br>
									<button class="settingButton" data-toggle="modal" id="ipDelete" href="#deleteIP">{{ lang._('btn_delete') }}</button>
								</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="row" hidden>
					<div class="col-sm-3"></div>
					<div class="col-sm-6 ">
						<div class="portlet box blue">
							<div class="portlet-title">
								<div class="caption">
									<i class="fa fa-database"></i>{{ lang._('setserver_database') }}
								</div>
								<div class="tools">
									<a href="javascript:;" class="collapse">
									</a>
								</div>
							</div>
							<div class="portlet-body portlet-notop">
								<div class="row">
									<div align="center" class="col-md-6 col-sm-6">
										<button class="settingButton" id="setServerTime" onclick="">{{ lang._('setserver_database_backup') }}</button>
									</div>
									<div align="center" class="col-md-6 col-sm-6">
										<button class="settingButton" id="setServerTime" onclick="">{{ lang._('setserver_database_format') }}</button>
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
<!-- page-content -->
	<div id="addIP" class="modal fade" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog" style="width:220px">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title">{{ lang._('addIP') }}</h4>
                </div>
                <div class="modal-body">
                    <div class="scroller" id="delBody"  data-always-visible="1" data-rail-visible1="1">
                        <div class="row">
                        	<div class="col-md-1"></div>
                            <div class="col-md-10">
                            	<input type="text" class="form-control" id="input_ipv4">
                        	</div>
                        </div>  
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" id="okBtn" onclick="onAddAddr()">{{ lang._('btn_ok') }}</button>
                    <button type="button" id="cancelBtn" data-dismiss="modal">{{ lang._('btn_cancel') }}</button>                  
                </div>
            </div>
        </div>
    </div>

    <div id="editIP" class="modal fade" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog" style="width:220px">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title">{{ lang._('addIP') }}</h4>
                </div>
                <div class="modal-body">
                    <div class="scroller" id="delBody"  data-always-visible="1" data-rail-visible1="1">
                        <div class="row">
                        	<div class="col-md-1"></div>
                            <div class="col-md-10">
                            	<input type="text" class="form-control" id="input">       
                            	<input type="hidden" id="allowNo">      
                        	</div>
                        </div>  
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" id="okBtn" onclick="onEditAddr()">{{ lang._('btn_ok') }}</button>
                    <button type="button" id="cancelBtn" data-dismiss="modal">{{ lang._('btn_cancel') }}</button>                  
                </div>
            </div>
        </div>
    </div>

    <div id="deleteIP" class="modal fade" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title">{{ lang._('addIP') }}</h4>
                </div>
                <div class="modal-body">
                    <div class="scroller" id="delBody"  data-always-visible="1" data-rail-visible1="1">
                        <div class="row">
                        	<h5>선택한 IP주소들을 삭제하겠습니까?</h5>
                        </div>  
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" id="okBtn" onclick="onDeleteAddr()">{{ lang._('btn_ok') }}</button>
                    <button type="button" id="cancelBtn" data-dismiss="modal">{{ lang._('btn_cancel') }}</button>                  
                </div>
            </div>
        </div>
    </div>
</div>
