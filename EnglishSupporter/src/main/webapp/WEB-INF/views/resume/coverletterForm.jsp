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
		<div class="com-md-5" align="center">
		 &nbsp;&nbsp;&nbsp;<input type="text" id="username" name="username" placeholder="YOUR ENGLISH NAME">
		<br>
		<br>
		</div>
		<div class="col-md-3">
		<input id="email" type="email" name="email" value="" placeholder="YOUR E-MAIL"/>
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
		<c:if test="${type eq 'insert'}">
		<div class="right">
			<select name="sampleTemplete" id=selectbox>
				<option value="sample1" selected>Entry Level sample</option>
				<option value="sample2">Experienced Level sample</option>
			</select>
		</div>
		</c:if>
			<br>
		<textarea rows="" cols="" name="maintext" >
		<c:if test="${type eq 'insert'}">
		${sample.maintext}
		</c:if>
		<c:if test="${type eq 'update'}">
		${myCL.maintext}
		</c:if>
		</textarea>
	</div>
	</form>
	
	<div class="right">
		<br>
	<c:if test="${type eq 'insert'}">
	<input type="button" class="btn" value="Send Form" id="datasend">
	</c:if>
	<c:if test="${type eq 'update'}">
	<input type="button" class="btn" value="Update Form" id="dataUpdate">
	</c:if>
	</div>
	
</div>
	<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>

<script type="text/javascript">

$(function() {
	$('#resume').addClass('active');
	
	// username 박아주기...
	var userid = $('input[name="userid"]').val();
	console.log(userid);
	$.ajax({
		method: "post",
		url: "getUserInfo",
		data : {"userid": userid},
		dataType : "JSON",
		success: function(reps){
			var user= reps;
			$('#username').text(user.username);			
		},
		error: function(error){
			console.log("에러"+error);
		}
	});
	// 타입 update 인 경우  값들 박아주기 
	
	var type = '${type}';
	console.log(type);
	if(type == 'update'){
		var title = '${myCL.title}';
		//console.log(maintext);
		var email = '${myCL.email}';
		var address = '${myCL.address}';
		var phone = '${myCL.phone}';
		var username ='${myCL.username}';
		
		$('input[name="title"]').val(title);
		$('input[name="title"]').attr("readonly", true); //편집불가 
		$('input[name="email"]').val(email);
		$('input[name="phone"]').val(phone);
		$('input[name="address"]').val(address);
		$('input[name="username"]').val(username);
	}else{
		var email = '${sessionScope.email}';
		$('input[name="email"]').val(email);
	}
		
});


$(function(){
	$.fn.serializeJSON   = FormSerializer.serializeJSON;

	$('#datasend').on('click',function(){
	 	var coverletter = $('#coverletter').serializeJSON();
		console.log(coverletter);
		
		$.ajax({
			method: "post",
			url: "sendCoverletter",
			data : coverletter,
			contentType : 'application/json; charset=UTF-8',
			success: function(reps){
				console.log(reps);
				var text="";
				text =reps;
				alert(text);
				if(text.includes("완료")){
				location.href = "${pageContext.request.contextPath}/goMyDocs";
				}
			},
			error: function(error){
				console.log("에러"+error);
			}
		});
	});
		$('#dataUpdate').on('click',function(){
		 	var coverletter = $('#coverletter').serializeJSON();
			console.log(coverletter);
			
			$.ajax({
				method: "post",
				url: "updateCoverletter",
				data : coverletter,
				contentType : 'application/json; charset=UTF-8',
				success: function(reps){
					console.log(reps);
					var text="";
					text =reps;
					alert(text);
					if(text.includes("완료")){
					location.href = "${pageContext.request.contextPath}/viewMyCoverletter?userid=${sessionScope.loginId}&title="+encodeURI('${myCL.title}');
					}
				},
				error: function(error){
					console.log("에러"+error);
				}
			});
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
				//console.log(reps);
			 $('textarea[name="maintext"]').text(reps);
			},
			error: function(error){
				console.log("에러"+error);
			}
		});

		
	});
	
	


</script>

</html>