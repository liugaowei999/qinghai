<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>内容缓存刷新</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function(){
			$("#qryBtn").click(function(){
				fresheshinfo();
			});
		});
	    function fresheshinfo(){
	    	var urlInput=$("#urlInput").val();
	    	if(urlInput==null || urlInput==""){
	    		top.$.jBox.tip('请选择归属栏目','warning');
	    		alert("请输入页面链接！");
	    		return false;
	    	}
	    	$.ajax({
				url: "${ctx}/nginx/nginx/refreshInfo",
				dataType: 'json',
				data:{refreshId:urlInput},
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
	<div class="breadcrumb form-search">
		<label>页面链接：</label><input id="urlInput" path="title" htmlEscape="false" maxlength="600" width="600" />&nbsp;
		<input id="qryBtn" class="btn btn-primary" type="button" value="刷新缓存"/>&nbsp;&nbsp;
	</div>
</body>
</html>