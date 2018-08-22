<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html >
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입</title>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
$(function(){

	
	$("#login").on('click', function(){
		var userid = $("#userid").val();
		var userpwd = $("#userpwd").val();
		var userpwdCheck = $("#userpwdCheck").val();
		var nickname = $("#nickname").val();
		var username = $("#username").val();
		var email = $('#email').val();			
		
		if(userid.length < 6 || userid.length > 11 ){
			alert("아이디는 6 ~ 11 자 사이로 입력하세요.");
			return;
		}
				
		if(userpwd.length < 7 || userpwd.length > 11 || userpwdCheck.length < 7 || userpwdCheck.length > 11){
			alert("비밀번호는 7~11 자리입니다.");
			return ;
		}
			
		if(userpwd != userpwdCheck){
			alert("비밀번호가 일치하지않습니다. ")
			return;		
		}
		
		if(nickname.length < 4 || nickname.length > 8){
			alert("닉네임은 4~8 자리입니다.");
			return ;
		}
		
		if(email.length == 0){
			alert("이메일을 입력하세요. ")
			return;
		}
			
		if(username.length < 2 || username.length > 8){
		alert("이름은 2~8자리 입니다.");
		 return;
		}
				
	})	
});

</script>

</head>
<body>

	<form id="loginCheck" method="post" action="#">

		<h3 align=left>회원가입양식</h3>

		<div class="form-group">
			<input type="text" class="form-control" placeholder="아이디"
				name="userid" maxlength="20" id="userid">
		</div>

		<div class="form-group">
			<input type="password" class="form-control" placeholder="비밀번호"
				name="userpwd" maxlength="20" id="userpwd">
		</div>
		<div class="form-group">
			<input type="password" class="form-control" placeholder="비밀번호확인"
				name="userpwdCheck" maxlength="20" id="userpwdCheck">

		</div>
		<div class="form-group">
			<input type="text" class="form-control" placeholder="닉네임"
				id="nickname" name="nickname" maxlength="20">
		</div>
		<div class="form-group">
			<input type="text" class="form-control" placeholder="이메일주소"
				id="email" name="email" maxlength="20"> 

		</div>
		<div class="form-group">
			<input type="text" class="form-control" placeholder="생일"
				name="birthdate" maxlength="20"> ex ) 900101 (공백없이)
		</div>
		<div class="form-group">
			<input type="text" class="form-control" placeholder="이름"
				name="username" maxlength="20" id="username">
		</div>

		<p>
			<input id="login" type="button" value="로그인" />
		</p>

	</form>


</body>
</html>