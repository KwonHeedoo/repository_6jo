<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

<title>Writing Notice Board</title>
<script>
$(function(){
	$('#nBoard').addClass('active');
});

function board(page) {
	location.href = "./goBoardList?page=" + page + "&boardType=notice";
};

function formCheck(){
	var title = document.getElementById("title").value;
	var contents = document.getElementById("contents").value;
	
	if(title.length == 0 || contents.length == 0){
		alert("Please Write Title or Content");
		return false;
	}
	
	return true;
};
</script>
<style type="text/css">
.container {
    margin-top: 30px;
    margin-bottom: 30px;
}
input[type="text"]{
width: 93%;
}
textarea {
width: 100%;
}
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp"%>
	<div class="container">
	<h2>Writing Notice Board</h2>
	<hr>
	<div>
	<form action="writeBoard" method="post" onsubmit="return formCheck()">
		<div>
			<input type="hidden" name="boardType" value="notice">
			<label>TITLE : </label>
			<input id="title" type="text" name="title" placeholder="TITLE" autocomplete="off">
		</div>
		<h1 id="introduce">Content</h1>
		<div>
		<label>Content</label>
			<textarea id="contents" name="contents"></textarea><br/>
		</div>
		<hr>
		<div>
				<input type="submit" value="Write" class="btn">
				<input type="button" value="Cancell" onclick="board(${page})" class="btn">
		</div>
	</form>
	</div>
</div>
<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>
</html>