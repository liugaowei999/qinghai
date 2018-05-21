<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>定时任务管理功能管理</title>
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
		<li class="active"><a href="${ctx}/timetask/sysTimetask/">定时任务管理功能列表</a></li>
		<shiro:hasPermission name="timetask:sysTimetask:edit"><li><a href="${ctx}/timetask/sysTimetask/form">定时任务管理功能添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="sysTimetask" action="${ctx}/timetask/sysTimetask/" method="post" class="breadcrumb form-search">
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
			<li><label>是否生效：</label>
				<form:select path="isEffect" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('sys_timetask_effect')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>是否启动：</label>
				<form:select path="isStart" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('sys_timetask_state')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
				<th>执行计划</th>
				<th>运行实例</th>
				<th>是否生效</th>
				<th>是否启动</th>
				<th>创建人</th>
				<th>创建时间</th>
				<th>修改人</th>
				<th>修改时间</th>
				<shiro:hasPermission name="timetask:sysTimetask:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="sysTimetask">
			<tr>
				<td><a href="${ctx}/timetask/sysTimetask/form?id=${sysTimetask.id}">
					${sysTimetask.taskId}
				</a></td>
				<td>
					${sysTimetask.taskDescribe}
				</td>
				<td>
					${sysTimetask.cronExpression}
				</td>
				<td>
					${sysTimetask.instId}
				</td>
				<td>
					${fns:getDictLabel(sysTimetask.isEffect, 'sys_timetask_effect', '')}
				</td>
				<td>
					${fns:getDictLabel(sysTimetask.isStart, 'sys_timetask_state', '')}
				</td>
				<td>
					${sysTimetask.createBy.name}
				</td>
				<td>
					<fmt:formatDate value="${sysTimetask.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${sysTimetask.updateBy.name}
				</td>
				<td>
					<fmt:formatDate value="${sysTimetask.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="timetask:sysTimetask:edit"><td>
    				<a href="${ctx}/timetask/sysTimetask/form?id=${sysTimetask.id}">修改</a>
					<a href="${ctx}/timetask/sysTimetask/delete?id=${sysTimetask.id}" onclick="return confirmx('确认要删除该定时任务管理功能吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>