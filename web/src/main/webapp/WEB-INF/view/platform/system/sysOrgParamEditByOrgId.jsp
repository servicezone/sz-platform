
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
	<title>组织参数属性管理</title>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=sysOrgParam"></script>
	<style type="text/css">
		.error
		{
			border-color: red;
		}
	</style>
	<script type="text/javascript">
		function add(){
			var tr='';
			tr+='<tr>';
			tr+='<td>';
			tr+='<input  type="checkbox" class="pk" name="valueId">';
			tr+='</td>';
			tr+='<td>';
			tr+='<select name="paramId" style="width: 70%;" >';
			tr+='<c:forEach items="${sysParamList}" var="p" >';
			tr+='<option title="${p.dataType }" value="${p.paramId }">${p.paramName }</option>';
			tr+='</c:forEach>';
			tr+='</select>';
			tr+='</td>';
			tr+='<td>';
			tr+='<input class="inputText" type="text" name="paramValue" style="width: 70%;">';
			tr+='</td>';
			tr+='<td>';
			tr+='<a href="#" class="link del" onclick="handlerDelOne(this);">删除</a>';
			tr+='</td>';
			tr+='</tr>';
			$("#sysParamItem").append(tr);
		
		};
		
		
		function validDuplicate(){
			var yes=true;
			var $aryId = $("select[name='paramId'] option:selected");
			if($aryId.length > 0)
			{
				$aryId.each(function(i,t){
					var tp=$(t).val();
					
		
					$aryId.each(function(j,o){
						var op=$(o).val();
						if(i!=j&&tp==op){
							yes=false;
							
							$(t).parent().addClass("error");
							if($(t).parent().next().html()==null||$(t).parent().next().html()=='')
							$(t).parent().after('<font color="red">参数名重复。</font>');
						};
						
					});
					
				});
			}
			if(yes){
				$aryId.parent().removeClass("error");
				if($aryId.parent().next().html()!=null)
					$aryId.parent().next().empty();
			}
			return yes;
		};
		
		function validValue(){
			var yes=true;
			var $aryId = $("input[name='paramValue']");
			if($aryId.length > 0)
			{
				$aryId.each(function(i,t){
					var val=$(t).val();
					var tr=$(t).parents("tr");
					var option=$(tr).find("select[name='paramId'] option:selected");
					var dataType=$(option).attr("title");
					
					if(dataType=="Integer"){
						
						if(isNaN(val))
				         {
							 $(t).addClass("error");
							 if($(t).next().html()==null||$(t).next().html()=='')
									$(t).after('<font color="red">请输入数字。</font>');
							 yes=false;
					     }
					}else if(dataType=="Date"){
						 var pattern =/^((\d{2}(([02468][048])|([13579][26]))[\-\/\s]?((((0?[13578])|(1[02]))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\-\/\s]?((0?[1-9])|([1-2][0-9])))))|(\d{2}(([02468][1235679])|([13579][01345789]))[\-\/\s]?((((0?[13578])|(1[02]))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\-\/\s]?((0?[1-9])|(1[0-9])|(2[0-8]))))))(\s(((0?[0-9])|([1-2][0-3]))\:([0-5]?[0-9])((\s)|(\:([0-5]?[0-9])))))?$/;
						 if(!pattern.exec(val))
		                 {
							 $(t).addClass("error");
							 if($(t).next().html()==null||$(t).next().html()=='')
									$(t).after('<font color="red">请输入日期。</font>');
							 yes=false;
			             }
					}
					
				});
			}
			if(yes){
				$aryId.removeClass("error");
				
				if($aryId.next().html()!=null)
					$aryId.next().empty();
			}
			return yes;
		};
		
		
		
		
		
		
		$(function() {
			
			function showRequest(formData, jqForm, options) { 
				var d=validDuplicate();
				var v=validValue();
				return (d&&v);
			} 
			valid(showRequest,showResponse);
			$("a.save").click(function() {
				var orgId=$("#orgId").val();
				if(orgId==null){
					$.ligerMessageBox.warn("你还没选择组织!");
				}else{
					$('#sysOrgParamForm').submit(); 
				}
				
			});
		
			
		
			function showResponse(responseText, statusText)  { 
				var obj=new org.sz.form.ResultMessage(responseText);
				if(obj.isSuccess()){//成功
					$.ligerMessageBox.success('提示信息',obj.getMessage(),function(rtn){
					});
					
			    }else{//失败
			    	$.ligerMessageBox.error('提示信息',obj.getMessage());
			    }
			} 
		});
		function handlerDelOne(obj){
			var tr=$(obj).parents('tr');
			$(tr).remove();
		};
		
		function handlerDelSelect(){
			//单击删除超链接的事件处理
			$("div.toolBar a.del").click(function()
			{	
				if(!$(this).hasClass('disabled')) {
					var $aryId = $("input[type='checkbox'][class='pk']:checked");
					//提交到后台服务器进行日志删除批处理的日志编号字符串
					if($aryId.length > 0)
					{
						$aryId.each(function(i){
							handlerDelOne(this);
						});
					}
				}
			});
		};
	
	</script>

</head>
<body>
			<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label">${sysOrg.orgName }组织参数属性管理列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="l-bar-separator"></div>
							<div class="group"><a class="link save">保存</a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><a class="link add" href="javascript:add();">添加</a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><a class="link del" href="javascript:handlerDelSelect();">删除</a></div>
						</div>	
					</div>
				</div>
				<div class="panel-body">
					
					
					<div class="panel-data">
				    	<form id="sysOrgParamForm" method="post" action="${ctx }/platform/system/sysOrgParam/saveByOrgId.xht">
						<input type="hidden" name="orgId" id="orgId" value="${orgId }">
				    	<table id="sysParamItem" cellpadding="1" cellspacing="1"  class="table-grid">
								<head>
									<th style="text-align: center;">
										<input type="checkbox" id="chkall"/>
									</th>
									<th style="text-align: center;">参数名</th>
									<th style="text-align: center;">参数值</th>
									<th style="text-align: center;">管理</th>
								</head>
								<tbody>
									<c:forEach items="${sysOrgParamList}" var="sysParamItem">
										<tr>
										<td>
										<input  type="checkbox" class="pk" name="valueId" value="${sysParamItem.valueId}">
										</td>
										<td>
										<select name="paramId" style="width: 70%;">
											<c:forEach items="${sysParamList}" var="p" >
												<option  title="${p.dataType }" value="${p.paramId }" <c:if test="${p.paramId==sysParamItem.paramId }">selected="selected"</c:if>>${p.paramName }</option>
											</c:forEach>
										</select>
										</td>
										<td>
											<input class="inputText" type="text" name="paramValue" style="width: 70%;" value="${sysParamItem.paramValue }">
											<input type="hidden" value="${sysParamItem.dataType}"> 
										</td>
										<td>
										<a href="#" class="link del" onclick="handlerDelOne(this);">删除</a>
										</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							</form>
							
					</div>
				</div><!-- end of panel-body -->				
			</div> <!-- end of panel -->
</body>
</html>


