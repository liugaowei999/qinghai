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
		<li class="active"><a href="${ctx}/settlementfront/settEd/">差错处理文件列表</a></li>
		 <shiro:hasPermission name="settlementfront:settEd:edit"><li><a href="${ctx}/settlementfront/settEd/form">记录添加</a></li></shiro:hasPermission> 
	</ul>
	<form:form id="searchForm" modelAttribute="settEd" action="${ctx}/settlementfront/settEd/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>清算月份：</label>
				<form:input path="settDate" id="settDate" htmlEscape="false"  readonly="readonly" maxlength="8" class="input-medium Wdate"
					 onclick="WdatePicker({dateFmt:'yyyyMM',maxDate:'%y%M',isShowClear:true});" value="${settEd.settDate}"/>
			</li>
			<li><label>确认标识：</label>
				<form:select path="dealFlag" class="input-medium">
					<form:option value="" label="全部"/>
					<form:options items="${fns:getDictList('deal_flag')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			
			<li>
				<label>发卡机构：</label><form:select path="issueOrgCode" class="input-medium">
					<form:option value="" label="请选择" />
					<form:options items="${orgInfoDropDownMap}" htmlEscape="false" />
				</form:select>
			</li>
			<li class="clearfix"></li>
			<li>
				<label>收单机构：</label><form:select path="billOrgId" class="input-medium">
					<form:option value="" label="请选择" />
					<form:options items="${orgInfoDropDownMap}" htmlEscape="false" />
				</form:select>
			</li>
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
				<th>发送机构代码</th> 
				<th>文件名称</th>
				<th>清算日期</th>
				 <th>清算中心流水号</th> 
				 <th>收单机构流水号</th>
				<th>收单机构受理日期</th>
				<th>交易检索参考号</th>
				<th>调整类型</th> 
				 <th>差错类型</th> 
				<th>卡号</th>
				 <th>卡消费计数器</th> 
				 <th>消费前卡余额</th>
				<th>调整后交易类型</th> 
				<th>调整后交易金额(元)</th>
				 <th>MCC</th>
				<th>渠道类型</th> 
				<th>交易日期</th>
				<th>交易时间</th>
				 <th>测试标志</th> 
				<th>原因码</th>
				 <th>差错发起方机构代码</th> 
				<th>发卡机构</th>
				<th>收单机构</th>
				 <th>处理时间</th> 
				 <th>入库时间</th> 
				<th>确认标志</th>
				<th>确认备注</th>
				<%-- <shiro:hasPermission name="settlementfront:settEd:edit"><th>操作</th></shiro:hasPermission> --%>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="settEd">
			<tr>
				 <td>
					${settEd.sendOrgCode}
				</td> 
				<td>
					${settEd.fileName}
				</td>
				<td>
					${settEd.settDate}
				</td>
				 <td>
					${settEd.settOrgNo}
				</td> 
				 <td>
					${settEd.billOrgNo}
				</td>
				<td>
					${settEd.billOrgDealDate}
				</td>
				<td>
					${settEd.tradeRetrievNo}
				</td>
				<td>
					${settEd.adjustType}
				</td> 
				 <td>
					${settEd.errType}
				</td> 
				<td>
					${settEd.cardNo}
				</td>
				 <td>
					${settEd.cardCount}
				</td>
				<td>
					${settEd.beforetradeCharge}
				</td>
				<td>
					${settEd.adjustedTradeType}
				</td> 
				<td>
					${settEd.adjustedTradeCharge}
				</td>
				 <td>
					${settEd.mcc}
				</td>
				<td>
					${settEd.channelType}
				</td> 
				<td>
					${settEd.tradeDate}
				</td>
				<td>
					${settEd.tradeTime}
				</td>
				 <td>
					${settEd.testFlag}
				</td> 
				<td>
					${settEd.causeCode}
				</td>
				 <td>
					${settEd.errOriOrgCode}
				</td> 
				<td>
					${settEd.issueOrg.id}
				</td>
				<td>
					${settEd.company.name}
				</td>
				 <td>
					${settEd.dealTime}
				</td> 
				<td>
					${settEd.indbTime}
				</td>
				<td>
					${fns:getDictLabel(settEd.dealFlag, 'deal_flag', '')}
				</td>
				<td>
					${settEd.dealNote}
				</td>
				<%-- <shiro:hasPermission name="settlementfront:settEd:edit"><td>
    				<a href="${ctx}/settlementfront/settEd/form?id=${settEd.id}&settDate=${settEd.settDate}">查看</a>
				</td></shiro:hasPermission> --%>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>