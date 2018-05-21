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
		<li><a href="${ctx}/cash/settAdDetail/">争议调整明细列表</a></li>
		<li class="active"><a href="${ctx}/cash/settAdDetail/form?id=${settAdDetail.id}">记录<shiro:hasPermission name="cash:settAdDetail:edit">${not empty settAdDetail.id?'详情':'添加'}</shiro:hasPermission><shiro:lacksPermission name="cash:settAdDetail:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="settAdDetail" action="${ctx}/cash/settAdDetail/save" method="post" class="form-horizontal" >
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">清算日期：</label>
			<div class="controls">
				<form:input path="settDate" htmlEscape="false" maxlength="8" class="input-xlarge " disabled = "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">接收机构：</label>
			<div class="controls">
				<form:input path="recvOrgCode" htmlEscape="false" maxlength="128" class="input-xlarge " disabled = "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">文件名称：</label>
			<div class="controls">
				<form:input path="fileName" htmlEscape="false" maxlength="128" class="input-xlarge " disabled = "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">清分结算机构调整交易流水号：</label>
			<div class="controls">
				<form:input path="settChangeNo" htmlEscape="false" maxlength="12" class="input-xlarge " disabled = "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">原消费交易清分结算机构结算日期：</label>
			<div class="controls">
				<form:input path="oriSettDate" htmlEscape="false" maxlength="8" class="input-xlarge " disabled = "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">原消费交易清分结算机构流水号：</label>
			<div class="controls">
				<form:input path="oriSettOrgNo" htmlEscape="false" maxlength="12" class="input-xlarge " disabled = "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">原消费交易收单机构流水号：</label>
			<div class="controls">
				<form:input path="oriBillOrgNo" htmlEscape="false" maxlength="12" class="input-xlarge " disabled = "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">原消费交易收单机构受理日期：</label>
			<div class="controls">
				<form:input path="oriBillDealDate" htmlEscape="false" maxlength="8" class="input-xlarge " disabled = "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">原消费交易检索参考号：</label>
			<div class="controls">
				<form:input path="oriRetrievNo" htmlEscape="false" maxlength="12" class="input-xlarge " disabled = "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">原交易交易类型：</label>
			<div class="controls">
				<form:input path="oriTradeType" htmlEscape="false" maxlength="4" class="input-xlarge " disabled = "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">调整类型：</label>
			<div class="controls">
				<form:input path="adjustType" htmlEscape="false" maxlength="1" class="input-xlarge " disabled = "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">卡号：</label>
			<div class="controls">
				<form:input path="cardNo" htmlEscape="false" maxlength="20" class="input-xlarge " disabled = "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">发卡机构：</label>
			<div class="controls">
				<form:input path="issueOrgCode" htmlEscape="false" maxlength="11" class="input-xlarge " disabled = "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">接收机构1：</label>
			<div class="controls">
				<form:input path="recvOrgCode1" htmlEscape="false" maxlength="11" class="input-xlarge " disabled = "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">收单机构：</label>
			<div class="controls">
				<form:input path="billOrgCode" htmlEscape="false" maxlength="11" class="input-xlarge " disabled = "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">发送机构：</label>
			<div class="controls">
				<form:input path="sendOrgId" htmlEscape="false" maxlength="11" class="input-xlarge " disabled = "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">差错发起方：</label>
			<div class="controls">
				<form:input path="errOriOrgId" htmlEscape="false" maxlength="11" class="input-xlarge " disabled = "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">差错确认方：</label>
			<div class="controls">
				<form:input path="errConfirmOrgId" htmlEscape="false" maxlength="11" class="input-xlarge " disabled = "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">卡消费计数器：</label>
			<div class="controls">
				<form:input path="cardCount" htmlEscape="false" maxlength="6" class="input-xlarge  digits" disabled = "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">消费前卡余额：</label>
			<div class="controls">
				<form:input path="beforetradeCharge" htmlEscape="false" maxlength="12" class="input-xlarge  digits" disabled = "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">调整后交易类型：</label>
			<div class="controls">
				<form:input path="adjustedTradeType" htmlEscape="false" maxlength="4" class="input-xlarge " disabled = "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">调整后交易金额：</label>
			<div class="controls">
				<form:input path="adjustedTradeCharge" htmlEscape="false" maxlength="12" class="input-xlarge  digits" disabled = "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">MCC：</label>
			<div class="controls">
				<form:input path="mcc" htmlEscape="false" maxlength="4" class="input-xlarge " disabled = "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">渠道类型：</label>
			<div class="controls">
				<form:input path="channelType" htmlEscape="false" maxlength="2" class="input-xlarge " disabled = "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">交易日期：</label>
			<div class="controls">
				<form:input path="tradeDate" htmlEscape="false" maxlength="8" class="input-xlarge " disabled = "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">交易时间：</label>
			<div class="controls">
				<form:input path="tradeTime" htmlEscape="false" maxlength="6" class="input-xlarge " disabled = "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">测试标志：</label>
			<div class="controls">
				<form:input path="testFlag" htmlEscape="false" maxlength="1" class="input-xlarge " disabled = "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">原因码：</label>
			<div class="controls">
				<form:input path="causeCode" htmlEscape="false" maxlength="4" class="input-xlarge " disabled = "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">回复码：</label>
			<div class="controls">
				<form:input path="responseCode" htmlEscape="false" maxlength="2" class="input-xlarge " disabled = "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">错误代码：</label>
			<div class="controls">
				<form:input path="errCode" htmlEscape="false" maxlength="6" class="input-xlarge " disabled = "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">错误代码描述：</label>
			<div class="controls">
				<form:input path="errInfo" htmlEscape="false" maxlength="40" class="input-xlarge " disabled = "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">差错手续费：</label>
			<div class="controls">
				<form:input path="errCharge" htmlEscape="false" maxlength="18" class="input-xlarge  digits" disabled = "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">手续费：</label>
			<div class="controls">
				<form:input path="settCharge" htmlEscape="false" class="input-xlarge  number" disabled = "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">发卡分润：</label>
			<div class="controls">
				<form:input path="issueCharge" htmlEscape="false" class="input-xlarge  number" disabled = "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">收单分润：</label>
			<div class="controls">
				<form:input path="billCharge" htmlEscape="false" class="input-xlarge  number" disabled = "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">处理时间：</label>
			<div class="controls">
				<form:input path="dealTime" htmlEscape="false" maxlength="14" class="input-xlarge " disabled = "true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">入库时间：</label>
			<div class="controls">
				<form:input path="indbTime" htmlEscape="false" maxlength="14" class="input-xlarge " disabled = "true"/>
			</div>
		</div>
		<div class="form-actions">
			<%-- <shiro:hasPermission name="cash:settAdDetail:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission> --%>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>