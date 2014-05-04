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
<%@ include file="../common/include_jui.jsp" %>
<%@ include file="../common/include_grid.jsp" %>
<%@ include file="js/flowDefList.js.jsp" %>
<style type="text/css">

</style>
</head>
<body class="bodystyle">
<div id="window"></div>	
	<div id="toolbar" class="ui-widget-header">
		<a href="#" id="impBtn" onclick="importFlow()" icon="ui-icon-arrowthick-1-n">导入</a>
		<a href="#" id="startFlowBtn" onclick="showProcess('image')" icon="ui-icon-play">启动</a>
		<a href="#" id="viexXmlBtn" onclick="showProcess('xml')" icon="ui-icon-document">XML</a>
		<a href="#" id="viexImageBtn" onclick="showProcess('image')" icon="ui-icon-image">Image</a>
		<a href="#" id="setupBtn" onclick="showSetup()" icon="ui-icon-gear">设置</a>
		<a href="#" id="delBtn" icon="ui-icon-trash">删除</a>
	</div>
 	<table id="formDefList" cellspacing="0" cellpadding="0" border="0" width="100%">
 	</table>
	<div id="pager"></div>  
	<!-- 
	<div id="defDetail"></div>
	 -->

	 <ul id="defMgtMenu" style="width:80px">
	 	<li>
	 		<a href="#" id="startFlow" onclick="showProcess('image')">
	 			<span class="ui-icon ui-icon-play">
	 			</span><span>启动</span>
	 		</a>
	 	</li>
	 	<li>
	 		<a href="#" id="viexXml" onclick="showProcess('xml')">
	 			<span class="ui-icon ui-icon-document">
	 			</span><span>XML</span>
	 		</a>
	 	</li>
		<li>
	 		<a href="#" id="viexImage" onclick="showProcess('image')">
	 			<span class="ui-icon ui-icon-image">
	 			</span><span>Image</span>
	 		</a>
	 	</li>
	 	<li>
	 		<a href="#" id="setup" onclick="showSetup()">
	 			<span class="ui-icon ui-icon-gear">
	 			</span><span>设置</span>
	 		</a>
	 	</li>
	 	<li>
	 		<a href="#" id="del" onclick="showSetup()">
	 			<span class="ui-icon ui-icon-trash">
	 			</span><span>删除</span>
	 		</a>
	 	</li>
	 </ul>
</body>
</html>