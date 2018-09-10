<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- google CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="resources/jquery.serialize-object.min.js"></script>
<title>Message</title>
<script type="text/javascript">
$(function() {
	$('#answer').on('click', function() {
		
	});
});
</script>
</head>
<body>
	<h3>${nickname}</h3>
	<div style="border: solid 1px black;">${message}</div>
	<button id="answer">Answer</button>
	<button id="close" onclick="window.close()">Close</button>
</body>
</html>