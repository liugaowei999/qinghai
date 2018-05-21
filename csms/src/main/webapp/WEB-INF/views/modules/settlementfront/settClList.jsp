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
		<li class="active"><a href="${ctx}/settlementfront/settCl/">发卡消费明细列表</a></li>
		<%-- <shiro:hasPermission name="settlementfront:settCl:edit"><li><a href="${ctx}/settlementfront/settCl/form">记录添加</a></li></shiro:hasPermission> --%>
	</ul>
	<form:form id="searchForm" modelAttribute="settCl" action="${ctx}/settlementfront/settCl/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>清算月份：</label>
				<form:input path="settDate" id="settDate" htmlEscape="false"  readonly="readonly" maxlength="8" class="input-medium Wdate"
					 onclick="WdatePicker({dateFmt:'yyyyMM',maxDate:'%y%M',isShowClear:true});" value="${settCl.settDate}"/>
			</li>
			<li>
				<label>发卡机构：</label><form:select path="recvOrgCode" class="input-medium">
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
			<li class="clearfix"></li>
			<li>
				<label>卡号：</label><form:input path="cardNo" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>清算日期</th>
				<th>接收机构</th>
				<th>文件名称</th>
				<th>清分结算机构流水号</th>
				<th>收单机构流水号</th>
				<th>收单机构受理日期</th>
				<th>检索参考号</th>
				<th>交易类型</th>
				<th>收单机构标识码</th>
				<th>收单机构代码</th>
				<th>发卡地通卡公司代码</th>
				<th>接收机构代码1</th>
				<th>发送机构标识码</th>
				<th>MCC</th>
				<th>渠道类型</th>
				<th>卡号</th>
				<th>卡消费计数器</th>
				<th>消费前卡余额(元)</th>
				<th>交易金额(元)</th>
				<th>交易日期</th>
				<th>交易时间</th>
				<th>余额类型</th>
				<th>算法标识</th>
				<th>错误代码</th>
				<th>错误描述</th>
				<th>测试标志</th>
				<th>手续费</th>
				<th>发卡分润</th>
				<th>收单分润</th>
				<th>预留字段</th>
				<th>验证数据</th>
				<th>处理时间</th>
				<th>入库时间</th>
				<shiro:hasPermission name="settlementfront:settCl:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="settCl">
			<tr>
				<td>
					${settCl.settDate}
				</td>
				<td>
					${settCl.recvOrgCode}
				</td>
				 <td>
					${settCl.fileName}
				</td>
				<td>
					${settCl.settOrgNo}
				</td>
				<td>
					${settCl.billOrgNo}
				</td>
				<td>
					${settCl.billDealDate}
				</td>
				<td>
					${settCl.retrievNo}
				</td>
				<td>
					${settCl.tradeType}
				</td>
				<td>
					${settCl.billOrgId}
				</td>
				<td>
					${settCl.billOrgCode}
				</td>
				<td>
					${settCl.issueCompanyCode}
				</td>
				<td>
					${settCl.recvOrgCode1}
				</td>
				<td>
					${settCl.sendOrgId}
				</td>
				<td>
					${settCl.mcc}
				</td>
				<td>
					${settCl.channelType}
				</td>
				<td>
					${settCl.cardNo}
				</td>
				<td>
					${settCl.cardCount}
				</td>
				<td>
					${settCl.beforetradeCharge}
				</td>
				<td>
					${settCl.tradeCharge}
				</td>
				<td>
					${settCl.tradeDate}
				</td>
				<td>
					${settCl.tradeTime}
				</td>
				<td>
					${settCl.balanceType}
				</td>
				<td>
					${settCl.algorithmId}
				</td>
				<td>
					${settCl.errCode}
				</td>
				<td>
					${settCl.errInfo}
				</td>
				<td>
					${settCl.testFlag}
				</td>
				<td>
					${settCl.settCharge}
				</td>
				<td>
					${settCl.issueCharge}
				</td>
				<td>
					${settCl.billCharge}
				</td>
				<td>
					${settCl.reserved}
				</td>
				<td>
					${settCl.tlvData}
				</td>
				<td>
					${settCl.dealTime}
				</td>
				<td>
					${settCl.indbTime}
				</td>
				<shiro:hasPermission name="settlementfront:settCl:edit"><td>
    				<a href="${ctx}/settlementfront/settCl/form?id=${settCl.id}&settDate=${settCl.settDate}">详情</a>
					<%-- <a href="${ctx}/settlementfront/settCl/delete?id=${settCl.id}" onclick="return confirmx('确认要删除该记录吗？', this.href)">删除</a> --%>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>