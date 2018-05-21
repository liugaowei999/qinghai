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
	<link href="${ctxStatic}/modules/cms/front/themes/sol/css/query.css" type="text/css" rel="stylesheet" />
	<link href="${ctxStatic}/bootstrap/2.3.1/css_default/bootstrap.min.css" type="text/css" rel="stylesheet" />
	<script src="${ctxStatic}/jquery/jquery-1.11.1.js"></script>
	<script type="text/javascript">

	</script>
</head>
<body>
<div class="banner">
		<div class="banner-inner clearfix">
			<div class="left" id="leftDiv">
				<p class="meau-tit">卡片查询</p>
				<input class="cardNum" type="text" placeholder="10007510463233263803">
				<div class="codeBox clearfix">
					<input type="text" id="validateCode"  placeholder="验证码" name="validateCode" maxlength="5" class="txt required" style="width:55px;height:24px;float:left;padding-left:7px !important;margin-left:6px;margin-bottom:11px;"/>
					<img src="${pageContext.request.contextPath}/servlet/validateCodeServlet" onclick="$('.validateCodeRefresh').click();" class="mid validateCode" style="float:left;margin-left:2px;"/>
					<a href="javascript:" onclick="$('.validateCode').attr('src','${pageContext.request.contextPath}/servlet/validateCodeServlet?'+new Date().getTime());" class="mid validateCodeRefresh" style="padding-top:7px;display:none;">看不清</a>
					
<%-- 					<sys:validateCode name="validateCode" inputCssStyle="margin-bottom:0;" imageCssStyle="padding-top:7px;"/> --%>
<!-- 					<input class="codeNum" type="text" placeholder="输入验证码"> -->
<%-- 					<img class="codePic" src="${ctxStatic}/modules/cms/front/themes/sol/images/code1.png" alt=""> --%>
				</div>
				<input class="searchBtn" type="button" value="搜索">
			</div>
			<div class="right" id="rightDiv">
				<ul class="breadcrumb">
					<li><strong>当前位置：</strong>
					 <a href="${ctx}">首页</a></li>
						<li><span class="divider"> > </span>查询结果</li>
				</ul>
				<p class="cardTxt">青海省交通一卡通卡卡号： <span class="cardNumber">10007510463233263803</span> </p>
				<p class="rechargeQuery">充值查询</p>
				<table class="table table-striped table-bordered">
					<tr class="header">
						<th>充值时间</th>
						<th>充值前金额</th>
						<th>充值金额</th>
						<th>充值后金额</th>
					</tr>
					<tr>
						<td>2016-12-10 08:15:00</td>
						<td>4.60</td>
						<td>100</td>
						<td>104.60</td>
					</tr>
					<tr>
						<td>2016-12-10 08:15:00</td>
						<td>4.60</td>
						<td>100</td>
						<td>104.60</td>
					</tr>
					<tr>
						<td>2016-12-10 08:15:00</td>
						<td>4.60</td>
						<td>100</td>
						<td>104.60</td>
					</tr>
					<tr>
						<td>2016-12-10 08:15:00</td>
						<td>4.60</td>
						<td>100</td>
						<td>104.60</td>
					</tr>
				</table>
				<p class="rechargeQuery">消费查询</p>
				<table class="table table-striped table-bordered">
					<tr class="header">
						<th>交易时间</th>
						<th>消费金额</th>
						<th>交易后金额</th>
						<th>累计消费金额</th>
						<th>应用行业</th>
					</tr>
					<tr>
						<td>2016-12-10 08:15:00</td>
						<td>1.00</td>
						<td>88.60</td>
						<td>132.60</td>
						<td>公交</td>
					</tr>
					<tr>
						<td>2016-12-10 08:15:00</td>
						<td>1.00</td>
						<td>88.60</td>
						<td>132.60</td>
						<td>公交</td>
					</tr>
					<tr>
						<td>2016-12-10 08:15:00</td>
						<td>1.00</td>
						<td>88.60</td>
						<td>132.60</td>
						<td>公交</td>
					</tr>
					<tr>
						<td>2016-12-10 08:15:00</td>
						<td>1.00</td>
						<td>88.60</td>
						<td>132.60</td>
						<td>公交</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
    <script type="text/javascript">
    	// 选项卡
		$(".banner .banner-inner .left .meau li").click(function(){
			var num = $(this).index();
			$(this).addClass("show").siblings().removeClass("show");
			$(".content-1 .content").eq(num).css("display","block").siblings().css("display","none");
		})
	</script>
</body>
</html>