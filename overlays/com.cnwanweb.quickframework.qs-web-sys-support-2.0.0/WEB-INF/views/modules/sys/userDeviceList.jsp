<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户设备管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxAdmin}/sys/user/device">用户设备列表</a></li>
		<%--<shiro:hasPermission name="sys:userDevice:edit"><li><a href="${ctxAdmin}/sys/user/device/form">用户设备添加</a></li></shiro:hasPermission>--%>
	</ul>
	<form:form id="searchForm" modelAttribute="userDevice" action="${ctxAdmin}/sys/user/device/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>用户：</label>
				<sys:treeselect id="user" name="user.id" value="${userDevice.user.id}" labelName="user.name" labelValue="${sysUserDevice.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>设备系统：</label>
				<form:input path="osName" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>设备品牌：</label>
				<form:input path="deviceBrand" htmlEscape="false" maxlength="30" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>用户</th>
				<th>通信协议</th>
				<th>设备ID</th>
				<th>设备名称</th>
				<th>设备操作系统</th>
				<th>设备品牌</th>
				<th>软件版本</th>
				<th>创建时间</th>
				<th>更新时间</th>
				<%--<th>备注</th>--%>
				<shiro:hasPermission name="sys:userDevice:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="userDevice">
			<tr>
				<td><a href="${ctxAdmin}/sys/user/device/form?id=${userDevice.id}">
					${userDevice.user.name}
				</a></td>
				<td>${userDevice.protocol}</td>
				<td>${userDevice.deviceId}</td>
				<td>${userDevice.deviceName}</td>
				<td>${userDevice.osName} ${userDevice.osVersion}</td>
				<td>${userDevice.deviceBrand}</td>
				<td>${userDevice.softVersion}</td>
				<td>
					<fmt:formatDate value="${userDevice.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${userDevice.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<%--<td>
					${userDevice.remarks}
				</td>--%>
				<shiro:hasPermission name="sys:userDevice:edit"><td>
					<a href="${ctxAdmin}/sys/user/device/form?id=${userDevice.id}">修改</a>
					<a href="${ctxAdmin}/sys/user/device/delete?id=${userDevice.id}" onclick="return confirmx('确认要删除该用户设备吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>