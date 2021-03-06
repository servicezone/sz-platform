<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<title>定时任务管理</title>
<%@include file="/commons/include/get.jsp" %>
    <script type="text/javascript" src="${ctx }/jslib/lg/plugins/ligerWindow.js" ></script>
 </head>
 <body>
		<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label">任务列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><a class="link add" href="addJob1.xht">添加</a></div>
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <table  cellpadding="1" cellspacing="1"   class="table-grid">
					    <thead>
					    <tr>
					    <th>序号</th>
					    <th>任务名称</th>
					    <th>任务类</th>
					    <th>任务描述</th>
					    <th>管理</th>
					    </tr>
					    </thead>
					    <tbody>
					    <c:forEach items="${jobList}" var="d" varStatus="status">
				           <tr class="${status.index%2==0?'odd':'even'}">
				           <td >${status.index }</td>
				           <td >${d.key.name }</td>
				           <td >${d.jobClass.name }</td>
				           <td >${d.description }</td>
				           <td >
				                <a href="delJob.xht?jobName=${d.key.name }" class="link del" >删除</a>
								<a href="addTrigger1.xht?jobName=${d.key.name }" class="link flowDesign">添加计划</a>
								<a href="getTriggersByJob.xht?jobName=${d.key.name }" class="link detail">计划列表</a>
								<a  href="executeJob.xht?jobName=${d.key.name}" class="link run">执行</a> 
								<a href="getLogList.xht?jobName=${d.key.name}" class="link flowDesign">日志</a>
				           </td>
				           </tr>
				        </c:forEach>
					    </tbody>
					    </table>
					</div>
				</div><!-- end of panel-body -->				
			</div> <!-- end of panel -->
</body>
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 