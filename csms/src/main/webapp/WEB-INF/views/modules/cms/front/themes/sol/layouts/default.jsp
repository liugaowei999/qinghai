<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!DOCTYPE html>
<html>
<head>
    <link href="${ctxStaticTheme}/sol.css" type="text/css" rel="stylesheet" />
	<title><sitemesh:title default="欢迎光临"/>${site.title}</title>
	<%@include file="/WEB-INF/views/modules/cms/front/include/head.jsp" %>
	<!-- Baidu tongji analytics -->
	<script>
	var _hmt=_hmt||[];
	(function(){
		var hm=document.createElement("script");
		hm.src="//hm.baidu.com/hm.js?f7078cf930b0b12b50ae316ac2103ff4";
		var s=document.getElementsByTagName("script")[0];
		s.parentNode.insertBefore(hm,s);})();
	</script>
	<sitemesh:head/>
	</head>
	
<body>
	<!-- 导航搜索栏 -->
	<div class="top-search">
		<div class="search-inner">
			<div class="search-left">
				<a class="setPage" href="javascript:void(0);">
					设为首页
				</a>  
				<a class="addColl" href="javascript:void(0);">
					加入收藏
				</a> 
			</div>
			<div class="search-right">
			 <form action="${ctx}/search/simple" method="get">
				<input class="searchBox" type="text"  name="q" maxlength="30" value="${q}"  placeholder="全站搜索..."/>
			</form>
				<img src="${ctxStaticTheme}/images/search.png" alt="">
			</div>
		</div>
	</div>
		<!-- 导航菜单栏 -->
	<div class="solnav">
		<div class="nav-inner">
			<div class="logoBox">
				<a href="${ctx}">
					<img class="logo" src="${ctxStaticTheme}/images/logo.png" alt="${site.title}" >
					<img class="line" src="${ctxStaticTheme}/images/line.png" alt="${site.title}" >
					<img class="logo-1" src="${ctxStaticTheme}/images/logo-1.png" alt="${site.title}" >
				</a>
			</div>
			<ul class="meau">
				<li class="list">
					<img class="line-1" src="${ctxStaticTheme}/images/line-1.png" alt="">
					<a href="${ctx}">首页</a>
					<img class="san" src="${ctxStaticTheme}/images/san.png" alt="">
				</li>
				
				<c:forEach items="${fnc:getMainNavList(site.id)}" var="category" varStatus="status">
					<li class="list dropDown">
						<img class="line-1" src="${ctxStaticTheme}/images/line-1.png" alt="">
							<a class="dropDown" href="#">${category.name}</a>
						<ul>
						<c:forEach items="${fnc:getCategoryList(site.id,category.id,9,'')}" var="childCategory" >
							<a href="${childCategory.url}" target="${childCategory.target}"><li>${childCategory.name}</li></a>
						</c:forEach>
						</ul>
						<img class="san" src="${ctxStaticTheme}/images/san.png" alt="">
					</li>
		    	</c:forEach>
				
			</ul>
		</div>
	</div>

	<div class="container">
		<div class="content">
			<sitemesh:body/>
		</div>
<!-- 		<hr style="margin:20px 0 10px;"> -->
		<div class="footer">
			<div class="footer-inner">
				<div class="footer-top">
					<span><a href="${ctx}/list-292714ef53c944c081a5aa5f2ed138dc.html">公司简介</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span> 
					<span><a href="${ctx}/list-3c163f6d4a864ef3a08fa085881cda25.html">关于我们</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</span>
					<span><a href="${ctx}/list-a29d618878824baba4fd964821deb5db.html">联系我们</a></span>
			</div>
				<div class="footer-bottom">${site.copyright}</div>
			</div>
		</div>
	</div>
	
	
	<script src="${ctxStatic}/jquery/jquery-1.11.1.js"></script>
    <script type="text/javascript">
    	//字体颜色改变
    	$(".meau .list").mouseenter(function(){
    		$(this).children("a").css("color","#6fba2c")
    	})
    	$(".meau .list").mouseleave(function(){
    		$(this).children("a").css("color","#589ed6")
    	})

    	//菜单下拉
     	$(".list").mouseenter(function(){
			$(this).children("ul").stop().slideDown();
		})
		$(".list").mouseleave(function(){
			$(this).children("ul").stop().slideUp();
		}) 
 
		//下拉菜单中选项背景色的添加
		$(".list ul li").mouseenter(function(){
			$(this).css("background-color","#f5fafd")
		})
		$(".list ul li").mouseleave(function(){
			$(this).css("background-color","")
		})

		//横线的改变
		$(".meau .dropDown").mouseenter(function(){
    		$(this).children("img.line-1").css("display","block")
    	})
    	$(".meau .dropDown").mouseleave(function(){
    		$(this).children("img.line-1").css("display","none")
    	})

     	//三角的改变
		$(".meau .dropDown").mouseenter(function(){
    		$(this).children("img.san").css("display","block")
    	})
    	$(".meau .dropDown").mouseleave(function(){
    		$(this).children("img.san").css("display","none")
    	}) 
    </script>
</body>
</html>