<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>选择自定义表</title>
<script type="text/javascript">
	function getTable(tableId,tableName){
		var obj={tableId:tableId,tableName:tableName};
		window.returnValue=obj;
		window.close();
	}
</script>
<style type="text/css">
	div.bottom{text-align: center;padding-top: 10px;}
	html,body{width:100%;height:100%;margin: 0 0 0 0;padding: 0 0 0 0 ;overflow: hidden;}
</style>
</head>
<body>
	<iframe src="dialog.xht" width="100%" height="100%" frameborder="0"></iframe>
</body>
</html>


