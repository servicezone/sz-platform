<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>流程实例扩展管理</title>
<%@include file="/commons/include/get.jsp" %>
</head>
<body>
			<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label">流程历史列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><a class="link search" id="btnSearch">查询</a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><a class="link del"  action="del.xht">删除</a></div>
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
							<form id="searchForm" method="post" action="history.xht">
									<div class="row">
										<span class="label">流程定义名称:</span><input type="text" name="Q_processName_S"  class="inputText" />
										<span class="label">流程实例标题:</span><input type="text" name="Q_subject_S"  class="inputText" />
										<span class="label">创建人:</span><input type="text" name="Q_creator_S"  class="inputText" />
										<span class="label">创建时间 从:</span> <input  name="Q_begincreatetime_S"  class="inputText date" />
										<span class="label">至: </span><input  name="Q_endcreatetime_S" class="inputText date" />
									</div>
							</form>
					</div>					
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="processRunList" id="processRunItem" requestURI="history.xht" sort="external" cellpadding="1" cellspacing="1" export="true"  class="table-grid">
							<display:column title="${f:unescapeXml(checkAll)}" media="html" style="width:30px;">
								  	<input type="checkbox" class="pk" name="runId" value="${processRunItem.runId}">
							</display:column>
							<display:column property="processName" title="流程定义名称" sortable="true" sortName="processName"></display:column>
							<display:column property="subject" title="流程实例标题" sortable="true" sortName="subject"></display:column>
							<display:column property="creator" title="创建人" sortable="true" sortName="creator"></display:column>
							<display:column  title="创建时间" sortable="true" sortName="createtime">
								<fmt:formatDate value="${processRunItem.createtime}" pattern="yyyy-MM-dd HH:mm:ss"/>
							</display:column>
							<display:column  title="结束时间" sortable="true" sortName="endtime">
								<fmt:formatDate value="${processRunItem.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
							</display:column>
							<display:column title="持续时间" sortable="true" sortName="duration">
								${f:getTime(processRunItem.duration)}
							</display:column>
							<display:column title="状态" sortable="true" sortName="status">
								<c:choose>
									<c:when test="${processRunItem.status==1}">
										<font color='green'>正在运行</font>
									</c:when>
									<c:when test="${processRunItem.status==2}">
										结束
									</c:when>
								</c:choose>
							</display:column>
							<display:column title="管理" media="html" style="width:180px">
								<a href="del.xht?runId=${processRunItem.runId}" class="link del">删除</a>
								<a href="get.xht?runId=${processRunItem.runId}" class="link detail">明细</a>
							</display:column>
						</display:table>
						<sz:paging tableId="processRunItem"/>
					</div>
				</div><!-- end of panel-body -->				
			</div> <!-- end of panel -->
</body>
</html>


