<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>图片上传选择器</title>
	<meta name="decorator" content="blank"/>
	<script src="${ctxStatic}/jquery-fileupload/js/vendor/jquery.ui.widget.js" type="text/javascript"></script>
	<script src="${ctxStatic}/jquery-fileupload/js/jquery.iframe-transport.js" type="text/javascript"></script>
	<script src="${ctxStatic}/jquery-fileupload/js/jquery.fileupload.js" type="text/javascript"></script>
	<link rel="stylesheet" href="${ctxStatic}/jquery-fileupload/css/style.css">
	<link rel="stylesheet" href="${ctxStatic}/jquery-fileupload/css/jquery.fileupload.css">
	<style>
		body {padding: 7px;}
		.rowex {margin-left:0;}
	</style>
</head>
<body>
	<div class="row rowex" style="border: 1px solid gray;text-align: center;height: 250px;">
		<span style="height: 100%;display: inline-block;vertical-align: middle;"></span>
		<img id="imgShow" src="${ctxStatic}/images/userinfobig.jpg" style="max-width: 240px; max-height: 240px;padding: 5px;vertical-align: middle;">
	</div>
	<div class="row rowex" style="margin-top: 12px;text-align: center;">
		<span class="btn btn-success fileinput-button">
			<i class="glyphicon glyphicon-plus"></i>
			<span>请选择图片上传</span>
			<input id="fileToUpload" type="file" name="fileToUpload">
			<input id="relativeUrl" type="hidden" name="relativeUrl">
		</span>
	</div>
	<script type="text/javascript">
        $(function(){
            $('#fileToUpload').fileupload({
                url:'${ctxAdmin}/sys/files/upload',
                dataType: 'json',
                done: function (e, data) {
                    if(data.result && data.result.result.length > 0) {
                        var respond = data.result.result[0];
						var relativeUrl = respond.relativeUrl;
						$('#relativeUrl').val(relativeUrl);
						if(relativeUrl.indexOf('http') == 0) {
                            $('#imgShow').attr('src', relativeUrl);
                        } else {
                            $('#imgShow').attr('src', '${ctx}' + relativeUrl);
                        }
                    } else {
                        $.jBox.tip('上传失败！');
                    }
                }, start: function (e) {
					var errImgUrl = '${ctxStatic}/images/loading.gif';
					$('#imgShow').attr('src', errImgUrl);
				}
            }).prop('disabled', !$.support.fileInput).parent().addClass($.support.fileInput ? undefined : 'disabled');
        });
	</script>
</body>