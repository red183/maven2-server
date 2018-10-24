<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>保存文件成功管理</title>
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
		<li class="active"><a href="${ctxAdmin}/sys/files/list">文件上传记录</a></li>
		<%--<shiro:hasPermission name="sys:sysFiles:edit"><li><a href="${ctxAdmin}/sys/files/form">保存文件成功添加</a></li></shiro:hasPermission>--%>
	</ul>
	<form:form id="searchForm" modelAttribute="sysFiles" action="${ctxAdmin}/sys/files/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li>
				<label>文件名称：</label>
				<form:input path="fileName" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li><label>后缀名称：</label>
				<form:input path="extName" htmlEscape="false" maxlength="10" class="input-medium"/>
			</li>
			<li><label>存储位置：</label>
				<form:select path="storeType" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('file_store_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<%--<li><label>容量：</label>
				<form:input path="fileSize" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>--%>
			<li><label>内容类型：</label>
				<form:input path="contentType" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>

			<%--<li><label>MD5值：</label>
				<form:input path="codeMd5" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>SHA1值：</label>
				<form:input path="codeSha1" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>--%>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>文件名称.后缀名称</th>
				<th>容量大小</th>
				<th>存储内容</th>
				<th>文件校验及存储路径</th>
				<th>上传用户</th>
				<th>上传时间</th>
				<%--<shiro:hasPermission name="sys:sysFiles:edit"><th>操作</th></shiro:hasPermission>--%>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="sysFiles">
			<tr>
				<td>
					<a href="${ctx}${sysFiles.relativeUrl}" target="_blank">${sysFiles.fileName}.${sysFiles.extName}</a>
				</td>
				<td>
					<script>
						var mySize = ${sysFiles.fileSize}/1024;
						if(mySize > 1024) {
                            mySize = mySize/1024;
                            document.write(mySize.toFixed(2) + "M");
						} else {
                            document.write(mySize.toFixed(2) + " KB");
						}
					</script>
				</td>
				<td>
					存储类别：${fns:getDictLabel(sysFiles.storeType, 'file_store_type', '')}<br/>
					内容类型：${sysFiles.contentType}
				</td>
				<td>
					MD5：${sysFiles.codeMd5}<br/>
					SHA1：${sysFiles.codeSha1}<br/>
					${sysFiles.relativeUrl}
				</td>
				<td>
					${sysFiles.createBy.name}
				</td>
				<td><fmt:formatDate value="${sysFiles.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<%--<shiro:hasPermission name="sys:sysFiles:edit"><td>
    				<a href="${ctxAdmin}/sys/sysFiles/form?id=${sysFiles.id}">修改</a>
					<a href="${ctxAdmin}/sys/sysFiles/delete?id=${sysFiles.id}" onclick="return confirmx('确认要删除该保存文件成功吗？', this.href)">删除</a>
				</td></shiro:hasPermission>--%>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>