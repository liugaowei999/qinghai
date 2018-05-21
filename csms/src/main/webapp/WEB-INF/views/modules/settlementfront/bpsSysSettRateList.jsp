<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>清算费率管理</title>
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
		<li class="active"><a href="${ctx}/settlementfront/bpsSysSettRate/">清算费率列表</a></li>
		<shiro:hasPermission name="settlementfront:bpsSysSettRate:edit"><li><a href="${ctx}/settlementfront/bpsSysSettRate/form">清算费率添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="bpsSysSettRate" action="${ctx}/settlementfront/bpsSysSettRate/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>行业类型：</label>
				<form:select path="businessType" class="input-medium">
					<form:option value="" label="请选择" />
					<form:options items="${businessTypeDropDownMap}" htmlEscape="false" />
				</form:select>
			</li>
			<li><label>业务类型：</label>
				<form:select path="serviceType" class="input-medium">
					<form:option value="" label="请选择" />
					<form:options items="${serviceTypeDropDownMap}" htmlEscape="false" />
				</form:select>
			</li>
			<li>&nbsp;&nbsp;&nbsp;&nbsp;<label>收单机构：</label>
					<form:select path="recvOrgCode" class="input-medium">
					<form:option value="" label="请选择" />
					<form:options items="${orgNameDropDownMap}" htmlEscape="false" />
				</form:select>
			</li>
			<li class="clearfix"></li>
			<li><label>发卡机构：</label>
					<form:select path="issueOrgCode" class="input-medium">
					<form:option value="" label="请选择" />
					<form:options items="${orgNameDropDownMap}" htmlEscape="false" />
				</form:select>
			</li>
			<li>
				<label>生效日期：</label><input id="effDate" name="effDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value='${bpsSysOrgInfo.effDate}' pattern='yyyy-MM-dd HH:mm:ss'/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false,maxDate:'#F{$dp.$D(\'expDate\')}'});"/>
			</li>
			<li>
				&nbsp;<label>失效日期：</label><input id="expDate" name="expDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value='${bpsSysOrgInfo.expDate}' pattern='yyyy-MM-dd HH:mm:ss'/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false,minDate:'#F{$dp.$D(\'effDate\')}'});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>行业类型</th>
				<th>业务类型</th>
				<th>收单机构</th>
				<th>发卡机构</th>
				<th>手续费费率</th>
				<th>收单机构分成比例</th>
				<th>发卡机构分成比例</th>
				<th>生效日期</th>
				<th>失效日期</th>
				<th>备注</th>
				<shiro:hasPermission name="settlementfront:bpsSysSettRate:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bpsSysSettRate">
			<tr>
				<td>${bpsSysSettRate.businessName}</td>
				<td>${bpsSysSettRate.serviceName}</td>
				<td>${bpsSysSettRate.recvOrgName}</td>
				<td>${bpsSysSettRate.issueOrgName}</td>
				<td>${bpsSysSettRate.chargeRate}</td>
				<td>${bpsSysSettRate.recvRate}</td>
				<td>${bpsSysSettRate.issueRate}</td>
				<td><fmt:formatDate value="${bpsSysSettRate.effDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td><fmt:formatDate value="${bpsSysSettRate.expDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td>${bpsSysSettRate.remark}</td>

				<shiro:hasPermission name="settlementfront:bpsSysSettRate:edit"><td>
    				<a href="${ctx}/settlementfront/bpsSysSettRate/form?id=${bpsSysSettRate.id}">修改</a>
					<a href="${ctx}/settlementfront/bpsSysSettRate/delete?id=${bpsSysSettRate.id}" onclick="return confirmx('确认要删除该清算费率吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>