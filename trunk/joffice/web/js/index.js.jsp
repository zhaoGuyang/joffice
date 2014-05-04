<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
base_context="${base_context}";

var base_context="${base_context}";
var navTree;
var mainTabs;
var tabCounter = 2;
var setting;
var tabMap = new Map();
$(function(){

//Toobar
	$("#toolbar")
	.buttonset()
	.children()
	.each(function(){
		var id = $(this).attr("id");
		$(this).button({
			icons :{secondary : "ui-icon-triangle-1-s"}
		})
		.click(function(){
			$(".menu").hide();
			var id = $(this).attr("id");
			$("#"+id+"Menu")
			.show()
			.position({my: "left top", at:"left bottom", of:this})
			.mouseleave(function(){
				$(this).hide();
			});
		});
	});
	
	$(".menu")
	.menu()
	.hide()
	.children()
	.click(function(){
		$(this).parent().hide();
	});


//Wait dialog
	$("#loadingDialog").dialog({
		autoOpen: false,
		width:100,
		height:100,
		pisition: { my: "center", at: "center", of: window },
		modal:true,
		resizable:true,
		title:"Loading..."
	});
	
//left right panel start
	$('#contentPanel').layout({
		spacing_open:2,
		spacing_closed:10,
		 togglerContent_closed:"<div>></div>"
	});
//Navigation tree	
	setting = {
			data: {
				key : {
					name: "moduleName",
					title: "title"
				},
				simpleData: {
					enable: true,
					idKey: "moduleId",
					pIdKey: "parentId",
					rootPId: -1
				}
			},
			view: {
				showIcon: false,
				selectedMulti: false
			},
			/*
			async: {
				enable: true,
				url:"${base_context}/module/getTreeData.oa?moduleId=${moduleId}",
				autoParam:["moduleId","parentId"],
				dataFilter: filter
			},
			*/
			callback: {
				onClick: zTreeOnLeftClick
			}
		};
	
	$.getJSON("${base_context}/module/getNavTreeData.oa?moduleId=${moduleId}",
			function(data){
				navTree = $.fn.zTree.init($("#navTree"), setting,data);
			}
	);
 	
 	
 	$("#expendBtn").button({
		text:false,
		icons:{primary: "ui-icon-plus"}
	})
	.addClass("toggleTreeBtn")
	.click(function(){expandTree();});
	
	$("#collapseBtn").button({
		text:false,
		icons:{primary: "ui-icon-minus"}
	})
	.addClass("toggleTreeBtn")
	.click(function(){collapseTree();});
	
	mainTabs = $( "#mainTabs" ).tabs({
		//heightStyle: "content"
	});
	 // close icon: removing the tab on click
	mainTabs.delegate( "span.ui-icon-close", "click", function() {
		var panelId = $( this ).closest( "li" ).remove().attr( "aria-controls" );
		$( "#" + panelId ).remove();
		mainTabs.tabs( "refresh" );
		tabMap.remove($(this).parent().find('a').text());
		
	});
	//
	
});

function showWaitDialog()
{
	$("#loadingDialog")
	.dialog("open")
	.dialog( "moveToTop" );
}

function closeWaitDialog()
{
	$("#loadingDialog")
	.dialog("close");
}


function clickMenuItem(mid,mname)
{
	$("#navHeader").html("<span>"+mname+"</span>")
	$.getJSON("${base_context}/module/getNavTreeData.oa?moduleId="+mid,
			function(data){
				navTree = $.fn.zTree.init($("#navTree"), setting,data);
				expandTree();
			}
	);
}


//Tree - left/right pane start
function zTreeOnLeftClick(event, treeId, treeNode)
{
	var _url = treeNode.defaultUrl;
	if(_url.length>0)
	{
		//$("#rightFrame").attr('src',_url);
		addTab(_url,treeNode.moduleName);
	}
};

function filter(treeId, parentNode, childNodes) {
	if (!childNodes) return null;
	for (var i=0, l=childNodes.length; i<l; i++) {
		if(!childNodes[i].isParent){
			childNodes[i].isParent = true;
		}
	}
	return childNodes;
};

function expandTree()
{
	navTree.expandAll(true);

}
function collapseTree()
{
	navTree.expandAll(false);
}

function addTab(_url,_label)
{
	if(tabMap.get(_label)==null)
	{
		var tabTemplate = "<li><a href='#{href}'>#{label}</a> <span class='ui-icon ui-icon-close' role='presentation'>Remove Tab</span></li>";
		var id = "tabs-" + tabCounter;
		var li = $( tabTemplate.replace( /#\{href\}/g, "#" + id ).replace( /#\{label\}/g, _label ) );
		var tabContent= "<iframe id='iframe" + tabCounter + "' name='iframe" + tabCounter + "' scrolling='no' frameborder='0'  style='width:100%;height:100%;'></iframe>";
		mainTabs.find( ".ui-tabs-nav" ).append( li );
		mainTabs.append( "<div id='" + id + "' style='height:90%;width:99%'>" + tabContent + "</div>" );
		mainTabs.tabs( "refresh" );
		$('#iframe' + tabCounter).attr('src', _url);
		mainTabs.tabs( "option", "active", -1 );
		tabMap.put(_label,tabCounter)
		tabCounter++;
	}
	else
	{
		var selTabIndex = tabMap.get(_label);
		$('#iframe' + selTabIndex).attr('src', _url);
		var _index = $("#mainTabs li").index($("li[aria-controls='tabs-"+selTabIndex+"']"));
		mainTabs.tabs( "option", "active", _index );
	}

}
//Tree - left/right pane end



</script>

