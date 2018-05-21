<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>跨省结算详单展示</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出报表吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#searchForm").attr("action","${ctx}/newreports/settProvDetail/export");
						$("#searchForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});			
			
			$("#btnSubmit").click(function(){
				$("#searchForm").attr("action","${ctx}/newreports/settProvDetail/list");
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
		<li class="active"><a href="${ctx}/newreports/settProvDetail/settProvDetailList/">跨省结算详单列表</a></li>
		</ul>
	<form:form id="searchForm" modelAttribute="settProvDetail" action="${ctx}/newreports/settProvDetail/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li><label>结算日期：</label>
				<input id="beginSettDate" name="beginSettDate" type="text" readonly="readonly" maxlength="8" class="input-medium Wdate"
					value="${settProvDetail.beginSettDate}"
					onclick="WdatePicker({dateFmt:'yyyyMMdd',maxDate:'#F{$dp.$D(\'endSettDate\')}',isShowClear:true});"/> 至 
				<input id="endSettDate" name="endSettDate" type="text" readonly="readonly" maxlength="8" class="input-medium Wdate"
					value="${settProvDetail.endSettDate}"
					onclick="WdatePicker({dateFmt:'yyyyMMdd',minDate:'#F{$dp.$D(\'beginSettDate\')}',isShowClear:true});"/>
			</li>
			<li><label>发卡机构：</label>
				<select name="issueOrgName" class="input-medium">
					<option value="">全部</option>
					<c:forEach items="${issueOrgNameList}" var="issueOrgName" >
						<c:choose>
							<c:when test="${issueOrgName ==settProvDetail.issueOrgName}" >
								<option selected="selected" value="${issueOrgName}">${issueOrgName}</option> 
							</c:when>
							<c:otherwise>
								<option value="${issueOrgName}">${issueOrgName}</option> 
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select>
			</li>
			<li><label>收单机构：</label>
				<select name="billOrgName" class="input-medium">
					<option value="">全部</option>
					<c:forEach items="${billOrgNameList}" var="billOrgName" >
						<c:choose>
							<c:when test="${billOrgName ==settProvDetail.billOrgName}" >
								<option selected="selected" value="${billOrgName}">${billOrgName}</option> 
							</c:when>
							<c:otherwise>
								<option value="${billOrgName}">${billOrgName}</option> 
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
				<th>交易类型</th>
				<th>发卡机构名称</th>
				<th>收单机构名称</th>
				<th>卡号</th>
				<th>消费前金额(元)</th>
				<th>消费金额(元)</th>
				<th>消费日期</th>
				<th>消费时间</th>
				<th>手续费</th>
				<th>发卡分润(元)</th>
				<th>收单分润(元)</th>
				<th>清算中心分润(元)</th>
				<th>结算金额(元)</th>
				<shiro:hasPermission name="newreports:settProvDetail:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="settProvDetail">
			<tr>
				<td>
					${settProvDetail.settDate}
				</td>
				<td>
					${settProvDetail.tradeType}
				</td>
				<td>
					<c:choose><c:when test="${settProvDetail.issueOrgName==NULL}">${settProvDetail.issueOrgCode}</c:when>
					<c:otherwise>${settProvDetail.issueOrgName}</c:otherwise></c:choose>
				</td>
				<td>
					<c:choose><c:when test="${settProvDetail.billOrgName==NULL}">${settProvDetail.billOrgCode}</c:when>
					<c:otherwise>${settProvDetail.billOrgName}</c:otherwise></c:choose>
				</td>
				<td>
					${settProvDetail.cardNo}
				</td>
				<td>
					${settProvDetail.beforeTradeCharge}
				</td>
				<td>
					${settProvDetail.tradeCharge}
				</td>
				<td>
					${settProvDetail.tradeDate}
				</td>
				<td>
					${settProvDetail.tradeTime}
				</td>
				<td>
					${settProvDetail.serviceCharge}
				</td>
				<td>
					${settProvDetail.issueCharge}
				</td>
				<td>
					${settProvDetail.billCharge}
				</td>
				<td>
					${settProvDetail.centerCharge}
				</td>
				<td>
					${settProvDetail.settCharge}
				</td>
				
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>