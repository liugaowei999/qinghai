<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>清算费率管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			jQuery.validator.addMethod("mathRules", function(value, element) {     
				var rules = /^(?!(0[0-9]{0,}$))[0-9]{1,}[.]{0,}[0-9]{0,}$/; 
				return this.optional(element) || (rules.test(value)&&(parseInt(value)>0));     
			}, "请输入正确的数字范围！");	
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
		<li><a href="${ctx}/settlementfront/bpsSysSettRate/">清算费率列表</a></li>
		<li class="active"><a href="${ctx}/settlementfront/bpsSysSettRate/form?id=${bpsSysSettRate.id}">清算费率<shiro:hasPermission name="settlementfront:bpsSysSettRate:edit">${not empty bpsSysSettRate.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="settlementfront:bpsSysSettRate:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="bpsSysSettRate" action="${ctx}/settlementfront/bpsSysSettRate/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">行业类型：</label>
			<div class="controls">
				<form:select path="businessType" class="input-xlarge required">
					<form:option value="" label="请选择" />
					<form:options items="${businessTypeDropDownMap}" htmlEscape="false" />
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">业务类型：</label>
			<div class="controls">
				<form:select path="serviceType" class="input-xlarge required">
					<form:option value="" label="请选择" />
					<form:options items="${serviceTypeDropDownMap}" htmlEscape="false" />
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">收单机构：</label>
			<div class="controls">
				<form:select path="recvOrgCode" class="input-xlarge required">
					<form:option value="" label="请选择" />
					<form:options items="${orgNameDropDownMap}" htmlEscape="false" />
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">发卡机构：</label>
			<div class="controls">
				<form:select path="issueOrgCode" class="input-xlarge required">
					<form:option value="" label="请选择" />
					<form:options items="${orgNameDropDownMap}" htmlEscape="false" />
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">手续费费率：</label>
			<div class="controls">
				<form:input path="chargeRate" htmlEscape="false" maxlength="12" class="input-xlarge number"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">收单机构分成比例：</label>
			<div class="controls">
				<form:input path="recvRate" htmlEscape="false" maxlength="12" class="input-xlarge number"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">发卡机构分成比例：</label>
			<div class="controls">
				<form:input path="issueRate" htmlEscape="false" maxlength="12" class="input-xlarge number"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">生效日期：</label>
			<div class="controls">
				<input name="effDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${bpsSysSettRate.effDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">失效日期：</label>
			<div class="controls">
				<input name="expDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${bpsSysSettRate.expDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:input path="remark" htmlEscape="false" maxlength="512" class="input-xlarge "/>
			</div>
		</div>
		
		<div class="form-actions">
			<shiro:hasPermission name="settlementfront:bpsSysSettRate:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>