<%@ page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>选择补签人员</title>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/js/sz/platform/system/SysDialog.js"></script>
	<script type="text/javascript">
	var taskId="${param.taskId}";
	function selectSignUsers(){
		var uIds=$("#addSignUserIds");
		var uNames=$('#addSignFullnames');
		UserDialog({callback:function(userIds,fullnames){
						uIds.val(userIds);
						uNames.val(fullnames);
					}
				});
	}
	
	function save(){
		 var signUserIds=$("#addSignUserIds").val();
		 if(signUserIds!=''){
    		 $.post(__ctx+'/platform/bpm/task/addSign.xht',
    				 {
    			 		taskId:taskId,
    			 		signUserIds:signUserIds
    				 },
	        		 function(){
    					 $.ligerMessageBox.success('操作成功','你成功进行了补签!',function(){
    						 window.returnValue={};
    						 window.close();
    					 });
	        		 }
    		 );
		 }
	}
	
	$(function(){
		$("#dataFormSave").click(save);
	});
	</script>
</head>
<body>


<div class="panel">
	<div class="panel-top">
		<div class="tbar-title">
			<span class="tbar-label">任务补签</span>
		</div>
		<div class="panel-toolbar">
			<div class="toolBar">
				<div class="group">
					<a class="link save" id="dataFormSave" href="#">补签</a>
				</div>
				<div class="l-bar-separator"></div>
				<div class="group">
					<a class="link del" href="#" onclick="window.close()">关闭</a>
				</div>
			</div>
		</div>
	</div>
	<table class="table-detail">
		<tr>
			<th nowrap="nowrap">选择补签人员</th>
			<td>
				<input type="hidden" id="addSignUserIds"/>
				<input type="hidden" id="taskId" value="${param.taskId}"/>
				<input type="text" size="60" value="" readonly="readonly" id="addSignFullnames" class="inputText"/> <input type="button" onclick="selectSignUsers()" value="选择.."/>
			</td>
		</tr>
	</table>
</div>
</body>
</html>