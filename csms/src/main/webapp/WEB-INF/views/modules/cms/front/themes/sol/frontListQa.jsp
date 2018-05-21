<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>${category.name}</title>
	<meta name="decorator" content="cms_default_${site.theme}"/>
	<meta name="description" content="${category.description}" />
	<meta name="keywords" content="${category.keywords}" />
	<link href="${ctxStatic}/modules/cms/front/themes/sol/css/frontListQa.css" type="text/css" rel="stylesheet" />
	<link href="${ctxStatic}/modules/cms/front/themes/sol/css/publicSol.css" type="text/css" rel="stylesheet" />
	<link href="${ctxStatic}/modules/cms/front/themes/sol/css/pagination.css" type="text/css" rel="stylesheet" />
	<script src="${ctxStatic}/jquery/jquery-1.11.1.js"></script>
	<script type="text/javascript" src="${ctxStatic}/modules/cms/front/themes/sol/js/pagination.js"></script>
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
				<p class="line"></p>
				<ul class="meau clearfix">
				   <cms:frontCategoryList categoryList="${categoryList}"/>
				</ul>
				<!-- 选项卡 start -->  
				<div class="clear"></div>
			</div>
			<div class="right" id="rightDiv">
				<ul class="breadcrumb">
					<cms:frontCurrentPosition category="${category}"/>
				</ul>
				<div class="content-1">
					<div class="news content">
						<div class="right-list">
							<div class="search-right">
								<span class="searchKey">请输入关键词</span>
								<input class="searchBox" type="text">
								<img src="${ctxStatic}/modules/cms/front/themes/sol/images/search.png" alt="">
							</div>
							<c:if test="${category.module eq 'article'}">
								<ul>
								   <c:forEach items="${page.list}" var="article" > 
										<li class="list-item">
											<p>
												<span><a href="${article.url}" style="color:${article.color}">${fns:abbr(article.title,96)}</a></span>
											</p>
											<p class="detailAn clearfix">
												<span class="answerTxt" id="qa_${article.id}"><a href="${article.url}" style="color:${article.color}">${fns:abbr(article.articleData.content,200)}</a><span>
											</p>
										</li>
									</c:forEach>
								</ul>
								<div class="pagination">${page}</div>
								<script type="text/javascript">
									function page(n, s) {
										location = "${ctx}/list-${category.id}${urlSuffix}?pageNo="
												+ n + "&pageSize=" + s;
									}
								</script>
							</c:if>
							<c:if test="${category.module eq 'link'}">
								<ul>
									<c:forEach items="${page.list}" var="link">
										<li><a href="${link.href}" target="_blank"
											style="color:${link.color}"><c:out value="${link.title}" /></a></li>
									</c:forEach>
								</ul>
							</c:if>
					</div>
					<div class="notice content">
					</div>
				</div>
			</div>
		</div>
	</div>
    <script type="text/javascript">
    	var categoryCount=0;
		$(document).ready(function() {
			var menu_id="menu_${category.id}";
			$("#"+menu_id).addClass("show");
			initData();
			calPageHeight();
		});
 
    	// 选项卡
// 		$(".banner .banner-inner .left .meau li").click(function(){
// 			var num = $(this).index();
// 			$(this).addClass("show").siblings().removeClass("show");
// 			$(".content-1 .content").eq(num).css("display","block").siblings().css("display","none");
// 		})
		//分页init
		function getParameter(name) { 
			var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)"); 
			var r = window.location.search.substr(1).match(reg); 
			if (r!=null) return unescape(r[2]); return null;
		}
		//init
		$(function(){
			var totalPage = 20;
			var totalRecords = 44;
			var pageNo = getParameter('pno');
			if(!pageNo){
				pageNo = 1;
			}
			//生成分页
			//有些参数是可选的，比如lang，若不传有默认值
			kkpager.generPageHtml({
				pno : pageNo,
				//总页码
				total : totalPage,
				//总数据条数
				totalRecords : totalRecords,
				mode : 'click',//默认值是link，可选link或者click
				click : function(n){
					// do something
					//手动选中按钮
					if(n=="2") window.location.href = "http:www.baidu.com"
					// if(n=="3") window.open("http:www.baidu.com")
					
					this.selectPage(n);
					return false;

				},
				   //  //getHref是在click模式下链接算法，一般不需要配置，默认代码如下
		    	// getHref : function(n){
		     //    	return "http:www";
		   		// }
			});
		});
		function calPageHeight(){
			//计算菜单列表最小高度
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
		}
		function initData(){
			
		}
	</script>
</body>
</html>