<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Home</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<style type="text/css">
.container{
	height: 740px;
	background-image: url('./resources/images/bible-book-christian-250609.jpg');
	background-size: 100%;
	background-repeat: no-repeat;
	background-position: center center; 
	opacity : 0.8;
}
</style>
<script type="text/javascript">
$(function(){
	$('#home').addClass('active');
	
	var msg = '';
	var msg1 = '${msg1}';
	var msg2 = '${msg2}';
	var msg3 = '${msg3}';
	var msg4 = '${msg4}';
	
	if(msg1 != '' && msg2 != '' && msg3 != '' && msg4 != ''){
		msg = msg1 + '\n\n' + msg2 + '\n\n' + msg3 + '\n\n' + msg4;
	}
	
	if(msg != ''){
		alert(msg);
	}
});
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp"%>
<div class="container">

</div>
<%@ include file="/WEB-INF/views/Footer.jsp"%>
<c:remove var="msg1" scope="session" />
</body>
</html>
