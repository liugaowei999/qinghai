<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>记录管理</title>
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
		<li class="active"><a href="${ctx}/cash/settBpDetail/">每日收支明细列表</a></li>
		<shiro:hasPermission name="cash:settBpDetail:edit"><li><a href="${ctx}/cash/settBpDetail/form">记录添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="settBpDetail" action="${ctx}/cash/settBpDetail/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>开始日期：</label>
				<form:input path="beginDate" id="beginDate" htmlEscape="false"  readonly="readonly" maxlength="8" class="input-medium Wdate"
					value="${settBpDetail.beginDate}" onclick="WdatePicker({dateFmt:'yyyyMMdd',maxDate:'%y%M%d',isShowClear:true});"/>
			</li>
			<li><label>结束日期：</label>
				<form:input path="endDate" id="endDate" htmlEscape="false" readonly="readonly" maxlength="8" class="input-medium Wdate"
					value="${settBpDetail.endDate}" onclick="WdatePicker({dateFmt:'yyyyMMdd',maxDate:'%y%M%d',isShowClear:true});"/>
			</li>
			<li>
				<label>接收机构：</label><form:select path="recvOrgCode" class="input-medium">
					<form:option value="" label="请选择" />
					<form:options items="${orgInfoDropDownMap}" htmlEscape="false" />
				</form:select>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>清算日期</th>
				<th>接收机构</th>
				<th>文件名称</th>
				<th>收入总金额(元)</th>
				<th>支出总金额(元)</th>
				<th>测试收入总金额(元)</th>
				<th>测试支出总金额(元)</th>
				<th>账户变动金额(元)</th>
				<th>金额符号位</th>
				<th>处理时间</th>
				<th>入库时间</th>
				<shiro:hasPermission name="cash:settBpDetail:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="settBpDetail">
			<tr>
				<td>
					${settBpDetail.settDate}
				</td>
				<td>
					<c:choose>
						<c:when test="${empty settBpDetail.company.name}">
							${settBpDetail.recvOrgCode}
						</c:when>
						<c:otherwise>
							${settBpDetail.company.name}
						</c:otherwise>
					</c:choose>
				</td>
				<td>
					${settBpDetail.fileName}
				</td>
				<td>
					${settBpDetail.incomeCharge}
				</td>
				<td>
					${settBpDetail.payCharge}
				</td>
				<td>
					${settBpDetail.testIncomeCharge}
				</td>
				<td>
					${settBpDetail.testPayCharge}
				</td>
				<td>
					${settBpDetail.depositChangeCharge}
				</td>
				<td>
					${settBpDetail.chargeSign}
				</td>
				<td>
					${settBpDetail.dealTime}
				</td>
				<td>
					${settBpDetail.indbTime}
				</td>
				<shiro:hasPermission name="cash:settBpDetail:edit"><td>
    				<a href="${ctx}/cash/settBpDetail/form?id=${settBpDetail.id}">修改</a>
					<a href="${ctx}/cash/settBpDetail/delete?id=${settBpDetail.id}" onclick="return confirmx('确认要删除该记录吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>