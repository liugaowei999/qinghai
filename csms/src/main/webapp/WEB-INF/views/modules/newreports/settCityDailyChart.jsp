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
		issueObjectMonthLineChart();
		billObjectMonthLineChart();
		pieIssueViewChart();
		pieBillViewChart();
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
		$("#settDate3").val(currentDate);
		$("#settDate4").val(currentDate);
		$("#settDate5").val(currentDate);
		$("#settDate6").val(currentDate);
		$("#settDate1").val(currentDate);
	}
	
	function billObjectMonthLineChart() {
		var settDate = $("#settDate4").val();
		var settObject = encodeURI($("#settObject4").val());
		if (settDate == null || settDate == '') {
			settDate = currentDate;
		}
		$.ajax({
			url : '${ctx}/newreports/settCityDaily/billCodeProvLineChart',
			method : "post",
			data : {
				settDate : settDate,
				settObject : settObject
			},
			success : function(data) {
				var xData = [];
				var yData1 = [];
				var yData2 = [];
				var yData3 = [];
				var yData4 = [];
				var yData5 = [];
				var yData6 = [];
				var yData7 = [];
				for (var i = 0; i < data.length; i++) {
					xData.push(data[i].settDate);
					yData1[i] = data[i].tradeCharge;
					yData2[i] = data[i].serviceCharge;
					yData3[i] = data[i].issueCharge;
					yData4[i] = data[i].billCharge;
					yData5[i] = data[i].centerCharge;
					yData6[i] = data[i].settCharge;
					yData7[i] = data[i].times;
				}
				stlBillEcharts(xData, yData1, yData2, yData3, yData4, yData5,
						yData6,yData7);
			}
		});

	}
	function stlBillEcharts(xData, yData1, yData2, yData3, yData4, yData5, yData6,yData7) {
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
				data : [ '交易金额', '手续费', '发卡分润', '收单分润', '清算中心分润', '结算费用', '次数']
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
			}, {
				name : '次数',
				type : 'line',
				data : yData7
			} ]
		};
		// 使用刚指定的配置项和数据显示图表。
		viewChart4.setOption(option4);

	}	
	
	function issueObjectMonthLineChart() {
		var settDate = $("#settDate3").val();
		var settObject = encodeURI($("#settObject3").val());
		if (settDate == null || settDate == '') {
			settDate = currentDate;
		}
		$.ajax({
			url : '${ctx}/newreports/settCityDaily/issueCodeProvLineChart',
			method : "post",
			data : {
				settDate : settDate,
				settObject : settObject
			},
			success : function(data) {
				var xData = [];
				var yData1 = [];
				var yData2 = [];
				var yData3 = [];
				var yData4 = [];
				var yData5 = [];
				var yData6 = [];
				var yData7 = [];
				for (var i = 0; i < data.length; i++) {
					xData.push(data[i].settDate);
					yData1[i] = data[i].tradeCharge;
					yData2[i] = data[i].serviceCharge;
					yData3[i] = data[i].issueCharge;
					yData4[i] = data[i].billCharge;
					yData5[i] = data[i].centerCharge;
					yData6[i] = data[i].settCharge;
					yData7[i] = data[i].times;
				}
				stlEcharts(xData, yData1, yData2, yData3, yData4, yData5,
						yData6,yData7);
			}
		});

	}
	function stlEcharts(xData, yData1, yData2, yData3, yData4, yData5, yData6,yData7) {
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
				data : [ '交易金额', '手续费', '发卡分润', '收单分润', '清算中心分润', '结算费用', '次数']
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
			}, {
				name : '次数',
				type : 'line',
				data : yData7
			} ]
		};
		// 使用刚指定的配置项和数据显示图表。
		viewChart3.setOption(option3);

	}
	
	function pieIssueViewChart() {
		var settDate = $("#settDate6").val();
		var settobject = encodeURI($("#settObject6").val());
		if (settDate == null || settDate == '') {
			settDate = currentDate;
		}
		$.ajax({
			url : '${ctx}/newreports/settCityDaily/issueCityViewChart',			
			method : "post",
			data : {
				settDate : settDate,
				settObject : settobject
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
					pieData.push({
						name : '次数',
						value : data[i].times
					});
				}
				pieIssueEcharts(pieData);

			}
		});

	}
	function pieIssueEcharts(pieData) {
		var pieChart6 = echarts.init(document.getElementById('viewChart6'));
		option6 = {
			
			tooltip : {
				trigger : 'item',
				formatter : "{a} <br/>{b} : {c} ({d}%)"
			},
			legend : {
				orient : 'vertical',
				left : 'left',
				data : [ '交易金额', '手续费', '发卡分润', '收单分润', '清算中心分润', '结算费用', '次数' ]
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
		pieChart6.setOption(option6);
	}
	
	function pieBillViewChart() {
		var settDate = $("#settDate5").val();
		var settobject = encodeURI($("#settObject5").val());
		if (settDate == null || settDate == '') {
			settDate = currentDate;
		}
		$.ajax({
			url : '${ctx}/newreports/settCityDaily/billCityViewChart',
			method : "post",
			data : {
				settDate : settDate,
				settObject : settobject
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
					pieData.push({
						name : '次数',
						value : data[i].times
					});
				}
				pieBillEcharts(pieData);

			}
		});

	}
	function pieBillEcharts(pieData) {
		var pieChart5 = echarts.init(document.getElementById('viewChart5'));
		option5 = {
			
			tooltip : {
				trigger : 'item',
				formatter : "{a} <br/>{b} : {c} ({d}%)"
			},
			legend : {
				orient : 'vertical',
				left : 'left',
				data : [ '交易金额', '手续费', '发卡分润', '收单分润', '清算中心分润', '结算费用', '次数' ]
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
		pieChart5.setOption(option5);
	}
</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/newreports/settCityDaily/settCityDailyList">省内日统计报表</a></li>
		<li class="active"><a href="${ctx}/newreports/settCityDaily/settCityDailyChart">图表展示</a></li>
	</ul>
	<br />
	<div class="chart-list-panel">
<%-- 
		<div class="row">
			<div class="col-md-6">
				<div class="chart">
					<form:form modelAttribute="settCityDaily" method="post"
						class="breadcrumb form-search">
						<label class="chart-title">省内-各地市发卡结算费用占比</label>
						<ul class="ul-form">
							<li><label>统计月份:</label> <input id="settDate6"
								name="settDate6" type="text" readonly="readonly" maxlength="8"
								class="input-medium Wdate"
								onclick="WdatePicker({dateFmt:'yyyyMM',isShowClear:true});" /></li>
						 	<li><label>入网机构：</label> 
							<select id="settObject6"
								name="settObject6" class="input-medium">
									<option value="" 全部>全部</option>
									<c:forEach items="${settObjectList}" var="settObjectMap">
										<option value="${settObjectMap}">${settObjectMap}</option>
									</c:forEach>
							</select>
							<li><a href="#" onClick="pieIssueViewChart()"
								class="btn btn-primary">查看</a></li>
							<li class="clearfix"></li>
						</ul>
					</form:form>
					<div id="viewChart6" style="height: 300px;"></div>
				</div>
			</div>
			<div class="col-md-6">
				<div class="chart">

					<form:form modelAttribute="settCityDaily" method="post"
						class="breadcrumb form-search">
						<label class="chart-title">省内-各地市发卡结算费用月趋势图</label>
						<ul class="ul-form">
							<li><label>统计月份:</label> <input id="settDate3"
								name="settDate3" type="text" readonly="readonly" maxlength="8"
								class="input-medium Wdate"
								onclick="WdatePicker({dateFmt:'yyyyMM',isShowClear:true});" /></li>
							<li><label>入网机构：</label> 
							<select id="settObject3"
								name="settObject3" class="input-medium">
									<option value="" 全部>全部</option>
									<c:forEach items="${settObjectList}" var="settObjectMap">
										<option value="${settObjectMap}">${settObjectMap}</option>
									</c:forEach>
							</select> <a href="#" onClick="issueObjectMonthLineChart()"
								class="btn btn-primary">查看</a></li>
							<li class="clearfix"></li>

						</ul>
					</form:form>
					<div id="viewChart3" style="height: 300px;"></div>
				</div>
			</div>
			<!--/span-->

		</div>
		 --%>
		<div class="row">
			<div class="col-md-6">
				<div class="chart">
					<form:form modelAttribute="settCityDaily" method="post"
						class="breadcrumb form-search">
						<label class="chart-title">省内-各地市收单结算费用占比</label>
						<ul class="ul-form">
							<li><label>统计月份:</label> <input id="settDate5"
								name="settDate5" type="text" readonly="readonly" maxlength="8"
								class="input-medium Wdate"
								onclick="WdatePicker({dateFmt:'yyyyMM',isShowClear:true});" /></li>
							<li><label>入网机构：</label> 
							<select id="settObject5"
								name="settObject5" class="input-medium">
									<option value="" 全部>全部</option>
									<c:forEach items="${settObjectList}" var="settObjectMap">
										<option value="${settObjectMap}">${settObjectMap}</option>
									</c:forEach>
							</select> <a href="#" onClick="pieBillViewChart()"
								class="btn btn-primary">查看</a></li>
							<li class="clearfix"></li>
						</ul>
					</form:form>
					<div id="viewChart5" style="height: 300px;"></div>
				</div>
			</div>
			<div class="col-md-6">
				<div class="chart">

					<form:form modelAttribute="settCityDaily" method="post"
						class="breadcrumb form-search">
						<label class="chart-title">省内-各地市收单结算费用月趋势图</label>
						<ul class="ul-form">
							<li><label>统计月份:</label> <input id="settDate4"
								name="settDate4" type="text" readonly="readonly" maxlength="8"
								class="input-medium Wdate"
								onclick="WdatePicker({dateFmt:'yyyyMM',isShowClear:true});" /></li>
							<li><label>入网机构：</label> 
							<select id="settObject4"
								name="settObject4" class="input-medium">
									<option value="" 全部>全部</option>
									<c:forEach items="${settObjectList}" var="settObjectMap">
										<option value="${settObjectMap}">${settObjectMap}</option>
									</c:forEach>
							</select> <a href="#" onClick="billObjectMonthLineChart()"
								class="btn btn-primary">查看</a></li>
							<li class="clearfix"></li>

						</ul>
					</form:form>
					<div id="viewChart4" style="height: 300px;"></div>
				</div>
			</div>
			<!--/span-->

		</div>
	</div>
</body>
</html>