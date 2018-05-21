<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>${article.title} - ${category.name}</title>
	<meta name="decorator" content="cms_default_${site.theme}"/>
	<meta name="description" content="${article.description} ${category.description}" />
	<meta name="keywords" content="${article.keywords} ${category.keywords}" />
	<link href="${ctxStatic}/modules/cms/front/themes/sol/css/publicSol.css" type="text/css" rel="stylesheet" />
	<link href="${ctxStatic}/modules/cms/front/themes/sol/css/article.css" type="text/css" rel="stylesheet" />
	<script src="${ctxStatic}/jquery/jquery-1.11.1.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			if ("${category.allowComment}"=="1" && "${article.articleData.allowComment}"=="1"){
				$("#comment").show();
				page(1);
			}
			var menu_id="menu_${category.id}";
			$("#"+menu_id).addClass("show");
			//计算菜单列表最小高度
			var categoryCount=0;
			<c:forEach items="${categoryList}" var="tpl" varStatus="tplStatus">
				categoryCount++;
			</c:forEach>
			var defaultHeight=44+57*categoryCount+20;
			var leftH=$("#leftDiv").height();
			var rightH=$("#rightDiv").height();
			if(leftH<defaultHeight){
				 leftH=defaultHeight;
				 $("#leftDiv").height(leftH);
			}
			if(leftH<rightH){
				$("#leftDiv").height(rightH);
			}
		});
		function page(n,s){
			$.get("${ctx}/comment",{theme: '${site.theme}', 'category.id': '${category.id}',
				contentId: '${article.id}', title: '${article.title}', pageNo: n, pageSize: s, date: new Date().getTime()
			},function(data){
				$("#comment").html(data);
			});
		}
    	// 选项卡
// 		$(".banner .banner-inner .left .meau li").click(function(){
// 			var num = $(this).index();
// 			$(this).addClass("show").siblings().removeClass("show");
// 			$(".content-1 .content").eq(num).css("display","block").siblings().css("display","none");
// 		})
	</script>
</head>
<body>
	<div class="banner">
		<div class="banner-inner clearfix">
			<div class="left" id="leftDiv">
				<p class="meau-tit">
					<c:forEach items="${fnc:getCategoryListByIds(category.parentIds)}" var="tpl">
						<c:if test="${tpl.id ne '1'}">
							 ${tpl.name}
						</c:if>
					</c:forEach>
				</p>
				<ul class="meau clearfix">
				   <cms:frontCategoryList categoryList="${categoryList}"/>
				</ul>
				<div class="clear"></div>
			</div>
			<div class="right" id="rightDiv">
				<ul class="breadcrumb">
					<cms:frontCurrentPosition category="${category}"/>
				</ul>
				<div class="content-1">
					<div class="news content">
						<div class="row">
					       <div class="span10">
								<h3 style="color:#555555;font-size:20px;text-align:center;border-bottom:1px solid #ddd;padding-bottom:15px;margin:25px 0;">${article.title}<p class="updateTime" style="font-size:13px;color:#666;font-weight:normal;">2016-11-01 13:00:00 </p></h3>
								<c:if test="${not empty article.description}"><div>摘要：${article.description}</div></c:if>
								<div>${article.articleData.content}</div>
<%-- 								<div style="border-top:1px solid #ddd;padding:10px;margin:25px 0;">发布者：${article.user.name} &nbsp; 点击数：${article.hits} &nbsp; 发布时间：<fmt:formatDate value="${article.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/> &nbsp; 更新时间：<fmt:formatDate value="${article.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></div> --%>
					  	       </div>
					  	     </div>
						 <div class="row">
							<div id="comment" class="hide span10">
								正在加载评论...
							</div>
					     </div>
					</div>
					<div class="notice content">
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	
<!-- 	<div class="row"> -->
<!-- 	   <div class="span2"> -->
<!-- 	   	 <h4>栏目列表</h4> -->
<!-- 		 <ol> -->
<%-- 		 	<cms:frontCategoryList categoryList="${categoryList}"/> --%>
<!-- 		 </ol> -->
<!-- 		 <h4>推荐阅读</h4> -->
<!-- 		 <ol> -->
<%-- 		 	<cms:frontArticleHitsTop category="${category}"/> --%>
<!-- 		 </ol> -->
<!-- 	   </div> -->
<!-- 	   <div class="span10"> -->
<!-- 		 <ul class="breadcrumb"> -->
<%-- 		    <cms:frontCurrentPosition category="${category}"/> --%>
<!-- 		 </ul> -->
<!-- 	   </div> -->
<!-- 	   <div class="span10"> -->
<!-- 	     <div class="row"> -->
<!-- 	       <div class="span10"> -->
<%-- 			<h3 style="color:#555555;font-size:20px;text-align:center;border-bottom:1px solid #ddd;padding-bottom:15px;margin:25px 0;">${article.title}</h3> --%>
<%-- 			<c:if test="${not empty article.description}"><div>摘要：${article.description}</div></c:if> --%>
<%-- 			<div>${article.articleData.content}</div> --%>
<%-- 			<div style="border-top:1px solid #ddd;padding:10px;margin:25px 0;">发布者：${article.user.name} &nbsp; 点击数：${article.hits} &nbsp; 发布时间：<fmt:formatDate value="${article.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/> &nbsp; 更新时间：<fmt:formatDate value="${article.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></div> --%>
<!--   	       </div> -->
<!--   	     </div> -->
<!-- 	     <div class="row"> -->
<!-- 			<div id="comment" class="hide span10"> -->
<!-- 				正在加载评论... -->
<!-- 			</div> -->
<!-- 	     </div> -->
<!-- 	     <div class="row"> -->
<!-- 	       <div class="span10"> -->
<!-- 			<h5>相关文章</h5> -->
<%-- 			<ol><c:forEach items="${relationList}" var="relation"> --%>
<%-- 				<li style="float:left;width:230px;"><a href="${ctx}/view-${relation[0]}-${relation[1]}${urlSuffix}">${fns:abbr(relation[2],30)}</a></li> --%>
<%-- 			</c:forEach></ol> --%>
<!-- 	  	  </div> -->
<!--   	    </div> -->
<!--   	  </div> -->
<!--    </div> -->
	
</body>
</html>