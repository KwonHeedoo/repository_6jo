<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- google CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>Report</title>
<script type="text/javascript">
$(function() {
	$('#sendReport').on('click', function() {
		var test = $('reporter').val();
		alert(test);
		
		//$('#sendData').submit();
		window.close();
	});
});
</script>
</head>
<body>
	<h1>Report to Administrator</h1>
	<form id="sendData" action="report" method="post">
		<input id="reporter" type="hidden" value="" name="reporter">
		<input id="report" type="hidden" value="" name="report">
		<input id="reportee" type="hidden" value="" name="reportee">
		<input id="boardNum" type="hidden" value="">
		<textarea id="reason" rows="20" cols="50" name="reason"></textarea>
		<button id="sendReport">Send</button>
		<button id="calcel" onclick="window.close()">Cancel</button>
	</form>
</body>
</html>