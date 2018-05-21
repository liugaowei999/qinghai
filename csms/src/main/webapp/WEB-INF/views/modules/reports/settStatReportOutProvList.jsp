<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>记录管理</title>
	<meta name="decorator" content="default"/>
	<link href="${ctxStatic}/bootstrap/3.1.1/css/bootstrap.css" rel="stylesheet" />
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
				$("#searchForm").attr("action","${ctx}/reports/settStatReport/settStatReportOutProvList");
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
		<li class="active"><a href="${ctx}/reports/settStatReport/settStatReportOutProvList">记录列表</a></li>
		<li><a href="${ctx}/reports/settStatReport/settStatReportOutProvChart">图表展示</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="settStatReport" action="${ctx}/reports/settStatReport/settStatReportOutProvList" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="settType" name="settType" type="hidden" value="01"/>
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
				<th>收入金额(元)</th>
				<th>支出金额(元)</th>
				<th>轧差(元)</th>
				<th>结算说明</th>
				
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
				
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>