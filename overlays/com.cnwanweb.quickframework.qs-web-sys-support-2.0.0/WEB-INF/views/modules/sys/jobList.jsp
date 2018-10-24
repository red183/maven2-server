<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>定时器管理</title>
	<meta name="decorator" content="default"/>
	<style>
		.updateCronBtn {}
		.middelSpan {height: 100%;display: inline-block;vertical-align: middle;}
	</style>
	<script type="text/javascript">
        Date.prototype.format = function (format) {
            var o =
                {
                    "M+" : this.getMonth() + 1, // month
                    "d+" : this.getDate(), // day
                    "h+" : this.getHours(), // hour
                    "m+" : this.getMinutes(), // minute
                    "s+" : this.getSeconds(), // second
                    "q+" : Math.floor((this.getMonth() + 3)  / 3), // quarter
                    "S" : this.getMilliseconds() // millisecond
                }
            if (/(y+)/.test(format))
            {
                format = format.replace(RegExp.$1, (this.getFullYear() + "") .substr(4 - RegExp.$1.length));
            }
            for ( var k in o)
            {
                if (new RegExp("(" + k + ")").test(format))
                {
                    format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
                }
            }
            return format;
        }

		function javaDateToFormat(obj) {
			return new Date(obj.time).format('yyyy-MM-dd hh:mm:ss');
		}
		function refreshJobAndTriggers(datas) {
//		    var datas = [];
//		    $.each(jobAndTriggers, function(k, v){
//				//console.log(k, v);
//				$.each(v, function(i, obj) {
//                    //console.log(jobIndex, jobObject);
//                    var jobInfo = {};
//                    $.each(obj, function(k2, v2) {
//                        //console.log(k2, v2);
//						if(k2 == 'jobName') {
//                            jobInfo.jobName = v2;
//						} else if(k2 == 'jobGroupName') {
//                            jobInfo.jobGroupName = v2;
//						} else if(k2 == 'triggers') {
//                            $.each(v2, function(j, obj2) {
//                               var triggerInfo = obj2;
//                                triggerInfo.jobGroupName = jobInfo.jobGroupName;
//                                triggerInfo.jobName = jobInfo.jobName;
//								datas.push(triggerInfo);
//                            });
//						}
//                    });
//				});
//			});
		    //TODO 强制要求 triggerName 唯一
		    $.each(datas, function(index, object) {
				var triggerName = object.triggerName;
				var $tr = $('#' + triggerName);
				$tr.find('td').each(function(i){
					if(i == 1) {
					    var $input = $($(this).find('input')[0]);
                        $input.val(object.cronExpression);
					} else if(i == 2) {
					    $(this).html(javaDateToFormat(object.startTime));
					} else if(i == 3) {
                        $(this).html(javaDateToFormat(object.nextFireTime));
                    } else if(i == 4) {
                        $(this).html(object.triggerState);
                    }
				});
			});
		}
		$(function(){
            $('.updateCronBtn').each(function(){
                $(this).click(function(){
                    var $this = $(this);
                    var $tr = $($this.parent().parent());
                    var updateTxtObj = $this.parent().parent().find('.updateCronTxt')[0];

                    var params = {};
                    var postUrl = $this.attr('data-href');
                    params.triggerGroupName = $tr.attr('data-triggerGroupName');
                    params.triggerName = $tr.attr('data-triggerName');
                    params.cronExpression = $(updateTxtObj).val();
                    $.ajax({type:'post', cache: false, data: params, url: postUrl, dataType: 'json', success: function(data){
                        if(data.tag == "SUCCESS") {
                            $.jBox.tip('CRON表达式更新成功！');
                            refreshJobAndTriggers(data.result);
						} else {
                            $.jBox.alert('CRON表达式更新失败！', data.message);
						}
                    }});
                });
            });

            function doCommonOper(targetObj) {
                var $this = $(targetObj);
                var $tr = $($this.parent().parent());
                var params = {};
                var postUrl = $this.attr('data-href');
                params.triggerGroupName = $tr.attr('data-triggerGroupName');
                params.triggerName = $tr.attr('data-triggerName');
                $.ajax({type:'post', data: params, url: postUrl, dataType: 'json', success: function(data){
                    if(data.tag = "SUCCESS") {
                        $.jBox.tip('更新成功！');
                        refreshJobAndTriggers(data.result);
                    } else {
                        $.jBox.tip('更新失败！参考信息：' + data.message);
                    }
                }});
			}

            $('.statusBtn').each(function(){
                $(this).click(function(){
                    doCommonOper(this);
                });
            });

            $('.btnOneKey').each(function(){
                var $this = $(this);
                $this.click(function(){
                    var params = {};
                    var postUrl = $this.attr('data-href');
                    $.ajax({type:'post', data: params, url: postUrl, dataType: 'json', success: function(data){
                        if(data.tag = "SUCCESS") {
                            $.jBox.tip($this.attr('value') + '成功！');
                            refreshJobAndTriggers(data.result);
                        } else {
                            $.jBox.tip($this.attr('value') + '失败！参考信息：' + data.message);
                        }
                    }});
                });
			});
		});
	</script>
