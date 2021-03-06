
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>查看未读信息</title>
	
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=messageReply"></script>
	
	<script type="text/javascript">
	
	$(function() {

		function showRequest(formData, jqForm, options) { 
			return true;
		} 
		valid(showRequest,showResponse);
		
		function showResponse(responseText, statusText)  { 
			var obj=new org.sz.form.ResultMessage(responseText);
			if(obj.isSuccess()){//成功
				$.ligerMessageBox.success('提示信息',obj.getMessage(),function(rtn){
					if(rtn){
						$('#btnReply').css('visibility','hidden');
					}
				});
				
		    }else{//失败
		    	$.ligerMessageBox.error('提示信息',obj.getMessage());
		    }
		}
		
//		parent.$('div.l-dialog-winbtn').click(function() {
//			winCls();
//		});
//		
		
		
		//进入后刷新未读信息条数
		top.refreshMsg();
	});
	
	// 查看下一条信息
	function nextMsg(){
		var url=__ctx + "/platform/system/messageSend/readMsgDialog.xht";
		window.location.href =url;
	}
		
	// 提交回复
	function msgReply(){

		$('#messageReplyForm').submit();
	}
	
	// 回复是否私密
	function changePrivate(value){

		$("#isPrivate").val(value);
	}
	
	</script>
	
</head>
<body>
<div class="panel">
		<%-- <div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">查看未读信息</span>
			</div>
		</div>
		--%>
		<div class="panel-body">
			<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<th width="20%">标题:</th>
					<td>${messageSend.subject}</td>
					<th width="20%">发送时间:</th>
					<td><fmt:formatDate value="${messageSend.sendTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				</tr>
				<tr>
					<th width="20%">发信人:</th>
					<td colspan="3">${messageSend.userName}</td>
				</tr>					
				<tr>
					<th width="20%">内容:</th>
					<td colspan="3">${messageSend.content}</td>
				</tr>
				<c:if test="${messageSend.canReply==1}">
				<tr>
					<th width="20%">私密回复: </th>
					<td colspan="3">
						<input type="radio" name="rdoPrivate" value="1" checked="checked" onclick="changePrivate(value)"/>是
						<input type="radio" name="rdoPrivate" value="0" onclick="changePrivate(value)"/>否
					</td>
				</tr>
				<tr>
					<th width="20%">回复内容:</th>
					<td colspan="3">
						<form id="messageReplyForm" name="messageReplyForm" action="${ctx}/platform/system/messageReply/reply.xht" method="post">
						    <textarea rows="3" cols="60" name="content">${messageReply.content}</textarea>
						    <input type="hidden" value="${messageReply.messageId}" name="messageId" />
						    <input type="hidden" value="${messageReply.isPrivate}" id="isPrivate" name="isPrivate" />
						</form>
					    <br>
					    <a href='#' id="btnReply" class='button' onclick="msgReply()" 
					    	style="margin-left:150px;" ><span>回&nbsp;&nbsp;&nbsp;&nbsp;复</span></a>
					</td>
				</tr>
				</c:if>
			</table>
		</div>
		<br>
		<div position="bottom"  class="bottom" style='margin-top:10px'>
			<form id="nextMsgForm" action=""></form>
			<c:if test="${flag==true}">
			<a href='#' class='button' onclick="nextMsg()" ><span>下一条</span></a>
			</c:if>
			<a href='#' class='button' style='margin-left:10px;' onclick="window.close();">
				<span>关&nbsp;&nbsp;&nbsp;&nbsp;闭</span></a>
		</div>
		
</div>

</body>
</html>
