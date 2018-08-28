<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Writing Matching Board</title>
<script>
	function board(page) {
		location.href = "./boardList?page=" + page + "&boardType=matching";
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
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp"%>
	<h1>Writing Matching Board</h1>
	<div>
	<form action="writeBoard" method="post" onsubmit="return formCheck()">
		<div>
			<input type="hidden" name="boardType" value="matching">
			<input id="title" type="text" name="title" placeholder="TITLE" autocomplete="off">
		</div>
		<h1 id="introduce">Content</h1>
		<div>
			<textarea id="contents" rows="15" cols="60" name="contents"></textarea><br/>
		</div>
		<div>
			<div class="col-md-6">
				<input type="submit" value="Write">
			</div>
			<div class="col-md-6">
				<input type="button" value="Cancell" onclick="board(${page})">
			</div>
		</div>
	</form>
	</div>
<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>
</html>