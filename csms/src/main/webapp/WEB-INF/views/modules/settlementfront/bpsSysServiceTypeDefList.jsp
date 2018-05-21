<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>业务类型管理</title>
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
		<li class="active"><a href="${ctx}/settlementfront/bpsSysServiceTypeDef/">业务类型列表</a></li>
		<shiro:hasPermission name="settlementfront:bpsSysServiceTypeDef:edit"><li><a href="${ctx}/settlementfront/bpsSysServiceTypeDef/form">业务类型添加</a></li></shiro:hasPermission>
	</ul>
		<form:form id="searchForm" modelAttribute="bpsSysServiceTypeDef" action="${ctx}/settlementfront/bpsSysServiceTypeDef/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>业务类型：</label>
				<form:select path="id" class="input-medium">
					<form:option value="" label="请选择" />
					<form:options items="${serviceTypesDropDownMap}" htmlEscape="false" />
				</form:select>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
		</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>业务类型</th>
				<th>业务名称</th>
				<th>备注</th>
				<shiro:hasPermission name="settlementfront:bpsSysServiceTypeDef:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bpsSysServiceTypeDef">
			<tr>
				<td>${bpsSysServiceTypeDef.serviceType}</td>
				<td>${bpsSysServiceTypeDef.serviceName}</td>
				<%-- <td>${bpsSysServiceTypeDef.createBy.id}</td>
				<td><fmt:formatDate value="${bpsSysServiceTypeDef.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td>${bpsSysServiceTypeDef.updateBy.id}</td>
				<td><a href="${ctx}/settlementfront/bpsSysServiceTypeDef/form?id=${bpsSysServiceTypeDef.id}">
					<fmt:formatDate value="${bpsSysServiceTypeDef.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</a></td> --%>
				<td>${bpsSysServiceTypeDef.remark}</td>
				<shiro:hasPermission name="settlementfront:bpsSysServiceTypeDef:edit"><td>
    				<a href="${ctx}/settlementfront/bpsSysServiceTypeDef/form?id=${bpsSysServiceTypeDef.id}">修改</a>
					<a href="${ctx}/settlementfront/bpsSysServiceTypeDef/delete?id=${bpsSysServiceTypeDef.id}" onclick="return confirmx('确认要删除该业务类型吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>