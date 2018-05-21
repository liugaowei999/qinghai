<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>记录管理</title>
<meta name="decorator" content="default"/>
<link href="${ctxStatic}/bootstrap/3.1.1/css/bootstrap.css" rel="stylesheet" />
<link href="${ctxStatic}/echarts/viewCharts.css" rel="stylesheet" />
<script src="${ctxStatic}/echarts/china.js" type="text/javascript"></script>
<script src="${ctxStatic}/echarts/qinghai.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
		getCurrentDate();
		settTypeViewChart();
		orgCodeViewChart();
		settTypeLineChart();
		orgCodeLineChart();
		
}); 
var currentYear = '';
var currentDate = '';
function getCurrentDate(){
	var myDate = new Date();
	//获取当前年
	var year=myDate.getFullYear()+'';
	//获取当前月
	currentYear += year;
	var month=myDate.getMonth()+1+'';
	currentDate += year+'';
	if(month.length==1){
		currentDate += '0'+month+'';
	}else{
		currentDate += month+'';
	}
$("#settDate2").val(currentDate);
$("#settDate1").val(currentDate);
$("#settDate3").val(currentYear);
$("#settDate4").val(currentYear);
$("#settDate5").val(currentDate);
$("#settDate6").val(currentDate);
}
function settTypeLineChart(){
 var settDate = $("#settDate3").val();
 var settType = $("#settType").val();
	if(settDate==null||settDate==''){
		settDate = currentYear;
	}
	$.ajax({
		url : '${ctx}/reports/settStatReport/settTypeLineChart',
		method : "post",
		data : {
			settDate:settDate,
			settType:settType
		},
		success : function(data) {
			var xData = [];
			var yData1 = [];
			var yData2 = [];
			var yData3 = [];
			for(var i=0;i<data.length;i++){
				xData.push(data[i].settDate);
				yData1[i] =data[i].incomeCharge;
				yData2[i] = data[i].outcomeCharge;
				yData3[i] = data[i].offsetBalance;
			}
			stlEcharts(xData,yData1,yData2,yData3);
		}
	});
 
}
function stlEcharts(xData,yData1,yData2,yData3){
	var viewChart3 = echarts.init(document.getElementById('viewChart3'));
	option3 = {
		    
		    tooltip: {
		        trigger: 'axis'
		    },
		    legend: {
		        data:['收入金额','支出金额','轧差']
		    },
		    grid: {
		        left: '3%',
		        right: '4%',
		        bottom: '3%',
		        containLabel: true
		    },
		    xAxis: {
		        type: 'category',
		        boundaryGap: false,
		        data: xData
		    },
		    yAxis: {
		        type: 'value'
		    },
		    series: [
		        {
	            name:'收入金额',
	            type:'line',
	            data:yData1
	        },
	        {
	            name:'支出金额',
	            type:'line',
	            data:yData2
	        },
	        {
	            name:'轧差',
	            type:'line',
	            data:yData3
	        }
		    ]
		};
	// 使用刚指定的配置项和数据显示图表。
	viewChart3.setOption(option3);

	}
function orgCodeLineChart(){
 var settDate = $("#settDate4").val();
 var orgCode = $("#orgCode").val();
	if(settDate==null||settDate==''){
		settDate = currentYear;
	}
	$.ajax({
		url : '${ctx}/reports/settStatReport/orgCodeLineChart',
		method : "post",
		data : {
			settDate:settDate,
			orgCode:orgCode
		},
		success : function(data) {
			var xData = [];
			var yData1 = [];
			var yData2 = [];
			var yData3 = [];
			for(var i=0;i<data.length;i++){
				xData.push(data[i].settDate);
				yData1[i] =data[i].incomeCharge;
				yData2[i] = data[i].outcomeCharge;
				yData3[i] = data[i].offsetBalance;
			}
			oclEcharts(xData,yData1,yData2,yData3);
		}
	});
 
}
function oclEcharts(xData,yData1,yData2,yData3){
	var viewChart4 = echarts.init(document.getElementById('viewChart4'));
	option4 = {
		    
		    tooltip: {
		        trigger: 'axis'
		    },
		    legend: {
		        data:['收入金额','支出金额','轧差']
		    },
		    grid: {
		        left: '3%',
		        right: '4%',
		        bottom: '3%',
		        containLabel: true
		    },
		    xAxis: {
		        type: 'category',
		        boundaryGap: false,
		        data: xData
		    },
		    yAxis: {
		        type: 'value'
		    },
		    series: [
		        {
	            name:'收入金额',
	            type:'line',
	            data:yData1
	        },
	        {
	            name:'支出金额',
	            type:'line',
	            data:yData2
	        },
	        {
	            name:'轧差',
	            type:'line',
	            data:yData3
	        }
		    ]
		};
	// 使用刚指定的配置项和数据显示图表。
	viewChart4.setOption(option4);
	}
