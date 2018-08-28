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
		var sendData = $('#report').text();
		
		window.close();
	});
});
</script>
</head>
<body>
	<h1>Report to Administrator</h1>
	<textarea id="report" rows="20" cols="50" name="composition"></textarea>
	<button id="sendReport">Send</button>
	<button id="calcel">Cancel</button>
</body>
</html>