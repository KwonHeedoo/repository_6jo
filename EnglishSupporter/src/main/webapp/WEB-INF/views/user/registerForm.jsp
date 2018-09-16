<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html >
<html>
<head>
<title>ENGLISH SUPPORTER</title>
<meta charset="utf-8">

<style type="text/css">
span#idcheck {
	color: white;
}

.center {
	margin: 0 auto;
	text-align: center;
	width: 45%;
	margin-top: 70px;
}

input {
	width: 100%;
	height: 30px;
	border: 1px solid;
	border-radius: 22px;
	display: block;
	width: 100%;
	padding: 8px 15px;
}

#imgInp {
	border: none;
}

.btn {
	width: 40%;
	height: 35px;
	padding: 8px 18px 10px;
	text-transform: uppercase;
	font-weight: 700;
	cursor: pointer;
	border: 1px solid;
	border-radius: 22px;
}

.container {
	height: 40%;
	display: inline; /* display넣어주면 블록과 분리시켜준다 */
}
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
var okuserid=false;
var oknickname=false;
var getMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);

// ID 중복검사
$(function(){ 
	$("#userid").on('keyup', function(){
		var inputVal = $(this).val();
      
		$.ajax({
			url : "idcheck"
			, type : "post"
			, data : {"userid" : $(this).val()}
			, success : function(resp){
				if(resp == 1){
					$('#idcheck').text("중복된 아이디가 있습니다");
					$('#idcheck').css("color" , "red");
					okuserid = false;
				}else if(resp == 0){
					$('#idcheck').text("아이디를 사용할수 있습니다");
					$('#idcheck').css("color" , "blue");
					okuserid = true;
				}else if(resp == -1){
					$('#idcheck').text("id는 3~ 10자리로 입력해주세요");
					$('#idcheck').css("color" , "black");
					okuserid = false;
				}
			}
			, error : function(resp){
				alert("통신실패")
			}
		});
	});
});

// 사진 미리보기
$(function(){
	$("#imgInp").on('change',function(){
		readURL(this);
	});
});

function readURL(input) {
	if (input.files && input.files[0]){
		var reader = new FileReader();
		reader.onload = function(e) {
		$('#blah').attr('src' , e.target.result);
		}
		reader.readAsDataURL(input.files[0]);
	}
}

