<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>跨省月结算报表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出报表吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#searchForm").attr("action","${ctx}/newreports/settProvStat/export");
						$("#searchForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});			
			
			$("#btnSubmit").click(function(){
				$("#searchForm").attr("action","${ctx}/newreports/settProvStat/list");
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
		<li class="active"><a href="${ctx}/newreports/settProvStat/settProvStatList">跨省月结算列表</a></li>
		<li><a href="${ctx}/newreports/settProvStat/settProvStatChart">图表展示</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="settProvStat" action="${ctx}/newreports/settProvStat/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li><label>结算账期：</label>
				<input name="settCycle" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="${settProvStat.settCycle}" onclick="WdatePicker({dateFmt:'yyyyMM',isShowClear:true});"/>
			</li>
			<li><label>结算对象：</label>
				<select name="settObject" class="input-medium">
					<option value="">全部</option>
					<c:forEach items="${settObjectList}" var="settObject" >
						<c:choose>
							<c:when test="${settObject ==settProvStat.settObject}" >
								<option selected="selected" value="${settObject}">${settObject}</option> 
							</c:when>
							<c:otherwise>
								<option value="${settObject}">${settObject}</option> 
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select>
				
			</li>
			<li class="btns">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
				<input id="btnExport" class="btn btn-primary" type="button" value="导出"/>
			</li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>结算账期</th>
				<th>结算对象</th>
				<th>收入金额(元)</th>
				<th>支出金额(元)</th>
				<th>结算金额(元)</th>
				
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="settProvStat">
			<tr>
				<td>
					${settProvStat.settCycle}
				</td>
				<td>
					${settProvStat.settObject}
				</td>
				<td>
					${settProvStat.incomeCharge}
				</td>
				<td>
					${settProvStat.outcomeCharge}
				</td>
				<td>
					${settProvStat.settCharge}
				</td>
				
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>