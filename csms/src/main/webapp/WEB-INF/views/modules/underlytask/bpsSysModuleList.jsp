<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>任务管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
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
		<li class="active"><a href="${ctx}/underlytask/bpsSysModule/">任务列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="bpsSysModule" action="${ctx}/underlytask/bpsSysModule/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>模块编码：</label><form:input path="moduleCode" htmlEscape="false" maxlength="50" class="input-medium"/></li>
			<li><label>模块名称：</label><form:input path="moduleName" htmlEscape="false" maxlength="50" class="input-medium"/></li>
			<li><label>程序名称：</label><form:input path="programName" htmlEscape="false" maxlength="50" class="input-medium"/></li>
			<li class="btns">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>模块标识</th>
				<th>模块编码</th>
				<th>模块名称</th>
				<th>程序名称</th>
				<th>备注</th>
				<shiro:hasPermission name="underlytask:bpsSysModule:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="bpsSysModule">
				<tr>
					<td>${bpsSysModule.moduleId}</td>
					<td>${bpsSysModule.moduleCode}</td>
					<td>${bpsSysModule.moduleName}</td>
					<td>${bpsSysModule.programName}</td>
					<td>${bpsSysModule.note}</td>
					<shiro:hasPermission name="underlytask:bpsSysModule:edit">
						<td>
    						<a href="${ctx}/underlytask/bpsSysModule/form?id=${bpsSysModule.moduleId}">修改</a>
						</td>
					</shiro:hasPermission>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>