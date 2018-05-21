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
		<li><a href="${ctx}/settlementfront/settLd/">处理文件明细列表</a></li>
		<li class="active"><a href="${ctx}/settlementfront/settLd/form?id=${settLd.id}">记录<shiro:hasPermission name="settlementfront:settLd:edit">${not empty settLd.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="settlementfront:settLd:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="settLd" action="${ctx}/settlementfront/settLd/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">清算日期：</label>
			<div class="controls">
				<form:input path="settDate" htmlEscape="false" maxlength="8" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">接收机构代码：</label>
			<div class="controls">
				<form:input path="recvOrgCode" htmlEscape="false" maxlength="11" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">文件名称：</label>
			<div class="controls">
				<form:input path="fileName" htmlEscape="false" maxlength="128" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">清分结算机构流水号：</label>
			<div class="controls">
				<form:input path="settOrgNo" htmlEscape="false" maxlength="12" class="input-xlarge  digits"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">文件列表名称：</label>
			<div class="controls">
				<form:input path="fileListName" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">错误代码：</label>
			<div class="controls">
				<form:input path="errCode" htmlEscape="false" maxlength="6" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">错误描述：</label>
			<div class="controls">
				<form:input path="errInfo" htmlEscape="false" maxlength="40" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">保留域：</label>
			<div class="controls">
				<form:input path="reserved" htmlEscape="false" maxlength="40" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">处理时间：</label>
			<div class="controls">
				<form:input path="dealTime" htmlEscape="false" maxlength="14" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">入库时间：</label>
			<div class="controls">
				<form:input path="indbTime" htmlEscape="false" maxlength="14" class="input-xlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="settlementfront:settLd:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>