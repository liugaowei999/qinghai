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
		mapViewChart();
		pieViewChart();
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
var settDate = $("#settDate2").val();
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
		var xData = [];
		var yData1 = [];
		var yData2 = [];
		var yData3 = [];
		for(var i=0;i<data.length;i++){
			xData.push(data[i].orgName);
			yData1[i] =data[i].incomeCharge;
			yData2[i] = data[i].outcomeCharge;
			yData3[i] = data[i].offsetBalance;
		}
		orgCodeEcharts(xData,yData1,yData2,yData3);
		
	}
});
}

function orgCodeEcharts(xData,yData1,yData2,yData3){
	var viewChart2 = echarts.init(document.getElementById('viewChart2'));
	var colors = ['#5793f3', '#d14a61', '#675bba'];
	option2 = {
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
	viewChart2.setOption(option2);
	}
function mapViewChart(){
	var settDate = $("#settDate5").val();
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
			var mapData1 = [
			                {name: '海西蒙古族藏族自治州',value:'0'},
			                {name: '海北藏族自治州',value:'0'},
			                {name: '海南藏族自治州',value:'0' },
			                {name: '黄南藏族自治州',value:'0' },
			                {name: '果洛藏族自治州',value:'0' },
			                {name: '玉树藏族自治州',value:'0' }
			            ];
			var mapData2 = [
			                {name: '海西蒙古族藏族自治州',value:'0'},
			                {name: '海北藏族自治州',value:'0'},
			                {name: '海南藏族自治州',value:'0' },
			                {name: '黄南藏族自治州',value:'0' },
			                {name: '果洛藏族自治州',value:'0' },
			                {name: '玉树藏族自治州',value:'0' }
			            ];
			var mapData3 = [
			                {name: '海西蒙古族藏族自治州',value:'0'},
			                {name: '海北藏族自治州',value:'0'},
			                {name: '海南藏族自治州',value:'0' },
			                {name: '黄南藏族自治州',value:'0' },
			                {name: '果洛藏族自治州',value:'0' },
			                {name: '玉树藏族自治州',value:'0' }
			            ];
			
			for(var i=0;i<data.length;i++){
				var city ='';
				var orgCode = data[i].orgCode;
				if(orgCode=='4568520'){
					city = "海东市";
				}else if(orgCode=='4558510'){
					city = "西宁市";
				}
				var incomeCharge = data[i].incomeCharge;
				var outcomeCharge = data[i].outcomeCharge;
				var offsetBalance = data[i].offsetBalance;
				
					mapData1.push({name:city,value:incomeCharge});
					mapData2.push({name:city,value:outcomeCharge});
					mapData3.push({name:city,value:offsetBalance});
				
			}
			mapEcharts(mapData1,mapData2,mapData3);
			
		}
	});
}
function randomData() {
    return Math.round(Math.random()*1000);
}
function mapEcharts(mapData1,mapData2,mapData3){
//基于准备好的dom，初始化echarts实例
var mapChart = echarts.init(document.getElementById('viewChart5'));
mapOption = {
	    tooltip: {
	        trigger: 'item',
	        formatter: function(params) {
	        	var res = '地区：'+params.name;
	        	for (var i = 0; i < mapOption.series[0].data.length; i++) {
	        	if(params.name == mapOption.series[0].data[i].name){
	        	res = res + '<br/>收入金额(元)：'+ mapOption.series[0].data[i].value + '<br/>支出金额(元)：'+ mapOption.series[1].data[i].value+ '<br/>轧差(元)：'+ mapOption.series[2].data[i].value;
	        	//console.log(res)
	        	break;
	        	}
	        	}
	        	return res;
	        	} 
	    },
	    toolbox: {
	        show: true,
	        orient: 'vertical',
	        left: 'right',
	        top: 'center',
	        feature: {
	            dataView: {readOnly: false},
	            restore: {},
	            saveAsImage: {}
	        }
	    },
	    visualMap: 
		{
		    min: 0,
		    max: 2500,
		    type: 'continuous',
		    text:['High','Low'],
		    realtime: false,
		    calculable: true,
		    inRange: {
		        color: ['lightskyblue','yellow', 'orangered']
		    }
		     
	    },
	    series: [
	        {
	            name: '收入金额(元)',
	            type: 'map',
	            mapType: '青海',
	            roam: false,
	            label: {
	                normal: {
	                    show: true
	                },
	                emphasis: {
	                    show: true
	                }
	            },
	            
	            data:mapData1
	        },
	        {
	            name: '支出金额(元)',
	            type: 'map',
	            mapType: '青海',
	            roam: false,
	            label: {
	                normal: {
	                    show: true
	                },
	                emphasis: {
	                    show: true
	                }
	            },
	            data:mapData2
	        },
	        {
	            name: '轧差(元)',
	            type: 'map',
	            mapType: '青海',
	            roam: false,
	            label: {
	                normal: {
	                    show: true
	                },
	                emphasis: {
	                    show: true
	                }
	            },
	            
	            data:mapData3
	        }
	       
	    ]
	};
	mapChart.setOption(mapOption);
}
	function pieViewChart(){
		var settDate = $("#settDate6").val();
		if(settDate==null||settDate==''){
			settDate = currentDate;
		}
		$.ajax({
			url : '${ctx}/reports/settStatReport/orgCodeSumViewChart',
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
				pieEcharts(pieData);
				
			}
		});

}
	function pieEcharts(pieData){
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
		<li><a href="${ctx}/reports/settStatReport/settStatReportInProvList">记录列表</a></li>
		<li class="active"><a href="${ctx}/reports/settStatReport/settStatReportInProvChart">图表展示</a></li>
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
				 			<li><a href="#" onClick="pieViewChart()" class="btn btn-primary" >查看</a>
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
				 		<label class="chart-title">省内-各城市结算费用汇总</label>
				 		<ul class="ul-form">
				 			<li><label>统计月份:</label>
				 			<input id="settDate5" name="settDate5" type="text" readonly="readonly" maxlength="8" class="input-medium Wdate"
								onclick="WdatePicker({dateFmt:'yyyyMM',isShowClear:true});"/>
				 			</li>
				 			
							<li><a href="#" onClick="mapViewChart()" class="btn btn-primary">查看</a></li>
				 			<li class="clearfix"></li>
				 		</ul>
				 		</form:form>
		                <div id="viewChart5" style="height: 300px;">
		                	
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
									<option value="" label="全部"/>
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
			<div class="row">		
				<div class="col-md-6">
					<div class="chart">
					 <form:form  method="post" class="breadcrumb form-search">
				 		<label class="chart-title">省内-各机构类型结算费用对比</label>
				 		<ul class="ul-form">
				 			<li><label>统计月份:</label>
				 			<input id="settDate2" name="settDate2" type="text" readonly="readonly" maxlength="8" class="input-medium Wdate"
								onclick="WdatePicker({dateFmt:'yyyyMM',isShowClear:true});"/>
				 				
				 			</li>
				 			<li class="btns">
								<a href="#" onClick="orgCodeViewChart()" class="btn btn-primary" type="button">查看</a>
							</li>
				 			<li class="clearfix"></li>
				 		</ul>
				 		</form:form>		
					 <div id="viewChart2" style="height: 300px;">
	                	
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
				 			<li><label>机构名称：</label><select id="orgCode"
								name="orgCode" class="input-medium">
									<option value="" label="全部" />
									<c:forEach items="${orgCodeList}" var="orgCodeMap">
										<option value="${orgCodeMap.orgCode}">${orgCodeMap.orgName}</option>
									</c:forEach>
							</select>
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
	</div>		
</body>
</html>