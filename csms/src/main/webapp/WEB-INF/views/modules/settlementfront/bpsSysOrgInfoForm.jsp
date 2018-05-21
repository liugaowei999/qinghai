<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>入网机构配置管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
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
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/settlementfront/bpsSysOrgInfo/">入网机构配置列表</a></li>
		<li class="active"><a href="${ctx}/settlementfront/bpsSysOrgInfo/form?id=${bpsSysOrgInfo.id}">入网机构配置<shiro:hasPermission name="settlementfront:bpsSysOrgInfo:edit">${not empty bpsSysOrgInfo.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="settlementfront:bpsSysOrgInfo:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="bpsSysOrgInfo" action="${ctx}/settlementfront/bpsSysOrgInfo/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">入网机构代码：</label>
			<div class="controls">
				<c:choose><c:when test="${bpsSysOrgInfo.id!=null}">
				<input name="orgCode" value="${bpsSysOrgInfo.orgCode}"  maxlength="64" type="text" readonly="readonly" class="input-xlarge required"/>
				</c:when><c:otherwise><form:input path="orgCode" htmlEscape="false" maxlength="11" class="input-xlarge required"/></c:otherwise></c:choose>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">入网机构名称：</label>
			<div class="controls">
				<form:input path="orgName" htmlEscape="false" maxlength="32" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">区域类型：</label>
			<div class="controls">
				<form:select path="areaType" class="input-xlarge required">
					<form:option value="" label="请选择" />
					<form:options items="${fns:getDictList('area_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">所在城市：</label>
			<%-- <div class="controls">
				<form:input path="cityCode" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div> --%>
			<div class="controls">
				<sys:treeselect id="cityCode" name="cityCode" value="${area.id}" labelName="cityName" labelValue="${bpsSysOrgInfo.cityName}"  
				title="区域" url="/sys/area/treeData" cssClass="" allowClear="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">生效日期：</label>
			<div class="controls">
				<input name="effDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${bpsSysOrgInfo.effDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">失效日期：</label>
			<div class="controls">
				<input name="expDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${bpsSysOrgInfo.expDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:input path="remark" htmlEscape="false" maxlength="512" class="input-xlarge "/>
			</div>
		</div>
		
		<div class="form-actions">
			<shiro:hasPermission name="settlementfront:bpsSysOrgInfo:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>