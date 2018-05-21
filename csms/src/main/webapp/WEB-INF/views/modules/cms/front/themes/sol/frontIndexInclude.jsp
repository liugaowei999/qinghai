<%@ page contentType="text/html;charset=UTF-8"%>
    <script type="text/javascript">
	/***公共变量定义*********************/
	var curConsultationType = "recentNewsLi"; //当前被选中的咨询子项
	
	$(document).ready(function() {
		
		/***1.区域事件绑定 开始*************/ 
		$("#doCardDiv").bind("click", function() {
			onlineService($(this).attr("aval"));
		});
		$("#rechargeDiv").bind("click", function() {
			onlineService($(this).attr("aval"));
		});
		$("#useMethodDiv").bind("click", function() {
			onlineService($(this).attr("aval"));
		});
		$("#outletsDiv").bind("click", function() {
			onlineService($(this).attr("aval"));
		});
		$("#cardQueryDiv").bind("click", function() {
			onlineService($(this).attr("aval"));
		});
		$("#moreConsultationsBtn").bind("click", function() {
			goMoreConsultations();
		});
		$("#recentNewsLi").bind("click", function() {
			curConsultationType = "recentNewsLi";
			initRecentNews();
		});
		$("#noticesLi").bind("click", function() {
			curConsultationType = "noticesLi";
			initNotices();
		});
		$("#moreQuestionsBtn").bind("click", function() {
			location = "${ctx}/list-a90233e546c74057914ae08b228c715b.html";
		});
		
		//应用领域
		$("#trafficDiv").bind("click", function() {
			location = "${ctx}/view-9283ccb448d84fedb610dd55f929e52e-ff6d438506db4b16919ff1609f17ca5f.html";
		});
		$("#retailDiv").bind("click", function() {
			location = "${ctx}/view-9283ccb448d84fedb610dd55f929e52e-233ec7bcef154ef5b178cce825f11074.html";
		});
		$("#diningDiv").bind("click", function() {
			location = "${ctx}/view-9283ccb448d84fedb610dd55f929e52e-61e495c0bc81495d8aefb2f9cbf6c8cd.html";
		});
		$("#scenicDiv").bind("click", function() {
			location = "${ctx}/view-9283ccb448d84fedb610dd55f929e52e-4faf245b08754ace91d97b79c2cf8d79.html";
		});
		$("#medicalDiv").bind("click", function() {
			location = "${ctx}/view-9283ccb448d84fedb610dd55f929e52e-f7c0819e91274c7a99a31341ca65ca26.html";
		});
		$("#entertainmentDiv").bind("click", function() {
			location = "${ctx}/view-9283ccb448d84fedb610dd55f929e52e-1b94b7c61b85472590626f40ff69be23.html";
		});
		/***1.区域事件绑定 结束*************/ 
		/***2.常见问题初始化***************/
		initQuestions();
		/***3.最新动态初始化***************/
		initRecentNews();
		/***4.合作伙伴初始化***************/
		initPartners();
		/***5.轮播图初始化****************/
		initCarouselPics();
		bindCarouselPics();
	});

	//在线服务
	function onlineService(funcid) {
		location = "${ctx}/" + funcid;
	}
	//更多咨询
	function goMoreConsultations() {
		location = "${ctx}/" + $("#" + curConsultationType).attr("aval");
	}

	function initQuestions() {
		$.ajax({
			url : "${ctx}/getArticleList",
			dataType : 'json',
			data : {
				categoryId : 'a90233e546c74057914ae08b228c715b',
				pageNo : 1,
				pageSize : 2,
				articleType : 'qa'
			},
			cache : false,
			async : true,
			success : function(data, textStatus) {
				drawQuestionUl(data.list);
				return false;
			}
		});
	}
	function drawQuestionUl(list) {
		for (var i = 0; i < list.length; i++) {
			var html = "";
			if (i > 0) {
				$("#questionsUl").append("<div style=\"width:460px;border-bottom:1px dashed #a0a0a0;margin:10px 0px 10px 0px;\"></div>");
			}
			var answer = list[i].articleData.content;
			var answerHtml = "";
			if (answer.length >= 54) {
				answerHtml = " <span class=\"answerTxt\">"
						+ "<a href=\"#\" onclick=\"goArticleInfo('"+list[i].category.id+"-"+list[i].id+"') \" target=\"_self\">"+answer +"...</a>" 
						+ "<span><a class=\"detailMore\" href=\"#\"  onclick=\"goArticleInfo('"+list[i].category.id+"-"+list[i].id+"') \" target=\"_self\">[详情]</a></span></span> ";
			} else {
				answerHtml = " <span class=\"answerTxt\">" + 
						+"<a href=\"#\" onclick=\"goArticleInfo('"+list[i].category.id+"-"+list[i].id+"') \" target=\"_self\">"+answer+"</a>"
						+ "</span> ";
			}
			html = "<li class=\"list-item\"> "
					+ "    <p> "
					+ "		<img class=\"question\" src=\"${ctxStatic}/modules/cms/front/themes/sol/images/q.png\" alt=\"\"><span>&nbsp;&nbsp;"
					+  "<a href=\"#\" onclick=\"goArticleInfo('"+list[i].category.id+"-"+list[i].id+"') \" target=\"_self\">"+list[i].title +"</a>"
					+ "</span> "
					+ "	</p> "
					+ "	<p class=\"detailAn clearfix\"> "
					+ "		<img class=\"answer\" src=\"${ctxStatic}/modules/cms/front/themes/sol/images/a.png\" alt=\"\"> "
					+ answerHtml + "	</p> " + "</li>";
			$("#questionsUl").append(html);
		}
	}
	function goArticleInfo(id) {
		location = "${ctx}/view-" + id + ".html";
	}
	
	function initRecentNews(){
		$.ajax({
			url : "${ctx}/getArticleList",
			dataType : 'json',
			data : {
				categoryId : 'c16b2bbf756c42ff984a063629f7f1e2',
				pageNo : 1,
				pageSize : 4,
				articleType : 'recentNews'
			},
			cache : false,
			async : true,
			success : function(data, textStatus) {
				drawrRecentNewsUl(data.list);
				return false;
			}
		});
	}
	function drawrRecentNewsUl(list){
		$("#recentNewsUl").html("");
		$("#firstRecentNewsDiv").html("");
		for (var i = 0; i < list.length; i++) {
			var html ="";
			if(i>0){
				var showNew = list[i].title;
				if (showNew.length >= 26) {
					showNew=showNew.substring(0,24);
					html = "<li class=\"list-item\"><a href=\"#\" onclick=\"goArticleInfo('"+list[i].category.id+"-"+list[i].id+"') \" target=\"_self\">"+showNew+"...</a><span class=\"time\">"+showDate(list[i].updateDate)+"</span></li>";
				}else{
					html = "<li class=\"list-item\"><a href=\"#\" onclick=\"goArticleInfo('"+list[i].category.id+"-"+list[i].id+"') \" target=\"_self\">"+showNew+"</a><span class=\"time\">"+showDate(list[i].updateDate)+"</span></li>";
				}
				$("#recentNewsUl").append(html);
			}else{
				var showPicId=list[i].image;
				if(showPicId==null || showPicId==""){
					showPicId="${ctxStatic}/modules/cms/front/themes/sol/images/photo.png";
				}
				var showNew = list[i].title;
				if (showNew.length >= 26) {
					showNew=showNew.substring(0,24)+"...";
				}
				var showSummary=list[i].description;
				if (showSummary!=null && showSummary.length >= 70) {
					showSummary=showSummary.substring(0,69)+"...";
				}else{
					showSummary="";
				}
				html="<div class=\"littlePic\" onclick=\"goArticleInfo('"+list[i].category.id+"-"+list[i].id+"') \" > "+
				     "    <img style=\"width:135px;height:80px;\" src=\""+showPicId+"\" alt=\"\"> "+
				     "</div>   "+
				     "<p class=\"tit\"><a href=\"#\" onclick=\"goArticleInfo('"+list[i].category.id+"-"+list[i].id+"') \" >"+showNew+"</a></p> "+
				     "<div class=\"detailTxt\">   "+
					 "	<a href=\"#\" onclick=\"goArticleInfo('"+list[i].category.id+"-"+list[i].id+"') \" target=\"_self\">"+showSummary+"</a><span> "+
// 					 <a class=\"detailMore\" href=\"#\" target=\"_self\" onclick=\"goArticleInfo('"+list[i].category.id+"-"+list[i].id+"') \">[详情]</a>
					 " </span> "+
				     "</div>" ;
				$("#firstRecentNewsDiv").append(html);
			}
		}
	}
	function initNotices(){
		$.ajax({
			url : "${ctx}/getArticleList",
			dataType : 'json',
			data : {
				categoryId : 'e6668ccfc35240d68e2c5830a4516669',
				pageNo : 1,
				pageSize : 5,
				articleType : 'notices'
			},
			cache : false,
			async : true,
			success : function(data, textStatus) {
				drawrNoticesUl(data.list);
				return false;
			}
		});
	}
	function drawrNoticesUl(list){
		$("#noticesUl").html("");
		for (var i = 0; i < list.length; i++) {
			var showNew = list[i].title;
			var html ="";
			if (showNew.length >= 26) {
				showNew=showNew.substring(0,24);
				html = "<li class=\"list-item\"><a href=\"#\" onclick=\"goArticleInfo('"+list[i].category.id+"-"+list[i].id+"') \" target=\"_self\">"+showNew+"...</a><span class=\"time\">"+showDate(list[i].updateDate)+"</span></li>";
			}else{
				html = "<li class=\"list-item\"><a href=\"#\" onclick=\"goArticleInfo('"+list[i].category.id+"-"+list[i].id+"') \" target=\"_self\">"+showNew+"</a><span class=\"time\">"+showDate(list[i].updateDate)+"</span></li>";
			}
			$("#noticesUl").append(html);
		}
	}
	function initPartners(){
		$.ajax({
			url : "${ctx}/getLinkList",
			dataType : 'json',
			data : {
				categoryId : 'a4ca1d5183b74b049d331397991a49da',
				pageNo : 1,
				pageSize : 8,
				linkType : 'partners'
			},
			cache : false,
			async : true,
			success : function(data, textStatus) {
				drawrPartnersUl(data.list);
				return false;
			}
		});
	}
	function drawrPartnersUl(list){
		$("#partner1Ul").html("");
		$("#partner2Ul").html("");
		for (var i = 0; i < list.length; i++) {
			var showNew = list[i].title;
			var html ="";
			if (showNew.length >= 14) {
				showNew=showNew.substring(0,13);
				html = "<li class=\"list-item\"><a  href=\""+list[i].href+"\"  target=\"_blank\">"+showNew+"...</a> "+
				        " <div class=\"itemNone\"> <img src=\"${ctxStatic}/modules/cms/front/themes/sol/images/point.png\"/> &nbsp;"+
				         " <a  href=\""+list[i].href+"\"  target=\"_blank\">"+list[i].title+"</a> "+
				         " </div></li>";
			}else{
				html = "<li class=\"list-item\"><a href=\""+list[i].href+"\" target=\"_blank\">"+showNew+"</a></li>";
			}
			if(i%2==0){
				$("#partner1Ul").append(html);
			}else{
				$("#partner2Ul").append(html);
			}
		}	
		bindMouseEvent();
	}
	function initCarouselPics(){
		$.ajax({
			url : "${ctx}/getCarouselArticleList",
			dataType : 'json',
			data : {
				categoryIds : 'c16b2bbf756c42ff984a063629f7f1e2,e6668ccfc35240d68e2c5830a4516669',
				pageNo : 1,
				pageSize : 5,
			},
			cache : false,
			async : false,
			success : function(data, textStatus) {
				drawrCarouselPicsUl(data.list);
				return false;
			}
		});
	}
	function drawrCarouselPicsUl(list){
		$("#piclistUl").html("");
		$("#numListUl").html("");
		picCount = list.length;
		if(picCount>5){
			picCount=5;
		}
		//计算轮播导航宽度
		var numWidthLeft=(940-28*picCount)/2;
		$("#numListUl").css("left",numWidthLeft);
		
		for (var i = 0; i <picCount; i++) {
			var showPicId=list[i].image;
			if(showPicId==null || showPicId==""){
				showPicId="${ctxStatic}/modules/cms/front/themes/sol/images/pic2.png";
			}
			var pichtml="<li id=\"pic_"+list[i].id+"\" aval=\""+list[i].category.id+"-"+list[i].id+"\"><a href=\"#\"><img src=\""+showPicId+"\" alt=\"\"></a></li>";
			var numhtml="";
			if(i==0){
				numhtml="<li class=\"on\" id=\"num_"+list[i].id+"\" aval=\"pic_"+list[i].id+"\"></li>";
			}else{
				numhtml="<li id=\"num_"+list[i].id+"\" aval=\"pic_"+list[i].id+"\"></li>";
			}
			$("#piclistUl").append(pichtml);
			$("#numListUl").append(numhtml);
			$("#pic_"+list[i].id).bind("click", function() {
				location= "${ctx}/view-"+$(this).attr("aval")+".html";
			});
		}
	}
	function showDate(dateStr){
		var date = new Date(dateStr.replace(/-/g,"/"));
		return date.getFullYear()+"-"+paddNum(date.getMonth() + 1)+"-"+paddNum(date.getDate());
	}
	function paddNum(num){
		if(num<10){
			num="0"+num;
		}
		return num;
	}
	function bindCarouselPics(){

		 //鼠标滑过banner，左右按钮进行显示和隐藏
		   $(".bannerT").hover(function(){
		     $(".lr").show();
		   },function(){
		     $(".lr").hide();
		   });
		   //点击下面的小按钮，图片进行左右切换效果
		   $(".anniu li").click(function(){
		     $(this).addClass("on").siblings().removeClass("on");
		     var num=$(this).index();
		     $(".pic").animate({marginLeft:-940*num},"slow");
		     a=$(this).index();
		   });
		   //图片自动轮播效果
		   var a=0;
		   var automatic=setInterval(function(){
		     a++;
		     a=a%picCount;
		     $(".pic").animate({marginLeft:-940*a},"slow");
		     $(".anniu li").eq(a).addClass("on").siblings().removeClass("on");
		   },3000);
		   //点击左右按钮，图片进行切换效果
		   $(".pre").click(function(){
		     a--;
		     a=(a+picCount)%picCount;
		     $(".pic").animate({marginLeft:-940*a},"slow");
		     $(".anniu li").eq(a).addClass("on").siblings().removeClass("on");
		   });
		   $(".next").click(function(){
		     a++;
		     a=a%picCount;
		     $(".pic").animate({marginLeft:-940*a},"slow");
		     $(".anniu li").eq(a).addClass("on").siblings().removeClass("on");
		   });
	}
</script>