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
	// 부모창의 msgList() 재실행
	opener.msgList();
	// 부모창의 messageList() 재실행
	opener.messageList();
	
	$('#answer').on('click', function() {
		var receiveId = '${receiveId}';
		location.href = './goSendMsgBox?receiveId=' + receiveId;
	});
});
</script>
</head>
<body>
	<h1>From ${nickname}</h1>
	<textarea rows="20" cols="50" disabled="disabled" style="background-color: white;">${message}</textarea>
	<button id="answer">Answer</button>
	<button id="close" onclick="window.close()">Close</button>
</body>
</html>