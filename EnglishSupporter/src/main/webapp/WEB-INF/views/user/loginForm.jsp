<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<style type="text/css">
.center{
margin :50px auto;
text-align: center;
width: 45%;
margin-top: 70px;
}
input{
width: 100%;
height: 30px;
border:1px solid; border-radius:22px;
display:block; width:100%; padding:8px 15px;
}
.btn{
width: 40%;
height: 35px;
padding:8px 18px 10px; text-transform:uppercase; font-weight:700; cursor:pointer;
border:1px solid; border-radius:22px;
}
.container{
height: 40%;
}
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp"%>
<script type="text/javascript">
$(function(){
	var msg = '${msg}';
	if(msg != ''){
		alert(msg);
	}
});
</script>
<div class="container" >
	<div class="row">
		<div class="center">
			<h2>[ LOGIN ]</h2>
			<form id="loginCheck" action="login" method="post">
			<div class="center">
				<p><input type="text" id="userid" name="userid" placeholder="ID" /></p>
				<p><input type="password" id="userpwd" name="userpwd" placeholder="PASSWORD" /></p>
				<p><input type="button" id="login" class="btn" value="LOGIN"></p>
			</div>
			</form>
		</div>
	</div><!-- row -->
</div>
<%@ include file="/WEB-INF/views/Footer.jsp"%>
<c:remove var="msg" scope="session" />
</body>
<script>
$(function(){
	$('#login').on('click', function(){
		var userid = $('#userid').val();
		var userpwd = $('#userpwd').val();
		
		if(userid.length < 3 || userid.length > 10){
			alert('ID는 3 ~ 10자리로 입력하세요');
			return false;
		}else if(userpwd.length < 6 || userpwd.length > 12 ){
			alert("비밀번호는 6 ~ 12자리로 입력하세요");
			return false;
		}
		
		$('#loginCheck').submit();
	});
});
</script>
</html>