</head>
<body>
<form>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxAdmin}/sys/quartz/job/list/">定时任务列表</a></li>
	</ul>
	<form:form id="searchForm" class="breadcrumb form-search">
		&nbsp;<input class="btn btn-primary btnOneKey" type="button" value="一键恢复" data-href="${ctxAdmin}/schedule/quartz/allResumeTrigger" style="float: right;margin-right: 9px;"/>
		&nbsp;<input class="btn btn-warning btnOneKey" type="button" value="一键暂停" data-href="${ctxAdmin}/schedule/quartz/allPauseTrigger" style="float: right;margin-right: 9px;"/>
	</form:form>
<c:forEach items="${jobGroupMap}" var="jobGroupItem" varStatus="stt">
	<h1>(${stt.index}) - ${jobGroupItem.key}</h1>
	<table class="table table-striped table-bordered table-condensed">
		<tr>
			<th>任务名称</th><%--<th>定时器分组</th><th>定时器名称</th>--%><th>定时器 CRON 表达式</th>
			<th>开始时间</th><%--<th>结束时间</th>--%><th>下次触发时间</th><%--<th>最后触发时间</th>--%><th>状态</th>
			<shiro:hasPermission name="schedule:quartz:edit"><th>操作</th></shiro:hasPermission>
		</tr>
		<c:forEach items="${jobGroupItem.value}" var="jobListItem">
		<c:forEach items="${jobListItem.triggers}" var="triggerItem">
		<tr id="${triggerItem.triggerName}" data-jobGroupName="${jobGroupItem.key}"
			data-jobName="${jobListItem.jobName}"
			data-triggerGroupName="${triggerItem.triggerGroup}"
			data-triggerName="${triggerItem.triggerName}" class="jobAndTriggers">
			<td>${jobListItem.jobName}</td>
			<%--<td>${triggerItem.triggerGroup}</td>
			<td>${triggerItem.triggerName}</td>--%>
			<td>
				<span class="middelSpan"></span>
				<input class="updateCronTxt" type="text" value="${triggerItem.cronExpression}" style="vertical-align: middle;max-height: 35px;margin-bottom: 0;" />
			</td>
			<td><fmt:formatDate value="${triggerItem.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			<%--<td><fmt:formatDate value="${triggerItem.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>--%>
			<td><fmt:formatDate value="${triggerItem.nextFireTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			<%--<td><fmt:formatDate value="${triggerItem.finalFireTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>--%>
			<td>${triggerItem.triggerState}
				<%--<c:choose>
					<c:when test="${triggerItem.triggerState == 'NONE'}">不存在</c:when>
					<c:when test="${triggerItem.triggerState == 'NORMAL'}">正常</c:when>
					<c:when test="${triggerItem.triggerState == 'PAUSED'}">暂停</c:when>
					<c:when test="${triggerItem.triggerState == 'COMPLETE'}">完成</c:when>
					<c:when test="${triggerItem.triggerState == 'ERROR'}">错误</c:when>
					<c:when test="${triggerItem.triggerState == 'BLOCKED'}">阻塞</c:when>
					<c:otherwise>未定义-${triggerItem.triggerState}</c:otherwise>
				</c:choose>--%>
			</td>
			<shiro:hasPermission name="schedule:quartz:edit">
			<td>
				&nbsp;<a class="updateCronBtn" data-href="${ctxAdmin}/schedule/quartz/updateTriggerCron" href="#">修改</a>
				&nbsp;<a class="statusBtn" data-href="${ctxAdmin}/schedule/quartz/pauseTrigger" href="#">暂停</a>
				&nbsp;<a class="statusBtn" data-href="${ctxAdmin}/schedule/quartz/resumeTrigger" href="#">恢复</a>
				<%--<c:choose>
					<c:when test="${triggerItem.triggerState == 'NORMAL'}">
					</c:when>
					<c:when test="${triggerItem.triggerState == 'PAUSED'}">
					</c:when>
				</c:choose>--%>
			</td>
			</shiro:hasPermission>
		</tr>
		</c:forEach>
		</c:forEach>
	</table>
</c:forEach>
</form>
</body>
</html>