/**
 * 分类管理
 * @param catKey
 * @param divId
 * @param conf
 * @returns {GlobalType}
 */
GlobalType=function(catKey,divId,conf){
	{
		this.glTypeTree=null;
		this.currentNode=null;
		this.conf=conf;
		this.catKey=catKey;
		this.divId=divId;
		var _self=this;
	};
	
	this.loadGlobalTree=function(){
	
		var setting = {
    			data: {
    				key : { name: "typeName"},
    				simpleData: {enable: true,idKey: "typeId",pIdKey: "parentId"}
    			},
    			
    			callback:{onClick: this.clickHandler,onRightClick: this.rightClickHandler}
    		};
			var url=__ctx + "/platform/system/globalType/getByCatKey.xht";
			if(conf.url){
				url=conf.url;
			}
    		
    		
    		var params={catKey:this.catKey};
    		$.post(url,params,function(result){
    			for(var i=0;i<result.length;i++){
    				var node=result[i];
    				if(node.parentId==0){
    					node.icon=__ctx +"/styles/default/images/icon/root.png";
    					node.isRoot=1;
    				}
    			}
    		
    			_self.glTypeTree=$.fn.zTree.init($("#" + _self.divId), setting,result);
    			_self.glTypeTree.expandAll(true);
			});
	};
	
	this.rightClickHandler=function(event, treeId, treeNode){
		if( _self.conf.onRightClick){
			_self.conf.onRightClick(event, treeId, treeNode);
		}
	};
	//点击事件处理
	this.clickHandler=function(event, treeId, treeNode){
		_self.currentNode=treeNode;
		if(_self.conf.onClick){
			_self.conf.onClick(treeNode);
		}
	};
	
	//展开收起
	this.treeExpandAll=function(type){
		_self.glTypeTree.expandAll(type);
	};
	
	this.delNode=function (){
		var typeId=_self.currentNode.typeId;;
		if(typeId!=0){
			var url=__ctx +'/platform/system/globalType/del.xht';
			var params={typeId:typeId};
    		$.post(url,params,function(data){
    			_self.loadGlobalTree();
    			$.ligerMessageBox.success('提示信息','成功删除!');
    		});
		}
	};
	
	this.openGlobalTypeDlg=function(isAdd,isPrivate){
		var typeId=_self.currentNode.typeId;
		var isRoot=_self.currentNode.isRoot;
		var url=__ctx +'/platform/system/globalType/dialog.xht';
		if(isAdd){
			if(isRoot){
				url+="?parentId="+typeId +"&isRoot=1";
			}else{
				url+="?parentId="+typeId +"&isRoot=0";
			}
		}else{
			url+="?typeId="+typeId;
		}
		if(isPrivate){
			url+="&isPrivate=1";
		}
	
	
	 	var winArgs="dialogWidth:500px;dialogHeight:250px";
	 	url=url.getNewUrl();
	 	var rtn=window.showModalDialog(url,"",winArgs);
	 	//重新加载树。
	 	_self.loadGlobalTree();
	};
}