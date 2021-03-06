var globalMenu=new GlobalMenu();
//树节点是否可点击
var treeNodelickAble=true;
$(function(){
	//修改分类类型
	changeType();
	//加载树
	loadTree(catId);
	//布局
	layout();
});

function changeType(){
	$('#dkey').change(function(){
		var obj=$(this);
		catId=obj.val();
		loadTree(catId);            	               	
     });
}

function clickHandler(item){
	var txt=item.text;
	var treeNode=getSelectNode();
	if(txt=="增加分类"){
		addNode();
	}
	else if(txt=="删除"){
		delNode();
	}
	else if(txt=="刷新"){
		reAsyncChild(treeNode);
	}
}

//点刷新按钮
function refresh(){     
	loadTree(catId);
}



//刷新
function refreshNode(isAdd){
	if(isAdd){
		curSelectNode.isParent=true;
		glTypeTree.selectNode(curSelectNode);
		reAsyncChild(curSelectNode);
	}
	else{
		loadTree(catId);
	}
	
};


//布局
function layout(){
	$("#layout").ligerLayout( {
		leftWidth : 210,
		onHeightChanged: heightChanged,
		allowLeftResize:false
		
	});
	//取得layout的高度
    var height = $(".l-layout-center").height();
    $("#glTypeTree").height(height-60);
};
//布局大小改变的时候通知tab，面板改变大小
function heightChanged(options){
 	$("#glTypeTree").height(options.middleHeight - 60);
};
//树
var glTypeTree;
//加载树
function loadTree(catId){
	
	var setting = {
		data: {
			key : {name: "typeName"},
			simpleData: {enable: true,idKey: "typeId",pIdKey: "parentId"}
		},
		view: {
			addHoverDom: addHoverDom,
			removeHoverDom: removeHoverDom,
			selectedMulti: false
		},
		edit: {
			drag: {
				prev: dropEnable,
				inner: dropEnable,
				next: dropEnable
			},
			enable: true,
			showRemoveBtn: false,
			showRenameBtn: false
		},
		async: {
			enable: true,
			url: __ctx + "/platform/system/globalType/getByParentId.xht",
			autoParam:["typeId=parentId"],
			otherParam: {"parentId":catId,catId:catId}
		},
		callback:{
			onClick: zTreeOnClick,
			onRightClick: zTreeOnRightClick,
			beforeClick: zTreeBeforeClick,
			beforeDrop:beforeDrop,
			onDrop: onDrop,
			onAsyncSuccess: zTreeOnAsyncSuccess
		}
	};
	glTypeTree=$.fn.zTree.init($("#glTypeTree"), setting);
	
};
var curSelectNode;
function zTreeOnClick(event, treeId, treeNode) {
	curSelectNode=treeNode;
	var typeId=treeNode.typeId;
	if(catId==typeId) return;
	var url=__ctx +"/platform/system/globalType/edit.xht?typeId="+typeId ;
	$("#listFrame").attr("src",url);
};

//获取根节点并修改节点的图标。
function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
	
	glTypeTree = $.fn.zTree.getZTreeObj("glTypeTree");
	var node=glTypeTree.getNodeByParam("typeId",catId);
	if(node){
		//设置根节点。
		node.isRoot=1;
		node.icon=__ctx + "/themes/img/icon/root.png";
		glTypeTree.updateNode(node);
	}
	
	//如果有选择节点，则重新选择该节点。
	if(curSelectNode){
		
		curSelectNode=glTypeTree.getNodeByParam("typeId",curSelectNode.typeId);
		glTypeTree.selectNode(curSelectNode);
	}
	
	
};


//向前拖
function dropEnable(treeId,curDragNodes,treeNode) {
	if (!treeNode) return false;
	if(treeNode.isRoot)
		return false;
	return true;
};


//拖放 前准备
function beforeDrop(treeId, treeNodes, targetNode, moveType) {
	if (!treeNodes) return false;
	if(targetNode.isRoot)
		return false;
	return true;
};


//拖放 后动作
function onDrop(event, treeId, treeNodes, targetNode, moveType) {
	if(targetNode==null || targetNode==undefined) return;
	var targetId=targetNode.typeId;
	var dragId=treeNodes[0].typeId;
	var url=__ctx + "/platform/system/globalType/move.xht";
	var params={targetId:targetId,dragId:dragId,moveType:moveType};

	$.post(url,params,function(result){
		if(moveType=="inner"){
			reAsyncChild(targetNode);
		}
	});
}

//刷新节点
function reAsyncChild(targetNode){
	var typeId=targetNode.typeId;
	if(typeId==catId){
		loadTree(catId);
	}else{
		glTypeTree = $.fn.zTree.getZTreeObj("glTypeTree");			
		glTypeTree.reAsyncChildNodes(targetNode, "refresh", false);
	
	}
	treeNodelickAble=true;
};

//左击前
function zTreeBeforeClick(treeId, treeNode, clickFlag){
	return treeNodelickAble;
};
//保存排序后的顺序
function sortType(targetNode,typeIds){
	var url=__ctx + "/platform/system/globalType/sort.xht";
	var params={typeIds:typeIds};
	$.post(url,params,function(){
		reAsyncChild(targetNode);
		treeNodelickAble=true;
	});	
};

//交换节点。
function swapNode(curNode,swapTo){
	var typeId= curNode.typeId;
	var preTypeId= swapTo.typeId;
	curNode.typeId=preTypeId;
	swapTo.typeId =typeId;
}