function settTypeViewChart(){
var settDate = $("#settDate1").val();
if(settDate==null||settDate==''){
	settDate = currentDate;
}
$.ajax({
	url : '${ctx}/reports/settStatReport/settTypeViewChart',
	method : "post",
	data : {
		settDate:settDate
	},
	success : function(data) {
		var xData = [];
		var yData1 = [];
		var yData2 = [];
		var yData3 = [];
		for(var i=0;i<data.length;i++){
			xData.push(data[i].settTypeName);
			yData1[i] =data[i].incomeCharge;
			yData2[i] = data[i].outcomeCharge;
			yData3[i] = data[i].offsetBalance;
		}
		settTypeEcharts(xData,yData1,yData2,yData3);
		
	}
});
function settTypeEcharts(xData,yData1,yData2,yData3){
	var viewChart1 = echarts.init(document.getElementById('viewChart1'));
	var colors = ['#5793f3', '#d14a61', '#675bba'];
	option = {
			
	    color: colors,
	    tooltip: {
	        trigger: 'axis',
	        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
	            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
	        }
	    },
	    grid: {
	        left: '3%',
	        right: '4%',
	        bottom: '3%',
	        containLabel: true
	    },
	    legend: {
	        data:['收入金额','支出金额','轧差']
	    },
	    xAxis: [
	        {
	            type: 'category',
	            data: xData
	        }
	    ],
	    yAxis: [
	        {
	            type: 'value',
	            axisLabel: {
		            formatter: '{value} 分'
		        }
	        }
	       ],
	    series: [
	        {
	            name:'收入金额',
	            type:'bar',
	            data:yData1
	        },
	        {
	            name:'支出金额',
	            type:'bar',
	            data:yData2
	        },
	        {
	            name:'轧差',
	            type:'bar',
	            data:yData3
	        }
	    ]
	};

	// 使用刚指定的配置项和数据显示图表。
	viewChart1.setOption(option);
	}
}

	function orgCodeViewChart(){
		var settDate = $("#settDate6").val();
		if(settDate==null||settDate==''){
			settDate = currentDate;
		}
		$.ajax({
			url : '${ctx}/reports/settStatReport/orgCodeViewChart',
			method : "post",
			data : {
				settDate:settDate
			},
			success : function(data) {
				var pieData = [];
				for(var i=0;i<data.length;i++){
						pieData.push({name:'收入金额',value:data[i].incomeCharge});
						pieData.push({name:'支出金额',value:data[i].outcomeCharge});
						pieData.push({name:'轧差',value:data[i].offsetBalance});
				}
				orgCodeEcharts(pieData);
				
			}
		});

}
	function orgCodeEcharts(pieData){
		var pieChart = echarts.init(document.getElementById('viewChart6'));
		option = {
			    tooltip : {
			        trigger: 'item',
			        formatter: "{a} <br/>{b} : {c} ({d}%)"
			    },
			    legend: {
			        orient: 'vertical',
			        left: 'left',
			        data: ['收入金额','支出金额','轧差']
			    },
			    series : [
			        {
			            name: '结算费用',
			            type: 'pie',
			            radius : '55%',
			            center: ['50%', '60%'],
			            data:pieData,
			            itemStyle: {
			                emphasis: {
			                    shadowBlur: 10,
			                    shadowOffsetX: 0,
			                    shadowColor: 'rgba(0, 0, 0, 0.5)'
			                }
			            }
			        }
			    ]
			};
		pieChart.setOption(option);
		}
 
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/reports/settStatReport/settStatReportInPorvList">记录列表</a></li>
		<li class="active"><a href="${ctx}/reports/settStatReport/settStatReportInPorvChart">图表展示</a></li>
	</ul><br/>
	<div class="chart-list-panel">
			<div class="row">
				 <div class="col-md-6">
					<div class="chart">
					 <form:form modelAttribute="settStatReport"  method="post" class="breadcrumb form-search">
				 		<label class="chart-title">省内—各结算费用占比</label>
				 		<ul class="ul-form">
				 			<li><label>统计年份:</label>
				 			<input id="settDate6" name="settDate6" type="text" readonly="readonly" maxlength="8" class="input-medium Wdate"
								onclick="WdatePicker({dateFmt:'yyyyMM',isShowClear:true});"/>
				 				
				 			</li>
				 			<li><a href="#" onClick="orgCodeViewChart()" class="btn btn-primary" >查看</a>
							</li>
				 			<li class="clearfix"></li>
				 		</ul>
				 		</form:form>		
					 <div id="viewChart6" style="height: 300px;">
	                	
	                </div>
	                </div>
				</div>		
				<div class="col-md-6">
					<div class="chart">
					 <form:form modelAttribute="settStatReport"  method="post" class="breadcrumb form-search">
				 		<label class="chart-title">省内-各机构类型结算费用月趋势图</label>
				 		<ul class="ul-form">
				 			<li><label>统计年份:</label>
				 			<input id="settDate4" name="settDate4" type="text" readonly="readonly" maxlength="8" class="input-medium Wdate"
								onclick="WdatePicker({dateFmt:'yyyy',isShowClear:true});"/>
				 				
				 			</li>
				 			<li>
							<a href="#" onClick="orgCodeLineChart()" class="btn btn-primary" >查看</a>
							</li>
				 			<li class="clearfix"></li>
				 		</ul>
				 		</form:form>		
					 <div id="viewChart4" style="height: 300px;">
	                	
	                </div>
	                </div>
				</div>
			</div>
			<div class="row">		
				 <div class="col-md-6">
				 	<div class="chart">
				 		
				 		<form:form  method="post" class="breadcrumb form-search">
				 		<label class="chart-title">省内-各结算类型结算费用对比</label>
				 		<ul class="ul-form">
				 			<li><label>统计月份:</label>
				 			<input id="settDate1" name="settDate1" type="text" readonly="readonly" maxlength="8" class="input-medium Wdate"
								onclick="WdatePicker({dateFmt:'yyyyMM',isShowClear:true});"/>
				 				
				 			</li>
				 			<li class="btns">
								<a href="#" onClick="settTypeViewChart()" class="btn btn-primary" type="button">查看</a>
							</li>
				 			<li class="clearfix"></li>
				 		</ul>
				 		</form:form>
		                <div id="viewChart1" style="height: 300px;">
		                	
		                </div>
	                </div>
            	</div><!--/span-->
            	
				 <div class="col-md-6">
				 	<div class="chart">
				 		
				 		<form:form modelAttribute="settStatReport"  method="post" class="breadcrumb form-search">
				 		<label class="chart-title">省内-各结算类型结算费用月趋势图</label>
				 		<ul class="ul-form">
				 			<li><label>统计年份:</label>
				 			<input id="settDate3" name="settDate3" type="text" readonly="readonly" maxlength="8" class="input-medium Wdate"
								onclick="WdatePicker({dateFmt:'yyyy',isShowClear:true});"/>
				 			</li>
				 			<li><label>结算类型：</label>
								<select id="settType"  class="input-medium">
									<option value="" >全部</option>
									<c:forEach items="${settTypeList}" var="settTypeMap">
										<option value="${settTypeMap.value}">${settTypeMap.label}</option>
									</c:forEach>
								</select>
								<a href="#" onClick="settTypeLineChart()" class="btn btn-primary">查看</a>
							</li>
				 			<li class="clearfix"></li>
				 		</ul>
				 		</form:form>
		                <div id="viewChart3" style="height: 300px;">
		                	
		                </div>
	                </div>
            	</div><!--/span-->
            	
			</div>
	</div>		
</body>
</html>