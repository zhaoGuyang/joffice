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

<script type="text/javascript" src="/js/selectLeftRight.js"></script>
<script type="text/javascript">
base_context="${base_context}";

$(function(){
	$("#usrBtnSet > button").addClass("k-button leftrightBtn");
	
	initLeftRight('availableUsers','selectedUsers','usrMoveRightBtn','usrMoveLeftBtn','usrMoveAllRightBtn','usrMoveAllLeftBtn');
	
	$("#saveBtn").bind("click", function(event){
		event.preventDefault();
		saveRole();
	});
	
});    

function saveRole()
{
	var selectedUsers="";
	$("#selectedUsers option").each(function(){
		var uId = $(this).prop('value');
		selectedUsers += uId+",";
	});
	console.log(selectedUsers);
	$("#userIds").val(selectedUsers);
	
	$("#roleDetail").submit();
}
function resetForm()
{
	$("#roleDetail")[0].reset();
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

<form:form commandName="roleDetail" method="post" action="${base_context}/role/assign.oa">
<form:hidden path="userIds"/>
<form:hidden path="roleId"/>
	<div id="addInfo" class="k-block">
			<table width="100%" cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td width="45%">
						<fieldset>
							<legend>
								<spring:message code="selectedUser"/>
							</legend>
							<select multiple="multiple" id="selectedUsers" style="width: 98%; height: 300px;">
								<c:forEach var="suser" items="${selectedUsers }">
									<option value="${suser.userId }">${suser.userName }</option>
								</c:forEach>
							</select>
						</fieldset>
					</td>
					<td align="center">
						<div id="usrBtnSet" >
							<button id="usrMoveRightBtn" >></button><br>
							<button id="usrMoveAllRightBtn" >>></button><br>
							<button id="usrMoveLeftBtn" ><</button><br>
							<button id="usrMoveAllLeftBtn" ><<</button>
						</div>
					</td>
					<td width="45%">
						<fieldset>
							<legend>
								<spring:message code="availableUser"/>
							</legend>
							<select multiple="multiple" id="availableUsers" style="width: 98%; height: 300px;">
								<c:forEach var="auser" items="${availableUsers }">
									<option value="${auser.userId }">${auser.userName }</option>
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
				<button id="saveBtn" class="k-button">Save</button>
				<button id="reset" type="reset" class="k-button">Reset</button>
			</td>
		</tr>
	</table>
				


</form:form>

</body>
</html>