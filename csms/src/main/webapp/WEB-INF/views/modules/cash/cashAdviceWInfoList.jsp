<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>待办业务</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
		.header{margin:15px 0px 10px 10px;padding:5px 0px 5px 5px;position:static;font-size:15px;font-weight:bold;color:white;background-color:#45aeea}	
		a.mess:link, a.mess:visited {color:#000000;text-decoration:none;} 
		a.mess:hover, a.mess:active {color:#45aeea;text-decoration:none;}
		a:link, a:visited {color:#FFFFFF;text-decoration:none;} 
		a:hover, a:active {color:#c2f8f7;text-decoration:none;}  
	</style>
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
		<li class="active"><a href="${ctx}/cash/cashAdviceInfo/">备付金用户信息中心</a></li>
	</ul>
	
		<div id="warningheader" class="panel-heading header">
			<i class="icon-tasks"></i> 待办业务（${ndWarningInfoCount}） <div style="float:right;font-size:12px"><a href="${ctx}/cash/cashAdviceInfo/">返回  &nbsp;</a></div>
		</div>
		<form:form id="searchForm" modelAttribute="cashAdviceInfo" action="${ctx}/cash/cashAdviceInfo/warningInfo" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li>
				<label>通知日期：</label><input id="createDate" name="createDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value='${cashAdviceInfo.createDate}' pattern='yyyy-MM-dd HH:mm:ss'/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false,maxDate:'#F{$dp.$D(\'updateDate\')}'});"/>
					——<input id="updateDate" name="updateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value='${cashAdviceInfo.updateDate}' pattern='yyyy-MM-dd HH:mm:ss'/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false,maxDate:'#F{$dp.$D(\'createDate\')}'});"/>
			</li>
			<li class="btns">&nbsp;&nbsp;&nbsp;&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
		</form:form>
		<form:form  class="form-horizontal">
		<c:choose>
			<c:when test="${fn:length(page.list)<= 0}">
				<div class="control-group">
					<label class="control-list-middle">目前暂无待处理流程！</label>
				</div>
			</c:when>
			<c:otherwise>
				<c:forEach items="${page.list}" var="cashAdviceInfo">
					<c:choose>
						<c:when test="${cashAdviceInfo.dealState=='0'}">
							<div class="control-group">
							<label class="control-list-8">
								<i class="icon-warning-sign icon-orange">（New）</i>
								缴费业务：您的账户目前余额不足，需缴纳${cashAdviceInfo.needPay}元，缴费截至日期为
								<fmt:formatDate value="${cashAdviceInfo.payDeadline}"
								pattern="yyyy-MM-dd HH:mm:ss" />,请您尽快缴纳，谢谢！
							</label>
							<label class="control-list-right">
								<fmt:formatDate value="${cashAdviceInfo.createDate}" pattern="yyyy-MM-dd HH:mm:ss" />
							</label>
						</div>
						</c:when>
						<c:otherwise>
							<div class="control-group">
							<label class="control-list-8">
								<i class="icon-warning-sign"></i>
								缴费业务：您的账户目前余额不足，需缴纳${cashAdviceInfo.needPay}元，缴费截至日期为
								<fmt:formatDate value="${cashAdviceInfo.payDeadline}" pattern="yyyy-MM-dd HH:mm:ss" />,请您尽快缴纳，谢谢！(已完成)
							</label>
							<label class="control-list-right">
								<fmt:formatDate value="${cashAdviceInfo.createDate}" pattern="yyyy-MM-dd HH:mm:ss" />
							</label>
							</div>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		<div class="pagination">${page}</div>
	</form:form>
</body>
</html>