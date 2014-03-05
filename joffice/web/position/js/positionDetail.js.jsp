<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
base_context="${base_context}";

$(function(){
	$("#toolbar").buttonset()
				.children()
				.first()
				.button({
					icons : {primary: "ui-icon-disk"}
				})
				.click(function(){
					save("posDetail");
				})
				.next()
				.button({
					icons : {primary: "ui-icon-cancel"}
				})
				.click(function(){
					$("#posDetail")[0].reset();
				});
});


</script>

