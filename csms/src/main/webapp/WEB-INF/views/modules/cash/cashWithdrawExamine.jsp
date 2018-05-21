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
		<li><a href="${ctx}/cash/cashWithdrawRecord/cashWithdrawExamineList">提现申请记录</a></li>
		<li class="active"><a href="#">提现申请审核</a></li>
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
			<label class="control-label">提现金额：</label><div class="label-top">${cashWithdrawRecord.withdrawDeposite}</div>
		</div>
	</form:form>
		<form:form id="inputForm" modelAttribute="cashWithdrawRecord" action="${ctx}/cash/cashWithdrawRecord/cashWithdrawExamineSave" method="post" class="form-horizontal">
		<form:hidden path="withdrawId"/>
		<div class="control-group">
			<label class="control-label">提现状态：</label>
			<div class="label-top">	
			<form:select path="withdrawState" class="input-xlarge">
					<form:options items="${fns:getDictList('withdraw_state')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
					<span class="help-inline"><font color="red">*</font> </span>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="label-top">	
				<form:input path="remarks" htmlEscape="false" maxlength="64" class="input-xlarge"/>
			</div>
		</div>		
		<div class="control-group">
			<label class="control-submit">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/></label>
		</div>
	</form:form>
</body>
</html>