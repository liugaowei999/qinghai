<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>记录管理</title>
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
		<li><a href="${ctx}/cash/settBpDetail/">每日收支明细列表</a></li>
		<li class="active"><a href="${ctx}/cash/settBpDetail/form?id=${settBpDetail.id}">记录<shiro:hasPermission name="cash:settBpDetail:edit">${not empty settBpDetail.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="cash:settBpDetail:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="settBpDetail" action="${ctx}/cash/settBpDetail/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">sett_date：</label>
			<div class="controls">
				<form:input path="settDate" htmlEscape="false" maxlength="8" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">recv_org_code：</label>
			<div class="controls">
				<form:input path="recvOrgCode" htmlEscape="false" maxlength="11" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">file_name：</label>
			<div class="controls">
				<form:input path="fileName" htmlEscape="false" maxlength="128" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">income_charge：</label>
			<div class="controls">
				<form:input path="incomeCharge" htmlEscape="false" maxlength="18" class="input-xlarge  digits"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">pay_charge：</label>
			<div class="controls">
				<form:input path="payCharge" htmlEscape="false" maxlength="18" class="input-xlarge  digits"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">test_income_charge：</label>
			<div class="controls">
				<form:input path="testIncomeCharge" htmlEscape="false" maxlength="18" class="input-xlarge  digits"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">test_pay_charge：</label>
			<div class="controls">
				<form:input path="testPayCharge" htmlEscape="false" maxlength="18" class="input-xlarge  digits"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">deposit_change_charge：</label>
			<div class="controls">
				<form:input path="depositChangeCharge" htmlEscape="false" maxlength="18" class="input-xlarge  digits"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">charge_sign：</label>
			<div class="controls">
				<form:input path="chargeSign" htmlEscape="false" maxlength="10" class="input-xlarge "/>
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
				<form:input path="indbTime" htmlEscape="false" maxlength="14" class="input-xlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="cash:settBpDetail:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>