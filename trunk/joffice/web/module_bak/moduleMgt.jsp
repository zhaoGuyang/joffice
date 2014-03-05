<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code="module.moduleMgt.title"/></title>
<%@ include file="../common/include.jsp" %>
<script type="text/javascript" src="${base_context}/js/module.js"></script>
<script type="text/javascript">
base_context="${base_context}";
$(function(){
	oncCustomLoad();
});

</script>
<style type="text/css">

#module
{
	padding-top:5px;
	margin-top:5px;
	padding-bottom:0px;
	margin-bottom:0px;
	height:700px;
}
#formDiv
{
	padding:5px;margin:5px;
}


</style>
<script id="treeTemplate" type="text/x-kendo-tmpl">
	<div class="treeNode" id="#=item.uid#">#=item.name#</div>
</script>
</head>
<body class="bodystyle">
	<div id="actionWin"></div>
	<div id="module" >
		<div id="moudelTreePanel" class="k-block"> 
			<div class="k-header k-shadow">
				<spring:message code="module.moduleMgt.module.header"/>
			</div>
			<div id="moduleTree"> </div>
		</div>
		<div id="moudelDetailPanel" class="k-block"> 
			<div class="k-header k-shadow">
				<spring:message code="module.moduleMgt.detail.header"/>
			</div>
			<button id="saveBtn">Save</button>
			<div id="formDiv" >
				<form action="#" id="moduleForm">
					<input id="moduleId" name="moduleId" type="hidden"/>
					<table cellspacing="0" cellpadding="0" border="0">
						<tr>
							<td><spring:message code="module.moduleMgt.detail.parent"/></td>
							<td>
								<input id="parent" name="parent" readOnly="readonly" disabled="disabled"/>
								<input id="parentId" name="parentId" type="hidden"/>
							</td>
						</tr>
						<tr>
							<td><spring:message code="module.moduleMgt.detail.moduleName"/></td>
							<td><input id="moduleName" name="moduleName" size="40"/></td>
						</tr>
						<tr>
							<td><spring:message code="module.moduleMgt.detail.moduleTitle"/></td>
							<td><input id="title" name="title" size="40"/></td>
						</tr>
						<tr>
							<td><spring:message code="module.moduleMgt.detail.moduleIcon"/></td>
							<td><input id="icon" name="icon" size="40"/></td>
						</tr>
						<tr>
							<td><spring:message code="module.moduleMgt.detail.moduleUrl"/></td>
							<td><input id="url" name="url" size="40"/></td>
						</tr>
						<tr>
							<td><spring:message code="module.moduleMgt.detail.resSn"/></td>
							<td><input id="resSn" name="resSn" size="40"/></td>
						</tr>
						
					</table>
				</form>
				
			</div>
		</div>
	</div>
	
	<div id="actWin">
		<form action="#" id="operForm">
			<input id="mid" name="mid"  type="hidden" required >
			<input id="actid" name="actid" type="hidden">
			<table cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td><spring:message code="module.action.actionTypeCode"/></td>
					<td><input id="actionTypeCode" name="actionTypeCode" size="40" type="number" required /></td>
				</tr>
				<tr>
					<td><spring:message code="module.action.actionTypeDesc"/></td>
					<td><input id="actionTypeDesc" name="actionTypeDesc" size="40" required /></td>
				</tr>
				<tr>
					<td colspan="2" align="center" valign="bottom">
						&nbsp;
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center" valign="bottom">
						<button id="saveAct" class="k-button">Save</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<!-- Tree Menu -->
	<ul id="moduleMenu" style="width:150px">
		<li id="mAddMenu" >Add</li>
		<li id="mDelMenu" >Delete</li>
		<li id="aAdd" >Add Operation</li>
	</ul>
	<ul id="actMenu" style="width:150px">
		<li id="actionEdit" >Edit Operation</li>
		<li id="actionDel" >Delete Operation</li>
	</ul>

</body>
</html>