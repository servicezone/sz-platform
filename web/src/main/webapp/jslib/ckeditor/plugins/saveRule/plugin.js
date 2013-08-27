(function(){
    //Section 1 : 按下自定义按钮时执行的代码
    var a= {
        exec:function(editor)
        {
        	    var defId=$("#defId").val();
    			var taskNameRule=editor.getData();
    			var data="defId="+defId+"&taskNameRule="+taskNameRule;
    			$.post("saveTitleRule.xht",data,function(msg){
    				var obj=new org.sz.form.ResultMessage(msg);
    				if(obj.isSuccess()){
    					$.ligerMessageBox.success('操作成功',obj.getMessage());
    				}else{
    					$.ligerMessageBox.error('操作失败',obj.getMessage());
    				}
    			});
    	
        }
    },
    //Section 2 : 创建自定义按钮、绑定方法
    b='saveRule';
    CKEDITOR.plugins.add(b,{
        init:function(editor){
            editor.addCommand(b,a);
            editor.ui.addButton('saveRule',{
                label:'保存',
                icon: this.path + 'save.png',
                command:b
            });
        }
    });
    
})();
