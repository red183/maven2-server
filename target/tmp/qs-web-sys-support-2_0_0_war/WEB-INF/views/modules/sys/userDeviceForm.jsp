<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户设备管理</title>
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
		<li><a href="${ctxAdmin}/sys/user/device/">用户设备列表</a></li>
		<li class="active"><a href="${ctxAdmin}/sys/user/device/form?id=${userDevice.id}">用户设备<shiro:hasPermission name="sys:userDevice:edit">${not empty sysUserDevice.id?'修改':'添加'}</shiro:hasPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="userDevice" action="${ctxAdmin}/sys/user/device/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">用户：</label>
			<div class="controls">
				${userDevice.user.name}
				<%--<sys:treeselect id="user" name="user.id" value="${userDevice.user.id}" labelName="user.name" labelValue="${userDevice.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
				<span class="help-inline"><font color="red">*</font> </span>--%>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">设备名称：</label>
			<div class="controls">
				${userDevice.deviceName}
			</div>
		</div><div class="control-group">
			<label class="control-label">设备系统：</label>
			<div class="controls">
				${userDevice.osName} ${userDevice.osVersion}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">设备品牌：</label>
			<div class="controls">
				${userDevice.deviceBrand}
			</div>
		</div><div class="control-group">
			<label class="control-label">软件版本：</label>
			<div class="controls">
				${userDevice.softVersion}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="sys:userDevice:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>