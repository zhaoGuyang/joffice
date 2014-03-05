<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">
base_context="${base_context}";
var _addDialog;
var _editDdialog;
var _assignDdialog;
var _authDdialog;
$(function(){
    
	dataSource = new kendo.data.DataSource({
         transport: {
             read:  {
                 url: base_context + "/role/list.oa?_timeStamp="+(new Date()).getTime(),
                 dataType: "json",
                 cache: false
             }
         },
         batch: true,
         pageSize: 20,
         schema: {
             model: {
                 id: "roleId",
                 fields: {
                	 roleId: {  editable: false, nullable: true },
                	 roleName: { validation: { required: true } }
                 }
             }
         }
     });
	
	
	
	 $("#roleGrid").kendoGrid({
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
                 { field: "roleName", title: "<spring:message code='role.roleName'/>" },
                 { width:"150px" }
                 ]
     });
	 
	//add/edit user window
	/*
	$("#addWin").kendoWindow({
        width: "600px",
        height:"100px",
        modal: true,
        title: "Add User",
        visible: false
    });
	_addDialog = $("#addWin").data("kendoWindow");
	*/
	
	$("#editWin").kendoWindow({
        width: "600px",
        height:"100px",
        modal: true,
        title: "Edit User",
        visible: false
    });
	_editDialog = $("#editWin").data("kendoWindow");
	
	
	$("#assignWin").kendoWindow({
        width: "600px",
        height:"400px",
        modal: true,
        title: "Assign User",
        visible: false
    });
	_assignDialog = $("#assignWin").data("kendoWindow");
	
	//auth
	$("#authWin").kendoWindow({
        width: "600px",
        height:"400px",
        modal: true,
        title: "Auth",
        visible: false
    });
	_authDialog = $("#authWin").data("kendoWindow");
	
	$("#check-all").change(function(){
		var _checked = $(this).prop('checked');
		$("[id^='ck']").prop('checked',_checked);
	});
	$("#editBtn1").kendoButton();
		
 });

function addRow()
{
	_addDialog.refresh({
		url : "${base_context}/role/add.oa"
	});
	_addDialog.toFront();
	_addDialog.center();
	_addDialog.open();
}
function editRow(rowId)
{
	
	_editDialog.refresh({
		//iframe : true,
		url : "${base_context}/role/add.oa",
		data : {roleId : rowId}
	});
	
	_editDialog.toFront();
	_editDialog.center();
	_editDialog.open();
}
function delUser(e)
{
	alert("del"+e);
}
function showAssign(rowId)
{	
	_assignDialog.refresh({
		//iframe:true,
		url: "${base_context}/role/showAssignedUsers.oa",
		data : {roleId : rowId}
	});

	_assignDialog.toFront();
	_assignDialog.center();
	_assignDialog.open();
}

function closeAuth()
{
	_authDialog.close();
}
function showAuth(rowId)
{
	_authDialog.refresh({
		options:{cache : true},
		url : "${base_context}/role/showAuth.oa",
		data : {roleId : rowId}
	});
	_authDialog.toFront();
	_authDialog.center();
	_authDialog.open();
}
function isnull(a, b) {
    b = b || '';
     return a || b;
}

</script>
<script id="toobarTemplate" type="text/x-kendo-tmpl">
	<button class="k-button" id="addBtn" onclick="editRow()">Add new redcord</button>
</script>
<script id="rowTemplate" type="text/x-kendo-tmpl">
	<tr ondblclick="editRow(#: roleId #)" >
		<td> <input type="checkbox" id="ck_#: roleId #"/></td>
		<td> #: isnull(roleName,"") # </td>
		<td> 
			<button class="k-button k-button-icon" onclick="editRow(#: roleId #)" title="<spring:message code='btn.edit'/>">
				<span class="k-sprite ui-icon ui-icon-pencil " ></span>
			</button>
			<button class="k-button k-button-icon" onclick="delRow(#: roleId #)" title="<spring:message code='btn.del'/>">
				<span class="k-sprite ui-icon ui-icon-trash" ></span>
			</button>
			<button class="k-button k-button-icon" onclick="showAssign(#: roleId #)" title="<spring:message code='role.assignedUsers'/>">
				<span class="k-sprite ui-icon ui-icon-person" ></span>
			</button>
			<button class="k-button k-button-icon" onclick="showAuth(#: roleId #)" title="<spring:message code='role.assignedUsers'/>">
				<span class="k-sprite ui-icon ui-icon-key" ></span>
			</button>
		</td>
	</tr>
</script>
