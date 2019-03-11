<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML>
<head>
	<title>省内地市结算异常记录管理</title>
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
	<style type="text/css">
		td{
			align:center
		}
	</style>
</head>
<body>
	<ul class="nav nav-tabs" style="width:2560px">
		<li class="active"><a href="${ctx}/settlementfront/erBillDetail/">省内地市结算异常记录列表</a></li>
		<shiro:hasPermission name="settlementfront:erBillDetail:edit"><li><a href="${ctx}/settlementfront/erBillDetail/form">省内地市结算异常记录添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="erBillDetail" action="${ctx}/settlementfront/erBillDetail/" method="post" class="breadcrumb form-search" style="width:2560px">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			
			<li><label>查询月份：</label>
				<input name="indbTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${erBillDetail.indbTime}" pattern="yyyy-MM"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM',maxDate:'%y-%M',isShowClear:false});"/>
			</li>
			<li>
				<label>发卡机构：</label><form:select path="issueOrgCode" class="input-medium">
					<form:option value="" label="请选择" />
					<form:options items="${orgInfoDropDownMap}" htmlEscape="false" />
				    <form:option value="-1" label="其他" />
				</form:select>
			</li>
			<li>
				<label>收单机构：</label><form:select path="billOrgCode" class="input-medium">
					<form:option value="" label="请选择" />
					<form:options items="${orgInfoDropDownMap}" htmlEscape="false" />
				</form:select>
			</li>
			<li>
				<label>卡号：</label><form:input path="cardNo" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" style="table-layout:fixed;" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<td width="100px">结算日期</td>
				<td width="100px">发送机构</td>
				<td width="100px">交易代码</td>
				<td width="200px">卡片序列号</td>
				<td width="100px">交易日期</td>
				<td width="100px">交易时间</td>
				<td width="100px">交易金额(元)</td>
				<td width="120px">交易前金额(元)</td>
				<td width="100px">错误代码</td>
				<td width="150px">错误描述</td>
				<td width="120px">发卡机构标识码</td>
				<td width="120px">收单机构标识码</td>
				<td width="100px">商户类型</td>
				<td width="150px">系统跟踪号</td>
				<td width="200px">漫游类型</td>
				<shiro:hasPermission name="settlementfront:erBillDetailList:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="erBillDetail">
			<tr>
				<td>${erBillDetail.settDate}</td>
				<td>${erBillDetail.sendOrgName}</td>
			 	<td>${erBillDetail.tradeCode}</td>
			 	<td>${erBillDetail.cardNo}</td>
			 	<td>${erBillDetail.tradeDate}</td>
			 	<td>${erBillDetail.tradeTime}</td>
			 	<td>${erBillDetail.tradeCharge/100}</td>
			 	<td>${erBillDetail.beforetradeChargeDec/100}</td>
			 	<td>${erBillDetail.sysErrorCode}</td>
			 	<td>${erBillDetail.sysErrorMsg}</td>
			 	<td>${erBillDetail.issueOrgCode}</td>
			 	<td>${erBillDetail.recvOrgId}</td>
			 	<td>${erBillDetail.sellerType}</td>
			 	<td>${erBillDetail.traceNo}</td>
			 	<td>${fns:getDictLabel(erBillDetail.roamType, 'roam_type', '无')}</td>
				<shiro:hasPermission name="settlementfront:erBillDetailList:edit"><td>
    				<a href="${ctx}/settlementfront/erBillDetailList/form?id=${erBillDetail.id}">修改</a>
					<a href="${ctx}/settlementfront/erBillDetailList/delete?id=${erBillDetail.id}" onclick="return confirmx('确认要删除该记录吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>