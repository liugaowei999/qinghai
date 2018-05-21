<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>备付金缴存成功管理</title>
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
		<li><a href="${ctx}/cash/cashPayRecord/form">备付金缴存</a></li>
		<li class="active"><a href="${ctx}/cash/cashPayRecord/">备付金缴存明细</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="cashPayRecord" action="${ctx}/cash/cashPayRecord/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<c:if test="${fns:getUser().admin}">
				<!-- <li><label>所属组织：</label><form:input path="officeName" htmlEscape="false" maxlength="50" class="input-medium"/></li> -->
				<li>
					<label>缴存机构：</label>
					<sys:treeselect id="office" name="office.id" value="${cashPayRecord.currentUser.office.id}" labelName="officeName" labelValue="${cashPayRecord.officeName}" 
						title="部门" url="/sys/office/treeData?type=1" cssClass="input-small" allowClear="true" />
				</li>
			</c:if>
			<li><label>备付金帐号：</label>
				<form:select path="cashProvisions.id" class="input-xlarge">
					<form:option value="" label=""/>
					<form:options items="${provisionsDropDownList}"  />
				</form:select>
			</li>
			<li><label>缴存状态：</label>
				<form:select path="payState" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('cash_pay_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li>
				<label>开始日期：</label><input id="beginDate" name="beginDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value='${cashPayRecord.beginDate}' pattern='yyyy-MM-dd HH:mm:ss'/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false,maxDate:'#F{$dp.$D(\'endDate\')}'});"/>
			</li>
			<li>
				<label>结束日期：</label><input id="endDate" name="endDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value='${cashPayRecord.endDate}' pattern='yyyy-MM-dd HH:mm:ss'/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false,minDate:'#F{$dp.$D(\'beginDate\')}'});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>缴存机构</th>
				<th>备付金帐号</th>
				<th>缴存金额( 元 )</th>
				<th>缴存状态</th>
				<th>缴存时间</th>
				<th>备注信息</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cashPayRecord">
			<tr>
				<td>
					${cashPayRecord.officeName}
				</td>
				<td>
					${cashPayRecord.cashProvisions.provisionsNo}
				</td>
				<td>
					${cashPayRecord.payMoney}
				</td>
				<td>
					${fns:getDictLabel(cashPayRecord.payState, 'cash_pay_status', '无')}
				</td>
				<td>
					<fmt:formatDate value="${cashPayRecord.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${cashPayRecord.remarks}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>