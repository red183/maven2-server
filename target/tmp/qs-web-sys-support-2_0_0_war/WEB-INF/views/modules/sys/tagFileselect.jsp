<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>文件上传选择器</title>
	<meta name="decorator" content="blank"/>
	<script src="${ctxStatic}/jquery-fileupload/js/vendor/jquery.ui.widget.js" type="text/javascript"></script>
	<script src="${ctxStatic}/jquery-fileupload/js/jquery.iframe-transport.js" type="text/javascript"></script>
	<script src="${ctxStatic}/jquery-fileupload/js/jquery.fileupload.js" type="text/javascript"></script>
	<link rel="stylesheet" href="${ctxStatic}/jquery-fileupload/css/style.css">
	<link rel="stylesheet" href="${ctxStatic}/jquery-fileupload/css/jquery.fileupload.css">
	<style>
		body {padding: 7px;}
		.rowex {margin-left:0;}
		.tl {text-align: left;}
	</style>
</head>
<body>
	<div class="row rowex" style="margin-top: 12px;text-align: center;">
		<span class="btn btn-success fileinput-button">
			<i class="glyphicon glyphicon-plus"></i>
			<span>请选择文件上传</span>
			<input id="fileToUpload" type="file" name="fileToUpload">
			<input id="relativeUrl" type="hidden" name="relativeUrl">
		</span>
	</div>
	<div id="imgShowDiv" class="row rowex" style="display:none; border: 1px solid gray;text-align: center;height: 250px;">
		<span style="height: 100%;display: inline-block;vertical-align: middle;"></span>
		<img id="imgShow" src="${ctxStatic}/images/loading.gif" style="max-width: 240px; max-height: 240px;padding: 5px;vertical-align: middle;">
	</div>
	<div id="uploadFileInfo" class="row rowex" style="margin-top: 12px;text-align: center;">

	</div>
	<script type="text/javascript">
        $(function(){
            var startTime = null;
            $('#fileToUpload').fileupload({
                url:'${ctxAdmin}/sys/files/upload',
                dataType: 'json',
                done: function (e, data) {
                    var endTime = new Date().getTime();
                    $('#imgShowDiv').hide();
                    if(data.result && data.result.result.length > 0) {
                        var respond = data.result.result[0];
						$('#relativeUrl').val(respond.relativeUrl);
						var html = '';
						html += '<div class="span8 tl">上传用时：' + (endTime - startTime) + '</div>';
						html += '<div class="span8 tl">文件路径：' + respond.relativeUrl + '</div>';
						html += '<div class="span8 tl">文件类型：' + respond.contentType + '</div>';
						html += '<div class="span8 tl">文件大小：' + respond.fileSize + '</div>';
						$('#uploadFileInfo').html(html);
                    } else {
                        $.jBox.tip('上传失败！');
                    }
                }, start: function (e) {
					startTime = new Date().getTime();
                    $('#imgShowDiv').show();
				}
            }).prop('disabled', !$.support.fileInput).parent().addClass($.support.fileInput ? undefined : 'disabled');
        });
	</script>
</body>