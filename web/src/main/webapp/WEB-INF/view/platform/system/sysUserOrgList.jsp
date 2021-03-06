
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html" %>
<html>
<head>
<title>用户所属组织或部门管理</title>
<%@include file="/commons/include/get.jsp" %>
</head>
<body>
			<div class="panel">
				<div class="panel-top">
					<div class="tbar-title">
						<span class="tbar-label">用户所属组织或部门管理列表</span>
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
												<span class="label">组织ID:</span><input type="text" name="Q_orgId_S"  class="inputText" />
											
												<span class="label">userId:</span><input type="text" name="Q_userId_S"  class="inputText" />
											
												<span class="label">是否为主要:</span><input type="text" name="Q_isPrimary_SN"  class="inputText" />
											
												<span class="label">组织负责人ID:</span><input type="text" name="Q_isCharge_S"  class="inputText" />
											
									</div>
							</form>
					</div>
					<br/>
					<div class="panel-data">
				    	<c:set var="checkAll">
							<input type="checkbox" id="chkall"/>
						</c:set>
					    <display:table name="sysUserOrgList" id="sysUserOrgItem" requestURI="list.xht" sort="external" cellpadding="1" cellspacing="1" export="true"  class="table-grid">
							<display:column title="${f:unescapeXml(checkAll)}" media="html" style="width:30px;">
								  	<input type="checkbox" class="pk" name="userOrgId" value="${sysUserOrgItem.userOrgId}">
							</display:column>
							<display:column property="orgId" title="组织ID" sortable="true" sortName="orgId"></display:column>
							<display:column property="userId" title="userId" sortable="true" sortName="userId"></display:column>
							<display:column property="isPrimary" title="是否为主要" sortable="true" sortName="isPrimary"></display:column>
							<display:column property="isCharge" title="组织负责人ID" sortable="true" sortName="isCharge"></display:column>
							<display:column title="管理" media="html" style="width:180px">
								<a href="del.xht?userOrgId=${sysUserOrgItem.userOrgId}" class="link del">删除</a>
								<a href="edit.xht?userOrgId=${sysUserOrgItem.userOrgId}" class="link edit">编辑</a>
								<a href="get.xht?userOrgId=${sysUserOrgItem.userOrgId}" class="link detail">明细</a>
							</display:column>
						</display:table>
						<sz:paging tableId="sysUserOrgItem"/>
					</div>
				</div><!-- end of panel-body -->				
			</div> <!-- end of panel -->
</body>
</html>


