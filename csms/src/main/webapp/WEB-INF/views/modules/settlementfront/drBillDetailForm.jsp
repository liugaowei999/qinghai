<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>省内地市结算详单管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/settlementfront/drBillDetail/">省内地市结算详单列表</a></li>
		<li class="active"><a href="${ctx}/settlementfront/drBillDetail/form?id=${drBillDetail.id}">省内地市结算详单<shiro:hasPermission name="settlementfront:drBillDetail:edit">${not empty drBillDetail.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="settlementfront:drBillDetail:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="drBillDetail" action="${ctx}/settlementfront/drBillDetail/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">dr_type：</label>
			<div class="controls">
				<form:input path="drType" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">file_type：</label>
			<div class="controls">
				<form:input path="fileType" htmlEscape="false" maxlength="5" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">send_org_code：</label>
			<div class="controls">
				<form:input path="sendOrgCode" htmlEscape="false" maxlength="11" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">send_date：</label>
			<div class="controls">
				<form:input path="sendDate" htmlEscape="false" maxlength="8" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">sett_date：</label>
			<div class="controls">
				<form:input path="settDate" htmlEscape="false" maxlength="8" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">file_name：</label>
			<div class="controls">
				<form:input path="fileName" htmlEscape="false" maxlength="128" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">trade_code：</label>
			<div class="controls">
				<form:input path="tradeCode" htmlEscape="false" maxlength="3" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">block_mark：</label>
			<div class="controls">
				<form:input path="blockMark" htmlEscape="false" maxlength="4" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">main_account_id：</label>
			<div class="controls">
				<form:input path="mainAccountId" htmlEscape="false" maxlength="19" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">trade_charge：</label>
			<div class="controls">
				<form:input path="tradeCharge" htmlEscape="false" maxlength="12" class="input-xlarge  digits"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">currency_code：</label>
			<div class="controls">
				<form:input path="currencyCode" htmlEscape="false" maxlength="3" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">trans_time：</label>
			<div class="controls">
				<form:input path="transTime" htmlEscape="false" maxlength="10" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">trace_no：</label>
			<div class="controls">
				<form:input path="traceNo" htmlEscape="false" maxlength="6" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">response_code：</label>
			<div class="controls">
				<form:input path="responseCode" htmlEscape="false" maxlength="6" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">grant_date：</label>
			<div class="controls">
				<form:input path="grantDate" htmlEscape="false" maxlength="4" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">retriev_no：</label>
			<div class="controls">
				<form:input path="retrievNo" htmlEscape="false" maxlength="12" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">recv_org_id：</label>
			<div class="controls">
				<form:input path="recvOrgId" htmlEscape="false" maxlength="11" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">send_org_id：</label>
			<div class="controls">
				<form:input path="sendOrgId" htmlEscape="false" maxlength="11" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">seller_type：</label>
			<div class="controls">
				<form:input path="sellerType" htmlEscape="false" maxlength="4" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">terminal_id：</label>
			<div class="controls">
				<form:input path="terminalId" htmlEscape="false" maxlength="8" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">acquirer_id：</label>
			<div class="controls">
				<form:input path="acquirerId" htmlEscape="false" maxlength="15" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">acquirer_addr：</label>
			<div class="controls">
				<form:input path="acquirerAddr" htmlEscape="false" maxlength="40" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">ori_trade_info：</label>
			<div class="controls">
				<form:input path="oriTradeInfo" htmlEscape="false" maxlength="23" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">message_code：</label>
			<div class="controls">
				<form:input path="messageCode" htmlEscape="false" maxlength="4" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">info_code：</label>
			<div class="controls">
				<form:input path="infoCode" htmlEscape="false" maxlength="1" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">sett_org_no：</label>
			<div class="controls">
				<form:input path="settOrgNo" htmlEscape="false" maxlength="9" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">bill_org_code：</label>
			<div class="controls">
				<form:input path="billOrgCode" htmlEscape="false" maxlength="11" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">issue_org_code：</label>
			<div class="controls">
				<form:input path="issueOrgCode" htmlEscape="false" maxlength="11" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">sett_notice：</label>
			<div class="controls">
				<form:input path="settNotice" htmlEscape="false" maxlength="1" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">trade_channel：</label>
			<div class="controls">
				<form:input path="tradeChannel" htmlEscape="false" maxlength="2" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">trade_sign：</label>
			<div class="controls">
				<form:input path="tradeSign" htmlEscape="false" maxlength="1" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">settle_stand：</label>
			<div class="controls">
				<form:input path="settleStand" htmlEscape="false" maxlength="8" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">condition_code：</label>
			<div class="controls">
				<form:input path="conditionCode" htmlEscape="false" maxlength="2" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">own_charge：</label>
			<div class="controls">
				<form:input path="ownCharge" htmlEscape="false" maxlength="12" class="input-xlarge  digits"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">trade_area_id：</label>
			<div class="controls">
				<form:input path="tradeAreaId" htmlEscape="false" maxlength="1" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">etc_flag：</label>
			<div class="controls">
				<form:input path="etcFlag" htmlEscape="false" maxlength="2" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">special_charge_id：</label>
			<div class="controls">
				<form:input path="specialChargeId" htmlEscape="false" maxlength="2" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">special_charge_level：</label>
			<div class="controls">
				<form:input path="specialChargeLevel" htmlEscape="false" maxlength="1" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">trade_mode：</label>
			<div class="controls">
				<form:input path="tradeMode" htmlEscape="false" maxlength="1" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">card_no：</label>
			<div class="controls">
				<form:input path="cardNo" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">trade_charge1：</label>
			<div class="controls">
				<form:input path="tradeCharge1" htmlEscape="false" maxlength="8" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">trade_type：</label>
			<div class="controls">
				<form:input path="tradeType" htmlEscape="false" maxlength="2" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">terminal_num：</label>
			<div class="controls">
				<form:input path="terminalNum" htmlEscape="false" maxlength="12" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">terminal_trade_no：</label>
			<div class="controls">
				<form:input path="terminalTradeNo" htmlEscape="false" maxlength="8" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">trade_date：</label>
			<div class="controls">
				<form:input path="tradeDate" htmlEscape="false" maxlength="8" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">trade_time：</label>
			<div class="controls">
				<form:input path="tradeTime" htmlEscape="false" maxlength="6" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">tac_code：</label>
			<div class="controls">
				<form:input path="tacCode" htmlEscape="false" maxlength="8" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">key_version：</label>
			<div class="controls">
				<form:input path="keyVersion" htmlEscape="false" maxlength="2" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">key_index：</label>
			<div class="controls">
				<form:input path="keyIndex" htmlEscape="false" maxlength="2" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">offline_trade_no：</label>
			<div class="controls">
				<form:input path="offlineTradeNo" htmlEscape="false" maxlength="6" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">trade_balance：</label>
			<div class="controls">
				<form:input path="tradeBalance" htmlEscape="false" maxlength="8" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">issue_org_id：</label>
			<div class="controls">
				<form:input path="issueOrgId" htmlEscape="false" maxlength="16" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">random_num：</label>
			<div class="controls">
				<form:input path="randomNum" htmlEscape="false" maxlength="8" class="input-xlarge  digits"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">cardholder_name：</label>
			<div class="controls">
				<form:input path="cardholderName" htmlEscape="false" maxlength="40" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">certificates_type：</label>
			<div class="controls">
				<form:input path="certificatesType" htmlEscape="false" maxlength="2" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">certificates_num：</label>
			<div class="controls">
				<form:input path="certificatesNum" htmlEscape="false" maxlength="30" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">cardholder_type：</label>
			<div class="controls">
				<form:input path="cardholderType" htmlEscape="false" maxlength="4" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">recv_org_code：</label>
			<div class="controls">
				<form:input path="recvOrgCode" htmlEscape="false" maxlength="11" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">recv_org_no：</label>
			<div class="controls">
				<form:input path="recvOrgNo" htmlEscape="false" maxlength="12" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">recv_date：</label>
			<div class="controls">
				<form:input path="recvDate" htmlEscape="false" maxlength="8" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">sett_org_no1：</label>
			<div class="controls">
				<form:input path="settOrgNo1" htmlEscape="false" maxlength="12" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">discount_type：</label>
			<div class="controls">
				<form:input path="discountType" htmlEscape="false" maxlength="4" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">beforetrade_charge：</label>
			<div class="controls">
				<form:input path="beforetradeCharge" htmlEscape="false" maxlength="8" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">receivable_charge：</label>
			<div class="controls">
				<form:input path="receivableCharge" htmlEscape="false" maxlength="8" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">trade_state：</label>
			<div class="controls">
				<form:input path="tradeState" htmlEscape="false" maxlength="2" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">algorithm_flag：</label>
			<div class="controls">
				<form:input path="algorithmFlag" htmlEscape="false" maxlength="2" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">card_org_id：</label>
			<div class="controls">
				<form:input path="cardOrgId" htmlEscape="false" maxlength="3" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">tlv_data：</label>
			<div class="controls">
				<form:input path="tlvData" htmlEscape="false" maxlength="256" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">actual_issue_org_code：</label>
			<div class="controls">
				<form:input path="actualIssueOrgCode" htmlEscape="false" maxlength="16" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">roam_type：</label>
			<div class="controls">
				<form:input path="roamType" htmlEscape="false" maxlength="3" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">rate_id：</label>
			<div class="controls">
				<form:input path="rateId" htmlEscape="false" maxlength="6" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">service_fee：</label>
			<div class="controls">
				<form:input path="serviceFee" htmlEscape="false" class="input-xlarge  number"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">issue_fee：</label>
			<div class="controls">
				<form:input path="issueFee" htmlEscape="false" class="input-xlarge  number"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">bill_fee：</label>
			<div class="controls">
				<form:input path="billFee" htmlEscape="false" class="input-xlarge  number"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">sys_error_code：</label>
			<div class="controls">
				<form:input path="sysErrorCode" htmlEscape="false" maxlength="6" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">sys_error_msg：</label>
			<div class="controls">
				<form:input path="sysErrorMsg" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">deal_time：</label>
			<div class="controls">
				<form:input path="dealTime" htmlEscape="false" maxlength="14" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">indb_time：</label>
			<div class="controls">
				<input name="indbTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${drBillDetail.indbTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">other_fee：</label>
			<div class="controls">
				<form:input path="otherFee" htmlEscape="false" class="input-xlarge  number"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">beforetrade_charge_dec：</label>
			<div class="controls">
				<form:input path="beforetradeChargeDec" htmlEscape="false" maxlength="12" class="input-xlarge  digits"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">balance_type：</label>
			<div class="controls">
				<form:input path="balanceType" htmlEscape="false" maxlength="2" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">test_flag：</label>
			<div class="controls">
				<form:input path="testFlag" htmlEscape="false" maxlength="2" class="input-xlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="settlementfront:drBillDetail:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>