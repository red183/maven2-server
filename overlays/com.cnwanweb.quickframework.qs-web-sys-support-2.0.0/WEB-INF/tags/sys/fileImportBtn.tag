<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="编号"%>
<%@ attribute name="title" type="java.lang.String" required="true" description="弹窗标题"%>
<%@ attribute name="btnName" type="java.lang.String" required="true" description="按钮名称"%>
<%@ attribute name="afterBeanName" type="java.lang.String" required="true" description="文件处理类"%>
<%@ attribute name="accept" type="java.lang.String" required="true" description="文件类型"%>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="cssStyle" type="java.lang.String" required="false" description="css样式"%>
<div class="input-append">
	<input id="${id}FileImportBtn" class="btn ${cssClass}" style="${cssStyle}" type="button" value="${btnName}"/>
	<input id="${id}FileImport" accept="${accept}" type="file" name="${id}FileImport" style="position: absolute; left: -1000px;">
</div>
<script type="text/javascript">
    $(function(){
        $("#${id}FileImportBtn").click(function(){
            $("#${id}FileImport").click();
        });
        $('#${id}FileImport').fileupload({
            url:'${ctxAdmin}/sys/files/upload?afterBeanName=${afterBeanName}',
            dataType: 'json',
            done: function (e, data) {
                var endTime = new Date().getTime();
                if(data.result && data.result.result.length > 0) {
//                    var respond = data.result.result[0];
//                $('#relativeUrl').val(respond.relativeUrl);
//                var html = '';
//                html += '<div class="span8 tl">上传用时：' + (endTime - startTime) + '</div>';
//                html += '<div class="span8 tl">文件路径：' + respond.relativeUrl + '</div>';
//                html += '<div class="span8 tl">文件类型：' + respond.contentType + '</div>';
//                html += '<div class="span8 tl">文件大小：' + respond.fileSize + '</div>';
//                $('#uploadFileInfo').html(html);
                    $.jBox.tip('文件处理成功！');
                } else {
                    $.jBox.tip('文件处理失败！');
                }
            }, start: function (e) {
                startTime = new Date().getTime();
                $.jBox.tip('文件处理中，请耐心等候……');
            }
        }).prop('disabled', !$.support.fileInput).parent().addClass($.support.fileInput ? undefined : 'disabled');
	});
</script>