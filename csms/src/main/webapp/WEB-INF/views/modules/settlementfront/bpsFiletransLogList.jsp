<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>记录管理</title>
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
		<li class="active"><a href="${ctx}/settlementfront/bpsFiletransLog/">记录列表</a></li>
		<shiro:hasPermission name="settlementfront:bpsFiletransLog:edit"><li><a href="${ctx}/settlementfront/bpsFiletransLog/form">记录添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="bpsFiletransLog" action="${ctx}/settlementfront/bpsFiletransLog/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li><label>文件名称：</label>
				<form:input path="fileName" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li><label>查询月份：</label>
				<input name="processTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${bpsFiletransLog.processTime}" pattern="yyyy-MM"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM',maxDate:'%y-%M',isShowClear:false});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<td>模块ID</td>
				<td>文件名</td>
				<td>原始文件大小(字节)</td>
				<td>状态</td>
				<td>操作时间</td>
				<td>操作状态</td>
				<td>已传输文件大小(字节)</td>
				<td>备注</td>
				<shiro:hasPermission name="settlementfront:bpsFiletransLog:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bpsFiletransLog">
			<tr>
				<td>${bpsFiletransLog.moduleId}</td>
				<td>${bpsFiletransLog.fileName}</td>
				<td>${bpsFiletransLog.fileSize}</td>
				<td>${fns:getDictLabel(bpsFiletransLog.isSucess, 'is_sucess', '无')}</td>
				<td><fmt:formatDate value="${bpsFiletransLog.processTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td>${fns:getDictLabel(bpsFiletransLog.isup, 'isup', '无')}</td>
				<td>${bpsFiletransLog.transSize}</td>
				<td>${bpsFiletransLog.remark}</td>
				<shiro:hasPermission name="settlementfront:bpsFiletransLog:edit"><td>
    				<a href="${ctx}/settlementfront/bpsFiletransLog/form?id=${bpsFiletransLog.id}">修改</a>
					<a href="${ctx}/settlementfront/bpsFiletransLog/delete?id=${bpsFiletransLog.id}" onclick="return confirmx('确认要删除该记录吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>