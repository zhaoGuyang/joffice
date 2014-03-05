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
<%@ include file="roleList.js.jsp" %>
<script type="text/javascript">

</script>

<style type="text/css">
.btn-small
{
	width:10px;
	color: red;
	
}

</style>
</head>
<body class="bodystyle">
<div id="addWin">
<!-- 
	<iframe src="${base_context}/role/add.oa" width="100%" height="100%" marginwidth="0" marginheight="0" frameborder="0" scrolling="no" ></iframe>
 -->
</div>	
<div id="editWin">
<!-- 
	<iframe src="${base_context}/role/add.oa" width="100%" height="100%" marginwidth="0" marginheight="0" frameborder="0" scrolling="no" ></iframe>
 -->
</div>	
<div id="assignWin">
<!-- 
	<iframe src="${base_context}/role/add.oa" width="100%" height="100%" marginwidth="0" marginheight="0" frameborder="0" scrolling="no" ></iframe>
 -->
</div>
<div id="authWin">
<!-- 
	<iframe src="${base_context}/role/add.oa" width="100%" height="100%" marginwidth="0" marginheight="0" frameborder="0" scrolling="no" ></iframe>
 -->
</div>		

 	<table id="roleGrid" cellspacing="0" cellpadding="0" border="0" width="100%">
 		
 	
 	</table>

	
</body>
</html>