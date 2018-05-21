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
		<li><a href="${ctx}/reports/settCityStatDetail/">记录列表</a></li>
		<li class="active"><a href="${ctx}/reports/settCityStatDetail/form?id=${settCityStatDetail.id}">记录<shiro:hasPermission name="reports:settCityStatDetail:edit">${not empty settCityStatDetail.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="reports:settCityStatDetail:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="settCityStatDetail" action="${ctx}/reports/settCityStatDetail/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">结算日期：</label>
			<div class="controls">
				<input name="settDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${settCityStatDetail.settDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">结算对象：</label>
			<div class="controls">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">结算方向：</label>
			<div class="controls">
				<form:select path="settDirection" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('sett_direction')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">角色：</label>
			<div class="controls">
				<form:select path="roleType" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('sett_role_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">发卡机构代码：</label>
			<div class="controls">
				<form:input path="issueCode" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">发卡机构名称：</label>
			<div class="controls">
				<form:select path="issueOrgName" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">收单机构代码：</label>
			<div class="controls">
				<form:input path="billCode" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">收单机构名称：</label>
			<div class="controls">
				<form:select path="billOrgName" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">交易金额：</label>
			<div class="controls">
				<form:input path="tradeCharge" htmlEscape="false" class="input-xlarge  number"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">手续费：</label>
			<div class="controls">
				<form:input path="serviceFee" htmlEscape="false" class="input-xlarge  number"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">发卡分润：</label>
			<div class="controls">
				<form:input path="issueCharge" htmlEscape="false" class="input-xlarge  number"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">收单分润：</label>
			<div class="controls">
				<form:input path="billCharge" htmlEscape="false" class="input-xlarge  number"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">清算中心分润：</label>
			<div class="controls">
				<form:input path="centerCharge" htmlEscape="false" class="input-xlarge  number"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">结算费用：</label>
			<div class="controls">
				<form:input path="settCharge" htmlEscape="false" class="input-xlarge  number"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="reports:settCityStatDetail:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>