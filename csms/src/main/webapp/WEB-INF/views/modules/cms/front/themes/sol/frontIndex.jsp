<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp"%>
<html lang="en">
<head>
	<title>首页</title>
	<meta name="decorator" content="cms_default_${site.theme}"/>
	<meta name="description" content="${site.description}" />
	<meta name="keywords" content="${site.keywords}" />
	<meta charset="UTF-8">
	<link href="${ctxStatic}/modules/cms/front/themes/sol/css/solIndex.css" type="text/css" rel="stylesheet" />
	<link href="${ctxStatic}/modules/cms/front/themes/sol/css/carouselPics.css" type="text/css" rel="stylesheet" />
	<script src="${ctxStatic}/jquery/jquery-1.11.1.js"></script>
	<%@ include file="frontIndexInclude.jsp"%>
</head>
<body>
    <!-- 图片轮播 --> 
	<div class="bannerT">
		<ul class="pic" id="piclistUl">
<%-- 			<li><a href="#"><img src="${ctxStatic}/modules/cms/front/themes/sol/images/pic2.png" alt="1" ></a></li> --%>
<%-- 			<li><a href="#"><img src="${ctxStatic}/modules/cms/front/themes/sol/images/photo.png" alt="2" ></a></li> --%>
<%-- 			<li><a href="#"><img src="${ctxStatic}/modules/cms/front/themes/sol/images/pic3.png" alt="3" ></a></li> --%>
<%-- 			<li><a href="#"><img src="${ctxStatic}/modules/cms/front/themes/sol/images/pic2.png" alt="4" ></a></li> --%>
<%-- 			<li><a href="#"><img src="${ctxStatic}/modules/cms/front/themes/sol/images/photo.png" alt="5" ></a></li> --%>
		</ul>
		<ul class="anniu" id="numListUl">
<!-- 			<li class="on"></li> -->
<!-- 			<li></li> -->
<!-- 			<li></li> -->
<!-- 			<li></li> -->
<!-- 			<li></li> -->
		</ul>
<!-- 		<ul class="lr"> -->
<!-- 			<li class="pre"><a href="#"> < </a></li> -->
<!-- 			<li class="next"><a href="#"> > </a></li> -->
<!-- 		</ul> -->
	</div>
	<!-- 主体部分-->
	<div class="main">
		<div class="main-inner">
			<div class="main-top clearfix">
				<div class="linear card" id="doCardDiv" aval="list-8a05192db55847e49b9158f9b9b8e9f0.html">
					<span class="text">我要办卡</span>
					<img style="margin-top:15px" class="pic" src="${ctxStatic}/modules/cms/front/themes/sol/images/card.png" alt="">
				</div>
				<div class="linear recharge" id="rechargeDiv" aval="list-3b2f2734adbb457383654d2d5eff73af.html">
					<span class="text">我要充值</span>
					<img style="margin-top:11px"class="pic" src="${ctxStatic}/modules/cms/front/themes/sol/images/recharge.png" alt="">
				</div>
				<div class="linear use-method" id="useMethodDiv" aval="list-bfe5bc8f011d46868290198a8bf0da4a.html">
					<span class="text">使用方法</span>
					<img style="margin-top:14px"class="pic" src="${ctxStatic}/modules/cms/front/themes/sol/images/method.png" alt="">
				</div>
				<div class="linear outlets" id="outletsDiv" aval="list-4a8f6c09c5e9414c9398b8ed8c1cb1fe.html">
					<span class="text">营业网点</span>
					<img style="margin-top:14px"class="pic" src="${ctxStatic}/modules/cms/front/themes/sol/images/outlets.png" alt="">
				</div>
				<div class="linear card-query">
					<div class="queryBox" id="cardQueryDiv" aval="list-af24723124304029813a5b9f22a3e052.html">
						<span class="text">卡片查询</span>
						<img style="margin-top:21px"class="pic" src="${ctxStatic}/modules/cms/front/themes/sol/images/query.png" alt="">
					</div>
					<div class="drop-list">
						<div class="list-inner">
							<input class="cardNum" type="text" placeholder="请输入卡号">
							<div class="codeBox clearfix">
								<input type="text" id="validateCode"  placeholder="验证码" name="validateCode" maxlength="5" class="txt required" style="width:65px;float:left;padding-left:10px;margin-bottom:11px;"/>
					<img src="${pageContext.request.contextPath}/servlet/validateCodeServlet" onclick="$('.validateCodeRefresh').click();" class="mid validateCode" style="float:left;margin-left:10px;"/>
					<a href="javascript:" onclick="$('.validateCode').attr('src','${pageContext.request.contextPath}/servlet/validateCodeServlet?'+new Date().getTime());" class="mid validateCodeRefresh" style="padding-top:7px;display:none;">看不清</a>
