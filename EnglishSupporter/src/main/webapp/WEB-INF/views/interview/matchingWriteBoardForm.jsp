<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- google CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<title>Writing Matching Board</title>
<script>
$(function(){
	$('#interview').addClass('active');
});

function board(page) {
	location.href = "./goBoardList?page=" + page + "&boardType=matching";
};

function formCheck(){
	var title = document.getElementById("title").value;
	var contents = document.getElementById("contents").value;
	var appointedTime = document.getElementById("appointedTime").value;
	
	if(title.length == 0 || contents.length == 0){
		alert("Please Write Title or Content");
		return false;
	}
	
	if(appointedTime.length == 0){
		alert("Please Select Date And Time");
		return false;
	}
	
	return true;
};
</script>
<style type="text/css">
textarea{
width: 100%;
}
.container{
margin-top: 30px;
margin-bottom: 30px;
}
input[type="checkbox"]{
width: 20px;
height: 20px;
}
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp"%>
<div class="container">
	<h2>Writing Matching Board</h2>
	<hr>
	<div>
	<form action="writeBoard" method="post" onsubmit="return formCheck()">
		<div>
			<input type="hidden" name="boardType" value="matching">
			<label id="title">TITLE : </label>
			<input id="title" type="text" name="title" autocomplete="off">
			&ensp;
			<label for="appointedTime"> Appointment Time : </label>
			<input id="appointedTime" type="datetime-local" name="appointedTime">
			&ensp;
			<c:if test="${sessionScope.loginType eq 'admin'}">
				<input id="notice" type="checkbox" name="status" value="1">&ensp;공지글
			</c:if>
		</div>
		<hr>
		<div>
		<label id="contents">Content</label>
			<textarea id="contents" rows="15" cols="60" name="contents"></textarea>
		</div>
		<hr>
		<div align="center">
				<input type="submit" value="Write" class="btn">&ensp;&ensp;&ensp;
				<input type="button" value="Back" onclick="board(${page})" class="btn">
		</div>
	</form>
	</div>
</div>
<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>
</html>