<%@page import="org.sz.platform.system.model.GlobalType"%>
<%@page pageEncoding="UTF-8" %>
<%@include file="/commons/include/html_doctype.html"%>
<html>
	<head>
		<title>选择流程表单</title>
		<%@include file="/commons/include/form.jsp" %>
		<link rel="stylesheet" href="${ctx}/jslib/tree/v30/zTreeStyle.css" type="text/css" />
		<script type="text/javascript" src="${ctx}/jslib/lg/plugins/ligerLayout.js" ></script>
	    <script type="text/javascript"	src="${ctx}/jslib/tree/v30/jquery.ztree.core-3.0.min.js"></script>
	    <script type="text/javascript" src="${ctx}/js/sz/platform/form/GlobalType.js"></script>
	    <script type="text/javascript">
	   		var catKey="<%=GlobalType.CAT_FORM%>";
			var globalType=new GlobalType(catKey,"glTypeTree",{onClick:treeClick});
			
			$(function(){
				$("#defLayout").ligerLayout({ leftWidth: 200,height: '90%',
						bottomHeight :40,
					 	allowBottomResize:false});
			
				globalType.loadGlobalTree();
			});
			
			//展开收起
			function treeExpandAll(type){
				globalType.treeExpandAll(type);
			};
			
			function treeClick( treeNode){
				if(treeNode.isRoot==undefined){
					var categroyId=treeNode.typeId;
				
					var url="selector.xht?categoryId="+categroyId;
	        		$("#formFrame").attr("src",url);
				}
        	}
			
			function selectForm(){
				var formName="";
				var formKey="";
				$('#formFrame').contents().find(":radio[name='formKey']:checked").each(function(){
					formName=$(this).siblings("input[name='subject']").val();
					formKey=$(this).val();
				});
				if(formKey==""){
					$.ligerMessageBox.warn('提示信息',"请选择表单ID!");
					return "";
				}
				
				window.returnValue={formKey:formKey,formName:formName};
				window.close();
			}
			
		</script>
		<style type="text/css">
			body{overflow: hidden;}
			div.bottom{text-align: center;}
			div.bottom input {width:65px;margin: 8px 10px;font-size: 14px;height: 23px;}
		</style>
	</head>
	<body>
			<div id="defLayout" >
	            <div position="left" title="表单分类" style="overflow: auto;float:left;">
					<ul id="glTypeTree" class="ztree"></ul>
	            </div>
	            <div position="center"  title="表单">
	          		<iframe id="formFrame" name="formFrame" height="100%" width="100%" frameborder="0"  src="selector.xht"></iframe>
	            </div>  
       	  </div>
       	 <div position="bottom"  class="bottom" style='margin-top:10px;'>
			  <a href='#' class='button'  onclick="selectForm()" ><span class="icon ok"></span><span >选择</span></a>
			  <a href='#' class='button' style='margin-left:10px;' onclick="window.close()"><span class="icon cancel"></span><span >取消</span></a>
		</div>
	
	</body>
</html>