$(function(){
	// 닉네임 중복검사
	$("#nickname").on('keyup', function(){
		$.ajax({
			url : "nicknameCheck"
			, type : "post"
			, data : {"nickname" : $(this).val()}
			, success : function(resp){
				if(resp == 1){
					$('#nicknamecheck').text("중복된 닉네임이 있습니다");
					$('#nicknamecheck').css("color" , "red");
					oknickname = false;
				}else if(resp == 0){
					$('#nicknamecheck').text("닉네임을 사용할수 있습니다");
					$('#nicknamecheck').css("color" , "blue");
					oknickname = true;
				}else if(resp == -1){
					$('#nicknamecheck').text("닉네임은 3~ 7자리로 입력해주세요");
					$('#nicknamecheck').css("color" , "black");
					oknickname = false;
				}
			}
			, error : function(resp){
				alert("통신실패")
			}
		});

	});
      
	// 패스워드 중복검사
	$("#userpwd").on('keyup', function(){ 
		var userpwd = $('#userpwd').val();
		var userpwdCheck = $('#userpwdCheck').val();
      
		if(userpwd.length == 0 ){
			$('#pwdcheck').text("비밀번호를 입력하세요");
		}else if(userpwd.length < 6 || userpwd.length > 12 ){
			$('#pwdcheck').text("비밀번호는 6 ~ 12자리로 입력하세요");
			return;
		}
	});
      
	$("#userpwdCheck").on('keyup', function(){
		var userpwd = $('#userpwd').val();
		var userpwdCheck = $('#userpwdCheck').val();

		if(userpwdCheck != userpwd){
			$('#pwdcheck').text("비밀번호가일치하지않습니다");
			$('#pwdcheck').css("color", "red");
		}else if(userpwdCheck == userpwd){
			$('#pwdcheck').text("비밀번호가 일치합니다");   
			$('#pwdcheck').css("color", "blue");   
		}
	});
      
	// 이미지 확장자 유효성 검사
	$("#imgInp").on("change", function(){
		if( $("#imgInp").val() != "" ){
			var ext = $('#imgInp').val().split('.').pop().toLowerCase();
			if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
				alert('gif, png, jpg, jpeg 파일만 업로드 할수 있습니다.');
				$("#imgInp").val("");
				return;
			}
		}
	});

	// 회원가입 입력 폼 유효성 검사
	$('#registbtn').on('click', function(){
		var userid =$("#userid").val();
		var userpwd =$("#userpwd").val();
		var userpwdCheck =$("#userpwdCheck").val();
		var nickname =$("#nickname").val();
		var email =$("#email").val();
		var birthdate =$("#birthdate").val();
		var username =$("#username").val();
         
		if(userid == 0){
			alert("ID를 입력하세요");
			return;
		}else if(userid.length < 3 || userid.length > 10){
			alert("아이디는 3~10자리로 입력하세요");
			return;
		}else if(userpwd == 0 || userpwd.length < 6 || userpwd.length > 12){
			alert("비밀번호는 6 ~ 12자리로 입력하세요");
			return;
		}else if(userpwdCheck == 0 || userpwdCheck < 6 || userpwdCheck.length > 12){
			alert("비밀번호확인란을 6 ~ 12자리로 입력하세요");
			return;
		}else if(userpwd != userpwdCheck){
			alert("비밀번호가 다릅니다 확인해주세요");
			return;
		}else if(nickname == 0 || nickname.length < 3 || nickname.length > 7){
			alert("닉네임은 3~7자리로 입력해주세요");
			return;
		}else if(!getMail.test($("#email").val())){
			alert("이메일형식에 맞게 입력해주세요")
			$("#email").val("");
			$("#email").focus();
			return false;
		}else if(birthdate == 0){
			alert("생년월일을 입력하세요");
			return;
		}else if(username == 0 ){
			alert("이름을 입력하세요");
			return;
		}
         
		/* console.log(okuserid+", "+oknickname); */
		if(okuserid == true && oknickname == true){
			$('#useridcheck').submit();
		}else{
			alert("중복된 값이 있습니다");
		}
	});
});
</script>
</head>
<body>
<%@ include file="/WEB-INF/views//header.jsp"%>
	<div class="container">
		<div class="row">
			<div class="center">
				<form id="useridcheck" method="post" action="insertUser" enctype="multipart/form-data">
					<h3 align=center>회원가입양식</h3>
					<h3>프로필사진을 등록하세요</h3>

					<div class="tt" data-ratio="16.9" style="display: inline;">
						<img id="blah"
							src="./resources/images/icons/user-avatar-placeholder.png"
							alt="Upload Image!!" style="width: 200px; height: 200px;" />
					</div>
					<br><br><br><input type="file" id="imgInp" name="imgInp" />

					<div class="center">
						<p>
							<input type="text" placeholder="아이디" name="userid" id="userid">
							<span id="idcheck"></span>
						</p>

						<p>
							<input type="password" placeholder="비밀번호" name="userpwd"
								maxlength="20" id="userpwd">
						</p>

						<p>
							<input type="password" placeholder="비밀번호확인" name="userpwdCheck" 
								maxlength="20" id="userpwdCheck">
						</p>
						<span id="pwdcheck"></span>

						<p>
							<input type="text" placeholder="닉네임" id="nickname"
								name="nickname" maxlength="20"> <span id="nicknamecheck"></span>
						</p>

						<p>
							<input type="email" placeholder="이메일주소" id="email" name="email"
								maxlength="20"> ex ) abcd@abcd.com (공백없이)
						</p>

						<p>
							<input type="date" placeholder="생일" name="birthdate"
								maxlength="20" id="birthdate">
						</p>


						<p>
							<input type="text" placeholder="이름" name="username"
								maxlength="20" id="username">
						</p>

						<p>
							<input value="회원가입" type="button" class="btn" id="registbtn" />
						</p>

						<p>
							<input type="reset" class="btn" value="다시 입력">
						</p>
					</div>
				</form>
			</div>

		</div>
	</div>

<!------ Include the above in your HEAD tag ---------->
<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>
</html>