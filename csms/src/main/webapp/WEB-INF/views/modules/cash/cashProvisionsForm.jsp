<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>备付金开户</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#inputForm").validate({
				rules: {
					loginName: {remote: "${ctx}/cash/cashProvisions/checkLoginName" }
				},
				messages: {
					loginName: {remote: "登录名已存在"},
					confirmNewPassword: {equalTo: "输入与上面相同的密码"}
				},
				
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
		<li><a href="${ctx}/cash/cashProvisions/">账户可用余额查询</a></li>
		<li class="active"><a href="${ctx}/cash/cashProvisions/form?id=${cashProvisions.id}">备付金<shiro:hasPermission name="cash:cashProvisions:edit">${not empty cashProvisions.id?'账户修改':'开户'}</shiro:hasPermission><shiro:lacksPermission name="cash:cashProvisions:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cashProvisions" action="${ctx}/cash/cashProvisions/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<c:if test="${not empty cashProvisions.id}">
			<div class="control-group">
				<label class="control-label">备付金帐号：</label>
				<div class="controls">
					<c:choose>
						<c:when test="${not empty cashProvisions.id}">
							<form:input path="provisionsNo" htmlEscape="false" maxlength="64" disabled="true"  class="input-xlarge required"/>
						</c:when>
						<c:otherwise>
							<form:input path="provisionsNo" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
						</c:otherwise>
					</c:choose>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
		</c:if>
		<div class="control-group">
			<label class="control-label">银行卡号：</label>
			<div class="controls">
				<form:input path="bankcardNo" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<c:if test="${empty cashProvisions.id}">
			<div class="control-group">
				<label class="control-label">缴存周期：</label>
				<div class="controls">
					<form:select path="payPeriod">
						<form:options items="${fns:getDictList('pay_period')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">押金：</label>
				<div class="controls">
					<form:input path="deposite" htmlEscape="false" class="input-xlarge  number" value="0.00"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="control-group">
					<label class="control-label">可用余额：</label>
					<div class="controls">
						<form:input path="remainingSum" htmlEscape="false" class="input-xlarge  number" value="20000.00"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
			</div>
		</c:if>
		<c:if test="${not empty cashProvisions.id}">
			<div class="control-group">
				<label class="control-label">缴存周期：</label>
				<div class="controls">
					<form:select path="payPeriod">
						<form:options items="${fns:getDictList('pay_period')}" itemLabel="label" itemValue="value" htmlEscape="false" disabled="true"/>
					</form:select>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">押金：</label>
				<div class="controls">
					<form:input path="deposite" htmlEscape="false" class="input-xlarge  number" disabled="true"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="control-group">
					<label class="control-label">可用余额：</label>
					<div class="controls">
						<form:input path="remainingSum" htmlEscape="false" class="input-xlarge  number" disabled="true"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</div>
			</div>
			<div class="control-group">
				<label class="control-label">总额：</label>
				<div class="controls">
					<form:input path="totalAmount" htmlEscape="false" class="input-xlarge  number" disabled="true"/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">可提现金额：</label>
				<div class="controls">
					<form:input path="withdrawDeposite" htmlEscape="false" class="input-xlarge  number" disabled="true"/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label"> 上周期清算金额：</label>
				<div class="controls">
					<form:input path="needPay" htmlEscape="false" class="input-xlarge  number" disabled="true"/>
				</div>
			</div>
		</c:if>
		<c:if test="${empty cashProvisions.id}">
			
			<div class="control-group">
				<label class="control-label">工号:</label>
				<div class="controls">
					<form:input path="user.no" htmlEscape="false" maxlength="50" class="required"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">姓名:</label>
				<div class="controls">
					<form:input path="user.name" htmlEscape="false" maxlength="50" class="required"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">登录名:</label>
				<div class="controls">
					<input id="loginName" name="loginName" type="text"  maxlength="50" class="required "/>
					<%-- <form:input path="user.loginName"   maxlength="50" class="required"/> --%>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">密码:</label>
				<div class="controls">
					<input id="newPassword" name="newPassword" type="password" value="" maxlength="50" minlength="3" class="${empty user.id?'required':''}"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">确认密码:</label>
				<div class="controls">
					<input id="confirmNewPassword" name="confirmNewPassword" type="password" value="" maxlength="50" minlength="3" equalTo="#newPassword"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">邮箱:</label>
				<div class="controls">
					<form:input path="user.email" htmlEscape="false" maxlength="100" class="email"/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">电话:</label>
				<div class="controls">
					<form:input path="user.phone" htmlEscape="false" maxlength="100"/>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">手机:</label>
				<div class="controls">
					<form:input path="user.mobile" htmlEscape="false" maxlength="100"/>
				</div>
			</div>
		</c:if>
		<div class="control-group">
			<label class="control-label">归属公司：</label>
			<div class="controls">
				<sys:treeselect id="company" name="company.id" value="${cashProvisions.company.id}" labelName="company.name" labelValue="${cashProvisions.company.name}"
					title="归属公司" url="/sys/office/treeData?type=1" cssClass="input-small required" allowClear="true" notAllowSelectParent="false"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="cash:cashProvisions:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>