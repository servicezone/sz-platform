<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>桌面布局明细</title>
	<%@include file="/commons/include/getById.jsp" %>
</head>
<body>
	<div class="panel">
			<div class="panel-top">
				<div class="tbar-title">
					<span class="tbar-label">桌面布局详细信息</span>
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
							<th width="20%">布局名:</th>
							<td>${desktopLayout.name}</td>
						</tr>
						<tr>
							<th width="20%">列数:</th>
							<td>${desktopLayout.cols}</td>
						</tr>
						<tr>
							<th width="20%">宽度:</th>
							<td>${desktopLayout.width}</td>
						</tr>
						<tr>
							<th width="20%">备注:</th>
							<td>${desktopLayout.memo}</td>
						</tr>
						<tr>
							<th width="20%">默认布局:</th>
							<td>${desktopLayout.isDefault}</td>
						</tr>
					</table>
			</div>
	</div>
</body>
</html>
