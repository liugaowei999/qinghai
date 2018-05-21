<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>通知信息</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
		.header{margin:15px 0px 10px 10px;padding:5px 0px 5px 5px;position:static;font-size:15px;font-weight:bold;color:white;background-color:#45aeea}	
		a.mess:link, a.mess:visited {color:#000000;text-decoration:none;} 
		a.mess:hover, a.mess:active {color:#45aeea;text-decoration:none;}
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
			var data2 = "<i class=\"icon-comments\"></i> 通知信息（"+(ndaicount-1)+"）<div style=\"float:right;font-size:12px\"><a href=\"#\">更多通知  &nbsp; </a></div>";
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
	
		<div id="adviceheader" class="panel-heading header">
			<i class="icon-comments"></i> 通知信息（${ndAdviceInfoCount}）<div style="float:right;font-size:12px"><a href="${ctx}/cash/cashAdviceInfo/">返回  &nbsp; </a></div>
		</div>
		<form:form id="searchForm" modelAttribute="cashAdviceInfo" action="${ctx}/cash/cashAdviceInfo/adviceInfo" method="post" class="breadcrumb form-search">
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
					<label class="control-list-middle">目前暂无未读通知！</label>
				</div>
			</c:when>
			<c:otherwise>
				<c:forEach items="${page.list}" var="cashAdviceInfo">
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
		<div class="pagination">${page}</div>
	</form:form>
</body>
</html>