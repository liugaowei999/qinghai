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
		issueCodeProvViewChart();
		billCodeProvViewChart();
		issueCodeProvLineChart();
		billCodeProvLineChart();
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
	function issueCodeProvLineChart() {
		var settDate = $("#settDate3").val();
		var issueCode = $("#issueCode").val();
		if (settDate == null || settDate == '') {
			settDate = currentYear;
		}
		$.ajax({
			url : '${ctx}/reports/settProvStatDetail/issueCodeProvLineChart',
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
	function billCodeProvLineChart() {
		var settDate = $("#settDate4").val();
		var billCode = $("#billCodeId").val();
		if (settDate == null || settDate == '') {
			settDate = currentYear;
		}
		$.ajax({
			url : '${ctx}/reports/settProvStatDetail/billCodeProvLineChart',
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
	function issueCodeProvViewChart() {
		var settDate = $("#settDate1").val();
		if (settDate == null || settDate == '') {
			settDate = currentDate;
		}
		$.ajax({
			url : '${ctx}/reports/settProvStatDetail/issueCodeProvViewChart',
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
	function billCodeProvViewChart() {
		var settDate = $("#settDate2").val();
		if (settDate == null || settDate == '') {
			settDate = currentDate;
		}
		$.ajax({
			url : '${ctx}/reports/settProvStatDetail/billCodeProvViewChart',
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
				billCodeEcharts(pieData);
				
			}
		});
	}

	function billCodeEcharts(xData, yData1, yData2, yData3, yData4, yData5,
			yData6) {
		var viewChart2 = echarts.init(document.getElementById('viewChart2'));
		option2 = {
				title : {
					text : '青海省清分结算支出',
					x : 'center'
				},
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
		// 使用刚指定的配置项和数据显示图表。
		viewChart2.setOption(option2);
	}
	
	function pieViewChart() {
		var settDate = $("#settDate6").val();
		if (settDate == null || settDate == '') {
			settDate = currentDate;
		}
		$.ajax({
			url : '${ctx}/reports/settProvStatDetail/billCodeSumProvViewChart',
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
	
</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/reports/settProvStatDetail">记录列表</a></li>
		<li class="active"><a
			href="${ctx}/reports/settProvStatDetail/settProvStatProvDetail">图表展示</a></li>
	</ul>
	<br />
	<div class="chart-list-panel">
		
		<div class="row">
			<div class="col-md-6">
				<div class="chart">

					<form:form method="post" class="breadcrumb form-search">
						<label class="chart-title">结算类型月统计</label>
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
			<!--/span-->

			<div class="col-md-6">
				<div class="chart">

					<form:form modelAttribute="settProvStatDetail" method="post"
						class="breadcrumb form-search">
						<label class="chart-title">发卡机构月趋势图</label>
						<ul class="ul-form">
							<li><label>统计年份:</label> <input id="settDate3"
								name="settDate3" type="text" readonly="readonly" maxlength="8"
								class="input-medium Wdate"
								onclick="WdatePicker({dateFmt:'yyyy',isShowClear:true});" /></li>
							<li><label>发卡机构：</label> 
							<select id="issueCode"
								name="issueCode" class="input-medium">
									<option value="" 全部>全部</option>
									<c:forEach items="${issueOrgCodeList}" var="issueCodeMap">
										<option value="${issueCodeMap.issueCode}">${issueCodeMap.issueOrgName}</option>
									</c:forEach>
							</select><a href="#" onClick="issueCodeProvLineChart()"
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
						<label class="chart-title">收单机构月统计</label>
						<ul class="ul-form">
							<li><label>统计月份:</label> <input id="settDate2"
								name="settDate2" type="text" readonly="readonly" maxlength="8"
								class="input-medium Wdate"
								onclick="WdatePicker({dateFmt:'yyyyMM',isShowClear:true});" /></li>
							<li class="btns"><a href="#" onClick="billCodeProvViewChart()"
								class="btn btn-primary" type="button">查看</a></li>
							<li class="clearfix"></li>
						</ul>
					</form:form>
					<div id="viewChart2" style="height: 300px;"></div>
				</div>
			</div>

			<div class="col-md-6">
				<div class="chart">
					<form:form modelAttribute="settProvStatDetail" method="post"
						class="breadcrumb form-search">
						<label class="chart-title">收单机构月趋势图</label>
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
							</select><a href="#" onClick="billCodeProvLineChart()"
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