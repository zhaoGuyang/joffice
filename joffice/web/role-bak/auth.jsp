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
var treeView;
var timer = null;
$(function(){
	permsInit = false;
	dateSoruce = new kendo.data.HierarchicalDataSource({
	    transport: {
	        read: {
	            url: "${base_context}/role/getAuth.oa",
	            dataType: "json"
	        }
	    },
	    schema: {
	        model: {
	            id: "id",
	            hasChildren: "hasChildren"
	        }
	    }
	}); 
	
	$("#moduleTree").kendoTreeView(
			{
				checkboxes: {
					template: "<input type='checkbox' onchange='permchange(this)' name='mck_#= item.resSn #_#if(item.actionTypeCode){##=item.actionTypeCode##}else{#1#}#_#=item.uid#' />#= item.resSn #",
					//template: kendo.template($("#checkboxTemplate").html()),
	                checkChildren: false
	            },
				loadOnDemand: false,
				dataSource : dateSoruce,
				dataTextField : "name",
				dataBound: function(e) {
				   if(timer)
				   {
					   clearTimeout(timer);
				   }
				   timer = setTimeout(function(){
					   getPermission();
				   },300);
				  }
			});
	
	
});    


function getPermission()
{

	//console.log("Init...");
	var _url = "${base_context}/role/getPermission.oa?_timeStamp="+(new Date()).getTime();
	var _param = {roleId : ${roleId}};
	$.getJSON(
		_url,
		_param,
		function(data){
			if(data)
			{
				initPermission(data)
			}
		}
	);

}
var funcArr = new Array();
function initPermission(data)
{

	if(data)	
	{
		var i=0;
		$.each(data, function(key,value){
			$("[name^='mck_"+key+"']").prop("checked", true);
		});
	}	
		

}

function permchange(field)
{
	var _name = field.name;
	var _checked = field.checked;
	var uid = _name.split("_")[3];
	var node = dateSoruce.getByUid(uid);
	if(_checked == true)
	{
		if(node.parentNode())
		{
			checkParent(node.parentNode());
		}
	}
	else
	{
		var children = node.children;
		if(node.hasChildren)
		{
			var len = children.data().length;
			for(var i = 0; i< len;i++)
			{
				var child = children.at(i);
				ucheckChildren(child);
			}
		}
	}
}
function checkParent(node)
{
	var uid = node.uid;
	$("[name$='"+uid+"']").prop("checked", true);
	
	if(node.parentNode())
	{
		checkParent(node.parentNode());
	}
	
}
function ucheckChildren(node)
{
	var uid = node.uid;
	$("[name$='"+uid+"']").prop("checked", false);
	var children = node.children;
	if(node.hasChildren)
	{
		var len = children.data().length;
		for(var i = 0; i< len;i++)
		{
			var child = children.at(i);
			ucheckChildren(child);
		}
	}
}
function saveAuth()
{
	var params = new Array();
	$("[name^='mck_']").each(function(){
		var _name = $(this).prop('name');
		var _value = $(this).prop('checked');
		if(_value==true)
		{
			params.push(_name+":"+_value);
		}
	});
	//console.log(params.join(","));
	var _url = "${base_context}/role/saveAuth.oa";
	var _param = {checks:params.join(","),roleId:${roleId}};
	$.post(
		_url,
		_param,
		function(data){
			if(data.status==1)
			{
				closeAuth();
			}
		},
		"json"
	);
}

</script>
<script id="checkboxTemplate" type="text/x-kendo-tmpl">
	<input type='checkbox' name='mck_#item.resSn#' />
</script>
<style type="text/css">

</style>
</head>
<body class="bodystyle">

<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%" class="k-block">
	<tr>
		<td align="left" valign="top" >
			<div id="moduleTree"> </div>
		</td>
	</tr>
	<tr>
		<td align="center" valign="middle" height="25px" class="k-header">
			<button id="saveBtn" class="k-button" onclick="saveAuth()">Save</button>
		</td>
	</tr>
</table>



</body>
</html>