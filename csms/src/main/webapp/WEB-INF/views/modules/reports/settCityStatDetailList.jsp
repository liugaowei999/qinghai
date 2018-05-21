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
						$("#searchForm").attr("action","${ctx}/reports/settCityStatDetail/export");
						$("#searchForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
			$("#btnSubmit").click(function(){
				$("#searchForm").attr("action","${ctx}/reports/settCityStatDetail/list");
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
		<li class="active"><a href="${ctx}/reports/settCityStatDetail/">记录列表</a></li>
		<c:if test="${dataScope=='2'}"><li><a href="${ctx}/reports/settCityStatDetail/settCityStatDetailProvReport">图表展示</a></li></c:if>
		<c:if test="${dataScope=='4'}"><li><a href="${ctx}/reports/settCityStatDetail/settCityStatDetailCityReport">图表展示</a></li></c:if>
		
	</ul>
	
	<form:form id="searchForm" modelAttribute="settCityStatDetail" action="${ctx}/reports/settCityStatDetail/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li><label>结算日期：</label>
				<input id="beginSettDate" name="beginSettDate" type="text" readonly="readonly" maxlength="8" class="input-medium Wdate"
					value="${settCityStatDetail.beginSettDate}"
					onclick="WdatePicker({dateFmt:'yyyyMMdd',maxDate:'#F{$dp.$D(\'endSettDate\')}',isShowClear:true});"/> 至 
				<input id="endSettDate" name="endSettDate" type="text" readonly="readonly" maxlength="8" class="input-medium Wdate"
					value="${settCityStatDetail.endSettDate}"
					onclick="WdatePicker({dateFmt:'yyyyMMdd',minDate:'#F{$dp.$D(\'beginSettDate\')}',isShowClear:true});"/>
			</li>
			<c:if test="${dataScope=='2'}"><li><label>结算对象：</label>
				<sys:treeselect id="company" name="company.id" value="${settCityStatDetail.company.id}" labelName="company.name" labelValue="${settCityStatDetail.company.name}"
					title="部门" url="/sys/office/treeData?type=1" cssClass="input-small" allowClear="true" notAllowSelectParent="false"/>
			</li>
			</c:if>
			<li><label>结算方向：</label>
				<form:select path="settDirection" class="input-medium">
					<form:option value="" label="全部"/>
					<form:options items="${fns:getDictList('sett_direction')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>角色：</label>
				<form:select path="roleType" class="input-medium">
					<form:option value="" label="全部"/>
					<form:options items="${fns:getDictList('sett_role_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>发卡机构：</label>
				<select name="issueOrgName" class="input-medium">
					<option value="" label="全部"/>
					<c:forEach items="${issueOrgNameList}" var="issue" >
						<option value="${issue}">${issue}</option> 
					</c:forEach>
				</select>
			</li>
			<c:if test="${dataScope=='2'}"><li><label>收单机构：</label>
				<select name="billOrgName" class="input-medium">
					<option value="" label="全部"/>
					<c:forEach items="${billOrgNameList}" var="bill" >
						<option value="${bill}">${bill}</option> 
					</c:forEach>
				</select>
			</li> 
			</c:if>
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
				<th>结算对象</th>
				<th>结算方向</th> 
				<th>角色</th>
				<th>发卡机构</th>
				<th>实际发卡机构</th>
				<th>收单机构</th>
				<th>交易金额(元)</th>
				<th>手续费(元)</th>
				<th>发卡分润(元)</th>
				<th>收单分润(元)</th>
				<th>清算中心分润(元)</th>
				<th>结算费用(元)</th>
				<th>次数</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="settCityStatDetail">
			<tr>
				<td>
					${settCityStatDetail.settDate}
				</td>
				<td>
					${settCityStatDetail.company.name}
				</td>
				<td>
					${fns:getDictLabel(settCityStatDetail.settDirection, 'sett_direction', '')}
				</td>
				<td>
					${fns:getDictLabel(settCityStatDetail.roleType, 'sett_role_type', '')}
				</td> 
				<td>
					${settCityStatDetail.issueOrgName}
				</td>
				<td>
					${settProvStatDetail.actualiIssueName}
				</td>
				<td>
					${settCityStatDetail.billOrgName}
				</td>
				<td>
					${settCityStatDetail.tradeCharge}
				</td>
				<td>
					${settCityStatDetail.serviceFee}
				</td>
				<td>
					${settCityStatDetail.issueCharge}
				</td>
				<td>
					${settCityStatDetail.billCharge}
				</td>
				<td>
					${settCityStatDetail.centerCharge}
				</td>
				<td>
					${settCityStatDetail.settCharge}
				</td>
				<td>
					${settCityStatDetail.times}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>