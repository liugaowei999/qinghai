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
						$("#searchForm").attr("action","${ctx}/reports/settProvStatDetail/export");
						$("#searchForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
			$("#btnSubmit").click(function(){
				$("#searchForm").attr("action","${ctx}/reports/settProvStatDetail/list");
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
		<li class="active"><a href="${ctx}/reports/settProvStatDetail/">记录列表</a></li>
		<li><a href="${ctx}/reports/settProvStatDetail/settProvStatDetailProvReport">图表展示</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="settProvStatDetail" action="${ctx}/reports/settProvStatDetail/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li><label>结算日期：</label>
				<input id="beginSettDate" name="beginSettDate" type="text" readonly="readonly" maxlength="8" class="input-medium Wdate"
					value="${settProvStatDetail.beginSettDate}"
					onclick="WdatePicker({dateFmt:'yyyyMMdd',maxDate:'#F{$dp.$D(\'endSettDate\')}',isShowClear:true});"/> 至 
				<input id="endSettDate" name="endSettDate" type="text" readonly="readonly" maxlength="8" class="input-medium Wdate"
					value="${settProvStatDetail.endSettDate}"
					onclick="WdatePicker({dateFmt:'yyyyMMdd',minDate:'#F{$dp.$D(\'beginSettDate\')}',isShowClear:true});"/>
			</li>
			<%-- <li><label>结算对象：</label>
				<sys:treeselect id="company" name="company.id" value="${settProvStatDetail.company.id}" labelName="company.name" labelValue="${settProvStatDetail.company.name}"
					title="部门" url="/sys/office/treeData?type=1" cssClass="input-small" allowClear="true" notAllowSelectParent="false"/>
			</li> --%>
			<li><label>角色：</label>
				<form:select path="roleType" class="input-medium">
					<form:option value="" label="全部"/>
					<form:options items="${fns:getDictList('sett_role_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="clearfix"></li>
			<li><label>发卡机构：</label>
				<select name="issueOrgName" class="input-medium">
					<option value="" label="全部"/>
					<c:forEach items="${issueOrgNameList}" var="issue" >
						<option value="${issue}">${issue}</option> 
					</c:forEach>
				</select>
			</li>
			<li><label>收单机构：</label>
				<select name="billOrgName" class="input-medium">
					<option value="" label="全部"/>
					<c:forEach items="${billOrgNameList}" var="bill" >
						<option value="${bill}">${bill}</option> 
					</c:forEach>
				</select>
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
				<th>结算对象</th>
				<th>结算方向</th>
				<th>角色</th>
				<th>发卡机构</th>
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
		<c:forEach items="${page.list}" var="settProvStatDetail">
			<tr>
				<td> 
					${settProvStatDetail.settDate}
				</td>
				<td>
					${settProvStatDetail.company.name}
				</td>
				<td>
					${fns:getDictLabel(settProvStatDetail.settDirection, 'sett_direction', '')}
				</td>
				<td>
					${fns:getDictLabel(settProvStatDetail.roleType, 'sett_role_type', '')}
				</td>
				<td>
					${settProvStatDetail.issueOrgName}
				</td>
				<td>
					${settProvStatDetail.billOrgName}
				</td>
				<td>
					${settProvStatDetail.tradeCharge}
				</td>
				<td>
					${settProvStatDetail.serviceFee}
				</td>
				<td>
					${settProvStatDetail.issueCharge}
				</td>
				<td>
					${settProvStatDetail.billCharge}
				</td>
				<td>
					${settProvStatDetail.centerCharge}
				</td>
				<td>
					${settProvStatDetail.settCharge}
				</td>
				<td>
					${settProvStatDetail.times}
				</td>
				
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>