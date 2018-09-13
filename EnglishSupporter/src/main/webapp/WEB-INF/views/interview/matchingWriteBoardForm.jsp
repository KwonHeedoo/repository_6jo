<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- google CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
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
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp"%>
	<h1>Writing Matching Board</h1>
	<div>
	<form action="writeBoard" method="post" onsubmit="return formCheck()">
		<div>
			<input type="hidden" name="boardType" value="matching">
			<input id="title" type="text" name="title" placeholder="TITLE" autocomplete="off">
			<c:if test="${sessionScope.loginType eq 'admin'}">
				<input id="notice" type="checkbox" name="status" value="1">공지글
			</c:if>
			<input id="appointedTime" type="datetime-local" name="appointedTime">
		</div>
		<h3 id="introduce">Content</h3>
		<div>
			<textarea id="contents" rows="15" cols="60" name="contents"></textarea>
		</div>
		<div>
			<div class="col-md-6">
				<input type="submit" value="Write">
			</div>
			<div class="col-md-6">
				<input type="button" value="Cancel" onclick="board(${page})">
			</div>
		</div>
	</form>
	</div>
<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>
</html>