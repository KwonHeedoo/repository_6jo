<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CoverLetter</title>
<script src="resources/jquery-3.3.1.min.js"></script>
<script src="resources/jquery.serialize-object.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<style>
.container{
    margin-bottom: 30px;
}

textarea {
	width: 100%;
	height: 800px;
	resize: none;
	background-color: white;
}
.center{
text-align: center;
}
.username{
height:60px;
padding-top:20px;
font-size :24pt;
font-weight: bold;
text-align: center;
}

</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/header.jsp"%>
	<div class="container">
		<div class="row justify-content-end">
			<br>
			<h3>[ COVER LETTER ]</h3>
			<table border="1">
			<tr>
			<th class="center">[TITLE]</th>
			<th class="center" colspan="2">${myCL.title}</th>
			</tr>
			<tr>
			<td colspan="3" class="username">${myCL.username}</td>
			</tr>
			<tr>
			<td colspan="3" class="center">
			${myCL.email}<br>
			${myCL.phone}<br>
			${myCL.address}</td>
			</tr>
			<tr>
			<td colspan="3">
			<textarea disabled>
			${myCL.maintext}
			</textarea>
			</td>
			</tr>
			</table>
		<div class="center">
		<br>
		<input type="button" value="Back" onclick="docs()" class="btn">
		</div>
	</div>
</div>
	<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>

<script type="text/javascript">
$(function() { // 유저이름 받아옴 
	$('#resume').addClass('active');
	
/* 	var userid = '${myCL.userid}';
	console.log(userid);
	$.ajax({
		method: "post",
		url: "getUserInfo",
		data : {"userid": userid},
		dataType : "JSON",
		success: function(reps){
			var user= reps;
			$('td.username').text(user.username);			
		},
		error: function(error){
			console.log("에러"+error);
		}
	});
}); */
function docs() {
	location.href = "./goMyDocs?selectedTab=coverletter";
};

</script>
</html>