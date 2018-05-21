<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>变更记录管理</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
	$(document).ready(function() {

	});
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").submit();
		return false;
	}
</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a
			href="${ctx}/cash/cashPayPeriodRecord/examinePeriodList">缴存周期变更申请记录</a></li>
		<li><a href="#">缴存周期变更审核</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="cashPayPeriodRecord"
		action="${ctx}/cash/cashPayPeriodRecord/examinePeriodList"
		method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
		<input id="pageSize" name="pageSize" type="hidden"
			value="${page.pageSize}" />
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}"
			callback="page();" />
		<ul class="ul-form">
			<li><label>备付金账号：</label><form:select path="provisionsId" class="input-xlarge">
					<form:option value="" label="请选择" />
					<form:options items="${provisionMap}" htmlEscape="false" />
				</form:select>
			</li>
			<li><label>审核状态：</label> <form:select path="examineStatus"
					class="input-medium">
					<form:option value="" label="请选择" />
					<form:options items="${fns:getDictList('examine_status')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />S
				</form:select></li>
			<li><label>变更状态：</label>
			<form:select path="modifyStatus" class="input-medium">
					<form:option value="" label="请选择" />
					<form:options items="${fns:getDictList('modify_status')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />S
				</form:select></li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary"
				type="submit" value="查询" onclick="return page();" />
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}" />
	<table id="contentTable"
		class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>备付金账号</th>
				<th>原缴存周期</th>
				<th>现缴存周期</th>
				<th>需缴存金额</th>
				<th>是否缴存</th>
				<th>审核状态</th>
				<th>变更状态</th>
				<th>创建时间</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="cashPayPeriodRecord">
				<tr>
					<td>${cashPayPeriodRecord.provisionsNo}</td>
					<td>${fns:getDictLabel(cashPayPeriodRecord.oriPayPeriod, 'pay_period', '无')}
					</td>
					<td>${fns:getDictLabel(cashPayPeriodRecord.curPayPeriod, 'pay_period', '无')}
					</td>
					<td>${cashPayPeriodRecord.neePayMoney}</td>
					<td>${fns:getDictLabel(cashPayPeriodRecord.payPeriodFlag, 'yes_no', '无')}
					</td>
					<td>${fns:getDictLabel(cashPayPeriodRecord.examineStatus, 'examine_status', '无')}
					</td>
					<td>${fns:getDictLabel(cashPayPeriodRecord.modifyStatus, 'modify_status', '无')}
					</td>
					<td><fmt:formatDate value="${cashPayPeriodRecord.createDate}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td><fmt:formatDate value="${cashPayPeriodRecord.updateDate}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td>${cashPayPeriodRecord.remarks}</td>
					<td><c:choose>
							<c:when test="${cashPayPeriodRecord.periodStatus==1}">已撤回</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${cashPayPeriodRecord.examineStatus==0}">
										<a href="${ctx}/cash/cashPayPeriodRecord/toExaminePayPeriod?periodId=${cashPayPeriodRecord.periodId}">审核</a>
									</c:when>
									<c:when test="${cashPayPeriodRecord.examineStatus==1}">
										<c:if test="${cashPayPeriodRecord.modifyStatus==0}">
											<a href="${ctx}/cash/cashPayPeriodRecord/toExaminePayPeriod?periodId=${cashPayPeriodRecord.periodId}">审核</a>
										</c:if>
										<c:if test="${cashPayPeriodRecord.modifyStatus==1||cashPayPeriodRecord.modifyStatus==2}">已完成
										</c:if></c:when>
									<c:otherwise>
										已完成
									</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>