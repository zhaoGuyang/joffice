<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">
var base_context;
var moduleMenu;
var currModule;
var dataSource;
var _actionDialog;
var _treeview;
/**
 * Initial
 */
$(function(){
	moduleMenu = $("#moduleMenu").hide();
	$(document).bind("contextmenu",function(e)
    {
        return false;
    }); 
	$(document).click(function(){
		moduleMenu.hide();
	});
	$("#module").kendoSplitter(
	{
		orientation : "horizontal",
		panes : [
		{
			collapsible : false,
			resizable : true,
			size : "300px"
		}
		,
		{
			collapsible : false,
			resizable : true
		} 
		]
	});


	// Moudel tree start

	var _url = base_context+"/module/getModules.oa";
	dataSource = new kendo.data.HierarchicalDataSource({
	    transport: {
	        read: {
	            url: _url,
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
		//loadOnDemand: false,
		template: "",
		dataSource : dataSource,
		dataTextField : "name",
		select : function(e)
		{
			var dataItem = _treeview.dataItem(e.node);
			selectModule(dataItem);
		}
	})
	.on('mousedown', '.k-in', function(event)
    {
        // Handle right click events...
        if (event.which === 3)
        {
        	console.log(event);
        	var _text = event.currentTarget.innerHTML;
        	console.log("text: "+_text);
        	var treeview = $("#moduleTree").data("kendoTreeView");
        	var _currNode = treeview.findByText(_text);
        	treeview.select(_currNode);
        	var dataItem = treeview.dataItem(_currNode);
			selectModule(dataItem);
            showModuleMenu(event);
        }
    });
	_treeview = $("#moduleTree").data("kendoTreeView");
	// module tree end
	
	
	$("#saveBtn").kendoButton({
		click : function(e){
			saveModule();
		}
	});
	
	
	
	//bind dirty
	$("#moduleForm table tr td input").change(function(){
		disableSaveBtn(false);
	});
	
	//var _winUrl = base_context+"/module/showActions.oa?moduleId="+$('#moduleId').val();
	$("#actionWin").kendoWindow({
		//content : _winUrl,
        width: "600px",
        height:"500px",
        modal: true,
        title: "Add",
        visible: false
    });
	_actionDialog = $("#actionWin").data("kendoWindow");
	$("#actBtn").kendoButton({
		click : function(e){
			openActionWin();
		}
	});
	
	
	var actBtn = $("#actBtn").data("kendoButton");
	
	if($("#moduleId").val())
	{
		actBtn.enable(true);
	}
	else
	{
		actBtn.enable(false);
	}
});
</script>
