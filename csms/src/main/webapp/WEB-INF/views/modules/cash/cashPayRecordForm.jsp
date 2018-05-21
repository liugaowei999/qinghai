<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>备付金缴存</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
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
		<li class="active"><a href="${ctx}/cash/cashPayRecord/form">备付金缴存</a></li>
		<li><a href="${ctx}/cash/cashPayRecord/list">备付金缴存明细</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cashPayRecord" action="${ctx}/cash/cashPayRecord/save" method="post" class="form-horizontal">
		<sys:message content="${message}"/>	
		<form:hidden path="payState" value="0"/>
		<div class="control-group">
			<label class="control-label">备付金帐号：</label>
			<div class="controls">
				<form:select path="cashProvisions.id" class="input-xlarge required">
					<form:options items="${provisionsDropDownList}"  />
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">缴存金额：</label>
			<div class="controls">
				<form:input path="payMoney" htmlEscape="false" class="input-xlarge required number"/>
				<span class="help-inline"><font color="red">( 元 )*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="cash:cashPayRecord:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>