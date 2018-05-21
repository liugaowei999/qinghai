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
		<li class="active"><a href="${ctx}/settlementfront/settLd/">处理文件明细列表</a></li>
		<shiro:hasPermission name="settlementfront:settLd:edit"><li><a href="${ctx}/settlementfront/settLd/form">记录添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="settLd" action="${ctx}/settlementfront/settLd/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>清算月份：</label>
				<form:input path="settDate" id="settDate" htmlEscape="false"  readonly="readonly" maxlength="8" class="input-medium Wdate"
					 onclick="WdatePicker({dateFmt:'yyyyMM',maxDate:'%y%M',isShowClear:true});" value="${settLd.settDate}"/>
			</li>
			<li>
				<label>收单机构：</label><form:select path="recvOrgCode" class="input-medium">
					<form:option value="" label="请选择" />
					<form:options items="${orgInfoDropDownMap}" htmlEscape="false" />
				</form:select>
			</li>
			<li>
				<label>处理结果：</label><form:select path="errCode" class="input-medium">
					<form:option value="" label="请选择"/>
					<form:option value="0" label="成功"/>
					<form:option value="1" label="失败"/>
				</form:select>
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
				<th>文件名称</th>
				<th>清分结算机构流水号</th>
				<th>文件列表</th>
				<th>错误代码</th>
				<th>错误描述</th>
				<th>保留域</th>
				<th>处理时间</th>
				<th>入库时间</th>
				<shiro:hasPermission name="settlementfront:settLd:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="settLd">
			<tr>
				<td><%-- <a href="${ctx}/settlementfront/settLd/form?id=${settLd.id}"> --%>
					${settLd.settDate}
				</a></td>
				<td>
					<c:choose>
						<c:when test="${empty settLd.company.name}">
							${settLd.recvOrgCode}
						</c:when>
						<c:otherwise>
							${settLd.company.name}
						</c:otherwise>
					</c:choose>
				</td>
				<td>
					${settLd.fileName}
				</td>
				<td>
					${settLd.settOrgNo}
				</td>
				<td>
					${settLd.fileListName}
				</td>
				<td>
					${settLd.errCode}
				</td>
				<td>
					${settLd.errInfo}
				</td>
				<td>
					${settLd.reserved}
				</td>
				<td>
					${settLd.dealTime}
				</td>
				<td>
					${settLd.indbTime}
				</td>
				<shiro:hasPermission name="settlementfront:settLd:edit"><td>
    				<a href="${ctx}/settlementfront/settLd/form?id=${settLd.id}">修改</a>
					<a href="${ctx}/settlementfront/settLd/delete?id=${settLd.id}" onclick="return confirmx('确认要删除该记录吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>