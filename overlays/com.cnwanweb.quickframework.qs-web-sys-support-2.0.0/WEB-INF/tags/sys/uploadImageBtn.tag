<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="targetId" type="java.lang.String" required="true" description="编号"%>
<%@ attribute name="tip" type="java.lang.String" required="false" description="提示内容"%>
<%@ attribute name="title" type="java.lang.String" required="true" description="选择框标题"%>
<%@ attribute name="cssClass" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="cssStyle" type="java.lang.String" required="false" description="css样式"%>
<%@ attribute name="hideBtn" type="java.lang.Boolean" required="false" description="是否显示按钮"%>
<div class="input-append" style="padding-left: 3px;">
	<a title="${tip}" id="${targetId}Button" href="javascript:" class="btn ${disabled} ${hideBtn ? 'hide' : ''}" style="${smallBtn?'padding:4px 2px;':''}">&nbsp;<i class="icon-search"></i>&nbsp;</a>&nbsp;&nbsp;
</div>
<script type="text/javascript">
	$("#${targetId}Button").click(function(){
		// 是否限制选择，如果限制，设置为disabled
		if ($("#${targetId}Button").hasClass("disabled")){
			return true;
		}
		// 正常打开	buttons:{"确定":"ok", "关闭":true}
		top.$.jBox.open("iframe:${ctxAdmin}/tag/uploadselect", "选择${title}", 300, 400, {
			ajaxData:{selectIds: $("#${targetId}Id").val()},buttons:{"确定":"ok", "窗口预览":"browse"},
			submit:function(v, h, f){
                var subWin = h.find("iframe")[0].contentWindow;
                var $imgShow = $(subWin.imgShow);
                var $relativeUrl = $(subWin.relativeUrl);//$('#relativeUrl')
                var imageSrc = $imgShow.attr('src');
                var relativeUrl = $relativeUrl.val();
			    if(v == 'browse') {
                    window.open(imageSrc);
                } else if (v=="ok"){
                    $("#${targetId}").val(relativeUrl);
				}
			}, loaded:function(h){
				$("#jbox-content", top.document).css("overflow","hidden");

				var currentUrl = $("#${targetId}").val();
				if(!!currentUrl) {
                    var subWin = h.find("iframe")[0].contentWindow;
                    var $imgShow = $(subWin.imgShow);
                    var $relativeUrl = $(subWin.relativeUrl);
                    if(currentUrl.indexOf("http") == 0) {
                        $imgShow.attr('src', currentUrl);
                    } else {
                        $imgShow.attr('src', '${ctx}' + currentUrl);
                    }
                    $relativeUrl.val(currentUrl);
                }
			}
		});
	});
</script>