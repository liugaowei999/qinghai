<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>记录管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出报表吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#searchForm").attr("action","${ctx}/reports/settStatReport/export");
						$("#searchForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
			$("#btnSubmit").click(function(){
				$("#searchForm").attr("action","${ctx}/reports/settStatReport/list");
				$("#searchForm").submit();
			});
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
		<li class="active"><a href="${ctx}/reports/settStatReport/">记录列表</a></li>
		<%-- <shiro:hasPermission name="reports:settStatReport:edit"><li><a href="${ctx}/reports/settStatReport/form">记录添加</a></li></shiro:hasPermission> --%>
	</ul>
	<form:form id="searchForm" modelAttribute="settStatReport" action="${ctx}/reports/settStatReport/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li><label>结算日期：</label>
				<input id="beginSettDate" name="beginSettDate" type="text" readonly="readonly" maxlength="8" class="input-medium Wdate"
					value="${settStatReport.beginSettDate}"
					onclick="WdatePicker({dateFmt:'yyyyMMdd',maxDate:'#F{$dp.$D(\'endSettDate\')}',isShowClear:true});"/> 至 
				<input id="endSettDate" name="endSettDate" type="text" readonly="readonly" maxlength="8" class="input-medium Wdate"
					value="${settStatReport.endSettDate}"
					onclick="WdatePicker({dateFmt:'yyyyMMdd',minDate:'#F{$dp.$D(\'beginSettDate\')}',isShowClear:true});"/>
			</li>
			<li><label>结算类型：</label>
				<form:select path="settType" class="input-medium">
					<form:option value="" label="全部"/>
					<form:options items="${fns:getDictList('sett_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>机构名称：</label>
				<sys:treeselect id="company" name="company.id" value="${settStatReport.company.id}" labelName="company.name" labelValue="${settStatReport.company.name}"
					title="部门" url="/sys/office/treeData?type=1" cssClass="input-small" allowClear="true" notAllowSelectParent="false"/>
			</li>
			<li class="btns">
				<input id="btnSubmit" class="btn btn-primary" type="button" value="查询"/>
				<input id="btnExport" class="btn btn-primary" type="button" value="导出"/>
			</li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>结算日期</th>
				<th>结算类型</th>
				<th>机构代码</th>
				<th>机构名称</th>
				<th>收入金额(分)</th>
				<th>支出金额(分)</th>
				<th>轧差(分)</th>
				<th>结算说明</th>
				<%-- <shiro:hasPermission name="reports:settStatReport:edit"><th>操作</th></shiro:hasPermission> --%>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="settStatReport">
			<tr>
				<td>
					${settStatReport.settDate}
				</td>
				<td>
					${fns:getDictLabel(settStatReport.settType, 'sett_type', settStatReport.settType)}
				</td>
				<td>
					${settStatReport.orgCode}
				</td>
				<td>
					${settStatReport.orgName}
				</td>
				<td>
					${settStatReport.incomeCharge}
				</td>
				<td>
					${settStatReport.outcomeCharge}
				</td>
				<td>
					${settStatReport.offsetBalance}
				</td>
				<td>
					${settStatReport.note}
				</td>
				<shiro:hasPermission name="reports:settStatReport:edit"><td>
    				<a href="${ctx}/reports/settStatReport/form?id=${settStatReport.id}">修改</a>
					<a href="${ctx}/reports/settStatReport/delete?id=${settStatReport.id}" onclick="return confirmx('确认要删除该记录吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>