<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>后台任务状态参数管理</title>
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
		<li class="active"><a href="${ctx}/underlytask/bpsSysModuleParam/">后台任务状态参数列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="bpsSysModuleParam" action="${ctx}/underlytask/bpsSysModuleParam/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>模块名称：</label>
				<form:input path="bpsSysModule.moduleName" htmlEscape="false" maxlength="6" class="input-medium"/>
			</li>
			<li><label>参数类别：</label>
				<form:input path="sectionCode" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			<li><label>参数编码：</label>
				<form:input path="paramCode" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>模块标识</th>
				<th>模块名称</th>
				<th>参数类别</th>
				<th>参数编码</th>
				<th>参数取值</th>
				<th>备注</th>
				<shiro:hasPermission name="underlytask:bpsSysModuleParam:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bpsSysModuleParam">
			<tr>
				<td><a href="${ctx}/underlytask/bpsSysModuleParam/form?moduleId=${bpsSysModuleParam.moduleId}">
					${bpsSysModuleParam.moduleId}
				</a></td>
				<td>
					${bpsSysModuleParam.bpsSysModule.moduleName}
				</td>
				<td>
					${bpsSysModuleParam.sectionCode}
				</td>
				<td>
					${bpsSysModuleParam.paramCode}
				</td>
				<td>
					${bpsSysModuleParam.paramValue}
				</td>
				<td>
					${bpsSysModuleParam.note}
				</td>
				<shiro:hasPermission name="underlytask:bpsSysModuleParam:edit"><td>
    				<a href="${ctx}/underlytask/bpsSysModuleParam/form?moduleId=${bpsSysModuleParam.moduleId}&sectionCode=${bpsSysModuleParam.sectionCode}&paramCode=${bpsSysModuleParam.paramCode}">修改</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>