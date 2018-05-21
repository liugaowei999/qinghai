<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>变更记录管理</title>
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
		<li><a href="${ctx}/cash/cashPayPeriodRecord/">缴存周期变更列表</a></li>
		<li class="active"><a href="#">缴存周期变更申请</a></li>
	</ul><br/>
	<c:if test="${periodValidate==1}">
		<div class="alert alert-waring" id="messageBox" style="display: block;">抱歉，由于距离上次备付金缴存周期变更成功未满3个月，您暂时不能申请备付金缴存周期变更，谢谢！</div>
	</c:if>
		<c:if test="${periodValidate==0}">
			<form:form id="inputForm" modelAttribute="cashPayPeriodRecord" action="${ctx}/cash/cashPayPeriodRecord/cashPayPeriodSave" method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<form:hidden path="provisionsId"/>
			<sys:message content="${message}"/>		
			<div class="control-group">
				<label class="control-label">备付金帐号：</label>
				<div class="controls">
					<input name="provisionsNo" value="${cashPayPeriodRecord.provisionsNo}"  maxlength="64" type="text" readonly="readonly" class="input-xlarge required"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">原缴存周期：</label>
				<div class="controls">
				<input name="oriPayPeriod" value="${cashPayPeriodRecord.oriPayPeriod}" type="text" readonly="readonly" maxlength="64" class="input-xlarge required"/>
					${fns:getDictLabel(cashPayPeriodRecord.oriPayPeriod, 'pay_period', '无')}<span class="help-inline"><font color="red">*</font> </span>
					
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">现缴存周期：</label>
				<div class="controls"> 
				<input name="curPayPeriod" value="${cashPayPeriodRecord.curPayPeriod}" type="text" readonly="readonly" maxlength="64" class="input-xlarge required"/>
					${fns:getDictLabel(cashPayPeriodRecord.curPayPeriod, 'pay_period', '无')}<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="form-actions">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="提交"/>&nbsp;
				<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
			</div>
			</form:form>
		</c:if>
	
</body>
</html>