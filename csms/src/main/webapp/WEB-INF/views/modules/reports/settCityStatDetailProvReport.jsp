<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>记录管理</title>
<meta name="decorator" content="default" />
<link href="${ctxStatic}/bootstrap/3.1.1/css/bootstrap.css"
	rel="stylesheet" />
<link href="${ctxStatic}/echarts/viewCharts.css" rel="stylesheet" />
<script src="${ctxStatic}/echarts/china.js" type="text/javascript"></script>
<script src="${ctxStatic}/echarts/qinghai.js" type="text/javascript"></script>
<script type="text/javascript">
	$(function() {
		getCurrentDate();
		issueCodeViewChart();
		billCodeViewChart();
		issueCodeLineChart();
		billCodeLineChart();
		mapViewChart();
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
	function issueCodeLineChart() {
		var settDate = $("#settDate3").val();
		var issueCode = $("#issueCode").val();
		if (settDate == null || settDate == '') {
			settDate = currentYear;
		}
		$.ajax({
			url : '${ctx}/reports/settCityStatDetail/issueCodeLineChart',
			method : "post",
			data : {
				settDate : settDate,
				issueCode : issueCode
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
					xData.push(data[i].settDate);
					yData1[i] = data[i].tradeCharge;
					yData2[i] = data[i].serviceFee;
					yData3[i] = data[i].issueCharge;
					yData4[i] = data[i].billCharge;
					yData5[i] = data[i].centerCharge;
					yData6[i] = data[i].settCharge;
				}
				stlEcharts(xData, yData1, yData2, yData3, yData4, yData5,
						yData6);
			}
		});

	}
	function stlEcharts(xData, yData1, yData2, yData3, yData4, yData5, yData6) {
		var viewChart3 = echarts.init(document.getElementById('viewChart3'));
		option3 = {
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
				type : 'line',
				data : yData1
			}, {
				name : '手续费',
				type : 'line',
				data : yData2
			}, {
				name : '发卡分润',
				type : 'line',
				data : yData3
			}, {
				name : '收单分润',
				type : 'line',
				data : yData4
			}, {
				name : '清算中心分润',
				type : 'line',
				data : yData5
			}, {
				name : '结算费用',
				type : 'line',
				data : yData6
			} ]
		};
		// 使用刚指定的配置项和数据显示图表。
		viewChart3.setOption(option3);

	}
	function billCodeLineChart() {
		var settDate = $("#settDate4").val();
		var billCode = $("#billCode").val();
		if (settDate == null || settDate == '') {
			settDate = currentYear;
		}
		$.ajax({
			url : '${ctx}/reports/settCityStatDetail/billCodeLineChart',
			method : "post",
			data : {
				settDate : settDate,
				billCode : billCode
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
					xData.push(data[i].settDate);
					yData1[i] = data[i].tradeCharge;
					yData2[i] = data[i].serviceFee;
					yData3[i] = data[i].issueCharge;
					yData4[i] = data[i].billCharge;
					yData5[i] = data[i].centerCharge;
					yData6[i] = data[i].settCharge;
				}
				oclEcharts(xData, yData1, yData2, yData3, yData4, yData5,
						yData6);
			}
		});

	}
	function oclEcharts(xData, yData1, yData2, yData3, yData4, yData5, yData6) {
		var viewChart4 = echarts.init(document.getElementById('viewChart4'));
		option4 = {
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
				type : 'line',
				data : yData1
			}, {
				name : '手续费',
				type : 'line',
				data : yData2
			}, {
				name : '发卡分润',
				type : 'line',
				data : yData3
			}, {
				name : '收单分润',
				type : 'line',
				data : yData4
			}, {
				name : '清算中心分润',
				type : 'line',
				data : yData5
			}, {
				name : '结算费用',
				type : 'line',
				data : yData6
			} ]
		}
		// 使用刚指定的配置项和数据显示图表。
		viewChart4.setOption(option4);
	}
	function issueCodeViewChart() {
		var settDate = $("#settDate1").val();
		if (settDate == null || settDate == '') {
			settDate = currentDate;
		}
		$.ajax({
			url : '${ctx}/reports/settCityStatDetail/issueCodeViewChart',
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
					xData.push(data[i].issueOrgName);
					yData1[i] = data[i].tradeCharge;
					yData2[i] = data[i].serviceFee;
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
	function billCodeViewChart() {
		var settDate = $("#settDate2").val();
		if (settDate == null || settDate == '') {
			settDate = currentDate;
		}
		$.ajax({
			url : '${ctx}/reports/settCityStatDetail/billCodeViewChart',
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
					xData.push(data[i].billOrgName);
					yData1[i] = data[i].tradeCharge;
					yData2[i] = data[i].serviceFee;
					yData3[i] = data[i].issueCharge;
					yData4[i] = data[i].billCharge;
					yData5[i] = data[i].centerCharge;
					yData6[i] = data[i].settCharge;
				}
				billCodeEcharts(xData, yData1, yData2, yData3, yData4, yData5,
						yData6);

			}
		});
	}

	function billCodeEcharts(xData, yData1, yData2, yData3, yData4, yData5,
			yData6) {
		var viewChart2 = echarts.init(document.getElementById('viewChart2'));
		option2 = {
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
		viewChart2.setOption(option2);
	}
	function mapViewChart() {
		var settDate = $("#settDate5").val();
		if (settDate == null || settDate == '') {
			settDate = currentDate;
		}
		$.ajax({
			url : '${ctx}/reports/settCityStatDetail/billCodeViewChart',
			method : "post",
			data : {
				settDate : settDate
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
				var mapData4 = [ {
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
				var mapData5 = [ {
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
				var mapData6 = [ {
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
					var billOrgName = '';
					var billCode = data[i].billCode;
					if(billCode=='4568520'){
						billOrgName = "海东市";
					}else if(billCode=='4558510'){
						billOrgName = "西宁市";
					}
					
					mapData1.push({
						name : billOrgName,
						value : data[i].tradeCharge
					});
					mapData2.push({
						name : billOrgName,
						value : data[i].serviceFee
					});
					mapData3.push({
						name : billOrgName,
						value : data[i].issueCharge
					});
					mapData4.push({
						name : billOrgName,
						value : data[i].billCharge
					});
					mapData5.push({
						name : billOrgName,
						value : data[i].centerCharge
					});
					mapData6.push({
						name : billOrgName,
						value : data[i].settCharge
					});

				}
				mapEcharts(mapData1, mapData2, mapData3, mapData4, mapData5,
						mapData6);

			}
		});
	}
	function randomData() {
		return Math.round(Math.random() * 1000);
	}
	function mapEcharts(mapData1, mapData2, mapData3, mapData4, mapData5,
			mapData6) {
		//基于准备好的dom，初始化echarts实例
		var mapChart = echarts.init(document.getElementById('viewChart5'));
		mapOption = {
			
			tooltip : {
				trigger : 'item',
				formatter : function(params) {
					var res = '地区：' + params.name;
					for (var i = 0; i < mapOption.series[0].data.length; i++) {
						if (params.name == mapOption.series[0].data[i].name) {
							res = res + '<br/>交易金额(元)：'
									+ mapOption.series[0].data[i].value
									+ '<br/>手续费(元)：'
									+ mapOption.series[1].data[i].value
									+ '<br/>发卡分润(元)：'
									+ mapOption.series[2].data[i].value
									+ '<br/>收单分润(元)：'
									+ mapOption.series[3].data[i].value
									+ '<br/>清算中心分润(元)：'
									+ mapOption.series[4].data[i].value
									+ '<br/>结算费用(元)：'
									+ mapOption.series[5].data[i].value;
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
				name : '交易金额(元)',
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
				name : '手续费(元)',
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
				name : '发卡分润(元)',
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
			},
			{
				name : '收单分润(元)',
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

				data : mapData4
			}, {
				name : '清算中心分润(元)',
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
				data : mapData5
			}, {
				name : '结算费用(元)',
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

				data : mapData6
			},

			]
		};
		mapChart.setOption(mapOption);
	}
	function pieViewChart() {
		var settDate = $("#settDate6").val();
		if (settDate == null || settDate == '') {
			settDate = currentDate;
		}
		$.ajax({
			url : '${ctx}/reports/settCityStatDetail/billCodeSumViewChart',
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
						value : data[i].serviceFee
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
		<li><a href="${ctx}/reports/settCityStatDetail">记录列表</a></li>
		<li class="active"><a
			href="${ctx}/reports/settCityStatDetail/settCityStatProvDetail">图表展示</a></li>
	</ul>
	<br />
	<div class="chart-list-panel">
		<div class="row">
			<div class="col-md-6">
				<div class="chart">
					<form:form modelAttribute="settCityStatDetail" method="post"
						class="breadcrumb form-search">
						<label class="chart-title">省内-各结算费用占比</label>
						<ul class="ul-form">
							<li><label>统计年份:</label> <input id="settDate6"
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
			<div class="col-md-6">
				<div class="chart">

					<form:form modelAttribute="settCityStatDetail" method="post"
						class="breadcrumb form-search">
						<label class="chart-title">省内-各地市结算费用统计</label>
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
		<div class="row">
			<div class="col-md-6">
				<div class="chart">

					<form:form method="post" class="breadcrumb form-search">
						<label class="chart-title">省内-各发卡机构结算费用月对比</label>
						<ul class="ul-form">
							<li><label>统计月份:</label> <input id="settDate1"
								name="settDate1" type="text" readonly="readonly" maxlength="8"
								class="input-medium Wdate"
								onclick="WdatePicker({dateFmt:'yyyyMM',isShowClear:true});" /></li>
							<li class="btns"><a href="#" onClick="issueCodeViewChart()"
								class="btn btn-primary" type="button">查看</a></li>
							<li class="clearfix"></li>
						</ul>
					</form:form>
					<div id="viewChart1" style="height: 300px;"></div>
				</div>
			</div>
			<!--/span-->

			<div class="col-md-6">
				<div class="chart">

					<form:form modelAttribute="settCityStatDetail" method="post"
						class="breadcrumb form-search">
						<label class="chart-title">省内-各发卡机构结算费用月趋势图</label>
						<ul class="ul-form">
							<li><label>统计年份:</label> <input id="settDate3"
								name="settDate3" type="text" readonly="readonly" maxlength="8"
								class="input-medium Wdate"
								onclick="WdatePicker({dateFmt:'yyyy',isShowClear:true});" /></li>
							<li><label>发卡机构：</label> 
							<select id="issueCode"
								name="issueCode" class="input-medium">
									<option value="" >全部</option>
									<c:forEach items="${issueOrgCodeList}" var="issueCodeMap">
										<option value="${issueCodeMap.issueCode}">${issueCodeMap.issueOrgName}</option>
									</c:forEach>
							</select> <a href="#" onClick="issueCodeLineChart()"
								class="btn btn-primary">查看</a></li>
							<li class="clearfix"></li>
						</ul>
					</form:form>
					<div id="viewChart3" style="height: 300px;"></div>
				</div>
			</div>
			<!--/span-->

		</div>
		<div class="row">
			<div class="col-md-6">
				<div class="chart">
					<form:form method="post" class="breadcrumb form-search">
						<label class="chart-title">省内-各收单机构结算费用月统计</label>
						<ul class="ul-form">
							<li><label>统计月份:</label> <input id="settDate2"
								name="settDate2" type="text" readonly="readonly" maxlength="8"
								class="input-medium Wdate"
								onclick="WdatePicker({dateFmt:'yyyyMM',isShowClear:true});" /></li>
							<li class="btns"><a href="#" onClick="billCodeViewChart()"
								class="btn btn-primary" type="button">查看</a></li>
							<li class="clearfix"></li>
						</ul>
					</form:form>
					<div id="viewChart2" style="height: 300px;"></div>
				</div>
			</div>

			<div class="col-md-6">
				<div class="chart">
					<form:form modelAttribute="settCityStatDetail" method="post"
						class="breadcrumb form-search">
						<label class="chart-title">省内-各收单机构结算费用月趋势图</label>
						<ul class="ul-form">
							<li><label>统计年份:</label> <input id="settDate4"
								name="settDate4" type="text" readonly="readonly" maxlength="8"
								class="input-medium Wdate"
								onclick="WdatePicker({dateFmt:'yyyy',isShowClear:true});" /></li>
							<li><label>收单机构：</label> 
							<select id="billCode"
								name="billCode" class="input-medium">
									<option value="" >全部</option>
									<c:forEach items="${billOrgCodeList}" var="billCodeMap">
										<option value="${billCodeMap.billCode}">${billCodeMap.billOrgName}</option>
									</c:forEach>
							</select>
							<a href="#" onClick="billCodeLineChart()"
								class="btn btn-primary">查看</a></li>
							<li class="clearfix"></li>
						</ul>
					</form:form>
					<div id="viewChart4" style="height: 300px;"></div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>