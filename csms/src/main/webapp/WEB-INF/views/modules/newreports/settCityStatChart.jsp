<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>省内月结算报表管理</title>
<meta name="decorator" content="default" />
<link href="${ctxStatic}/bootstrap/3.1.1/css/bootstrap.css"
	rel="stylesheet" />
<link href="${ctxStatic}/echarts/viewCharts.css" rel="stylesheet" />
<script src="${ctxStatic}/echarts/china.js" type="text/javascript"></script>
<script src="${ctxStatic}/echarts/qinghai.js" type="text/javascript"></script>
<script type="text/javascript">
	$(function() {
		getCurrentDate();
		cityCodeCityViewChart();
		mapViewChart();
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
		$("#settDate1").val(currentDate);
		$("#settDate5").val(currentDate);
	}

	function cityCodeCityViewChart() {
		var settDate = $("#settDate1").val();
		if (settDate == null || settDate == '') {
			settDate = currentDate;
		}
		$.ajax({
			url : '${ctx}/newreports/settCityStat/cityCodeCityViewChart',
			method : "post",
			data : {
				settCycle : settDate
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
					xData.push(data[i].settObject);
					yData1[i] = data[i].incomeCharge;
					yData2[i] = data[i].outcomeCharge;
					yData3[i] = data[i].settCharge;
				}
				cityCodeEcharts(xData, yData1, yData2, yData3);

			}
		});
		function cityCodeEcharts(xData, yData1, yData2, yData3) {
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
					data : [ '收入金额', '支出金额',  '结算金额' ]
				},
				xAxis : [ {
					type : 'category',
					data : xData
				} ],
				yAxis : [ {
					type : 'value',
					axisLabel : {
						formatter : '{value} 元'
					}
				} ],
				series : [ {
					name : '收入金额',
					type : 'bar',
					data : yData1
				}, {
					name : '支出金额',
					type : 'bar',
					data : yData2
				}, {
					name : '结算金额',
					type : 'bar',
					data : yData3
				} ]
			};

			// 使用刚指定的配置项和数据显示图表。
			viewChart1.setOption(option);
		}
	}
	
	function mapViewChart() {
		var settDate = $("#settDate5").val();
		if (settDate == null || settDate == '') {
			settDate = currentDate;
		}
		$.ajax({
			url : '${ctx}/newreports/settCityStat/cityCodeCityViewChart',
			method : "post",
			data : {
				settCycle : settDate
			},
			success : function(data) {
				
				var mapData1 = [ {
					name : '海西蒙古族藏族自治州',
					value : '0'
				}, {
					name : '海北藏族自治州',
					value : '0'
				}, {
					name : '海南藏族自治州',
					value : '0'
				}, {
					name : '黄南藏族自治州',
					value : '0'
				}, {
					name : '果洛藏族自治州',
					value : '0'
				}, {
					name : '玉树藏族自治州',
					value : '0'
				} ];
				var mapData2 = [ {
					name : '海西蒙古族藏族自治州',
					value : '0'
				}, {
					name : '海北藏族自治州',
					value : '0'
				}, {
					name : '海南藏族自治州',
					value : '0'
				}, {
					name : '黄南藏族自治州',
					value : '0'
				}, {
					name : '果洛藏族自治州',
					value : '0'
				}, {
					name : '玉树藏族自治州',
					value : '0'
				} ];
				var mapData3 = [ {
					name : '海西蒙古族藏族自治州',
					value : '0'
				}, {
					name : '海北藏族自治州',
					value : '0'
				}, {
					name : '海南藏族自治州',
					value : '0'
				}, {
					name : '黄南藏族自治州',
					value : '0'
				}, {
					name : '果洛藏族自治州',
					value : '0'
				}, {
					name : '玉树藏族自治州',
					value : '0'
				} ];
				for (var i = 0; i < data.length; i++) {
					var cityName = '';
					if(data[i].settObject=='西宁通卡公司'){
						cityName = "西宁市";
					}else if(data[i].settObject=='海东'){
						cityName = "海东市";
					}
					
					mapData1.push({
						name : cityName,
						value : data[i].incomeCharge
					});
					mapData2.push({
						name : cityName,
						value : data[i].outcomeCharge
					});
					mapData3.push({
						name : cityName,
						value : data[i].settCharge
					});

				}
				mapEcharts(mapData1, mapData2, mapData3);

			}
		});
	}
	
	function mapEcharts(mapData1, mapData2, mapData3) {
		//基于准备好的dom，初始化echarts实例
		var mapChart = echarts.init(document.getElementById('viewChart5'));
		mapOption = {
			tooltip : {
				trigger : 'item',
				formatter : function(params) {
					var res = '地区：' + params.name;
					for (var i = 0; i < mapOption.series[0].data.length; i++) {
						if (params.name == mapOption.series[0].data[i].name) {
							res = res + '<br/>收入金额(元)：'
									+ mapOption.series[0].data[i].value
									+ '<br/>支出金额(元)：'
									+ mapOption.series[1].data[i].value
									+ '<br/>结算金额(元)：'
									+ mapOption.series[2].data[i].value;
							"";
							//console.log(res)
							break;
						}
					}
					return res;
				}
			},
			toolbox : {
				show : true,
				orient : 'vertical',
				left : 'right',
				top : 'center',
				feature : {
					dataView : {
						readOnly : false
					},
					restore : {},
					saveAsImage : {}
				}
			},
			visualMap : {
				min : 0,
				max : 2500,
				type : 'continuous',
				text : [ 'High', 'Low' ],
				realtime : false,
				calculable : true,
				inRange : {
					color : [ 'lightskyblue', 'yellow', 'orangered' ]
				}

			},
			series : [ {
				name : '收入金额(元)',
				type : 'map',
				mapType : '青海',
				roam : false,
				label : {
					normal : {
						show : true
					},
					emphasis : {
						show : true
					}
				},

				data : mapData1
			}, {
				name : '支出金额(元)',
				type : 'map',
				mapType : '青海',
				roam : false,
				label : {
					normal : {
						show : true
					},
					emphasis : {
						show : true
					}
				},
				data : mapData2
			}, {
				name : '结算金额(元)',
				type : 'map',
				mapType : '青海',
				roam : false,
				label : {
					normal : {
						show : true
					},
					emphasis : {
						show : true
					}
				},
				data : mapData3
			}
			]
		};
		mapChart.setOption(mapOption);
	}
