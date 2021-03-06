<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>流程代理管理</title>
<%@include file="/commons/include/get.jsp" %>
<script type="text/javascript" src="${ctx}/jslib/lg/plugins/ligerMenu.js"></script>
<script type="text/javascript" src="${ctx}/jslib/lg/plugins/ligerLayout.js"></script>
</head>
<body>
			<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label">流程代理管理列表</span>
					</div>
					<div class="panel-toolbar">
						<div class="toolBar">
							<div class="group"><a class="link search" id="btnSearch">查询</a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><a class="link add" href="edit.xht">添加</a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><a class="link update" id="btnUpd" action="edit.xht">修改</a></div>
							<div class="l-bar-separator"></div>
							<div class="group"><a class="link del"  action="del.xht">删除</a></div>
						</div>	
					</div>
				</div>
				<div class="panel-body">
					<div class="panel-search">
							<form id="searchForm" method="post" action="list.xht">
									<div class="row">
												<span class="label">agentid:</span><input type="text" name="Q_agentid_S"  class="inputText" />
											
												<span class="label">流程定义ID:</span><input type="text" name="Q_defid_S"  class="inputText" />
											
												<span class="label">agentuserid:</span><input type="text" name="Q_agentuserid_S"  class="inputText" />
											
												<span class="label">touserid:</span><input type="text" name="Q_touserid_S"  class="inputText" />
											
												<span class="label">actdefid:</span><input type="text" name="Q_actdefid_S"  class="inputText" />
											
									</div>
							</form>
					</div>
					<br/>
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="bpmAgentList" id="bpmAgentItem" requestURI="list.xht" sort="external" cellpadding="1" cellspacing="1" export="true"  class="table-grid">
							<display:column title="${f:unescapeXml(checkAll)}" media="html" style="width:30px;">
								  	<input type="checkbox" class="pk" name="id" value="${bpmAgentItem.id}">
							</display:column>
							<display:column property="agentid" title="agentid" sortable="true" sortName="agentid"></display:column>
							<display:column property="defid" title="流程定义ID" sortable="true" sortName="defid"></display:column>
							<display:column property="agentuserid" title="agentuserid" sortable="true" sortName="agentuserid"></display:column>
							<display:column property="touserid" title="touserid" sortable="true" sortName="touserid"></display:column>
							<display:column property="actdefid" title="actdefid" sortable="true" sortName="actdefid"></display:column>
							<display:column title="管理" media="html" style="width:180px">
								<a href="del.xht?id=${bpmAgentItem.id}" class="link del">删除</a>
								<a href="edit.xht?id=${bpmAgentItem.id}" class="link edit">编辑</a>
								<a href="get.xht?id=${bpmAgentItem.id}" class="link detail">明细</a>
							</display:column>
						</display:table>
						<sz:paging tableId="bpmAgentItem"/>
					</div>
				</div><!-- end of panel-body -->				
			</div> <!-- end of panel -->
</body>
</html>


