<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>省内地市结算详单管理</title>
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
	<ul class="nav nav-tabs" style="width:2560px">
		<li class="active"><a href="${ctx}/settlementfront/drBillDetail/">省内地市结算详单列表</a></li>
		<shiro:hasPermission name="settlementfront:drBillDetail:edit"><li><a href="${ctx}/settlementfront/drBillDetail/form">省内地市结算详单添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="drBillDetail" action="${ctx}/settlementfront/drBillDetail/" method="post" class="breadcrumb form-search" style="width:2560px">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			
			<li><label>查询月份：</label>
				<input name="indbTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${drBillDetail.indbTime}" pattern="yyyy-MM"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM',maxDate:'%y-%M',isShowClear:false});"/>
			</li>
			<li>
				<label>发卡机构：</label><form:select path="issueOrgCode" class="input-medium">
					<form:option value="" label="请选择" />
					<form:options items="${orgInfoDropDownMap}" htmlEscape="false" />
				</form:select>
			</li>
			<li>
				<label>收单机构：</label><form:select path="billOrgCode" class="input-medium">
					<form:option value="" label="请选择" />
					<form:options items="${orgInfoDropDownMap}" htmlEscape="false" />
				</form:select>
			</li>
			<li>
				<label>漫游类型：</label><form:select path="roamType" class="input-medium">
					<form:option value="" label="请选择" />
					<form:options items="${fns:getDictList('roam_type')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
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
	<table id="contentTable" style="table-layout:fixed" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<td width="100px">结算日期</td>
				<td width="200px">卡片序列号</td>
				<td width="100px">交易日期</td>
				<td width="100px">交易时间</td>
				<td width="100px">交易金额(元)</td>
				<td width="120px">交易前金额(元)</td>
				<td width="100px">发卡机构代码</td>
				<td width="120px">收单机构标识码</td>
				<td width="120px">发送机构标识码</td>
				<td width="200px">漫游类型</td>
				<td width="100px">错误代码</td>
				<td width="150px">错误描述</td>
				<td width="100px">手续费(分)</td>
				<td width="100px">发卡元润(分)</td>
				<td width="100px">收单元润(分)</td>
				<td width="100px">商户类型</td>
				<td width="130px">受卡机终端标识码</td>
				<td width="150px">受卡方标识码</td>
				<td width="180px">受卡方名称地址</td>
				<td width="100px">系统跟踪号</td>
				<td width="100px">交易代码</td>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="drBillDetail">
			<tr>
			 	<td>${drBillDetail.settDate}</td>
			 	<td>${drBillDetail.cardNo}</td>
			 	<td>${drBillDetail.tradeDate}</td>
			 	<td>${drBillDetail.tradeTime}</td>
			 	<td>${drBillDetail.tradeCharge/100}</td>
			 	<td>${drBillDetail.beforetradeChargeDec/100}</td>
			 	<td>${drBillDetail.issueOrgCode}</td>
			 	<td>${drBillDetail.recvOrgId}</td>
			 	<td>${drBillDetail.sendOrgId}</td>
			 	<td>${fns:getDictLabel(drBillDetail.roamType, 'roam_type', '无')}</td>
			 	<td>${drBillDetail.sysErrorCode}</td>
			 	<td>${drBillDetail.sysErrorMsg}</td>
			 	<td>${drBillDetail.serviceFee}</td>
			 	<td>${drBillDetail.issueFee}</td>
			 	<td>${drBillDetail.billFee}</td>
			 	<td>${drBillDetail.sellerType}</td>
			 	<td>${drBillDetail.terminalId}</td>
			 	<td>${drBillDetail.acquirerId}</td>
			 	<td>${drBillDetail.acquirerAddr}</td>
			 	<td>${drBillDetail.traceNo}</td>
			 	<td>${drBillDetail.tradeCode}</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>