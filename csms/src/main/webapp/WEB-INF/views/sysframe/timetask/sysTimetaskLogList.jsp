<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>定时任务日志管理</title>
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
		<li class="active"><a href="${ctx}/timetask/sysTimetaskLog/">定时任务日志列表</a></li>
		<shiro:hasPermission name="timetask:sysTimetaskLog:edit"><li><a href="${ctx}/timetask/sysTimetaskLog/form">定时任务日志添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="sysTimetaskLog" action="${ctx}/timetask/sysTimetaskLog/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>任务标识：</label>
				<form:input path="taskId" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>任务描述：</label>
				<form:input path="taskDescribe" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li><label>运行实例：</label>
				<form:input path="instId" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>运行状态：</label>
				<form:select path="runState" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('sys_timetask_run')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>业务状态：</label>
				<form:select path="busiState" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('sys_timetask_busi')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
				<th>任务标识</th>
				<th>任务描述</th>
				<th>运行实例</th>
				<th>开始时间</th>
				<th>结束时间</th>
				<th>运行状态</th>
				<th>运行描述</th>
				<th>业务状态</th>
				<th>业务描述</th>
				<shiro:hasPermission name="timetask:sysTimetaskLog:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="sysTimetaskLog">
			<tr>
				<td><a href="${ctx}/timetask/sysTimetaskLog/form?id=${sysTimetaskLog.id}">
					${sysTimetaskLog.taskId}
				</a></td>
				<td>
					${sysTimetaskLog.taskDescribe}
				</td>
				<td>
					${sysTimetaskLog.instId}
				</td>
				<td>
					<fmt:formatDate value="${sysTimetaskLog.beginDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${sysTimetaskLog.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${fns:getDictLabel(sysTimetaskLog.runState, 'sys_timetask_run', '')}
				</td>
				<td>
					${sysTimetaskLog.runRemarks}
				</td>
				<td>
					${fns:getDictLabel(sysTimetaskLog.busiState, 'sys_timetask_busi', '')}
				</td>
				<td>
					${sysTimetaskLog.busiRemarks}
				</td>
				<shiro:hasPermission name="timetask:sysTimetaskLog:edit"><td>
    				<a href="${ctx}/timetask/sysTimetaskLog/form?id=${sysTimetaskLog.id}">修改</a>
					<a href="${ctx}/timetask/sysTimetaskLog/delete?id=${sysTimetaskLog.id}" onclick="return confirmx('确认要删除该定时任务日志吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>