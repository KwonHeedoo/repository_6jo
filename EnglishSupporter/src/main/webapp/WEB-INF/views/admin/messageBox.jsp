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
	$('#sendMsg').on('click', function() {
		var message = $('#message').val();
		
		// 쪽지 내욜을 작성 해야한다.
		if(message.length == 0){
			alert('Please Write Your Message');
			return;
		}
		
		// form의 값들 JSON화
		$.fn.serializeObject = FormSerializer.serializeObject;
		var msg = $('#messageCheck').serializeObject();
		
		// 쪽지 보내기
		$.ajax({
			url : 'sendMsg'
			, type : 'post'
			, data : JSON.stringify(msg)
			, contentType : 'application/json; charset=UTF-8'
			, success : function(resp){
				if(resp == 1){
					window.close();
				}
			}
			, error : function(){alert('Error!');}
		});
	});
});
</script>
</head>
<body>
	<h1>Message to Administrator</h1>
	<form id="messageCheck">
		<input type="hidden" value="${sessionScope.loginId}" name="userid">
		<input type="hidden" value="${sessionScope.loginNick}" name="nickname">
		<input type="hidden" value="admin" name="receiveId">
		<textarea id="message" rows="20" cols="50" name="message"></textarea>
	</form>
	<button id="sendMsg">Send</button>
	<button id="calcel" onclick="window.close()">Cancel</button>
</body>
</html>