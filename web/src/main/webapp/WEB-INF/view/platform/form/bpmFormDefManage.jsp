<%@page import="org.sz.platform.system.model.GlobalType"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="org.sz.platform.bpm.model.flow.BpmDefRights"%>
<%@include file="/commons/include/html_doctype.html"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>表单定义管理</title>
<%@include file="/commons/include/form.jsp" %>
<link rel="stylesheet" href="${ctx}/jslib/tree/v30/zTreeStyle.css" type="text/css" />
<script type="text/javascript" src="${ctx}/jslib/lg/plugins/ligerLayout.js" ></script>
<script type="text/javascript" src="${ctx}/jslib/lg/plugins/ligerMenu.js"></script>
<script type="text/javascript" src="${ctx}/jslib/tree/v30/jquery.ztree.core-3.0.min.js"></script>
<script type="text/javascript" src="${ctx}/js/sz/platform/form/GlobalType.js"></script>
<script type="text/javascript" src="${ctx}/js/sz/platform/form/FormDefMenu.js"></script>
<style type="text/css">
	.tree-title{overflow:hidden;width:100%;}
</style>	
	<script type="text/javascript">
		var catKey="<%=GlobalType.CAT_FORM%>";
		var curMenu=null;
		
		var globalType=new GlobalType(catKey,"glTypeTree",{onClick:onClick,onRightClick:zTreeOnRightClick});
		var formDefMenu=new FormDefMenu();
				
		function onClick(treeNode){
			var url="${ctx}/platform/form/bpmFormDef/list.xht";
			if(treeNode.isRoot==undefined){
				var typeId=treeNode.typeId;
				url+="?categoryId="+typeId;
			}
			$("#defFrame").attr("src",url);
		}
				
		function hiddenMenu(){
			if(curMenu){
				curMenu.hide();
			}
		}
		
		$(function (){
		  	//布局
		    $("#defLayout").ligerLayout({ leftWidth:210,height: '100%',allowLeftResize:false});
		  	$(document).click(hiddenMenu);
			globalType.loadGlobalTree();
		});
		        
		      
		        
		function handler(item){
		 	hiddenMenu();
		 	var txt=item.text;
		 	switch(txt){
		 		case "增加分类":
		 			globalType.openGlobalTypeDlg(true);
		 			break;
		 		case "编辑分类":
		 			globalType.openGlobalTypeDlg(false);
		 			break;
		 		case "删除分类":
		 			globalType.delNode();
		 			break;
		 	}
		
		}
		/**
		 * 树右击事件
		 */
		function zTreeOnRightClick(event, treeId, treeNode) {
			if (treeNode) {
				globalType.currentNode=treeNode;
				globalType.glTypeTree.selectNode(treeNode);
				curMenu=formDefMenu.getMenu(treeNode, handler);
				curMenu.show({ top: event.pageY, left: event.pageX });
			}
		};
		//展开收起
		function treeExpandAll(type){
			globalType.treeExpandAll(type);
		};
	</script> 
</head>
<body>
   	<div id="defLayout" >
         <div position="left" title="表单分类管理" style="overflow: auto;float:left;width:100%">
         	<div class="tree-toolbar">
				<span class="toolBar">
					<div class="group"><a class="link reload" id="treeFresh" href="javascript:loadTree();">刷新</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link expand" id="treeExpandAll" href="javascript:treeExpandAll(true)">展开</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link collapse" id="treeCollapseAll" href="javascript:treeExpandAll(false)">收起</a></div>
				</span>
			</div>
			<ul id="glTypeTree" class="ztree"></ul>
         </div>
         <div position="center" title="表单列表管理">
        	<iframe id="defFrame" height="100%" width="100%" frameborder="0" src="${ctx}/platform/form/bpmFormDef/list.xht"></iframe>
         </div>
     </div>
</body>
</html>
