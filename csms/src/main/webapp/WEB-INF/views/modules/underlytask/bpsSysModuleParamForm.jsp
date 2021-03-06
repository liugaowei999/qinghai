<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>后台任务状态参数管理</title>
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
		<li><a href="${ctx}/underlytask/bpsSysModuleParam/">后台任务状态参数列表</a></li>
		<li class="active"><a href="${ctx}/underlytask/bpsSysModuleParam/form?id=${bpsSysModuleParam.id}">后台任务状态参数<shiro:hasPermission name="underlytask:bpsSysModuleParam:edit">${not empty bpsSysModuleParam.moduleId?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="underlytask:bpsSysModuleParam:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="bpsSysModuleParam" action="${ctx}/underlytask/bpsSysModuleParam/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">模块标识：</label>
			<div class="controls">
				<form:input path="moduleId" htmlEscape="false" maxlength="6" readonly="true" class="input-xlarge required digits"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">参数类别：</label>
			<div class="controls">
				<form:input path="sectionCode" htmlEscape="false" maxlength="32" readonly="true"  class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">参数编码：</label>
			<div class="controls">
				<form:input path="paramCode" htmlEscape="false" maxlength="32" readonly="true"  class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">参数取值：</label>
			<div class="controls">
				<form:input path="paramValue" htmlEscape="false" maxlength="1024" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:input path="note" htmlEscape="false" maxlength="256" class="input-xlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="underlytask:bpsSysModuleParam:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>