</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/newreports/settCityStat/settCityStatList">省内月结算报表</a></li>
		<li class="active"><a href="${ctx}/newreports/settCityStat/settCityStatChart">图表展示</a></li>
	</ul>
	<br />
	<div class="chart-list-panel">
		<div class="row">
			<div class="col-md-6">
				<div class="chart">
					<form:form method="post" class="breadcrumb form-search">
						<label class="chart-title">省内-各地市结算费用收入支出对比</label>
						<ul class="ul-form">
							<li><label>统计月份:</label> <input id="settDate1"
								name="settDate1" type="text" readonly="readonly" maxlength="8"
								class="input-medium Wdate"
								onclick="WdatePicker({dateFmt:'yyyyMM',isShowClear:true});" /></li>
							<li class="btns"><a href="#" onClick="cityCodeCityViewChart()"
								class="btn btn-primary" type="button">查看</a></li>
							<li class="clearfix"></li>
						</ul>
					</form:form>
					<div id="viewChart1" style="height: 300px;"></div>
				</div>
			</div>
			
			<div class="col-md-6">
				<div class="chart">

					<form:form modelAttribute="settCityStat" method="post"
						class="breadcrumb form-search">
						<label class="chart-title">跨省-各地市结算费用统计</label>
						<ul class="ul-form">
							<li><label>统计月份:</label> <input id="settDate5"
								name="settDate5" type="text" readonly="readonly" maxlength="8"
								class="input-medium Wdate"
								onclick="WdatePicker({dateFmt:'yyyyMM',isShowClear:true});" /></li>

							<li><a href="#" onClick="mapViewChart()"
								class="btn btn-primary">查看</a></li>
							<li class="clearfix"></li>
						</ul>
					</form:form>
					<div id="viewChart5" style="height: 300px;"></div>
				</div>
			</div>
			
		</div>
	</div>
</body>
</html>