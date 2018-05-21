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
		<li><a href="${ctx}/settlementfront/settEd/">差错处理文件列表</a></li>
		<li class="active"><a href="${ctx}/settlementfront/settEd/form?id=${settEd.id}&settDate=${settEd.settDate}">记录<shiro:hasPermission name="settlementfront:settEd:edit">${not empty settEd.id?'确认':'添加'}</shiro:hasPermission><shiro:lacksPermission name="settlementfront:settEd:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="settEd" action="${ctx}/settlementfront/settEd/save" method="post" class="form-horizontal">
		<form:hidden path="id" />
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">发送机构：</label>
			<div class="controls">
				<sys:treeselect id="sendOrgCode" name="sendOrgCode" value="${settEd.sendOrg.id}" labelName="company.name" labelValue="${settEd.sendOrg.name}"
					title="部门" url="/sys/office/treeData?type=1" cssClass="input-xlarge" allowClear="true" notAllowSelectParent="false" disabled="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">文件名称：</label>
			<div class="controls">
				<form:input path="fileName" htmlEscape="false" maxlength="128" class="input-xlarge " disabled="true" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">清算日期：</label>
			<div class="controls">
				<form:input path="settDate" htmlEscape="false" maxlength="8" class="input-xlarge " />  
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">清算中心流水号：</label>
			<div class="controls">
				<form:input path="settOrgNo" htmlEscape="false" maxlength="12" class="input-xlarge "  disabled="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">收单机构流水号：</label>
			<div class="controls">
				<form:input path="billOrgNo" htmlEscape="false" maxlength="12" class="input-xlarge "  disabled="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">收单机构受理日期：</label>
			<div class="controls">
				<form:input path="billOrgDealDate" htmlEscape="false" maxlength="8" class="input-xlarge "  disabled="true" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">交易检索参考号：</label>
			<div class="controls">
				<form:input path="tradeRetrievNo" htmlEscape="false" maxlength="12" class="input-xlarge "  disabled="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">调整类型：</label>
			<div class="controls">
				<form:input path="adjustType" htmlEscape="false" maxlength="1" class="input-xlarge "  disabled="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">差错类型：</label>
			<div class="controls">
				<form:input path="errType" htmlEscape="false" maxlength="4" class="input-xlarge "   disabled="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">卡号：</label>
			<div class="controls">
				<form:input path="cardNo" htmlEscape="false" maxlength="20" class="input-xlarge "  disabled="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">卡消费计数器：</label>
			<div class="controls">
				<form:input path="cardCount" htmlEscape="false" maxlength="6" class="input-xlarge  digits"   disabled="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">消费前卡余额：</label>
			<div class="controls">
				<form:input path="beforetradeCharge" htmlEscape="false" maxlength="12" class="input-xlarge  digits"   disabled="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">调整后交易类型：</label>
			<div class="controls">
				<form:input path="adjustedTradeType" htmlEscape="false" maxlength="4" class="input-xlarge "  disabled="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">调整后交易金额：</label>
			<div class="controls">
				<form:input path="adjustedTradeCharge" htmlEscape="false" maxlength="12" class="input-xlarge  digits"  disabled="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">MCC：</label>
			<div class="controls">
				<form:input path="mcc" htmlEscape="false" maxlength="4" class="input-xlarge "  disabled="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">渠道类型：</label>
			<div class="controls">
				<form:input path="channelType" htmlEscape="false" maxlength="2" class="input-xlarge "  disabled="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">交易日期：</label>
			<div class="controls">
				<form:input path="tradeDate" htmlEscape="false" maxlength="8" class="input-xlarge "  disabled="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">交易时间：</label>
			<div class="controls">
				<form:input path="tradeTime" htmlEscape="false" maxlength="6" class="input-xlarge "  disabled="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">测试标志：</label>
			<div class="controls">
				<form:input path="testFlag" htmlEscape="false" maxlength="1" class="input-xlarge "  disabled="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">原因码：</label>
			<div class="controls">
				<form:input path="causeCode" htmlEscape="false" maxlength="4" class="input-xlarge " disabled="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">差错发起方机构：</label>
			<div class="controls">
				<sys:treeselect id="errOriOrgCode" name="errOriOrgCode" value="${settEd.errOriOrg.id}" labelName="company.name" labelValue="${settEd.errOriOrg.name}"
					title="部门" url="/sys/office/treeData?type=1" cssClass="input-small" allowClear="true" notAllowSelectParent="false"  disabled="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">发卡机构：</label>
			<div class="controls">
				<sys:treeselect id="issueOrgCode" name="issueOrgCode" value="${settEd.issueOrg.id}" labelName="company.name" labelValue="${settEd.issueOrg.name}"
					title="部门" url="/sys/office/treeData?type=1" cssClass="input-small" allowClear="true" notAllowSelectParent="false" disabled="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">收单机构：</label>
			<div class="controls">
				<sys:treeselect id="billOrgId" name="billOrgId" value="${settEd.company.id}" labelName="company.name" labelValue="${settEd.company.name}"
					title="部门" url="/sys/office/treeData?type=1" cssClass="input-small" allowClear="true" notAllowSelectParent="false" disabled="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">处理时间：</label>
			<div class="controls">
				<form:input path="dealTime" htmlEscape="false" maxlength="14" class="input-xlarge " disabled="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">入库时间：</label>
			<div class="controls">
				<form:input path="indbTime" htmlEscape="false" maxlength="14" class="input-xlarge " disabled="true"/>
			</div>
		</div>
		<c:choose>
			<c:when test="${settEd.dealFlag == 0}">
				<div class="control-group">
					<label class="control-label">确认标志：</label>
					<div class="controls">
						<form:select path="dealFlag" class="input-xlarge ">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('deal_flag')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">确认备注：</label>
					<div class="controls">
						<form:input path="dealNote" htmlEscape="false" maxlength="512" class="input-xlarge "/>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<div class="control-group">
					<label class="control-label">确认标志：</label>
					<div class="controls">
						<form:select path="dealFlag" class="input-xlarge " disabled="true">
							<form:option value="" label=""/>
							<form:options items="${fns:getDictList('deal_flag')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">确认备注：</label>
					<div class="controls">
						<form:input path="dealNote" htmlEscape="false" maxlength="512" class="input-xlarge " disabled="true"/>
					</div>
				</div>
			</c:otherwise>
		</c:choose>
		
		<div class="form-actions">
			<shiro:hasPermission name="settlementfront:settEd:edit"><c:if test="${settEd.dealFlag == '0'}"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</c:if></shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>