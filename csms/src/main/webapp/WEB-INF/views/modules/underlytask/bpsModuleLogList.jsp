<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>日志记录管理</title>
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
		<li class="active"><a href="${ctx}/underlytask/bpsModuleLog/">日志记录列表</a></li>
		<shiro:hasPermission name="underlytask:bpsModuleLog:edit"><li><a href="${ctx}/underlytask/bpsModuleLog/form">记录添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="bpsModuleLog" action="${ctx}/underlytask/bpsModuleLog/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>模块名称：</label>
				<form:input path="bpsSysModule.moduleName" htmlEscape="false" maxlength="50" class="input-medium"/></li>
			</li>
			<%-- <li><label>文件类型：</label>
				<form:select path="fileType" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li> --%>
			<li><label>查询月份：</label>
				<input name="beginDealTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${bpsModuleLog.beginDealTime}" pattern="yyyy-MM"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM',maxDate:'%y-%M',isShowClear:false});"/>
			</li>
			<%-- <li><label>结束时间：</label>
				<input name="endDealTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${bpsModuleLog.endDealTime}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			</li> --%>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>模块名称</th>
				<th>文件名</th>
				<th>文件类型</th>
				<th>文件大小</th>
				<th>文件日期</th>
				<th>开始处理时间</th>
				<th>结束处理时间</th>
				<th>话单总数</th>
				<th>正确话单数</th>
				<th>错误话单数</th>
				<th>重复话单数</th>
				<th>无用话单数</th>
				<th>增减话单数</th>
				<th>合并话单数</th>
				<th>拆分话单数</th>
				<th>保留1</th>
				<th>保留2</th>
				<th>ASN坏块大小</th>
				<th>最早话单时间</th>
				<th>最晚话单时间</th>
				<shiro:hasPermission name="underlytask:bpsModuleLog:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bpsModuleLog">
			<tr>
				<td> 
					${bpsModuleLog.bpsSysModule.moduleName}
				</td>
				<td>
					${bpsModuleLog.fileName}
				</td>
				<td>
					${bpsModuleLog.fileType}
				</td>
				<td>
					${bpsModuleLog.fileSize}
				</td>
				<td>
					<fmt:formatDate value="${bpsModuleLog.fileDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${bpsModuleLog.beginDealTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${bpsModuleLog.endDealTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${bpsModuleLog.totalCount}
				</td>
				<td>
					${bpsModuleLog.normalCount}
				</td>
				<td>
					${bpsModuleLog.errorCount}
				</td>
				<td>
					${bpsModuleLog.dupCount}
				</td>
				<td>
					${bpsModuleLog.nouseCount}
				</td>
				<td>
					${bpsModuleLog.changedCount}
				</td>
				<td>
					${bpsModuleLog.mergeCount}
				</td>
				<td>
					${bpsModuleLog.splitCount}
				</td>
				<td>
					${bpsModuleLog.other1}
				</td>
				<td>
					${bpsModuleLog.other2}
				</td>
				<td>
					${bpsModuleLog.asnBadblock}
				</td>
				<td>
					${bpsModuleLog.earlyTime}
				</td>
				<td>
					${bpsModuleLog.lateTime}
				</td>
				<shiro:hasPermission name="underlytask:bpsModuleLog:edit"><td>
    				<a href="${ctx}/underlytask/bpsModuleLog/form?id=${bpsModuleLog.id}">修改</a>
					<a href="${ctx}/underlytask/bpsModuleLog/delete?id=${bpsModuleLog.id}" onclick="return confirmx('确认要删除该记录吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>