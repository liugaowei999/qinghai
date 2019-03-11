<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>BN白名单管理</title>
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
		<li class="active"><a href="${ctx}/settlementfront/bpsBnConf/">BN白名单列表</a></li>
		<shiro:hasPermission name="settlementfront:bpsBnConf:edit"><li><a href="${ctx}/settlementfront/bpsBnConf/form">BN白名单添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="bpsBnConf" action="${ctx}/settlementfront/bpsBnConf/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>下发日期：</label>
				<%-- <form:input path="downDate" htmlEscape="false" maxlength="8" class="input-medium"/> --%>
				<form:input path="downDate" id="downDate" htmlEscape="false"  readonly="readonly" maxlength="8" class="input-medium Wdate"
					 onclick="WdatePicker({dateFmt:'yyyyMMdd',maxDate:'%y%M%d',isShowClear:true});" value="${bpsBnConf.downDate}"/>
			</li>

			<li><label>卡BIN：</label>
				<form:input path="cardBinNo" htmlEscape="false" maxlength="10" class="input-medium"/>
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
				<th>卡BIN</th>
				<th>处理时间</th>
				<th>入库时间</th>
				<th>备注</th>
				<shiro:hasPermission name="settlementfront:bpsBnConf:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bpsBnConf">
			<tr>
				<td><a href="${ctx}/settlementfront/bpsBnConf/form?id=${bpsBnConf.id}">
					${bpsBnConf.downDate}
				</a></td>
				<td>
					${bpsBnConf.fileName}
				</td>
				<td>
					${bpsBnConf.company.name}
				</td>
				<td>
					${bpsBnConf.cardBinNo}
				</td>
				<td>
					${bpsBnConf.dealTime}
				</td>
				<td>
					${bpsBnConf.indbTime}
				</td>
				<td>
					${bpsBnConf.remarks}
				</td>
				<shiro:hasPermission name="settlementfront:bpsBnConf:edit"><td>
    				<a href="${ctx}/settlementfront/bpsBnConf/form?id=${bpsBnConf.id}">修改</a>
					<a href="${ctx}/settlementfront/bpsBnConf/delete?id=${bpsBnConf.id}" onclick="return confirmx('确认要删除该BN白名单吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>