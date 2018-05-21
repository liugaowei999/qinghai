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
	<link href="${ctxStatic}/modules/cms/front/themes/sol/css/listPage2.css" type="text/css" rel="stylesheet" />
	<script src="${ctxStatic}/jquery/jquery-1.11.1.js"></script>

	<script type="text/javascript">
		$(document).ready(function() {
			//计算菜单列表最小高度
			var categoryCount=0;
			<c:forEach items="${categoryList}" var="tpl" varStatus="tplStatus">
				categoryCount++;
			</c:forEach>
			var defaultHeight=44+57*categoryCount+20;
			var leftH=$("#leftDiv").height();
			var rightH=$("#rightDiv").height();
			if(defaultHeight<400){
				defaultHeight=400;
			}
			if(leftH<defaultHeight){
				 leftH=defaultHeight;
				 $("#leftDiv").height(leftH);
			}
			if(leftH<rightH){
				$("#leftDiv").height(rightH);
			}
		});
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
				<div class="iconBox clearfix">
					<div class="areaBox box1">
						<img src="${ctxStatic}/modules/cms/front/themes/sol/images/check.png" alt="">
						<p class="areaTxt">余额查询</p>
					</div>
					<div class="areaBox box2">
						<img src="${ctxStatic}/modules/cms/front/themes/sol/images/query_1.png" alt="">
						<p class="areaTxt">交易查询</p>
					</div>
					<div class="areaBox box2">
						<img src="${ctxStatic}/modules/cms/front/themes/sol/images/money.png" alt="">
						<p class="areaTxt">在线充值</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>