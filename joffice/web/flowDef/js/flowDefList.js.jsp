<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
base_context="${base_context}";
var win;
var defMgtMenu;
var selectData;
$(function(){
	var selectId = 0;
	
	defMgtMenu = $("#defMgtMenu").menu();
	defMgtMenu.hide();
	$(document).bind("contextmenu",function(e)
    {
        return false;
    }); 
	$(document).click(function(){
		defMgtMenu.hide();
	});
	
	
	
	top.$("#pubDialog").dialog({
		autoOpen: false,
		width : 300,
		height: 200,
		pisition: { my: "center", at: "center", of: window },
		modal:true,
		resizable:true,
		title:"流程定义",
		close : function(){
			//$("#formDefList").trigger("reloadGrid");
		}
		
	});
	
    $("#toolbar").buttonset()
    .children()
    .each(function(){
    	$(this).button({
    		icons:{primary: $(this).attr('icon')}
    	});
    })
    
    
	$("#formDefList").jqGrid({
		url : "${base_context}/flowDef/getDefList.oa",  
        contentType : 'application/json',  
        mtype : "get",  
        datatype : 'json',  
        prmNames : {search : "search"},  
        jsonReader : {id : "0", repeatitems : false, userdata : "userdata"},
		height : $(window).height()-100,  
        colNames : ["ID","processDefid","depId","标题","Key","分类" ,"版本号" ,"发布状态", "创建时间"/*, "管理"*/],  
        colModel : [{name:"flowDefId", index:"flowDefId",hidden:true},  
                    {name:"processDefId", index:"processDefId",hidden:true},  
                    {name:"deployId", index:"deployId",hidden:true},  
                    {name:"subject", index:"subject"}, 
                    {name:"defKey", index:"defKey"}, 
                    {name:"defTypeId", index:"defTypeId"},  
                    {name:"versionNo", index:"versionNo"},  
                    {name:"status", index:"stats"},  
                    {name:"addDate", index:"addDate"}
                    /*
                    ,  
                    {
                    	name:"mgt", 
                    	index:"mgt",
                    	align:"center",
                    	width:15

                    }
                    */
                    ],  
        pager : "#pager",  
        //autoWidth : true,  
        width:$(window).width(),
        rowNum : 20,  
        rowList:[10,20,30],
        rownumbers : true,  
        viewrecords: true,  
        gridview: true,
        onSelectRow: function(id){
        	selectRow(id); 
        },
        onRightClickRow : function(id,irow, icol, event){
        	selectRow(id); 
        	defMgtMenu.show();
        	defMgtMenu.position({my:"left top", at:"left bottom", of:event});
        },
        ondblClickRow : function(id,irow, icol, event){
        	
        },
        
        gridComplete: function(){
        	var ids = $("#formDefList").jqGrid('getDataIDs');
        	for(var i=0;i < ids.length;i++)
        	{
        		$("#formDefList").setRowData( ids[i],false,{height: 30+i*2});
        	}
        	
        }
	});
	$("#formDefList").jqGrid('navGrid','#pager',{edit:false,add:false,del:false});	
	
	
	var btnWid = 0;
	var defMgtTool = $("#defMgtTool");
	defMgtTool
	.buttonset()
	.children()
	.each(function(){
		var _icon= $(this).attr('icon')
		$(this).button({
			icons : {primary: _icon}
		});
		btnWid+=$(this).width();
	});
	defMgtTool.width(btnWid+10);
	
	
	
	
 });
function selectRow(id)
{
	var data = $("#formDefList").jqGrid('getRowData',id);
	selectData = data;
	selectId = data.flowDefId;
}

function editRow()
{
	top
	.$("#pubDialog")
	.dialog( "open" )
	//.dialog("option","position",{ my: "center", at: "center", of: window })
	.load("${base_context}/flowDef/edit.oa?flowDefId="+selectId);
}
function importFlow()
{
	top
	.$("#pubDialog")
	.dialog( "open" )
	.dialog("option","width","350")
	.dialog("option","height","150")
	.dialog("option","position",{ my: "center", at: "center", of: window })
	.load("${base_context}/flowDef/showUpload.oa?flowDefId=0");
}
function showProcess(_type)
{
	var data = $("#formDefList").jqGrid('getRowData',selectId);
	var processId = data.processDefId;
	
	top.$("#pubDialog").html("");
	if(_type == 'xml')
	{
		
		top.$("#pubDialog").load("${base_context}/flowDef/showProcess.oa?resourceType=xml&processId="+processId,function(data){
			$(this).text(data);
		} );
	}
	else if (_type == 'image')
	{
		$('<div/>', {
            'id': 'imgDialog',
            html: "<img src='${base_context}/flowDef/showProcess.oa?resourceType=image&processId="+processId + "' />"
        }).appendTo(top.$("#pubDialog"));
	}
	
	top.$("#pubDialog")
    .dialog( "open" )
	.dialog("option","position",{ my: "center", at: "center", of: window })
	.dialog("option","width","800")
	.dialog("option","height","500");
}
function showSetup()
{
	if(selectData && selectData.processDefId)
	{
		/*
		top.
		$("#pubDialog")
		.dialog( "open" )
		.dialog("option","position",{ my: "center", at: "center", of: window })
		.dialog("option","width","800")
		.dialog("option","height","600")
		.dialog("option","title","设置流程")
		.load("${base_context}/flowDef/showSetup.oa?processId="+selectData.processDefId);
		*/
		var _url = "${base_context}/flowDef/showSetup.oa?processId="+selectData.processDefId;
		top.addTab(_url,"设置流程");
	}
}

</script>

