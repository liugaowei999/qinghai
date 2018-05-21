<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>DC下发黑名单管理</title>
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
		<li class="active"><a href="${ctx}/settlementfront/bpsDcConf/">DC下发黑名单列表</a></li>
		<shiro:hasPermission name="settlementfront:bpsDcConf:edit"><li><a href="${ctx}/settlementfront/bpsDcConf/form">DC下发黑名单添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="bpsDcConf" action="${ctx}/settlementfront/bpsDcConf/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>下发日期：</label>
				<%-- <form:input path="downDate" htmlEscape="false" maxlength="8" class="input-medium"/> --%>
				<form:input path="downDate" id="downDate" htmlEscape="false"  readonly="readonly" maxlength="8" class="input-medium Wdate"
					 onclick="WdatePicker({dateFmt:'yyyyMMdd',maxDate:'%y%M%d',isShowClear:true});" value="${bpsDcConf.downDate}"/>
			</li>
			<li><label>文件名称：</label>
				<form:input path="fileName" htmlEscape="false" maxlength="128" class="input-medium"/>
			</li>
			<li><label>发卡机构：</label>
				<%-- <form:input path="issueOrgCode" htmlEscape="false" maxlength="11" class="input-medium"/> --%>
				<sys:treeselect id="company" name="company.id" value="${bpsDcConf.company.id}" labelName="company.name" labelValue="${bpsDcConf.company.name}"
					title="部门" url="/sys/office/treeData?type=1" cssClass="input-small" allowClear="true" notAllowSelectParent="false"/>
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
				<th>下发日期</th>
				<th>文件名称</th>
				<th>发卡机构代码</th>
				<th>卡号</th>
				<th>处理时间</th>
				<th>入库时间</th>
				<th>备注</th>
				<shiro:hasPermission name="settlementfront:bpsDcConf:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bpsDcConf">
			<tr>
				<td><a href="${ctx}/settlementfront/bpsDcConf/form?id=${bpsDcConf.id}">
					${bpsDcConf.downDate}
				</a></td>
				<td>
					${bpsDcConf.fileName}
				</td>
				<td>
					${bpsDcConf.issueOrgCode}
				</td>
				<td>
					${bpsDcConf.cardNo}
				</td>
				<td>
					${bpsDcConf.dealTime}
				</td>
				<td>
					${bpsDcConf.indbTime}
				</td>
				<td>
					${bpsDcConf.remarks}
				</td>
				<shiro:hasPermission name="settlementfront:bpsDcConf:edit"><td>
    				<a href="${ctx}/settlementfront/bpsDcConf/form?id=${bpsDcConf.id}">修改</a>
					<a href="${ctx}/settlementfront/bpsDcConf/delete?id=${bpsDcConf.id}" onclick="return confirmx('确认要删除该DC下发黑名单吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>