<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>桌面栏目明细</title>
	<%@include file="/commons/include/getById.jsp" %>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">桌面栏目详细信息</span>
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
						<th width="20%">栏目名称:</th>
						<td>${desktopColumn.name}</td>
					</tr>
					<tr>
						<th width="20%">数据方法名:</th>
						<td>${desktopColumn.serviceMethod}</td>
					</tr>
					<tr>
						<th width="20%">模板名称:</th>
						<td>${desktopColumn.templateName}</td>
					</tr>
					<tr>
						<th width="20%">模板标识:</th>
						<td>${desktopColumn.templateId}</td>
					</tr>
					<tr>
						<th width="20%">栏目路径:</th>
						<td>${desktopColumn.columnUrl}</td>
					</tr>
					<tr>
						<th width="20%">栏目HTML:</th>
						<td><textarea id="html" name="html" readonly="readonly" cols=100 rows=20>${fn:escapeXml(desktopColumn.html)}</textarea></td>
					</tr>
				</table>
		</div>
</div>
</body>
</html>