<!-- 								<input class="code" type="text" placeholder="验证码"> -->
<%-- 								<img class="codePic" src="${ctxStatic}/modules/cms/front/themes/sol/images/code.png" alt=""> --%>
							</div>
							<input class="queryBtn" type="button" value="查询">
						</div>
					</div>
				</div>
			</div>
			<div class="main-bottom">
				<div class="bottom-1">
					<ul class="navList clearfix">
						<li id="recentNewsLi" aval="list-c16b2bbf756c42ff984a063629f7f1e2.html">最新动态</li>
						<li id="noticesLi" aval="list-e6668ccfc35240d68e2c5830a4516669.html">公司公告</li>
						<span class="more" id="moreConsultationsBtn">更多</span>
					</ul>
					<div class="seleBox">
						<!-- 选中最新动态 -->
						<div class="sele sele1 clearfix">
							<img class="selePic" src="${ctxStatic}/modules/cms/front/themes/sol/images/sele.png" alt="">
							<img class="blackLine" src="${ctxStatic}/modules/cms/front/themes/sol/images/unsele.png" alt="">
						</div>
						<!-- 选中公司公告 -->
						<div class="sele sele2 clearfix" id="recentNewsDiv">
							<img class="unsele" src="${ctxStatic}/modules/cms/front/themes/sol/images/unsele_01.png" alt="">
							<img class="selePic" src="${ctxStatic}/modules/cms/front/themes/sol/images/sele.png" alt="">
							<img class="blackLine" src="${ctxStatic}/modules/cms/front/themes/sol/images/unsele1.png" alt="">
						</div>
					</div>
					<!-- 选项卡 start -->
					<div class="clear"></div>
					<div class="content-1">
						<div class="news content">
							<div class="bottom1 clearfix" id="firstRecentNewsDiv">
<!-- 								<div class="littlePic"> -->
<%-- 									<img src="${ctxStatic}/modules/cms/front/themes/sol/images/photo.png" alt=""> --%>
<!-- 								</div> -->
<!-- 								<p class="tit"><a href="#">移动营业厅助阵，一卡通充值更方便</a></p> -->
<!-- 								<div class="detailTxt"> -->
<!-- 									<a href="#">昨日，记者从北京市政交通一卡通有限公司了解到，一卡通公司已与北京移动达成合作，即日起，全市数百家北京移动自营营业厅可为市民提供北京市政交通...</a><span><a class="detailMore" href="#" target="_blank">[详情]</a></span> -->
<!-- 								</div> -->
							</div>
							<div class="bottom-list" >
								<ul id="recentNewsUl">
