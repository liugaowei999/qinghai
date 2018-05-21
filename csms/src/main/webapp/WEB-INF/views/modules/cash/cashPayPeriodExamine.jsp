<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>变更记录管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			var neePayMoney = parseInt(encodeURIComponent('${cashPayPeriodRecord.neePayMoney}'));
			jQuery.validator.addMethod("modifyStatusRules", function(value, element) {     
				var flag = true;
				var examineStatus = $('#examineStatus option:selected').val();
				var payPeriodFlag = $('#payPeriodFlag option:selected').val();
				if(value==1){
					if(examineStatus!=1){
						flag = false;
					}else{
						if(neePayMoney!=0){
							if(payPeriodFlag==0){
								flag = false;
							}
						}
					}
				}else if(value==2){
					if(examineStatus==0){
						flag = false;
					}
				}
				return this.optional(element) || flag;     
			}, "请选择正确的变更状态！");
			
			//$("#name").focus();
			$("#inputForm").validate({
				rules: {
					modifyStatus:{modifyStatusRules:true},
				},
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
			$("#examineStatus").change(function(){
				var examineStatus = $('#examineStatus option:selected').val();
				if(examineStatus==0){
					$('#payPeriodFlag').removeAttr("readonly");
					$('#s2id_payPeriodFlag').find('.select2-chosen').empty();
					$('#s2id_payPeriodFlag').find('.select2-chosen').append("否");
					$('#modifyStatus').removeAttr("readonly");
					$('#s2id_modifyStatus').find('.select2-chosen').empty();
					$('#s2id_modifyStatus').find('.select2-chosen').append("处理中");
				}else if(examineStatus==1){
					if(neePayMoney==0){
						$('#payPeriodFlag').val(0); 
						$('#s2id_payPeriodFlag').find('.select2-chosen').empty();
						$('#s2id_payPeriodFlag').find('.select2-chosen').append("否");
						$('#payPeriodFlag').attr("readonly","readonly");
						$('#modifyStatus').val(1);
						$('#s2id_modifyStatus').find('.select2-chosen').empty();
						$('#s2id_modifyStatus').find('.select2-chosen').append("变更成功");
						$('#modifyStatus').attr("readonly","readonly");
					}
				}else if(examineStatus==2){
					$('#payPeriodFlag').val(0);
					$('#s2id_payPeriodFlag').find('.select2-chosen').empty();
					$('#s2id_payPeriodFlag').find('.select2-chosen').append("否");
					$('#payPeriodFlag').attr("readonly","readonly");
					$('#modifyStatus').val(2);
					$('#s2id_modifyStatus').find('.select2-chosen').empty();
					$('#s2id_modifyStatus').find('.select2-chosen').append("变更失败");
					$('#modifyStatus').attr("readonly","readonly");
				}
			}); 
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cash/cashPayPeriodRecord/examinePeriodList">缴存周期变更申请记录</a></li>
		<li class="active"><a href="#">缴存周期变更审核</a></li>
	</ul>
	<form:form  class="breadcrumb form-search ">
		<ul class="ul-form">
			<li><label>备付金帐号：</label>${cashPayPeriodRecord.provisionsNo}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</li>
			<li><label>原缴存周期：</label>${fns:getDictLabel(cashPayPeriodRecord.oriPayPeriod, 'pay_period', '无')}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</li>
			<li><label>现缴存周期：</label>${fns:getDictLabel(cashPayPeriodRecord.curPayPeriod, 'pay_period', '无')}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</li>
			<li><label>需缴存金额：</label>${cashPayPeriodRecord.neePayMoney}</li>
			</ul>
	</form:form>
	<form:form id="inputForm" modelAttribute="cashPayPeriodRecord" action="${ctx}/cash/cashPayPeriodRecord/examinePeriod" method="post" class="form-horizontal">
		<form:hidden path="periodId"/>
		<form:hidden path="provisionsId"/>
		<sys:message content="${message}"/>	
		<div class="control-group">
			<label class="control-label">审核状态：</label>
			<div class="controls">
				<form:select path="examineStatus" id="examineStatus" style="width:150px" class="input-xlarge required">
					<form:options items="${fns:getDictList('examine_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否缴费：</label>
			<div class="controls">
				<form:select path="payPeriodFlag" id="payPeriodFlag" style="width:150px" class="input-xlarge required">
					<form:options items="${fns:getDictList('yes_no')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
				<span class="help-inline"><font color="red">*</font></span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">变更状态：</label>
			<div class="controls">
				<form:select path="modifyStatus" id="modifyStatus" style="width:150px" class="input-xlarge required">
					<form:options items="${fns:getDictList('modify_status')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="1" maxlength="255" style="width:150px" class="input-xxlarge"/>
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/></label>
			</div>
		</div>	
	</form:form>
	<table id="contentTable"
		class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>备付金账号</th>
				<th>缴存金额</th>
				<th>缴存状态</th>
				<th>缴存时间</th>
				<th>备注信息</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="cashPayRecord">
				<tr>
					<td>${cashPayRecord.cashProvisions.provisionsNo}</td>
					<td>${cashPayRecord.payMoney}</td>
					<td>${fns:getDictLabel(cashPayRecord.payState, 'yes_no', '无')}
					</td>
					<td><fmt:formatDate value="${cashPayRecord.updateDate}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td>${cashPayRecord.remarks}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>