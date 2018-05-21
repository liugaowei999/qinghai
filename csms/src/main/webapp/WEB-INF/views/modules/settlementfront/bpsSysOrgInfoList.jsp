<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>入网机构配置管理</title>
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
		<li class="active"><a href="${ctx}/settlementfront/bpsSysOrgInfo/">入网机构配置列表</a></li>
		<shiro:hasPermission name="settlementfront:bpsSysOrgInfo:edit"><li><a href="${ctx}/settlementfront/bpsSysOrgInfo/form">入网机构配置添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="bpsSysOrgInfo" action="${ctx}/settlementfront/bpsSysOrgInfo/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>入网机构：</label><form:select path="id" class="input-medium">
					<form:option value="" label="请选择" />
					<form:options items="${orgInfoDropDownMap}" htmlEscape="false" />
				</form:select>
			</li>
			<li>&nbsp;&nbsp;&nbsp;&nbsp;<label>地域标识：</label><form:select path="areaType" class="input-medium">
					<form:option value="" label="请选择" />
					<form:options items="${fns:getDictList('area_type')}" itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
			</li>
			<li>&nbsp;&nbsp;&nbsp;&nbsp;<label>所在城市：</label>
					<sys:treeselect id="cityCode" name="cityCode" value="${area.id}" labelName="area.name" labelValue="${area.name}"  
				title="区域" url="/sys/area/treeData" cssClass="input-medium" allowClear="true"/>
			</li>
			<li class="clearfix"></li>
			<li>
				<label>生效日期：</label><input id="effDate" name="effDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value='${bpsSysOrgInfo.effDate}' pattern='yyyy-MM-dd HH:mm:ss'/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false,maxDate:'#F{$dp.$D(\'expDate\')}'});"/>
			</li>
			<li>
				<label>失效日期：</label><input id="expDate" name="expDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value='${bpsSysOrgInfo.expDate}' pattern='yyyy-MM-dd HH:mm:ss'/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false,minDate:'#F{$dp.$D(\'effDate\')}'});"/>
			</li>
			<li class="btns">&nbsp;&nbsp;&nbsp;&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>入网机构代码</th>
				<th>入网机构名称</th>
				<th>地域标识</th>
				<th>所在城市</th>
				<th>生效日期</th>
				<th>失效日期</th>
				<th>备注</th>
				
				<shiro:hasPermission name="settlementfront:bpsSysOrgInfo:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bpsSysOrgInfo">
			<tr>
				<td>${bpsSysOrgInfo.orgCode}</td>
				<td>${bpsSysOrgInfo.orgName}</td>
				<td>${fns:getDictLabel(bpsSysOrgInfo.areaType,'area_type','无')}</td>
				<td>${bpsSysOrgInfo.cityName}</td>
				<td><fmt:formatDate value="${bpsSysOrgInfo.effDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td><fmt:formatDate value="${bpsSysOrgInfo.expDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				
				<td>${bpsSysOrgInfo.remark}</td>
				
				<shiro:hasPermission name="settlementfront:bpsSysOrgInfo:edit"><td>
    				<a href="${ctx}/settlementfront/bpsSysOrgInfo/form?id=${bpsSysOrgInfo.id}">修改</a>
					<a href="${ctx}/settlementfront/bpsSysOrgInfo/delete?id=${bpsSysOrgInfo.id}" onclick="return confirmx('确认要删除该入网机构配置吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>