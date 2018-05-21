<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>备付金开户</title>
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
		<li class="active"><a href="${ctx}/cash/cashProvisions/">账户可用余额查询</a></li>
		<shiro:hasPermission name="cash:cashProvisions:edit"><li><a href="${ctx}/cash/cashProvisions/form">备付金开户</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="cashProvisions" action="${ctx}/cash/cashProvisions/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>备付金帐号：</label>
				<form:input path="provisionsNo" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>银行卡号：</label>
				<form:input path="bankcardNo" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>归属公司：</label>
				<sys:treeselect id="company" name="company.id" value="${cashProvisions.company.id}" labelName="company.name" labelValue="${cashProvisions.company.name}"
					title="归属公司" url="/sys/office/treeData?type=1" cssClass="input-small" allowClear="true" notAllowSelectParent="false"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>备付金帐号</th>
				<th>银行卡号</th>
				<th>缴存周期</th>
				<th>押金</th>				
				<th>可用余额</th>
				<th>总额</th>
				<th>可提现金额</th>
				<th>上周期清算金额</th>
				<th>应付总额</th>
				<th>系统账号</th>
				<th>组织机构</th>
				<!-- <th>创建者</th>
				<th>创建时间</th>
				<th>更新者</th>
				<th>更新时间</th> -->
				<th>备注信息</th>
				<shiro:hasPermission name="cash:cashProvisions:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cashProvisions">
			<tr>
				<td><a href="${ctx}/cash/cashProvisions/form?id=${cashProvisions.id}">
					${cashProvisions.provisionsNo}
				</a></td>
				<td>
					${cashProvisions.bankcardNo}
				</td>
				<td>
					${fns:getDictLabel(cashProvisions.payPeriod,'pay_period','')}
				</td>
				<td>
					${cashProvisions.deposite}
				</td>
				<td>
					${cashProvisions.remainingSum}
				</td>
				<td>
					${cashProvisions.totalAmount}
				</td>
				<td>
					${cashProvisions.withdrawDeposite}
				</td>
				<td>
					${cashProvisions.needPay}
				</td>
				<td>
					<c:choose>
						<c:when test="${cashProvisions.needPay-cashProvisions.remainingSum<0}">
							 0.00
						</c:when>
						<c:otherwise>
							${cashProvisions.needPay-cashProvisions.remainingSum}
						</c:otherwise>
					</c:choose>
				</td>
				<td>
					${cashProvisions.user.loginName}
				</td>
				<td>
					${cashProvisions.company.name}
				</td>
				<%-- <td>
					${cashProvisions.createBy}
				</td>
				<td>
					<fmt:formatDate value="${cashProvisions.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${cashProvisions.updateBy}
				</td>
				<td>
					<fmt:formatDate value="${cashProvisions.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td> --%>
				<td>
					${cashProvisions.remarks}
				</td>
				<shiro:hasPermission name="cash:cashProvisions:edit"><td>
    				<a href="${ctx}/cash/cashProvisions/form?id=${cashProvisions.id}">修改</a>
					<a href="${ctx}/cash/cashProvisions/delete?id=${cashProvisions.id}" onclick="return confirmx('确认要删除该记录吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>