//节点排序。
function sortTreeNode(treeNode){
	var parentNode=treeNode.getParentNode();
	var children=parentNode.children;
	var typeIds="";
	$.each( children, function(i, c){
		typeIds+=c.typeId+",";	 
	});
	if(typeIds.length>0){
		typeIds=typeIds.substring(0,typeIds.length-1);
	}
	if(typeIds.length==0) return;
	sortType(parentNode,typeIds);
}

/**
*显示
*/

function addHoverDom(treeId, treeNode) {
	//下一个结点
	var nextNode=treeNode.getNextNode();
	//前一个结点
	var preNode=treeNode.getPreNode();
	var sObj = $("#" + treeNode.tId + "_span");
	//向上
	if(preNode){
		if ($("#upBtn_"+treeNode.id).length>0) return;
		var upStr = "<button  type='button' class='link-sortUp' id='upBtn_" + treeNode.id	+ "' title='向前' ></button>";
		sObj.append(upStr);
		var upBtn_ = $("#upBtn_"+treeNode.id);
		 
		upBtn_.bind("click", function(){
			treeNodelickAble=false;
			//前后结点置换
			swapNode(treeNode,preNode);
			//取当下同级结点所有ID
			sortTreeNode(treeNode);
		});
	}
	//向下
	if(nextNode){
		if ($("#downBtn_"+treeNode.id).length>0) return;
		var dowStr = "<button  type='button' class='link-sortDown' id='downBtn_" + treeNode.id	+ "' title='向后' ></button>";
		sObj.append(dowStr);
		var downBtn_ = $("#downBtn_"+treeNode.id);
		downBtn_.bind("click", function(){
			treeNodelickAble=false;
			//前后结点置换
			swapNode(treeNode,nextNode);
			//重新排序
			sortTreeNode(treeNode);
		});
	}

	//最上
	if(preNode){
		if ($("#topBtn_"+treeNode.id).length>0) return;
		var topBtnStr = "<button  type='button' class='link-sortTop' id='topBtn_" + treeNode.id	+ "' title='最前' ></button>";
		sObj.append(topBtnStr);
		var topBtn_ = $("#topBtn_"+treeNode.id);
		topBtn_.bind("click", function(){
			treeNodelickAble=false;
			//取父结点
			var parentNode = treeNode.getParentNode();
			var children=parentNode.children; 
			var firstNode=children[0];
			swapNode(treeNode,firstNode);
			//重新排序
			sortTreeNode(treeNode);
		});
	}
	//最下
	if(nextNode){
		if ($("#bottomBtn_"+treeNode.id).length>0) return;
		var bottomBtnStr = "<button  type='button' class='link-sortBottom' id='bottomBtn_" + treeNode.id	+ "' title='最后' ></button>";
		sObj.append(bottomBtnStr);

		var bottomBtn_ = $("#bottomBtn_"+treeNode.id);
		bottomBtn_.bind("click", function(){
			treeNodelickAble=false;
			//取父结点
			var parentNode = treeNode.getParentNode();
			var children=parentNode.children; 
			var lastNode=children[children.length-1];
			//交换节点
			swapNode(treeNode,lastNode);
			//重新排序
			sortTreeNode(treeNode);
		});
	}
};
/**
*隐藏
*/
function removeHoverDom(treeId, treeNode) {
	$("#upBtn_"+treeNode.id).unbind().remove();
	$("#downBtn_"+treeNode.id).unbind().remove();
	$("#topBtn_"+treeNode.id).unbind().remove();
	$("#bottomBtn_"+treeNode.id).unbind().remove();
};

/**
 * 树右击事件
 */
function zTreeOnRightClick(e, treeId, treeNode) {
	if (treeNode) {
		glTypeTree.selectNode(treeNode);
		var menu=globalMenu.getMenu(treeNode, clickHandler);
		if(menu){
			menu.show({ top: e.pageY, left: e.pageX });
		}
	}
};


//展开收起
function treeExpandAll(type){
	glTypeTree = $.fn.zTree.getZTreeObj("glTypeTree");
	glTypeTree.expandAll(type);
};

//添加分类
function addNode(){
	if(curSelectNode){
		var typeId=curSelectNode.typeId;
		var isRoot=0;
		if(curSelectNode.isRoot){
			isRoot=1;
		}
		var url=__ctx   +"/platform/system/globalType/edit.xht?parentId="+typeId +"&isRoot=" + isRoot;
		$("#listFrame").attr("src",url);
	}
	
	
};

//删除分类
function delNode(){
	var selectNode=getSelectNode();
	var typeId=selectNode.typeId;
 	var callback = function(rtn) {
 		if(!rtn) return;
		var url=__ctx +"/platform/system/globalType/del.xht";
		var params={typeId:typeId};
		$.post(url,params,function(result){
			var parentNode=selectNode.getParentNode();
			if(parentNode){
				reAsyncChild(parentNode);
			}
		});
	};
	$.ligerMessageBox.confirm('提示信息','此操作将删除改分类下所有的子节点，如果是数据字典分类字典数据也将删除，确认删除吗？',callback);
};

//选择分类
function getSelectNode(){
	glTypeTree = $.fn.zTree.getZTreeObj("glTypeTree");
	var nodes  = glTypeTree.getSelectedNodes();
	var node   = nodes[0];
	return node;
};
	