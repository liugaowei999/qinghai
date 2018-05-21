<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>前台出账管理</title>
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
		
		function executeProc(id, moduleId){
			var month = document.getElementById(id).value;
			if(month != null && month != ""){
				$.post("${ctx}/settlementfront/settProcStat/executeProc?module_id="+moduleId+"&month="+month, function(data){
					$.jBox.tip("完成！");
				});
			}else{
				$.jBox.tip("   请输入结算日期!    ");
			}
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/settlementfront/settProcStat/">前台出账列表</a></li>
		<shiro:hasPermission name="settlementfront:settProcStat:edit"><li><a href="${ctx}/settlementfront/settProcStat/form">前台出账添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="settProcStat" action="${ctx}/settlementfront/settProcStat/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li><label>模块编码：</label><form:input path="moduleCode" htmlEscape="false" maxlength="50" class="input-medium"/></li>
			<li><label>模块名称：</label><form:input path="moduleName" htmlEscape="false" maxlength="50" class="input-medium"/></li>
			<li><label>程序名称：</label><form:input path="programName" htmlEscape="false" maxlength="50" class="input-medium"/></li>
			<li class="btns">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>模块标识</th>
				<th>模块编码</th>
				<th>模块名称</th>
				<th>程序名称</th>
				<th>结算日期</th>
				<th>操作</th>
				<!--  <th>开始时间</th>
				<th>结束时间</th>
				<th>进程状态</th>
				<th>备注</th>-->
				<shiro:hasPermission name="settlementfront:settProcStat:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="settProcStat">
			<tr>
				<td>${settProcStat.bpsSysModule.moduleId}</td>
				<td>${settProcStat.bpsSysModule.moduleCode}</td>
				<td>${settProcStat.bpsSysModule.moduleName}</td>
				<td id="note" name="note">${settProcStat.bpsSysModule.note}</td>
				<td>
					<input id="settDate${settProcStat.bpsSysModule.moduleId}" name="settDate" type="text" readonly="readonly" maxlength="6" class="input-medium Wdate"
						value="${settProcStat.settDate}"
						onclick="WdatePicker({dateFmt:'yyyyMM',date:'#F{$dp.$D(\'settDate\')}',isShowClear:true});"/>
				</td>
				<td>
   					<a onclick='executeProc("settDate${settProcStat.bpsSysModule.moduleId}", ${settProcStat.bpsSysModule.moduleId})'>执行</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>