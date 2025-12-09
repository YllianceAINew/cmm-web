{{ content() }}
<style type="text/css">
	select {
	    width: 85%;
	    height: 34px;
	    padding: 6px 12px;
	    font-size: 14px;
	    line-height: 1.42857143;
	    color: #555;
	    background-color: #fff;
	    background-image: none;
	    border: 1px solid #ccc;
	}

	#restartButton , #servicerestartButton, #stopButton{
	    background: url(/adminpage/login/btn_noicon.png) no-repeat;
	    height: 26px;
	    width: 112px;
	    border-style: none;
	    float: left;
	    margin-left: 10px;
	    color: #6b8db1;
	    cursor: hand;
	    padding: 0 0 3 0;
	}

	#settingButton{
		background: url(/adminpage/login/dialog_btn.png) no-repeat;
	    width: 76px;
	    height: 27px;
	    color: #306494;
	    text-align: center;
	    margin-right: 20px;
	    margin-left: 10px;
	    border: none;
	    padding: 0 0 2 0;
	    cursor: hand;
	    margin-left: 89%;
    	margin-top: 20px;
	}

	.portlet.box.blue > .portlet-title {
		background-color: #3598dc;
    	background: #4e95d2;
    	background-image: url('/adminpage/login/title_gradient.png');
    	border: 1px solid #5c99cc;
    	height: 40px;
	}
</style>
<div class="page-content-wrapper">
<div class="page-content">
	<div class="portlet-body">
	    <div class="tab-content">
	        <div class="tab-pane fade active in" id="tab_1_1"> 
				<h3 style="font-family: PRK P ChonRiMa; ">{{ lang._('setserver_title') }}</h3>

				<div class="row">
					<div class="col-sm-2"></div>
					<div class="col-sm-8">
						<div class="portlet box blue" style="margin-top:15px;">
							<div class="portlet-title">
								<div class="caption">
									<i class="fa fa-clock-o"></i>{{ lang._('setserver_settime') }}
								</div>
								<div class="tools">
									<a href="javascript:;" class="collapse">
									</a>
									<a href="javascript:;" class="reload">
									</a>
								</div>
							</div>
							<div class="portlet-body" style="margin-top:0;">
								<div class="row" style="margin-top:10px;">
									<div class="col-sm-2">
										<select class="" style="">
											<?php
												for ($year = 2013; $year <= 2030; $year ++) {
													echo '<option value="'.$year.'">'.$year.'</option>';
												}
											?>
										</select>
										<span>{{ lang._('setserver_year') }}</span>
									</div>
									<div class="col-sm-2">
										<select class="" style="">
											<?php
												for ($year = 1; $year <= 12; $year ++) {
													echo '<option value="'.$year.'">'.$year.'</option>';
												}
											?>
										</select>
		   								<span>{{ lang._('setserver_month') }}</span>
									</div>
									<div class="col-sm-2">
										<select class="" style="">
											<?php
												for ($year = 1; $year <= 31; $year ++) {
													echo '<option value="'.$year.'">'.$year.'</option>';
												}
											?>
										</select>
		   								<span>{{ lang._('setserver_day') }}</span>
									</div>
									<div class="col-sm-2">
										<select class="" style="">
											<?php
												for ($year = 0; $year <= 24; $year ++) {
													echo '<option value="'.$year.'">'.$year.'</option>';
												}
											?>
										</select>
		   								<span>{{ lang._('setserver_hour') }}</span>
									</div>
									<div class="col-sm-2">
										<select class="" style="">
											<?php
												for ($year = 0; $year <= 60; $year ++) {
													echo '<option value="'.$year.'">'.$year.'</option>';
												}
											?>
										</select>
		   								<span>{{ lang._('setserver_minite') }}</span>
									</div>
									<div class="col-sm-2">
										<select class="" style="">
											<?php
												for ($year = 0; $year <= 60; $year ++) {
													echo '<option value="'.$year.'">'.$year.'</option>';
												}
											?>
										</select>
		   								<span>{{ lang._('setserver_second') }}</span>
									</div>
								</div>
								<button id="settingButton">{{ lang._('setserver_set') }}</button>

							</div>
						</div>
					</div>
					<div class="col-sm-2"></div>

			</div>

			<div class="row">
					<div class="col-sm-2"></div>
					<div class="col-sm-8">
						<div class="portlet box blue" style="margin-top:15px;">
							<div class="portlet-title">
								<div class="caption">
									<i class="fa fa-share-alt"></i>{{ lang._('setserver_setnet') }}
								</div>
								<div class="tools">
									<a href="javascript:;" class="collapse">
									</a>
									<a href="javascript:;" class="reload">
									</a>
								</div>
							</div>
							<div class="portlet-body" style="margin-top:0;">
								<div class="row">
									<div class="col-sm-2"></div>
									<div class="col-sm-8">
										<table align="center" class="netclass">
										<tbody>
											<tr>
												<td align="right"><span id="dev0"><p style="margin-bottom:15px;">IP:</p></td>
												<td ><input type="text" class="form-control" name="ip0" id="ip0" value="AUTO" style="margin-left:15px;margin-bottom:15px;"></td>
												<td><input type="hidden" name="oldgw0" id="oldgw0" value=""></td>
											</tr>
											<tr>
												<td><p style="margin-bottom:15px;">Netmask: </p></td>
												<td><input type="text" class="form-control" name="nm0" id="nm0" value="AUTO" style="margin-left:15px;margin-bottom:15px;"></td>
												<td><input type="hidden" name="oldip0" id="oldip0" value="AUTO"></td>
											</tr>
											<tr>
												<td><p style="margin-bottom:15px;">Gateway: </p></td>
												<td><input type="text" class="form-control" name="gw0" id="gw0" value="" style="margin-left:15px;margin-bottom:15px;"></td>
												<td><input type="hidden" name="oldnm0" id="oldnm0" value="AUTO"></td>
											</tr>
										</tbody>
										</table>
									</div>
									<div class="col-sm-2"></div>
								</div>
								<button id="settingButton">{{ lang._('setserver_change') }}</button>
							</div>
						</div>
					</div>
					<div class="col-sm-2"></div>

			</div>


			<div class="row">
					<div class="col-sm-2"></div>
					<div class="col-sm-8">
						<div class="portlet box blue" style="margin-top:15px;">
							<div class="portlet-title">
								<div class="caption">
									<i class="fa fa-power-off"></i>{{ lang._('setserver_setrestart') }}
								</div>
								<div class="tools">
									<a href="javascript:;" class="collapse">
									</a>
									<a href="javascript:;" class="reload">
									</a>
								</div>
							</div>
							<div class="portlet-body" style="margin-top:0;">
								<div class="row">
									<div class="col-sm-2"></div>
									<div class="col-sm-8">
										<button id="restartButton" style="margin-left: 10%;">{{ lang._('setserver_reserver') }}</button>
										<button id="stopButton">{{ lang._('setserver_stopserver') }}</button>
										<button id="servicerestartButton">{{ lang._('setserver_resystem') }}</button>
									</div>
									<div class="col-sm-2"></div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-sm-2"></div>

			</div>
		</div>
	</div>
</div>
</div>
