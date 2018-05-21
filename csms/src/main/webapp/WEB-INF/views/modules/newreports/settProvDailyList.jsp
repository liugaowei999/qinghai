<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>跨省日统计报表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出报表吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#searchForm").attr("action","${ctx}/newreports/settProvDaily/export");
						$("#searchForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});			
			
			$("#btnSubmit").click(function(){
				$("#searchForm").attr("action","${ctx}/newreports/settProvDaily/list");
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
		<li class="active"><a href="${ctx}/newreports/settProvDaily/settProvDailyList">跨省日统计报表</a></li>
		<li><a href="${ctx}/newreports/settProvDaily/settProvDailyChart">图表展示</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="settProvDaily" action="${ctx}/newreports/settProvDaily/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li><label>结算日期：</label>
				<input id="beginSettDate" name="beginSettDate" type="text" readonly="readonly" maxlength="8" class="input-medium Wdate"
					value="${settProvDaily.beginSettDate}"
					onclick="WdatePicker({dateFmt:'yyyyMMdd',maxDate:'#F{$dp.$D(\'endSettDate\')}',isShowClear:true});"/> 至 
				<input id="endSettDate" name="endSettDate" type="text" readonly="readonly" maxlength="8" class="input-medium Wdate"
					value="${settProvDaily.endSettDate}"
					onclick="WdatePicker({dateFmt:'yyyyMMdd',minDate:'#F{$dp.$D(\'beginSettDate\')}',isShowClear:true});"/>
			</li>
			<li><label>结算对象：</label>
				<select name="settObject" class="input-medium">
					<option value="">全部</option>
					<c:forEach items="${settObjectList}" var="settObject" >
						<c:choose>
							<c:when test="${settObject ==settProvDaily.settObject}" >
								<option selected="selected" value="${settObject}">${settObject}</option> 
							</c:when>
							<c:otherwise>
								<option value="${settObject}">${settObject}</option> 
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select>
				
			</li>
			<li><label>结算角色：</label>
				<select name="settRole" class="input-medium">
					<option value="">全部</option>
					<c:forEach items="${settRoleList}" var="settRole" >
						<c:choose>
							<c:when test="${settRole ==settProvDaily.settRole}" >
								<option selected="selected" value="${settRole}">${settRole}</option> 
							</c:when>
							<c:otherwise>
								<option value="${settRole}">${settRole}</option> 
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
				<th>结算日期</th>
				<th>结算对象</th>
				<th>结算角色</th>
				<th>消费总额(元)</th>
				<th>手续费(元)</th>
				<th>发卡分润(元)</th>
				<th>收单分润(元)</th>
				<th>清算中心分润(元)</th>
				<th>次数</th>
				<th>结算金额(元)</th>
				<shiro:hasPermission name="newreports:settProvDaily:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="settProvDaily">
			<tr>
				<td>
					${settProvDaily.settDate}
				</td>
				<td>
					${settProvDaily.settObject}
				</td>
				<td>
					${settProvDaily.settRole}
				</td>
				<td>
					${settProvDaily.tradeCharge}
				</td>
				<td>
					${settProvDaily.serviceCharge}
				</td>
				<td>
					${settProvDaily.issueCharge}
				</td>
				<td>
					${settProvDaily.billCharge}
				</td>
				<td>
					${settProvDaily.centerCharge}
				</td>
				<td>
					${settProvDaily.times}
				</td>
				<td>
					${settProvDaily.settCharge}
				</td>
				<shiro:hasPermission name="newreports:settProvDaily:edit"><td>
    				<a href="${ctx}/newreports/settProvDaily/form?id=${settProvDaily.id}">修改</a>
					<a href="${ctx}/newreports/settProvDaily/delete?id=${settProvDaily.id}" onclick="return confirmx('确认要删除该跨省日统计报表吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>