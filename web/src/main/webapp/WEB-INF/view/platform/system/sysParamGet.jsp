
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>系统参数属性明细</title>
	<%@include file="/commons/include/getById.jsp" %>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">系统参数属性详细信息</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link back" href="list.xht">返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body">
				<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
					
					<tr>
						<th width="20%">参数名:</th>
						<td>${sysParam.paramName}</td>
					</tr>
					<tr>
						<th width="20%">参数Key:</th>
						<td>${sysParam.paramKey}</td>
					</tr>
					<tr>
						<th width="20%">参数类型:</th>
						<td>
							<c:if test="${sysParam.effect==1}">用户参数</c:if>
							<c:if test="${sysParam.effect==2}">组织参数</c:if>
												
						</td>
					</tr>
					<tr>
						<th width="20%">数据类型:</th>
						<td>
						
							<c:forEach items="${dataTypeMap}" var="t">
										<c:if test="${t.key==sysParam.dataType}">${t.value}</c:if>
							</c:forEach>
						
						</td>
					</tr>
					
				</table>
		</div>
</div>

</body>
</html>
