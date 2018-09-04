<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Writing Matching Board</title>
<script>
	function board(page) {
		location.href = "./goBoardList?page=" + page + "&boardType=matching";
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
	function dataList(){
		var form = document.createElement('form');
		form.setAttribute('method', 'post');
		form.setAttribute('action', 'goInterviewData');
		form.setAttribute('target', 'data');
		input = document.createElement('input');
		input.type = 'hidden';
		input.name = 'userid';
		input.value = "aaa";
		form.appendChild(input);
		
		document.body.appendChild(form);
		window.open('', 'data', 'width=400, height=500, location=no, toolbar=no, menubar=no, scrollbars=yes, resizable=no');
		form.submit();
		document.body.removeChild(form);
	}
	function setFile(datanum,fileName){
		$("#dataNum").value = datanum;
		$("#fileName").text(fileName);
	}
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp"%>
	<h1>Writing Matching Board</h1>
	<div>
	<form action="writeBoard" method="post" onsubmit="return formCheck()">
		<div>
			<input type="hidden" name="boardType" value="matching">
			<input id="dataNum" type="hidden" name="dataNum" value="">
			<input id="title" type="text" name="title" placeholder="TITLE" autocomplete="off">
			<c:if test="${sessionScope.loginType eq 'admin'}">
				<input id="notice" type="checkbox" name="status" value="1">공지글
			</c:if>
		</div>
		<h1 id="introduce">Content</h1>
		<div>
			<textarea id="contents" rows="15" cols="60" name="contents"></textarea>
			<p  id = "fileName"> </p>
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
	<button onclick="dataList()">button</button>
	</div>
<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>
</html>