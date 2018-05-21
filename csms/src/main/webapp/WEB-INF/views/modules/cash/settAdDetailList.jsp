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
		<li class="active"><a href="${ctx}/cash/settAdDetail/">争议调整明细列表</a></li>
		<%-- <shiro:hasPermission name="cash:settAdDetail:edit"><li><a href="${ctx}/cash/settAdDetail/form">记录添加</a></li></shiro:hasPermission> --%>
	</ul>
	<form:form id="searchForm" modelAttribute="settAdDetail" action="${ctx}/cash/settAdDetail/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>开始日期：</label>
				<form:input path="beginDate" id="beginDate" htmlEscape="false"  readonly="readonly" maxlength="8" class="input-medium Wdate"
					 onclick="WdatePicker({dateFmt:'yyyyMMdd',maxDate:'%y%M%d',isShowClear:true});" value="${settAdDetail.beginDate}"/>
			</li>
			<li><label>结束日期：</label>
				<form:input path="endDate" id="endDate" htmlEscape="false" readonly="readonly" maxlength="8" class="input-medium Wdate"
					 onclick="WdatePicker({dateFmt:'yyyyMMdd',maxDate:'%y%M%d',isShowClear:true});" value="${settAdDetail.endDate}"/>
			</li>
			
			<li>
				<label>发卡机构：</label><form:select path="issueOrgCode" class="input-medium">
					<form:option value="" label="请选择" />
					<form:options items="${orgInfoDropDownMap}" htmlEscape="false" />
				</form:select>
			</li>
			<li class="clearfix"></li>
			<li>
				<label>收单机构：</label><form:select path="billOrgCode" class="input-medium">
					<form:option value="" label="请选择" />
					<form:options items="${orgInfoDropDownMap}" htmlEscape="false" />
				</form:select>
			</li>
			
			<li>
				<label> &nbsp;&nbsp;卡&nbsp;号：</label><form:input path="cardNo" htmlEscape="false" maxlength="20" class="input-xlarge "/>
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
				<!-- <th>文件名称</th>
				<th>清分结算机构调整交易流水号</th>
				<th>原消费交易清分结算机构结算日期</th>
				<th>原消费交易清分结算机构流水号</th>
				<th>原消费交易收单机构流水号</th>
				<th>原消费交易收单机构受理日期</th>
				<th>原消费交易检索参考号</th>
				<th>原交易交易类型</th>
				<th>调整类型</th> -->
				<th>卡号</th>
				<th>发卡机构</th>
				<!-- <th>接收机构代码1</th> -->
				<th>收单机构</th>
				<!-- <th>发送机构代码标识码</th> 
				<th>差错发起方机构代码</th>
				<th>差错确认方机构代码</th>
				<th>卡消费计数器</th> -->
				<th>消费前卡余额</th>
				<!-- <th>调整后交易类型</th> -->
				<th>调整后交易金额</th>
				<!-- <th>MCC</th>
				<th>渠道类型</th> -->
				<th>交易日期</th>
				<th>交易时间</th> 
				<!--<th>测试标志</th>
				<th>原因码</th>
				<th>回复码</th>
				<th>错误代码</th>
				<th>错误代码描述</th>
				<th>差错手续费</th>
				<th>手续费</th>
				<th>发卡分润</th>
				<th>收单分润</th> -->
				<th>处理时间</th>
				<th>入库时间</th>
				<shiro:hasPermission name="cash:settAdDetail:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="settAdDetail">
			<tr>
				<td><a href="${ctx}/cash/settAdDetail/form?id=${settAdDetail.id}">
					${settAdDetail.settDate}
				</a></td>
				<td>
					${settAdDetail.recvOrgCode}
				</td>
				<%-- <td>
					${settAdDetail.fileName}
				</td>
				<td>
					${settAdDetail.settChangeNo}
				</td>
				<td>
					${settAdDetail.oriSettDate}
				</td>
				<td>
					${settAdDetail.oriSettOrgNo}
				</td>
				<td>
					${settAdDetail.oriBillOrgNo}
				</td>
				<td>
					${settAdDetail.oriBillDealDate}
				</td>
				<td>
					${settAdDetail.oriRetrievNo}
				</td>
				<td>
					${settAdDetail.oriTradeType}
				</td>
				<td>
					${settAdDetail.adjustType}
				</td> --%>
				<td>
					${settAdDetail.cardNo}
				</td>
				<td>
					${settAdDetail.issueOrgCode}
				</td>
				<%-- <td>
					${settAdDetail.recvOrgCode1}
				</td> --%>
				<td>
					${settAdDetail.billOrgCode}
				</td>
				<%-- <td>
					${settAdDetail.sendOrgId}
				</td>
				<td>
					${settAdDetail.errOriOrgId}
				</td>
				<td>
					${settAdDetail.errConfirmOrgId}
				</td>
				<td>
					${settAdDetail.cardCount}
				</td> --%>
				<td>
					${settAdDetail.beforetradeCharge}
				</td>
				<%-- <td>
					${settAdDetail.adjustedTradeType}
				</td> --%>
				<td>
					${settAdDetail.adjustedTradeCharge}
				</td>
				<%-- <td>
					${settAdDetail.mcc}
				</td>
				<td>
					${settAdDetail.channelType}
				</td> --%>
				<td>
					${settAdDetail.tradeDate} 
				</td>
				<td>
					${settAdDetail.tradeTime}
				</td>
				<%--<td>
					${settAdDetail.testFlag}
				</td> 
				 <td>
					${settAdDetail.causeCode}
				</td>
				<td>
					${settAdDetail.responseCode}
				</td>
				<td>
					${settAdDetail.errCode}
				</td>
				<td>
					${settAdDetail.errInfo}
				</td>
				<td>
					${settAdDetail.errCharge}
				</td>
				<td>
					${settAdDetail.settCharge}
				</td>
				<td>
					${settAdDetail.issueCharge}
				</td>
				<td>
					${settAdDetail.billCharge}
				</td> --%>
				<td>
					${settAdDetail.dealTime}
				</td>
				<td>
					${settAdDetail.indbTime}
				</td>
				<shiro:hasPermission name="cash:settAdDetail:edit"><td>
    				<a href="${ctx}/cash/settAdDetail/form?id=${settAdDetail.id}">详情</a>
					<%-- <a href="${ctx}/cash/settAdDetail/delete?id=${settAdDetail.id}" onclick="return confirmx('确认要删除该记录吗？', this.href)">删除</a> --%>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>