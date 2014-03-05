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
<script type="text/javascript" src="../js/selectLeftRight.js"></script>
<script type="text/javascript">
base_context="${base_context}";

$(function(){
	$("#rolBtnSet > button").addClass("k-button leftrightBtn");
	
	initLeftRight('availableRoles','selectedRoles','rolMoveRightBtn','rolMoveLeftBtn','rolMoveAllRightBtn','rolMoveAllLeftBtn');
	
	$("button").kendoButton();
	$(".k-datepicker").kendoDatePicker({
	    format: "MM/dd/yyyy"
	});
	
	$("#saveBtn").bind("click", function(event){
		event.preventDefault();
		saveUser();
	});
	
});    

function saveUser()
{
	var selectedRoles="";
	$("#selectedRoles option").each(function(){
		var rId = $(this).prop('value');
		selectedRoles += rId+",";
	});
	console.log(selectedRoles);
	$("#roleIds").val(selectedRoles);
	$("#userDetail").submit();
}


</script>
<style type="text/css">
.leftrightBtn
{
	width:30px;
}
</style>
</head>
<body class="bodystyle">
<div id="detailForm" class="k-content">
<form:form commandName="userDetail" method="post" action="${base_context}/user/assign.oa">
<form:hidden path="roleIds"/>
<form:hidden path="userId"/>
			<div id="addInfo" class="k-block">
				<div class="k-header"><spring:message code="additionalInfo"/></div>
				<table width="100%" cellspacing="0" cellpadding="0" border="0">
					<tr>
						<td width="45%">
							<fieldset>
								<legend>
									<spring:message code="selectedRole"/>
								</legend>
								<select multiple="multiple" id="selectedRoles" style="width: 98%; height: 300px;">
									<c:forEach var="srole" items="${selectedRoles }">
										<option value="${srole.roleId }">${srole.roleName }</option>
									</c:forEach>
								</select>
							</fieldset>
						</td>
						<td align="center">
							<div id="rolBtnSet" >
								<button id="rolMoveRightBtn" >></button><br>
								<button id="rolMoveAllRightBtn" >>></button><br>
								<button id="rolMoveLeftBtn" ><</button><br>
								<button id="rolMoveAllLeftBtn" ><<</button>
							</div>
						</td>
						<td width="45%">
							<fieldset>
								<legend>
									<spring:message code="availableRole"/>
								</legend>
								<select multiple="multiple" id="availableRoles" style="width: 98%; height: 300px;">
									<c:forEach var="arole" items="${availableRoles }">
										<option value="${arole.roleId }">${arole.roleName }</option>
									</c:forEach>
								</select>
							</fieldset>
						</td>
					</tr>
				</table>
			</div>
			
			<table cellspacing="0" cellpadding="0" border="0" width="100%">
				<tr>
					<td align="center">
						<button id="saveBtn">Save</button>
						<button id="reset" class="k-button" type="reset">Reset</button>
					</td>
				</tr>
			</table>
				
</form:form>
</div>
</body>
</html>