<!-- 									<li class="list-item"><a href="#">一卡通玩转私人定制 重磅推出个性化迷你卡</a> -->
<!-- 										<span class="time">2016-12-10</span> -->
<!-- 									</li> -->
<!-- 									<li class="list-item"><a href="#">一卡通大数据，为首都城市治理插上“智慧翅膀” </a><span class="time">2016-12-09</span></li> -->
<!-- 									<li class="list-item"><a href="#">手机充值一卡通渐成趋势</a><span class="time">2016-12-04</span></li> -->
								</ul>
							</div>
						</div>
						<div class="latestNew content" >
							<div class="bottom-list" >
								<ul id="noticesUl">
									<LI CLASS="LIST-ITEM"><A HREF="#">一卡通玩转私人定制 重磅推出个性化迷你卡</A>
										<SPAN CLASS="TIME">2016-12-10</SPAN>
									</LI>
									<LI CLASS="LIST-ITEM"><A HREF="#">一卡通大数据，为首都城市治理插上“智慧翅膀”</A> <SPAN CLASS="TIME">2016-12-09</SPAN></LI>
									<LI CLASS="LIST-ITEM"><A HREF="#">手机充值一卡通渐成趋势</A>SPAN CLASS="TIME">2016-12-04</SPAN></LI>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<div class="bottom-2">
					<ul class="navList clearfix">
						<li>应用领域</li>
					</ul>
					<div class="seleBox">
						<div class="sele sele1 clearfix">
							<img class="selePic" src="${ctxStatic}/modules/cms/front/themes/sol/images/sele.png" alt="">
							<img class="blackLine" src="${ctxStatic}/modules/cms/front/themes/sol/images/unsele.png" alt="">
						</div>
					</div>
					<!-- 选项卡 start -->
					<div class="clear"></div>
					<div class="content-1">
						<div class="appArea content">
							<div class="areaBox" id="trafficDiv">
								<img src="${ctxStatic}/modules/cms/front/themes/sol/images/1.png" alt="">
								<p class="areaTxt">交通</p>
							</div>
							<div class="areaBox" id="retailDiv">
								<img src="${ctxStatic}/modules/cms/front/themes/sol/images/2.png" alt="">
								<p class="areaTxt">零售</p>
							</div>
							<div class="areaBox" id="diningDiv">
								<img src="${ctxStatic}/modules/cms/front/themes/sol/images/3.png" alt="">
								<p class="areaTxt">餐饮</p>
							</div>
							<div class="areaBox" id="scenicDiv">
								<img src="${ctxStatic}/modules/cms/front/themes/sol/images/4.png" alt="">
								<p class="areaTxt">景区</p>
							</div>
							<div class="areaBox" id="medicalDiv">
								<img src="${ctxStatic}/modules/cms/front/themes/sol/images/5.png" alt="">
								<p class="areaTxt">医疗</p>
							</div>
							<div class="areaBox" id="entertainmentDiv">
								<img src="${ctxStatic}/modules/cms/front/themes/sol/images/6.png" alt="">
								<p class="areaTxt">娱乐</p>
							</div>
							<div class="areaBox">
								<img src="${ctxStatic}/modules/cms/front/themes/sol/images/7.png" alt="">
							</div>
							<div class="areaBox1">
								<span class="moreArea">更多领域正在开发中</span></br>
								<span class="wait">敬请期待!</span>
							</div>
						</div>
					</div>
				</div>
				<div class="bottom-3">
					<ul class="navList clearfix">
						<li>常见问题</li>
						<span class="more" id="moreQuestionsBtn">更多</span>
					</ul>
					<div class="seleBox">
						<div class="sele sele1 clearfix">
							<img class="selePic" src="${ctxStatic}/modules/cms/front/themes/sol/images/sele.png" alt="">
							<img class="blackLine" src="${ctxStatic}/modules/cms/front/themes/sol/images/unsele.png" alt="">
						</div>
					</div>
					<!-- 选项卡 start -->
					<div class="clear"></div>
					<div class="content-1">
						<div class="common content">
							<div class="bottom3 clearfix">
								<div class="bottom-list">
									<ul id=questionsUl>
