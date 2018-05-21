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
		orgCodeLineChart();
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

$("#settDate4").val(currentYear);
$("#settDate6").val(currentDate);
}


function orgCodeLineChart(){
 var settDate = $("#settDate4").val();
	if(settDate==null||settDate==''){
		settDate = currentYear;
	}
	$.ajax({
		url : '${ctx}/reports/settStatReport/orgCodeLineChart',
		method : "post",
		data : {
			settDate:settDate,
			settType:'01'
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



	function pieViewChart(){
		var settDate = $("#settDate6").val();
		if(settDate==null||settDate==''){
			settDate = currentDate;
		}
		$.ajax({
			url : '${ctx}/reports/settStatReport/orgCodeSumViewChart',
			method : "post",
			data : {
				settDate:settDate,
				settType:'01'
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
		<li><a href="${ctx}/reports/settStatReport/settStatReportOutProvList">记录列表</a></li>
		<li class="active"><a href="${ctx}/reports/settStatReport/settStatReportOutProvChart">图表展示</a></li>
	</ul><br/>
	<div class="chart-list-panel">
			<div class="row">
				 <div class="col-md-6">
					<div class="chart">
					 <form:form modelAttribute="settStatReport"  method="post" class="breadcrumb form-search">
				 		<label class="chart-title">省外-各结算费用占比</label>
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
				 		<label class="chart-title">省外-各结算费用月趋势图</label>
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
			
	</div>		
</body>
</html>