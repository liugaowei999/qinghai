<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>UC上发黑名单配置文件管理</title>
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
		<li class="active"><a href="${ctx}/settlementfront/bpsUcConf/">UC上发黑名单配置文件列表</a></li>
		<shiro:hasPermission name="settlementfront:bpsUcConf:edit"><li><a href="${ctx}/settlementfront/bpsUcConf/form">UC上发黑名单配置文件添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="bpsUcConf" action="${ctx}/settlementfront/bpsUcConf/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>发送日期：</label>
				<form:input path="sendDate" htmlEscape="false" maxlength="8" class="input-medium"/>
			</li>
			<li ><label width="20px">发送机构代码：</label>
				<form:input path="sendOrgCode" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label>文件名称：</label>
				<form:input path="fileName" htmlEscape="false" maxlength="128" class="input-medium"/>
			</li>
			<li class="clearfix"></li>
			<li><label>发卡机构代码：</label>
				<form:input path="issueOrgCode" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			
			<li><label>卡号：</label>
				<form:input path="cardNo" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<%-- <li><label>处理时间：</label>
				<form:input path="dealTime" htmlEscape="false" maxlength="14" class="input-medium"/>
			</li>
			<li><label>入库时间：</label>
				<form:input path="indbTime" htmlEscape="false" maxlength="14" class="input-medium"/>
			</li> --%>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>发送日期</th>
				<th>发送机构代码</th>
				<th>文件名称</th>
				<th>发卡机构代码</th>
				<th>卡号</th>
				<th>处理时间</th>
				<th>入库时间</th>
				<th>备注</th>
				<shiro:hasPermission name="settlementfront:bpsUcConf:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bpsUcConf">
			<tr>
				<td><a href="${ctx}/settlementfront/bpsUcConf/form?id=${bpsUcConf.id}">
					${bpsUcConf.sendDate}
				</a></td>
				<td>
					${bpsUcConf.sendOrgCode}
				</td>
				<td>
					${bpsUcConf.fileName}
				</td>
				<td>
					${bpsUcConf.issueOrgCode}
				</td>
				<td>
					${bpsUcConf.cardNo}
				</td>
				<td>
					${bpsUcConf.dealTime}
				</td>
				<td>
					${bpsUcConf.indbTime}
				</td>
				<td>
					${bpsUcConf.remarks}
				</td>
				<shiro:hasPermission name="settlementfront:bpsUcConf:edit"><td>
    				<a href="${ctx}/settlementfront/bpsUcConf/form?id=${bpsUcConf.id}">修改</a>
					<a href="${ctx}/settlementfront/bpsUcConf/delete?id=${bpsUcConf.id}" onclick="return confirmx('确认要删除该UC上发黑名单配置文件吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>