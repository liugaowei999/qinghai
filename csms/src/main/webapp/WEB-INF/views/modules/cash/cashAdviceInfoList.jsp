<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>通知信息管理</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
		.header{margin:15px 0px 10px 10px;padding:5px 0px 5px 5px;position:static;font-size:15px;font-weight:bold;color:white;background-color:#45aeea}	
		a.mess:link, a.mess:visited {color:#45aeea;text-decoration:none;} 
		a.mess:hover, a.mess:active {color:#1684c2;text-decoration:none;}
		a:link, a:visited {color:#FFFFFF;text-decoration:none;} 
		a:hover, a:active {color:#c2f8f7;text-decoration:none;}  
	</style>
	<script type="text/javascript">
	    var ndaicount;
		$(document).ready(function() {
			ndaicount = '${ndAdviceInfoCount}';
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		function showMessageInfo(id,adviceType){
			var data = "<label class=\"control-list-1\"><i class=\"icon-comments\">&nbsp;&nbsp;</i>"+adviceType+"</label>";
			var data2 = "<i class=\"icon-comments\"></i> 通知信息（"+(ndaicount-1)+"）<div style=\"float:right;font-size:12px\"><a href=\"${ctx}/cash/cashAdviceInfo/warningInfo\">返回  &nbsp; </a></div>";
			$.ajax({
				url:'${ctx}/cash/cashAdviceInfo/updateDealState',
				method : "post",
				data:{id:id},
				success : function(msg){
					if(msg==true){
						$("#"+id+"a").empty();
						$("#"+id+"a").append(data);
						$("#"+id+"h").css("display","block");
						$("#adviceheader").empty();
						$("#adviceheader").append(data2);
					}
				}
			});
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/cash/cashAdviceInfo/">备付金用户信息中心</a></li>
	</ul>
	<form:form  class="form-horizontal">
		<div id="header" class="panel-heading header">
			<i class="icon-foursquare"></i> 账户信息
		</div>
		<div class="control-group">
			<div><label class="control-list-middle">备付金帐号：${cashProvisions.provisionsNo}</label></div>
			<div><label class="control-list-short">账户总额：${cashProvisions.totalAmount}</label></div>
			<div><label class="control-list-short">账户押金：${cashProvisions.deposite}</label></div>
			<div><label class="control-list-short">可用余额：${cashProvisions.remainingSum}</label></div>
		</div>
		<div class="control-group">
			<div><label class="control-list-middle">银行卡帐号：${cashProvisions.bankcardNo}</label></div>
			<div><label class="control-list-short">缴存周期：${fns:getDictLabel(cashProvisions.payPeriod,'pay_period','')}</label></div>
			<div><label class="control-list-short">可提现金额：${cashProvisions.withdrawDeposite}</label></div>
			<div><label class="control-list-short">应付总额：${cashProvisions.needPay}</label></div>
		</div>
		<div id="warningheader" class="panel-heading header">
			<i class="icon-tasks"></i> 待办业务（${ndWarningInfoCount}） <div style="float:right;font-size:12px"><a href="${ctx}/cash/cashAdviceInfo/warningInfo">更多业务  &nbsp;</a></div>
		</div>
		<c:choose>
			<c:when test="${fn:length(warningInfoList)<= 0}">
				<div class="control-group">
					<label class="control-list-middle">目前暂无待处理流程！</label>
				</div>
			</c:when>
			<c:otherwise>
				<c:forEach items="${warningInfoList}" var="cashAdviceInfo">
					<c:choose>
						<c:when test="${cashAdviceInfo.dealState=='0'}">
							<div class="control-group">
							<label class="control-list-8">
								<i class="icon-warning-sign icon-orange">（New）</i>
								缴费业务：您的账户目前余额不足，需缴纳${cashAdviceInfo.needPay}元，缴费截至日期为
								<fmt:formatDate value="${cashAdviceInfo.payDeadline}"
								pattern="yyyy-MM-dd HH:mm:ss" />,请您尽快缴纳，谢谢！<a class="mess" href="${ctx}/cash/cashPayRecord/form">(缴费)</a>
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
		<div id="adviceheader" class="panel-heading header">
			<i class="icon-comments"></i> 通知信息（${ndAdviceInfoCount}）<div style="float:right;font-size:12px"><a href="${ctx}/cash/cashAdviceInfo/adviceInfo">更多通知  &nbsp; </a></div>
		</div>
		<c:choose>
			<c:when test="${fn:length(adviceInfoList)<= 0}">
				<div class="control-group">
					<label class="control-list-middle">目前暂无未读通知！</label>
				</div>
			</c:when>
			<c:otherwise>
				<c:forEach items="${adviceInfoList}" var="cashAdviceInfo">
					<c:choose>
						<c:when test="${cashAdviceInfo.dealState=='0'}">
							<div class="control-group">
								<div id="${cashAdviceInfo.id}a">
									<label class="control-list-1">
										<a class="mess" href="#" onclick="showMessageInfo('${cashAdviceInfo.id}','${fns:getDictLabel(cashAdviceInfo.adviceType,'advice_type','')}')"><i class="icon-comments icon-green">（New）</i>
										${fns:getDictLabel(cashAdviceInfo.adviceType,'advice_type','')}</a>
									</label>
								</div>
								<div id="${cashAdviceInfo.id}h" style="display:none">
								<label class="control-list-lang">${cashAdviceInfo.message}</label>
								<label class="control-list-right">
								<fmt:formatDate value="${cashAdviceInfo.createDate}" pattern="yyyy-MM-dd HH:mm:ss" />
								</label>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<div class="control-group">
							<label class="control-list-1">
								<i class="icon-comments"></i>
								${fns:getDictLabel(cashAdviceInfo.adviceType,'advice_type','')}
							</label>
							<label class="control-list-lang">${cashAdviceInfo.message}</label>
							<label class="control-list-right">
							<fmt:formatDate value="${cashAdviceInfo.createDate}" pattern="yyyy-MM-dd HH:mm:ss" />
							</label>
							</div>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</form:form>
</body>
</html>