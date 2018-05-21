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
		<li><a href="${ctx}/reports/settStatReport/">记录列表</a></li>
		<li class="active"><a href="${ctx}/reports/settStatReport/form?id=${settStatReport.id}">记录<shiro:hasPermission name="reports:settStatReport:edit">${not empty settStatReport.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="reports:settStatReport:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="settStatReport" action="${ctx}/reports/settStatReport/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">结算类型：</label>
			<div class="controls">
				<form:select path="settType" class="input-xlarge required">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('sett_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">结算日期：</label>
			<div class="controls">
				<form:input path="settDate" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">机构代码：</label>
			<form:input path="orgCode" htmlEscape="false" maxlength="64" class="input-xlarge "/>
		</div>
		<div class="control-group">
			<label class="control-label">机构名称：</label>
			<div class="controls">
				<form:input path="orgName" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">收入金额：</label>
			<div class="controls">
				<form:input path="incomeCharge" htmlEscape="false" class="input-xlarge  number"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">支出金额：</label>
			<div class="controls">
				<form:input path="outcomeCharge" htmlEscape="false" class="input-xlarge  number"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">轧差：</label>
			<div class="controls">
				<form:input path="offsetBalance" htmlEscape="false" class="input-xlarge  number"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">结算说明：</label>
			<div class="controls">
				<form:input path="note" htmlEscape="false" maxlength="1024" class="input-xlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="reports:settStatReport:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>