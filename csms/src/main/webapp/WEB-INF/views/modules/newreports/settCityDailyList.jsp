<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>省地市-日统计报表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出报表吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#searchForm").attr("action","${ctx}/newreports/settCityDaily/export");
						$("#searchForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});			
			
			$("#btnSubmit").click(function(){
				$("#searchForm").attr("action","${ctx}/newreports/settCityDaily/list");
				$("#searchForm").submit();
			});	
		});

		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		function setSettRole(){
			$("#settArea").val();
			var options=$("#settArea option:selected");//获取当前选择项.
			var settArea = options.val(); 
			$.ajax({
				type : "GET",//方法类型
				dataType : "json",//预期服务器返回的数据类型
				url : "${ctx}/newreports/settCityDaily/getSettRole",
				data : {"settArea":settArea},
				success : function(result) {
					if(result.length>0){
						$("#settRole").empty();
						var optionVar = "<option value=\"\">全部</option>";
						for(var i=0;i<result.length;i++){
							optionVar+="<option value=\""+result[i]+"\">"+result[i]+"</option>";
						}
						$("#settRole").append(optionVar);
					}
				},
				error : function() {
				}
			})
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/newreports/settCityDaily/settCityDailyList">省地市-日统计报表</a></li>
		<li><a href="${ctx}/newreports/settCityDaily/settCityDailyChart">图表展示</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="settCityDaily" action="${ctx}/newreports/settCityDaily/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li><label>结算日期：</label>
				<input id="beginSettDate" name="beginSettDate" type="text" readonly="readonly" maxlength="8" class="input-medium Wdate"
					value="${settCityDaily.beginSettDate}"
					onclick="WdatePicker({dateFmt:'yyyyMMdd',maxDate:'#F{$dp.$D(\'endSettDate\')}',isShowClear:true});"/> 至 
				<input id="endSettDate" name="endSettDate" type="text" readonly="readonly" maxlength="8" class="input-medium Wdate"
					value="${settCityDaily.endSettDate}"
					onclick="WdatePicker({dateFmt:'yyyyMMdd',minDate:'#F{$dp.$D(\'beginSettDate\')}',isShowClear:true});"/>
			</li>
			<li><label>结算对象：</label>
				<select name="settObject" class="input-medium">
					<option value="">全部</option>
					<c:forEach items="${settObjectList}" var="settObject" >
						<c:choose>
							<c:when test="${settCityDaily.settObject == settObject}">
								<option selected="selected" value="${settObject}">${settObject}</option>
							</c:when>
							<c:otherwise>
								<option value="${settObject}">${settObject}</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select>
				
			</li>
			<li><label>结算地区：</label>
				<select id="settArea" name="settArea" class="input-medium" onchange="setSettRole()">
					<option value="">全部</option>
					<c:forEach items="${settAreaList}" var="settArea" >
						<c:choose>
							<c:when test="${settAreaMap.settArea == settArea}">
								<option selected="selected" value="${settArea}">${settArea}</option>
							</c:when>
							<c:otherwise>
								<option value="${settArea}">${settArea}</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select>
			</li>
			<li><label>结算类型：</label>
				<select id="settRole" name="settRole" class="input-medium">
					<option value="">全部</option>
					<c:forEach items="${settRoleList}" var="settRole" >
						<c:choose>
							<c:when test="${settCityDaily.settRole == settRole}">
								<option selected="selected" value="${settRole}">${settRole}</option>
							</c:when>
							<c:otherwise>
								<option value="${settRole}">${settRole}</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select>
			</li>
			<li class="btns">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
				<input id="btnExport" class="btn btn-primary" type="button" value="导出"/>
			</li>
			
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>结算日期</th>
				<th>结算对象</th>
				<th>结算角色</th>
				<th>消费总额(元)</th>
				<th>手续费(元)</th>
				<th>发卡分润(元)</th>
				<th>收单分润(元)</th>
				<th>清算中心分润(元)</th>
				<th>次数</th>
				<th>结算金额(元)</th>
				<shiro:hasPermission name="newreports:settCityDaily:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="settCityDaily">
			<tr>
				<td>
					${settCityDaily.settDate}
				</td>
				<td>
					${settCityDaily.settObject}
				</td>
				<td>
					${settCityDaily.settRole}
				</td>
				<td>
					${settCityDaily.tradeCharge}
				</td>
				<td>
					${settCityDaily.serviceCharge}
				</td>
				<td>
					${settCityDaily.issueCharge}
				</td>
				<td>
					${settCityDaily.billCharge}
				</td>
				<td>
					${settCityDaily.centerCharge}
				</td>
				<td>
					${settCityDaily.times}
				</td>
				<td>
					${settCityDaily.settCharge}
				</td>
				<shiro:hasPermission name="newreports:settCityDaily:edit"><td>
    				<a href="${ctx}/newreports/settCityDaily/form?id=${settCityDaily.id}">修改</a>
					<a href="${ctx}/newreports/settCityDaily/delete?id=${settCityDaily.id}" onclick="return confirmx('确认要删除该省内日统计报表吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>