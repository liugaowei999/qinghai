<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>清单记录格式定义管理</title>
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
		<li class="active"><a href="${ctx}/settlementfront/bpsRecordFormat/">清单记录格式定义列表</a></li>
		<%-- <shiro:hasPermission name="settlementfront:bpsRecordFormat:edit"><li><a href="${ctx}/settlementfront/bpsRecordFormat/form">清单记录格式定义添加</a></li></shiro:hasPermission> --%>
	</ul>
	<form:form id="searchForm" modelAttribute="bpsRecordFormat" action="${ctx}/settlementfront/bpsRecordFormat/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>记录类型：</label><form:select path="drType" class="input-medium">
					<form:option value="" label="请选择" />
					<form:options items="${drTypeDropDownMap}" htmlEscape="false" />
				</form:select>
			</li>
			<li><label>值类型：</label>
			<form:select path="valueType" class="input-medium">
					<form:option value="" label="请选择" />
					<form:options items="${fns:getDictList('value_type')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
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
				<td>记录类型</td>
				<td>字段名称</td>
				<td>字段位置</td>
				<td>值类型</td>
				<td>序号</td>
				<td>备注</td>
				<%-- <shiro:hasPermission name="settlementfront:bpsRecordFormat:edit"><th>操作</th></shiro:hasPermission> --%>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bpsRecordFormat">
			<tr>
				<td>${bpsRecordFormat.drType}</td>
				<td>${bpsRecordFormat.filedName}</td>
				<td>${bpsRecordFormat.filedIndex}</td>
				<td>${fns:getDictLabel(bpsRecordFormat.valueType, 'value_type', '无')}</td>
				<td>${bpsRecordFormat.seq}</td>
				<td>${bpsRecordFormat.note}</td>
				<%-- <shiro:hasPermission name="settlementfront:bpsRecordFormat:edit"><td>
    				<a href="${ctx}/settlementfront/bpsRecordFormat/form?id=${bpsRecordFormat.id}">修改</a>
					<a href="${ctx}/settlementfront/bpsRecordFormat/delete?id=${bpsRecordFormat.id}" onclick="return confirmx('确认要删除该清单记录格式定义吗？', this.href)">删除</a>
				</td></shiro:hasPermission> --%>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>