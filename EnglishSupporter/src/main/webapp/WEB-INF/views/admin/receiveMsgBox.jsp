<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- google CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="resources/jquery.serialize-object.min.js"></script>
<link href="resources/styles/layout.css" rel="stylesheet" type="text/css" media="all">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<title>Message</title>
<style type="text/css">
body {
    background: #f8f6f6;
    color: #404040;
    font-family: 'Lucida Grande', Verdana, sans-serif;
    font-size: 13px;
    font-weight: normal;
    line-height: 20px;
}
textarea{
width: 80%;
}
.container{
text-align: center;

}

</style>
<script type="text/javascript">
$(function() {
	// 부모창의 msgList() 재실행
	opener.msgList();
	// 부모창의 messageList() 재실행
	if(typeof opener.messageList == 'function') {
		opener.messageList();
	}
	
	$('#answer').on('click', function() {
		console.log($('#answer'));
		var receiveId = '${receiveId}';
		location.href = './goSendMsgBox?receiveId=' + receiveId;
	});
});
</script>
</head>
<body>
<div class="container">
	<h1>From ${nickname}</h1>
	<textarea rows="20" cols="50" disabled="disabled" style="background-color: white;">${message}</textarea>
	<br><br>
	<button id="answer" class="btn">Answer</button>
	<button id="close" onclick="window.close()" class="btn">Close</button>
</div>
</body>
</html>