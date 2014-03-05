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
<script type="text/javascript">
base_context="${base_context}";

$(function(){
	$("#saveBtn").bind("click", function(event){
		event.preventDefault();
		saveRole();
	});
	
});    

function saveRole()
{
	$("#actionDetail").submit();
}
function resetForm()
{
	$("#actionDetail")[0].reset();
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

<form:form commandName="actionDetail" method="post" action="${base_context}/module/saveAction.oa">
<form:hidden path="actionId"/>
<form:hidden path="moduleId"/>
	<div id="baseInfo" class="k-block">
		<div class="k-header"><spring:message code="baseInfo"/></div>
		<div>
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td width="200px"><spring:message code="module.action.actionTypeCode"/></td>
					<td ><form:input path="actionTypeCode" size="30"/></td>
				</tr>
				<tr>
					<td width="200px"><spring:message code="module.action.actionTypeDesc"/></td>
					<td ><form:input path="actionTypeDesc" size="30"/></td>
				</tr>
			</table>
		</div>
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