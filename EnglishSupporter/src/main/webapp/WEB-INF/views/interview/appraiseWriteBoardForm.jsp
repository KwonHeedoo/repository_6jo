<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<title>Writing appraise Board</title>
<style type="text/css">
.container {
    margin-top: 20px;
    margin-bottom: 30px;
}
input[type="text"]{
width: 100%;
}
textarea {
width: 100%;
}

</style>
<script> 
function test(func){
	
}

function a(value){
	test(
			function (){
				var sum = value * 10;
	});
	
}

	function board(page) {
		location.href = "./goBoardList?page=" + page + "&boardType=appraise";
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
		$("#dataNum").val(datanum);
		var a = $("#dataNum").val();
		console.log(a);
		$("#fileName").text(fileName);
	}
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp"%>
	<div class="container" align="center">
	<h1>Writing appraise Board</h1>
	<div>
	<form action="writeBoard" method="post" onsubmit="return formCheck()">
		<div>
			<input type="hidden" name="boardType" value="appraise">
			<input id="dataNum" type="hidden" name="datanum" value="">
			<input id="title" type="text" name="title" placeholder="TITLE" autocomplete="off">
			<c:if test="${sessionScope.loginType eq 'admin'}">
				<input id="notice" type="checkbox" name="status" value="1">공지글
			</c:if>
		</div>
		<h3 id="introduce">Content</h3>
		<div>
			<textarea id="contents" rows="15" cols="60" name="contents"></textarea>
			<p id = "fileName"> </p>
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
	<button onclick="dataList()">select video</button>
	</div>
	</div>
<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>
</html>