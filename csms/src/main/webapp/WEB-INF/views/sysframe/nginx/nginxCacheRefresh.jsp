<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>nginx缓存刷新</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function(){
			$("#qryBtn").click(function(){
				page();
			});
			$("#refreshBtn").click(function(){
				freshAll();
			});
		});
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctx}/nginx/nginx/list");
			$("#searchForm").submit();
	    	return false;
	    }
	    function fresheinfo(categoryId,id){
	    	var refreshId="csms/f/view-"+categoryId+"-"+id+".html";
	    	$.ajax({
				url: "${ctx}/nginx/nginx/refreshInfo",
				dataType: 'json',
				data:{refreshId:refreshId},
				cache: false,
				async: true,
				success: function(data, textStatus) {
					top.$.jBox.alert(data.result, '系统提示');
					return false;
				}
			}).done(function(data, textStatus) {
				console.log("ajax done");
			}).fail(function(jqXHR, textStatus, error){
				console.error('Get diagram layout['+processDefinitionKey+'] failure: ', textStatus, 'error: ', error, jqXHR);
			});
	    }
	    function freshAll(){
// 	    	loading('正在提交，请稍等...');
	    	$.ajax({
				url: "${ctx}/nginx/nginx/refreshAll",
				dataType: 'json',
				data:{},
				cache: false,
				async: true,
				success: function(data, textStatus) {
					top.$.jBox.alert(data.result, '系统提示');
					return false;
				}
			}).done(function(data, textStatus) {
				console.log("ajax done");
			}).fail(function(jqXHR, textStatus, error){
				console.error('Get diagram layout['+processDefinitionKey+'] failure: ', textStatus, 'error: ', error, jqXHR);
			});
	    }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/cms/article/?category.id=${article.category.id}">内容列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="article" action="${ctx}/cms/article/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<label>栏目：</label><sys:treeselect id="category" name="category.id" value="${article.category.id}" labelName="category.name" labelValue="${article.category.name}"
					title="栏目" url="/cms/category/treeData" module="article" notAllowSelectRoot="false" cssClass="input-small"/>
		<label>标题：</label><form:input path="title" htmlEscape="false" maxlength="50" class="input-small"/>&nbsp;
		<input id="qryBtn" class="btn btn-primary" type="button" value="查询"/>&nbsp;&nbsp;
		<input id="refreshBtn" class="btn btn-primary" type="button" value="全部刷新"/>&nbsp;&nbsp;
<%-- 		<label>状态：</label><form:radiobuttons onclick="$('#searchForm').submit();" path="delFlag" items="${fns:getDictList('cms_del_flag')}" itemLabel="label" itemValue="value" htmlEscape="false"/> --%>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>栏目</th><th>标题</th><th>发布者</th><th>更新时间</th><th>操作</th></tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="article">
			<tr>
				<td><a href="javascript:" onclick="$('#categoryId').val('${article.category.id}');$('#categoryName').val('${article.category.name}');$('#searchForm').submit();return false;">${article.category.name}</a></td>
				<td><a href="${ctx}/cms/article/form?id=${article.id}" title="${article.title}">${fns:abbr(article.title,40)}</a></td>
				<td>${article.user.name}</td>
				<td><fmt:formatDate value="${article.updateDate}" type="both"/></td>
				<td>
					<a href="${pageContext.request.contextPath}${fns:getFrontPath()}/view-${article.category.id}-${article.id}${fns:getUrlSuffix()}" target="_blank">访问</a>
					<a href="javascript:viod(0)" onclick="return fresheshinfo('${article.category.id}','${article.id}');">刷新</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>