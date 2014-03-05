<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
base_context="${base_context}";
var win;
$(function(){
    
	dataSource = new kendo.data.DataSource({
         transport: {
             read:  {
                 url: base_context + "/user/list.oa",
                 dataType: "json"
             }
         },
         batch: true,
         pageSize: 20,
         schema: {
             model: {
                 id: "userId",
                 fields: {
                	 userId: { name: "userId", editable: false, nullable: true },
                	 userName: { name:"userName",validation: { required: true } },
                	 fullName: { name:"fullName"},
                	 email: { name:"email" },
                	 address: { name:"address" }
                 }
             }
         }
     });
	
	 $("#userGrid").kendoGrid({
		 toolbar: [
		           { template: kendo.template($("#toobarTemplate").html()) }
		         ],
         dataSource: dataSource,
         selectable: 'row',
         sortable: true,
         rowTemplate: kendo.template($("#rowTemplate").html()),
         pageable: true,
         reorderable: true,
         resizable: true,
         height: "500",
         /**/
         columns: [
			 { headerTemplate: '<input type="checkbox" id="check-all" />', width:"40px" },
             { field: "userName", title: "User Name" },
             { field: "fullName", title:"Full Name" },
             { field: "email", title:"Email" },
             { field: "address", title:"Address" },
             {  width:"150px"}
             ]
     });
	 
	//add/edit user window
	win = $("#window");
	addBtn = $("#addBtn")
			.bind("click", function(){
				win.data("kendoWindow").open();
				win.data("kendoWindow").center();
				win.data("kendoWindow").refresh("${base_context}/user/add.oa");
			});
	
	win.kendoWindow({
        width: "600px",
        modal: true,
        title: "Add User",
        visible: false
    });
	
	$("#check-all").change(function(){
		var _checked = $(this).prop('checked');
		$("[id^='ck']").prop('checked',_checked);
	});
		
 });
function closeWin()
{
	$("#window").data("kendoWindow").close()
}

function editUser(uId)
{
	win.data("kendoWindow").open();
	win.data("kendoWindow").center();
	win.data("kendoWindow").refresh("${base_context}/user/add.oa?userId="+uId);
}
function assignRoles(uId)
{
	win.data("kendoWindow").open();
	win.data("kendoWindow").center();
	win.data("kendoWindow").refresh("${base_context}/user/showAssignRoles.oa?userId="+uId);
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
	<button class="k-button" id="addBtn" >Add new redcord</button>
</script>
<script id="rowTemplate" type="text/x-kendo-tmpl">
	<tr ondblclick="editUser(#: userId #)" >
		<td> <input type="checkbox" id="ck_#: userId #"/></td>
		<td> #: isnull(userName,"") # </td>
		<td> #: isnull(fullName,"") # </td>
		<td> #: isnull(email,"") # </td>
		<td> #: isnull(address,"") # </td>
		<td> 
			<button class="k-button k-button-icon" onclick="editUser(#: userId #)" title="<spring:message code='btn.edit'/>">
				<span class="k-sprite ui-icon ui-icon-pencil " ></span>
			</button>
			<button class="k-button k-button-icon" onclick="delUser(#: userId #)" title="<spring:message code='btn.del'/>">
				<span class="k-sprite ui-icon ui-icon-trash" ></span>
			</button>
			<button class="k-button k-button-icon" onclick="assignRoles(#: userId #)" title="<spring:message code='role.assignedUsers'/>">
				<span class="k-sprite ui-icon ui-icon-person" ></span>
			</button>
		</td>
	</tr>
</script>
