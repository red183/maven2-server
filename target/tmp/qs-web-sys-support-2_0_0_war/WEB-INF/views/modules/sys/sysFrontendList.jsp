<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>前台应用管理管理</title>
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
		<li class="active"><a href="${ctxAdmin}/sys/sysFrontend/">前台应用管理列表</a></li>
		<shiro:hasPermission name="sys:sysFrontend:add"><li><a href="${ctxAdmin}/sys/sysFrontend/form">前台应用管理添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="sysFrontend" action="${ctxAdmin}/sys/sysFrontend/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>名称</th>
				<th>地址</th>
				<th>监控范围</th>
				<th>应用ID</th>
				<%--<th>密钥</th>--%>
				<th>操作人</th>
				<th>更新时间</th>
				<th>状态</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="sysFrontend">
			<tr>
				<td><a href="${ctxAdmin}/sys/sysFrontend/form?id=${sysFrontend.id}">
					${sysFrontend.name}
				</a></td>
				<td>
					${sysFrontend.address}
				</td>
				<td>
					${fns:getDictLabel(sysFrontend.uriCode, 'sys_frontend_uriCode', '')}
				</td>
				<td>
					${sysFrontend.fsId}
				</td>
				<%--<td>
					${sysFrontend.secret}
				</td>--%>
				<td>
					${sysFrontend.updateBy.name}
				</td>
				<td>
					<fmt:formatDate value="${sysFrontend.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${fns:getDictLabel(sysFrontend.delFlag, 'del_flag', '')}
				</td>
				<td>
    				<shiro:hasPermission name="sys:sysFrontend:edit"><a href="${ctxAdmin}/sys/sysFrontend/form?id=${sysFrontend.id}">修改</a></shiro:hasPermission>
					<shiro:hasPermission name="sys:sysFrontend:remove"><a href="${ctxAdmin}/sys/sysFrontend/remove?id=${sysFrontend.id}" onclick="return confirmx('确认要删除该前台应用管理吗？', this.href)">删除</a></shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>