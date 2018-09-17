<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
.container{
text-align: center;
}
</style>
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
<div class="container">
	<h1>Message to 
		<c:if test="${empty receiveId}">Administrator</c:if>
		<c:if test="${not empty receiveId}">${receiveId}</c:if>
	</h1>
	<form id="messageCheck">
		<input type="hidden" value="${sessionScope.loginId}" name="userid">
		<input type="hidden" value="${sessionScope.loginNick}" name="nickname">
		<c:if test="${empty receiveId}">
			<input type="hidden" value="admin" name="receiveId">
		</c:if>
		<c:if test="${not empty receiveId}">
			<input type="hidden" value="${receiveId}" name="receiveId">
		</c:if>
		<textarea id="message" rows="20" cols="50" name="message"></textarea>
	</form>
	<br><br>
	<button id="sendMsg" class="btn">Send</button>
	<button id="calcel" onclick="window.close()" class="btn">Cancel</button>
</div>
</body>
</html>