<%--
	desc:edit the 系统角色表
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>编辑 系统角色表</title>
	<%@include file="/commons/include/form.jsp" %>
	<link href="${ctx}/themes/css/default/ligerui-all.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${ctx}/jslib/calendar/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=sysRole"></script>
	<script type="text/javascript">
		$(function() {
			function showRequest(formData, jqForm, options) { 
				return true;
			} 
			valid(showRequest,showResponse);
			$("a.save").click(function() {
				$('#sysRoleForm').submit(); 
			});
		});
	</script>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">
				<c:if test="${sysRole.roleId==null }">添加系统角色</c:if>
				<c:if test="${sysRole.roleId!=null }">编辑系统角色</c:if>  
				</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href="#">保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="list.xht">返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body">
				<form id="sysRoleForm" method="post" action="save.xht">
					<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<th width="20%">角色名称: </th>
							<td><input type="text" id="roleName" name="roleName" value="${sysRole.roleName}"  class="inputText"/></td>
						</tr>
						<tr>
							<th width="20%">角色别名: </th>
							<td><input type="text" id="alias" name="alias" value="${sysRole.alias}"  class="inputText"/></td>
						</tr>
						<c:if test="${systemId!=1}">
						    <c:choose>
							<c:when test="${sysRole.roleId!=null }">
											<input type="hidden" name="systemId" value="${sysRole.systemId}" />
										</c:when>
										<c:otherwise>
											<input type="hidden" name="systemId" value="${systemId}" />
										</c:otherwise>
							</c:choose>
						</c:if>
						<c:if test="${systemId==1}">
							<tr>
								<th width="20%">子系统名称: </th>
								<td>
									<c:choose>
										<c:when test="${sysRole.roleId==null }">
											<select name="systemId" id="systemId" class="select" style="width:18%;">
											    <option value="">--请选择--</option>
												<c:forEach var="subsystem" items="${subsystemList }">
													<option value="${subsystem.systemId}"  >${subsystem.sysName}</option>
												</c:forEach>
											</select>
										</c:when>
										<c:otherwise>
											<input type="hidden" name="systemId" value="${sysRole.systemId }" />
											<c:forEach var="subsystem" items="${subsystemList }">
												 <c:if test="${sysRole.systemId==subsystem.systemId }">${subsystem.sysName }</c:if>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						
						</c:if>
						
						<tr>
							<th width="20%">备注: </th>
							<td>
								<textarea rows="3" cols="50" id="memo" name="memo">${sysRole.memo}</textarea>
						</tr>
						<tr>
							<th width="20%">允许删除: </th>
							<td>
								<input type="radio" id="allowDel" name="allowDel" value="1" checked="checked" <c:if test="${sysRole.allowDel==1}"> checked="checked" </c:if> />允许
								<input type="radio" id="allowDel" name="allowDel" value="0"  <c:if test="${sysRole.allowDel==0}"> checked="checked" </c:if> >不允许
							</td>
						</tr>
						<tr>
							<th width="20%">允许编辑: </th>
							<td>
							    <input type="radio" id="allowEdit" name="allowEdit" value="1" checked="checked" <c:if test="${sysRole.allowEdit==1}"> checked="checked" </c:if> />允许
								<input type="radio" id="allowEdit" name="allowEdit" value="0"  <c:if test="${sysRole.allowEdit==0}"> checked="checked" </c:if> >不允许
							</td>
						</tr>
						<tr>
							<th width="20%">是否启用: </th>
							<td>
							    <input type="radio" id="enabled" name="enabled" value="1" checked="checked" <c:if test="${sysRole.enabled==1}"> checked="checked" </c:if> />启用
								<input type="radio" id="enabled" name="enabled" value="0"  <c:if test="${sysRole.enabled==0}"> checked="checked" </c:if> >禁用
							</td>
						</tr>
					</table>
					<input type="hidden" name="roleId" value="${sysRole.roleId}" />
				</form>
		</div>
</div>
</body>
</html>
