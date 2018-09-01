<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>New Resume</title>
<script src="resources/jquery-3.3.1.min.js"></script>
<script src="resources/jquery.serialize-object.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<style>

input{
	background: transparent;
}

input[type='text'], input[type='date'], input[type='email'] {
margin:0 auto;
height: 28px;
width: 100%
}
::placeholder{
 color: #dad9d9;
 font-size: 9pt;
}

.add{
width: 30px;
margin-left: 0;
}

.box{
height: 55px;
}
h5{
font-weight: bold;
}

textarea {
	width: 100%;
	height: 500px;
	resize: none;
}

.container{
    margin-bottom: 30px;
}

</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/header.jsp"%>
	<div class="container">
			<form id ="coverletter">
		<div class="row justify-content-end">
			<br>
			<h3>[ COVER LETTER ]</h3>
		<div class="col-md-5">
		<p>COVER LETTER TITLE: </p><input id="title" type="text" name="title" /></div>
		<br>
		</div>
		<hr>
			<input type="hidden" name="userid" value="${sessionScope.loginId}">
		<div class="row">
		<div class="com-md-10">
		 &nbsp;&nbsp;&nbsp;[${sessionScope.username}]
		<br>
		<br>
		</div>
		<div class="col-md-3">
		<input id="email" type="email" name="email" value="${sessionScope.email}" placeholder="YOUR E-MAIL"/>
		</div>
		<div class="col-md-3">
		<input type="text" name="phone" placeholder="YOUR PHONE NUMBER"/>
		</div>
		<div class="col-md-6">
		<input id="address" type="text" name="address" placeholder="YOUR ADDRESS"/>
		</div>
	</div>
	<hr>
	<div class="raw">
		<div class="right">
			<select name="sampleTemplete" id=selectbox>
				<option value="sample1" selected>Entry Level sample</option>
				<option value="sample2">Experienced Level sample</option>
			</select>
		</div>
			<br>
		<textarea rows="" cols="" name="maintext" >
		${sample.maintext}
		</textarea>
	</div>
	</form>
	
	<div class="right">
		<br>
	<input type="button" class="btn" value="send Form" id="datasend">
	</div>
	
</div>
	<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>

<script type="text/javascript">
$.fn.serializeJSON   = FormSerializer.serializeJSON;

$(function(){
	
	$('#datasend').on('click',function(){
	 	var coverletter = $('#coverletter').serializeObject();
		console.log(coverletter);
		
		$.ajax({
			method: "post",
			url: "sendCoverletter",
			data : JSON.stringify(coverletter),
			contentType : 'application/json; charset=UTF-8',
			success: function(reps){
				console.log(reps);
				alert(resp);
				if(resp.includes("완료")){
				location.href = "${pageContext.request.contextPath}/goMyDocs";
				}
			},
			error: function(error){
				console.log("에러"+error);
			}
		});
		
	});
	
	//샘플박스 선택값을 DB에 보내서 갔다옴!
	$('#selectbox').on('change',function(){
		var sample_no = $('#selectbox option:selected').val();
		
		//ajax 로 처리 
		$.ajax({
			method: "post",
			url: "selectSamples",
			data : {"userid":"admin", "title": sample_no},
			success: function(reps){
				console.log(reps);
			 $('textarea[name="maintext"]').text(reps);
			},
			error: function(error){
				console.log("에러"+error);
			}
		});

		
	});
	
	
});

</script>

</html>