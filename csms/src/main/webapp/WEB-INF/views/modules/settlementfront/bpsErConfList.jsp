<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>ER错误代码下发配置文件管理</title>
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
		<li class="active"><a href="${ctx}/settlementfront/bpsErConf/">ER错误代码下发配置文件列表</a></li>
		<shiro:hasPermission name="settlementfront:bpsErConf:edit"><li><a href="${ctx}/settlementfront/bpsErConf/form">ER错误代码下发配置文件添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="bpsErConf" action="${ctx}/settlementfront/bpsErConf/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>下发日期：</label>
				<form:input path="downDate" id="downDate" htmlEscape="false"  readonly="readonly" maxlength="8" class="input-medium Wdate"
					 onclick="WdatePicker({dateFmt:'yyyyMMdd',maxDate:'%y%M%d',isShowClear:true});" value="${bpsErConf.downDate}"/>
			</li>
			<li><label>文件名称：</label>
				<form:input path="fileName" htmlEscape="false" maxlength="128" class="input-medium"/>
			</li>
			<li><label>错误代码：</label>
				<form:input path="errCode" htmlEscape="false" maxlength="6" class="input-medium"/>
			</li>
			<%--<li><label>错误代码描述：</label>
				<form:input path="errInfo" htmlEscape="false" maxlength="40" class="input-medium"/>
			</li>
			<li><label>处理时间：</label>
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
				<th>错误代码</th>
				<th>错误代码描述</th>
				<th>处理时间</th>
				<th>入库时间</th>
				<th>备注</th>
				<shiro:hasPermission name="settlementfront:bpsErConf:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bpsErConf">
			<tr>
				<td><a href="${ctx}/settlementfront/bpsErConf/form?id=${bpsErConf.id}">
					${bpsErConf.downDate}
				</a></td>
				<td>
					${bpsErConf.fileName}
				</td>
				<td>
					${bpsErConf.errCode}
				</td>
				<td>
					${bpsErConf.errInfo}
				</td>
				<td>
					${bpsErConf.dealTime}
				</td>
				<td>
					${bpsErConf.indbTime}
				</td>
				<td>
					${bpsErConf.remarks}
				</td>
				<shiro:hasPermission name="settlementfront:bpsErConf:edit"><td>
    				<a href="${ctx}/settlementfront/bpsErConf/form?id=${bpsErConf.id}">修改</a>
					<a href="${ctx}/settlementfront/bpsErConf/delete?id=${bpsErConf.id}" onclick="return confirmx('确认要删除该ER错误代码下发配置文件吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>