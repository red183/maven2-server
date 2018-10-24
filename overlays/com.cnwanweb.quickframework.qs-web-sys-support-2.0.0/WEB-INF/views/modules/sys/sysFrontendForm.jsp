<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>前台应用管理管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$('#testCon').click(function(){
			    var $addr = $('#address');
			    if($addr.val()) {
					var protocolIndex1 = $addr.val().indexOf('http://');
					var protocolIndex2 = $addr.val().indexOf('https://');
					if(protocolIndex1 == 0 || protocolIndex2 == 0) {
                        $.post('${ctxAdmin}/sys/sysFrontend/connect/ping', {'addr':$addr.val()}, function(x,y,z){
                            console.log(x, y, z);
                            $('#pingResult').html(x);
                        });
					} else {
                        $.jBox.tip('地址必须使用 http:// 或 https:// 开头！');
					}
				} else {
                    $.jBox.tip('地址不能为空！');
				}
			});
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
		<li><a href="${ctxAdmin}/sys/sysFrontend/">前台应用管理列表</a></li>
		<li class="active">
		<a href="${ctxAdmin}/sys/sysFrontend/form?id=${sysFrontend.id}">前台应用管理
			<c:if test="${empty sysFrontend.id}">
				<shiro:hasPermission name="sys:sysFrontend:add">添加</a></shiro:hasPermission>
			</c:if>
			<c:if test="${not empty sysFrontend.id}">
				<shiro:hasPermission name="sys:sysFrontend:edit">修改</shiro:hasPermission>
			</c:if>
			<shiro:lacksPermission name="sys:sysFrontend:edit">查看</shiro:lacksPermission>
		</a>
		</li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="sysFrontend" action="${ctxAdmin}/sys/sysFrontend/${empty sysFrontend.id?'add':'edit'}" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">名称：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">地址：</label>
			<div class="controls">
				<form:input path="address" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
			<div class="controls" style="margin-top: 5px;">
				<a id="testCon" style="cursor: pointer;">测试连接</a><span class="help-inline"><font id="pingResult" color="red"></font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">监控范围：</label>
			<div class="controls">
				<form:select path="uriCode">
					<form:options items="${fns:getDictList('sys_frontend_uriCode')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">应用ID：</label>
			<div class="controls">
				<form:input path="fsId" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">应用密钥：</label>
			<div class="controls">
				<form:input path="fsSecret" htmlEscape="false" maxlength="200" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasAnyPermissions name="sys:sysFrontend:add,sys:sysFrontend:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasAnyPermissions>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>