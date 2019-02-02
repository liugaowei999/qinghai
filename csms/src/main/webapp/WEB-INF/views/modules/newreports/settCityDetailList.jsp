<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>省地市-结算详单展示管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出报表吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#searchForm").attr("action","${ctx}/newreports/settCityDetail/export");
						$("#searchForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});			
			
			$("#btnSubmit").click(function(){
				$("#searchForm").attr("action","${ctx}/newreports/settCityDetail/list");
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
		<li class="active"><a href="${ctx}/newreports/settCityDetail/list">省地市-结算详单展示</a></li>
		</ul>
	<form:form id="searchForm" modelAttribute="settCityDetail" action="${ctx}/newreports/settCityDetail/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li><label>结算日期：</label>
				<input id="beginSettDate" name="beginSettDate" type="text" readonly="readonly" maxlength="8" class="input-medium Wdate"
					value="${settCityDetail.beginSettDate}"
					onclick="WdatePicker({dateFmt:'yyyyMMdd',maxDate:'#F{$dp.$D(\'endSettDate\')}',isShowClear:true});"/> 至 
				<input id="endSettDate" name="endSettDate" type="text" readonly="readonly" maxlength="8" class="input-medium Wdate"
					value="${settCityDetail.endSettDate}"
					onclick="WdatePicker({dateFmt:'yyyyMMdd',minDate:'#F{$dp.$D(\'beginSettDate\')}',isShowClear:true});"/>
			</li>
			<li><label>结算对象：</label>
				<select name="settOrgCode" class="input-medium">
					<option value="">全部</option>
					<c:forEach items="${settOrgCodeList}" var="settOrgCode" >
						<c:choose>
							<c:when test="${settOrgCode ==settCityDetail.settOrgCode}" >
								<option selected="selected" value="${settOrgCode}">${settOrgCode}</option> 
							</c:when>
							<c:otherwise>
								<option value="${settOrgCode}">${settOrgCode}</option> 
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select>
			</li>
		</ul>
		<ul class="ul-form">
			<li><label>发卡机构：</label>
				<select name="issueOrgName" class="input-medium">
					<option value="">全部</option>
					<c:forEach items="${issueOrgNameList}" var="issueOrgName" >
						<c:choose>
							<c:when test="${issueOrgName ==settCityDetail.issueOrgName}" >
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
							<c:when test="${billOrgName ==settCityDetail.billOrgName}" >
								<option selected="selected" value="${billOrgName}">${billOrgName}</option> 
							</c:when>
							<c:otherwise>
								<option value="${billOrgName}">${billOrgName}</option> 
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select>
			</li>
			<li>
				<label>漫游类型：</label><form:select path="roamType" class="input-medium">
					<form:option value="" label="请选择" />
					<form:options items="${fns:getDictList('roam_type')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
			</li> 
			<li class="btns">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
				<input id="btnExport" class="btn btn-primary" type="button" value="导出"/>
			</li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed nowrap">
		<thead>
			<tr>
				<th>结算日期</th>
				<th>&nbsp;&nbsp;&nbsp;&nbsp;结算对象&nbsp;&nbsp;&nbsp;&nbsp;</th>
				<th>交易类型</th>
				<th>漫游类型</th>
				<th>发卡机构名称</th>
				<th>收单机构名称</th>
				<th>卡号</th>
				<th>消费前金额(元)</th>
				<th>消费金额(元)</th>
				<th>消费日期</th>
				<th>消费时间</th>
				<th>手续费(元)</th>
				<th>发卡分润(元)</th>
				<th>收单分润(元)</th>
				<th>清算中心分润(元)</th>
				<th>结算金额(元)</th>
				<shiro:hasPermission name="newreports:settCityDetail:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="settCityDetail">
			<tr>
				<td>
 					${settCityDetail.settDate}
				</td> 
				<td>
 					${settCityDetail.settOrgCode}
				</td> 
				<td>
					${settCityDetail.tradeType}
				</td>
				<td  style=" white-space:nowrap">
					${fns:getDictLabel(settCityDetail.roamType, 'roam_type', '')}
				</td>
				<td>
					<c:choose><c:when test="${settCityDetail.issueOrgName==NULL}">${settCityDetail.issueOrgCode}</c:when>
					<c:otherwise>${settCityDetail.issueOrgName}</c:otherwise></c:choose>
				</td>
				<td>
					<c:choose><c:when test="${settCityDetail.billOrgName==NULL}">${settCityDetail.billOrgCode}</c:when>
					<c:otherwise>${settCityDetail.billOrgName}</c:otherwise></c:choose>
				</td>
				<td>
					${settCityDetail.cardNo}
				</td>
				<td>
					${settCityDetail.beforeTradeCharge}
				</td>
				<td>
					${settCityDetail.tradeCharge}
				</td>
				<td>
					${settCityDetail.tradeDate}
				</td>
				<td>
					${settCityDetail.tradeTime}
				</td>
				<td>
					${settCityDetail.serviceCharge}
				</td>
				<td>
					${settCityDetail.issueCharge}
				</td>
				<td>
					${settCityDetail.billCharge}
				</td>
				<td>
					${settCityDetail.centerCharge}
				</td>
				<td>
					${settCityDetail.settCharge}
				</td>
				
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>