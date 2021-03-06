<%--
	desc:edit the 脚本管理
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>编辑 脚本管理</title>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=script"></script>
	<script type="text/javascript" src="${ctx}/js/ligerui/plugins/ligerComboBox.js"></script>
	<script type="text/javascript" src="${ctx}/js/ligerui/plugins/htDicCombo.js"></script>
	<script type="text/javascript">
		$(function() {
			function showRequest(formData, jqForm, options) { 
				return true;
			} 
			valid(showRequest,showResponse);
			$("a.save").click(function() {
				$('#scriptForm').submit(); 
			});
		});
	</script>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
			    <c:choose>
			        <c:when test="${script.id !=null }">
			            <span class="tbar-label">编辑脚本管理</span>
			        </c:when>
			        <c:otherwise>
			            <span class="tbar-label">添加脚本管理</span>
			        </c:otherwise>
			    </c:choose>					
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href="#">保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back " href="list.xht">返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body">
				<form id="scriptForm" method="post" action="save.xht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<th width="20%">名称: </th>
							<td><input type="text" id="name" name="name" size="60" value="${script.name}"  class="inputText"/></td>
						</tr>
						<tr>
							<th width="20%">脚本: </th>
							<td><textarea type="text" id="script" name="script"  rows="10" cols="80" >${script.script}</textarea></td>
						</tr>
						<tr>
							<th width="20%">脚本分类: </th>
							<td>
								<input class="dicComboBox" nodeKey="scriptType" name="category" value="${script.category}"  height="40" />
							</td>
						</tr>
						<tr>
							<th width="20%">备注: </th>
							<td><textarea id="memo" name="memo" rows="5" cols="80">${script.memo}</textarea></td>
						</tr>
					</table>
					<input type="hidden" name="id" value="${script.id}" />
				</form>
		</div>
</div>
</body>
</html>
