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
<script type="text/javascript">
base_context="${base_context}";

$(function(){
	$("#userDetail input").addClass("k-input ui-corner-all");
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
	$("#userDetail").submit();
}


</script>
<style type="text/css">
.k-len-textbox
{

}

</style>
</head>
<body class="bodystyle">

<form:form commandName="userDetail" method="post" action="${base_context}/user/save.oa">
<form:hidden path="userId"/>
	<div id="baseInfo" class="k-block">
		<div class="k-header"><spring:message code="baseInfo"/></div>
		<div>
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td width="200px"><spring:message code="user.userName"/></td>
					<td ><form:input path="userName" size="30"/></td>
				</tr>
				<tr>
					<td><spring:message code="user.password"/></td>
					<td><form:password path="password" size="30"/></td>
				</tr>
				<tr>
					<td><spring:message code="user.fullName"/></td>
					<td><form:input path="fullName" size="30"/></td>
				</tr>
				<tr>
					<td><spring:message code="user.email"/></td>
					<td><form:input path="email" size="30"/></td>
				</tr>
				<tr>
					<td><spring:message code="user.depart"/></td>
					<td><form:input path="deptId" size="30"/></td>
				</tr>
				<tr>
					<td><spring:message code="user.job"/></td>
					<td><form:input path="jobId" size="30"/></td>
				</tr>
				<tr>
					<td><spring:message code="user.joinDate"/></td>
					<td><form:input path="joinDate" size="30" class="k-datepicker"/></td>
				</tr>
				<tr>
					<td><spring:message code="user.active"/></td>
					<td><form:checkbox path="active"/></td>
				</tr>
			</table>
		</div>
	</div>
			<div id="addInfo" class="k-block">
				<div class="k-header"><spring:message code="additionalInfo"/></div>
				<div>
					<table cellspacing="0" cellpadding="0" border="0">
						<tr>
							<td width="200px"><spring:message code="user.sex"/></td>
							<td ><form:input path="sex" size="30"/></td>
						</tr>
						<tr>
							<td width="100px"><spring:message code="user.phone"/></td>
							<td ><form:input path="phone" size="30"/></td>
						</tr>
						<tr>
							<td width="100px"><spring:message code="user.address"/></td>
							<td ><form:input path="address" size="30"/></td>
						</tr>
					</table>
				</div>
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

</body>
</html>