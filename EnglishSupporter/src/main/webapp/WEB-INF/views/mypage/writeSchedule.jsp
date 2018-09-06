<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href=" https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"/>
<title>Schedule</title>
<style type="text/css">
input:not([type=button]){
width: 100%;
}

input[type=checkbox] {
width: 20px;
height: 20px;
}

.datecol{
border: none;
}

.container{
text-align: center;
}

</style>
</head>
<body>
<div class="container">
<form id="schedule">
<input type="hidden" value="${sessionScope.loginId}" name="userid">
<table class="table">
	<tr>
	<th colspan="2"><h4>[ SCHEDULE ]</h4></th>
	</tr>
	<tr>
	<th>DATE</th>
	<td><input type="text" value="${date}" name="date" readonly="readonly" class="datecol"></td>
	</tr>
	<tr>
	<th>TITLE</th>
	<td><input type="text" value="" name="date"></td>
	</tr>
	<tr>
	<th>ALL DAY</th><td><input type="checkbox" name="allDay" width="20" height="20"/></td>
	</tr>
	<tr>
	<th>START</th>
	<td><input type="datetime-local" name="start"></td>
	</tr>
	<tr>
	<th>END</th>
	<td><input type="datetime-local" name="end"></td>
	</tr>
	<tr>
	<td colspan="2"><input type="button" value="SEND" class="btn btn-primary"> <input type="button" value="CANCLE" class="btn btn-primary"></td>
	</tr>
	</table>
</form>
</div>
</body>
<script type="text/javascript">
$(function() {
	$('input[name="allDay"]').change(function() {
		//console.log(this);
		if(	this.checked){
			$('input[name="start"]').attr('disabled',true);
			$('input[name="end"]').attr('disabled',true);
		}else{
			$('input[name="start"]').attr('disabled',false);
			$('input[name="end"]').attr('disabled',false);
		}		
	});
	// 창닫기 
	$('input[value="CANCLE"]').click(function() {
		window.close();
	});
	//스케쥴 DB 저장+만든 오브젝트 부모에서 받기  
	$('input[value="SEND"]').click(function() {
		
		
		//window.close();
	});

});
</script>
</html>