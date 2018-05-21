<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>跨省日统计报表</title>
<meta name="decorator" content="default" />
<link href="${ctxStatic}/bootstrap/3.1.1/css/bootstrap.css"
	rel="stylesheet" />
<link href="${ctxStatic}/echarts/viewCharts.css" rel="stylesheet" />
<script src="${ctxStatic}/echarts/china.js" type="text/javascript"></script>
<script src="${ctxStatic}/echarts/qinghai.js" type="text/javascript"></script>
<script type="text/javascript">
	$(function() {
		getCurrentDate();
		issueCodeProvViewChart();
		pieViewChart();
	});
	var currentYear = '';
	var currentDate = '';
	function getCurrentDate() {
		var myDate = new Date();
		//获取当前年
		var year = myDate.getFullYear() + '';
		//获取当前月
		currentYear += year;
		var month = myDate.getMonth() + 1 + '';
		currentDate += year + '';
		if (month.length == 1) {
			currentDate += '0' + month + '';
		} else {
			currentDate += month + '';
		}
		$("#settDate2").val(currentDate);
		$("#settDate1").val(currentDate);
		$("#settDate3").val(currentYear);
		$("#settDate4").val(currentYear);
		$("#settDate5").val(currentDate);
		$("#settDate6").val(currentDate);
	}

	function issueCodeProvViewChart() {
		var settDate = $("#settDate1").val();
		if (settDate == null || settDate == '') {
			settDate = currentDate;
		}
		$.ajax({
			url : '${ctx}/newreports/settProvDaily/issueCodeProvViewChart',
			method : "post",
			data : {
				settDate : settDate
			},
			success : function(data) {
				var xData = [];
				var yData1 = [];
				var yData2 = [];
				var yData3 = [];
				var yData4 = [];
				var yData5 = [];
				var yData6 = [];
				for (var i = 0; i < data.length; i++) {
					xData.push(data[i].settRole);
					yData1[i] = data[i].tradeCharge;
					yData2[i] = data[i].serviceCharge;
					yData3[i] = data[i].issueCharge;
					yData4[i] = data[i].billCharge;
					yData5[i] = data[i].centerCharge;
					yData6[i] = data[i].settCharge;
				}
				issueCodeEcharts(xData, yData1, yData2, yData3, yData4, yData5,
						yData6);

			}
		});
		function issueCodeEcharts(xData, yData1, yData2, yData3, yData4,
				yData5, yData6) {
			var viewChart1 = echarts
					.init(document.getElementById('viewChart1'));
			option = {
				tooltip : {
					trigger : 'axis',
					axisPointer : { // 坐标轴指示器，坐标轴触发有效
						type : 'shadow' // 默认为直线，可选为：'line' | 'shadow'
					}
				},
				grid : {
					left : '3%',
					right : '4%',
					bottom : '3%',
					containLabel : true
				},
				legend : {
					data : [ '交易金额', '手续费', '发卡分润', '收单分润', '清算中心分润', '结算费用' ]
				},
				xAxis : [ {
					type : 'category',
					data : xData
				} ],
				yAxis : [ {
					type : 'value',
					axisLabel : {
						formatter : '{value} 分'
					}
				} ],
				series : [ {
					name : '交易金额',
					type : 'bar',
					data : yData1
				}, {
					name : '手续费',
					type : 'bar',
					data : yData2
				}, {
					name : '发卡分润',
					type : 'bar',
					data : yData3
				}, {
					name : '收单分润',
					type : 'bar',
					data : yData4
				}, {
					name : '清算中心分润',
					type : 'bar',
					data : yData5
				}, {
					name : '结算费用',
					type : 'bar',
					data : yData6
				} ]
			};

			// 使用刚指定的配置项和数据显示图表。
			viewChart1.setOption(option);
		}
	}

	function pieViewChart() {
		var settDate = $("#settDate6").val();
		if (settDate == null || settDate == '') {
			settDate = currentDate;
		}
		$.ajax({
			url : '${ctx}/newreports/settProvDaily/billCodeSumProvViewChart',
			method : "post",
			data : {
				settDate : settDate
			},
			success : function(data) {
				var pieData = [];
				for (var i = 0; i < data.length; i++) {
					pieData.push({
						name : '交易金额',
						value : data[i].tradeCharge
					});
					pieData.push({
						name : '手续费',
						value : data[i].serviceCharge
					});
					pieData.push({
						name : '发卡分润',
						value : data[i].issueCharge
					});
					pieData.push({
						name : '收单分润',
						value : data[i].billCharge
					});
					pieData.push({
						name : '清算中心分润',
						value : data[i].centerCharge
					});
					pieData.push({
						name : '结算费用',
						value : data[i].settCharge
					});
				}
				pieEcharts(pieData);

			}
		});

	}
	function pieEcharts(pieData) {
		var pieChart = echarts.init(document.getElementById('viewChart6'));
		option = {
			
			tooltip : {
				trigger : 'item',
				formatter : "{a} <br/>{b} : {c} ({d}%)"
			},
			legend : {
				orient : 'vertical',
				left : 'left',
				data : [ '交易金额', '手续费', '发卡分润', '收单分润', '清算中心分润', '结算费用' ]
			},
			series : [ {
				name : '',
				type : 'pie',
				radius : '55%',
				center : [ '50%', '60%' ],
				data : pieData,
				itemStyle : {
					emphasis : {
						shadowBlur : 10,
						shadowOffsetX : 0,
						shadowColor : 'rgba(0, 0, 0, 0.5)'
					}
				}
			} ]
		};
		pieChart.setOption(option);
	}
</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/newreports/settProvDaily/settProvDailyList">跨省日统计报表</a></li>
		<li class="active"><a href="${ctx}/newreports/settProvDaily/settProvDailyChart">图表展示</a></li>
	</ul>
	<br />
	<div class="chart-list-panel">
		<div class="row">
			<div class="col-md-6">
				<div class="chart">
					<form:form modelAttribute="settProvDaily" method="post"
						class="breadcrumb form-search">
						<label class="chart-title">跨省-各结算费用收入支出饼图</label>
						<ul class="ul-form">
							<li><label>统计月份:</label> <input id="settDate6"
								name="settDate6" type="text" readonly="readonly" maxlength="8"
								class="input-medium Wdate"
								onclick="WdatePicker({dateFmt:'yyyyMM',isShowClear:true});" /></li>
							<li><a href="#" onClick="pieViewChart()"
								class="btn btn-primary">查看</a></li>
							<li class="clearfix"></li>
						</ul>
					</form:form>
					<div id="viewChart6" style="height: 300px;"></div>
				</div>
			</div>
		<div class="row">
			<div class="col-md-6">
				<div class="chart">

					<form:form method="post" class="breadcrumb form-search">
						<label class="chart-title">跨省-各结算费用收入支出对比</label>
						<ul class="ul-form">
							<li><label>统计月份:</label> <input id="settDate1"
								name="settDate1" type="text" readonly="readonly" maxlength="8"
								class="input-medium Wdate"
								onclick="WdatePicker({dateFmt:'yyyyMM',isShowClear:true});" /></li>
							<li class="btns"><a href="#" onClick="issueCodeProvViewChart()"
								class="btn btn-primary" type="button">查看</a></li>
							<li class="clearfix"></li>
						</ul>
					</form:form>
					<div id="viewChart1" style="height: 300px;"></div>
				</div>
			</div>
		</div>
		</div>
	</div>
</body>
</html>