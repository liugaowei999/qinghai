<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>提现管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/cash/cashWithdrawRecord/cashWithdrawList">提现记录列表</a></li>
		<li><a href="${ctx}/cash/cashWithdrawRecord/cashWithdrawApply">提现申请</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="cashWithdrawRecord" action="${ctx}/cash/cashWithdrawRecord/cashWithdrawList" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>提现类型：</label> <form:select path="withdrawType"
					class="input-medium">
					<form:option value="" label="请选择" />
					<form:options items="${fns:getDictList('withdraw_type')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
					<span class="help-inline"><font color="red">*</font> </span>
				</form:select></li>
			<li><label>提现状态：</label>
			<form:select path="withdrawState" class="input-medium">
					<form:option value="" label="请选择" />
					<form:options items="${fns:getDictList('withdraw_state')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
					<span class="help-inline"><font color="red">*</font> </span>
				</form:select></li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary"
				type="submit" value="查询" onclick="return page();" />
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>备付金账号</th>
				<th>提现前金额</th>
				<th>提现金额</th>
				<th>提现后金额</th>
				<th>提现类型</th>
				<th>提现状态</th>
				<th>提现人</th>
				<th>提现时间</th>
				<th>备注信息</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cashWithdrawRecord">
			<tr>
				<td>${cashWithdrawRecord.provisionsNo}</td>
				<td>${cashWithdrawRecord.preWithdrawDeposite}</td>
				<td>${cashWithdrawRecord.withdrawDeposite}</td>
				<td>${cashWithdrawRecord.nextWithdrawDeposite}</td>
				<td>${fns:getDictLabel(cashWithdrawRecord.withdrawType, 'withdraw_type', '无')}</td>
				<td>${fns:getDictLabel(cashWithdrawRecord.withdrawState, 'withdraw_state', '无')}</td>
				<td>${cashWithdrawRecord.createName}</td>
				<td><fmt:formatDate value="${cashWithdrawRecord.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td>${cashWithdrawRecord.remarks}</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>