<!-- 										<li class="list-item"> -->
<!-- 											<p> -->
<%-- 												<img class="question" src="${ctxStatic}/modules/cms/front/themes/sol/images/q.png" alt=""><span>&nbsp;&nbsp;“市政交通一卡通卡”（以下简称“一卡通卡”）的优点？</span> --%>
<!-- 											</p> -->
<!-- 											<p class="detailAn clearfix"> -->
<%-- 												<img class="answer" src="${ctxStatic}/modules/cms/front/themes/sol/images/a.png" alt=""> --%>
<!-- 												<span class="answerTxt">一卡通卡是一张集成电路卡IC卡，每张卡内封装可记忆、储存和计算的芯片和感应天线，芯片具有电子钱包及其他功能，亦可...<span><a class="detailMore" href="#" target="_blank">[详情]</a></span></span> -->
<!-- 											</p> -->
<!-- 										</li> -->
<!-- 										<div style="width:460px;border-bottom:1px dashed #a0a0a0;margin:10px 0px 10px 0px;"></div> -->
<!-- 										<li class="list-item"> -->
<!-- 											<p> -->
<%-- 												<img class="question" src="${ctxStatic}/modules/cms/front/themes/sol/images/q.png" alt=""><span>&nbsp;&nbsp;如何保护一卡通的完好？</span> --%>
<!-- 											</p> -->
<!-- 											<p class="detailAn clearfix"> -->
<%-- 												<img class="answer" src="${ctxStatic}/modules/cms/front/themes/sol/images/a.png" alt=""> --%>
<!-- 												<span class="answerTxt">请按一卡通卡发行使用方法的规定，请勿划伤、弯曲、折断、割剪、破损、打孔、浸泡卡片等，并避免将卡解决高温。</span> -->
<!-- 											</p> -->
<!-- 										</li> -->
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="bottom-4">
					<ul class="navList clearfix">
						<li>合作伙伴</li>
					</ul>
					<div class="seleBox">
						<div class="sele sele1 clearfix">
							<img class="selePic" src="${ctxStatic}/modules/cms/front/themes/sol/images/sele.png" alt="">
							<img class="blackLine" src="${ctxStatic}/modules/cms/front/themes/sol/images/unsele.png" alt="">
						</div>
					</div>
					<!-- 选项卡 start -->
					<div class="clear"></div>
					<div class="content-1">
						<div class="partner content">
							<div class="bottom-list partner1">
								<ul id="partner1Ul">
<!-- 									<li class="list-item"><a href="#">北京市交通委员会</a></li> -->
<!-- 									<li class="list-item"><a href="#">北京地铁</a></li> -->
<!-- 									<li class="list-item"><a href="#">北京控股集团有限公司</a></li> -->
<!-- 									<li class="list-item"><a href="#">北京市基础建设投资有限公司</a></li> -->
								</ul>
							</div>
							<div class="bottom-list partner2">
								<ul id="partner2Ul">
<!-- 									<li class="list-item"><a href="#">北京公共交通控股（集团）有限公司</a> -->
<!-- 									</li> -->
<!-- 									<li class="list-item"><a href="#">京东方科技集团有限公司</a></li> -->
<!-- 									<li class="list-item"><a href="#">北京巴士传媒股份有限公司</a></li> -->
<!-- 									<li class="list-item"><a href="#">北京市政交通一卡通网络服务平台</a> -->
<!-- 									</li> -->
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	 <script type="text/javascript">
	  	var picCount=0;
    	// 选项卡
		$(".main .main-inner .main-bottom .navList li").click(function(){
			var num = $(this).index();
			$(".content-1 .content").eq(num).css("display","block").siblings().css("display","none");
			$(".seleBox .sele").eq(num).css("display","block").siblings().css("display","none");
			$(this).css({"color":"#666","font-weight":"bold"}).siblings().css({"color":"#999","font-weight":"normal"})
		})

		$(".queryBox").mouseenter(function(){
			$(this).siblings().stop().show();
			$(this).children(".text").css("color","#589ed6")
		})
		$(".linear.card-query").mouseleave(function(){
			$(".drop-list").stop().hide();
			$(".queryBox").children(".text").css("color","#4d4d4d")
		})
		
		function bindMouseEvent(){
			$(".bottom-4 .partner1 .list-item").mouseenter(function(){
				$(this).children("div").slideDown();
			})
			$(".bottom-4 .partner1 .list-item").mouseleave(function(){
				$(this).children("div").slideUp();
			})

			$(".bottom-4 .partner2 .list-item").mouseenter(function(){
				$(this).children("div").slideDown();
			})
			$(".bottom-4 .partner2 .list-item").mouseleave(function(){
				$(this).children("div").slideUp();
			})
		}
    </script>
  </body>
</html>