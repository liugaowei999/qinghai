<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>提现管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		
		$(document).ready(function() {
			// 电话号码验证     
			jQuery.validator.addMethod("withdrawDepositeRules", function(value, element) {     
				var rules = /^(?!(0[0-9]{0,}$))[0-9]{1,}[.]{0,}[0-9]{0,}$/; 
				return this.optional(element) || (rules.test(value)&&(parseInt(value)<=parseInt(encodeURIComponent('${cashProvisions.withdrawDeposite}'))));     
			}, "提现金额必须大于0且小于等于可提现金额");	
			//$("#name").focus();
			$("#inputForm").validate({
				rules: {
					withdrawDeposite:{withdrawDepositeRules:true},
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
		<li><a href="${ctx}/cash/cashWithdrawRecord/cashWithdrawList">提现记录列表</a></li>
		<li class="active"><a href="${ctx}/cash/cashWithdrawRecord/cashWithdrawApply">提现申请</a></li>
	</ul><br/>
	
	<form:form  class="form-horizontal">
		<div class="control-group">
			<label class="control-label">备付金帐号：</label><div class="label-top">${cashProvisions.provisionsNo}</div>
		</div>
		<div class="control-group">
			<label class="control-label">银行卡帐号：</label><div class="label-top">${cashProvisions.bankcardNo}</div>
		</div>
		<div class="control-group">
			<label class="control-label">账户总额：</label><div class="label-top">${cashProvisions.totalAmount}</div>
		</div>
		<div class="control-group">
			<label class="control-label">可用余额：</label><div class="label-top">${cashProvisions.remainingSum}</div>
		</div>
		<div class="control-group">
			<label class="control-label">可提现金额：</label><div class="label-top">${cashProvisions.withdrawDeposite}</div>
		</div>
	</form:form>
	<c:if test="${withdrawFlag==1}">
		<div class="alert alert-waring" id="messageBox" style="display: block;">抱歉，由于您的账户可提现余额不足，您暂时不能进行提现，谢谢！</div>
	</c:if>
	<c:if test="${withdrawFlag==2}">
		<form:form id="inputForm" modelAttribute="cashWithdrawRecord" action="${ctx}/cash/cashWithdrawRecord/cashWithdrawApplySave" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:input path="provisionsId" type="hidden" value="${cashProvisions.id}"/>
		<div class="control-group">
			<label class="control-label">提现金额：</label>
			<div class="label-top">	
			<form:input path="withdrawDeposite" htmlEscape="false" maxlength="64" class="input-xlarge number required" style="width:150px"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-submit">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/></label>
		</div>
	</form:form>
	</c:if>
</body>
</html>