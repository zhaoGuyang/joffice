<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">
base_context="${base_context}";
var _addDialog;
var _editDdialog;

$(function(){
    
	dataSource = new kendo.data.DataSource({
         transport: {
             read:  {
                 url: base_context + "/module/getActions.oa?moduleId=${moduleId}",
                 dataType: "json"
             }
         },
         batch: true,
         pageSize: 20,
         schema: {
             model: {
                 id: "actionId",
                 fields: {
                	 actionId: {  editable: false, nullable: true },
                	 moduleId: {  editable: false, nullable: true },
                	 actionTypeCode: { validation: { required: true } },
                	 actionTypeDesc: { validation: { required: true } }
                 }
             }
         }
     });
	
	
	
	 $("#actionGrid").kendoGrid({
		 toolbar: [{ template: kendo.template($("#toobarTemplate").html()) }],
         dataSource: dataSource,
         selectable: 'row',
         sortable: true,
         rowTemplate: kendo.template($("#rowTemplate").html()),
         pageable: true,
         reorderable: true,
         resizable: true,
         height: "500",
         columns: [
      			 { headerTemplate: '<input type="checkbox" id="check-all" />', width:"40px" },
                 { field: "actionTypeCode", title: "<spring:message code='module.action.actionTypeCode'/>" },
                 { field: "actionTypeDesc", title: "<spring:message code='module.action.actionTypeDesc'/>" },
                 { width:"150px" }
                 ]
     });
	 
	//add/edit user window
	
	$("#addWin").kendoWindow({
		//content:"${base_context}/module/addAction.oa",
        width: "400px",
        height:"500px",
        modal: true,
        title: "Add",
        visible: false
    });
	_addDialog = $("#addWin").data("kendoWindow");
	
	
	$("#editWin").kendoWindow({
        width: "400px",
        height:"500px",
        modal: true,
        title: "Edit",
        visible: false
    });
	_editDialog = $("#editWin").data("kendoWindow");
	
	
	
	$("#check-all").change(function(){
		var _checked = $(this).prop('checked');
		$("[id^='ck']").prop('checked',_checked);
	});
	$("#editBtn1").kendoButton();
		
 });

function addRow()
{
	_editDialog.refresh({
		//iframe : true,
		url : "${base_context}/module/addAction.oa",
		data : { moduleId : $("#moduleId").val()}
	});
	_addDialog.toFront();
	_addDialog.center();
	_addDialog.open();
	//win.data("kendoWindow").refresh("${base_context}/role/add.oa");
}
function editRow(rowId)
{
	
	_editDialog.refresh({
		//iframe : true,
		url : "${base_context}/module/editAction.oa",
		data : {actionId : rowId, moduleId : $("#moduleId").val()}
	});
	
	_editDialog.toFront();
	_editDialog.center();
	_editDialog.open();
}
function delUser(e)
{
	alert("del"+e);
}

function isnull(a, b) {
    b = b || '';
     return a || b;
}

</script>
<script id="toobarTemplate" type="text/x-kendo-tmpl">
	<button class="k-button" id="addBtn" onclick="addRow()">Add new redcord</button>
</script>
<script id="rowTemplate" type="text/x-kendo-tmpl">
	<tr ondblclick="editRow(#: actionId #)" >
		<td> <input type="checkbox" id="ck_#: actionId #"/></td>
		<td> #: isnull(actionTypeCode,"") # </td>
		<td> #: isnull(actionTypeDesc,"") # </td>
		<td> 
			<button class="k-button k-button-icon" onclick="editRow(#: roleId #)" title="<spring:message code='btn.edit'/>">
				<span class="k-sprite ui-icon ui-icon-pencil " ></span>
			</button>
			<button class="k-button k-button-icon" onclick="delRow(#: roleId #)" title="<spring:message code='btn.del'/>">
				<span class="k-sprite ui-icon ui-icon-trash" ></span>
			</button>

		</td>
	</tr>
</script>
