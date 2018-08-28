<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>My Info</title>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

<style type="text/css">
.raw{
height: 60%;

}
.side-menu {
margin-top:0;
position:absolute;
float:left;
  width: 280px;
  height: 100%;
  background-color: #f8f8f8;
  border-right: 1px solid #e7e7e7;
}
.side-menu .navbar-nav li {
  display: block;
  width: 100%;
  border-bottom: 1px solid #e7e7e7;
}
.side-body {
  margin-top: 20px;
  margin-left: 250px;
}

.navbar-default .navbar-nav>li>a:hover, .navbar-default .navbar-nav>li>a:focus{
	background-color: #c7c7c7 ;
}

/* 로그인폼에서 긁어옴 ~~ */
.center{
margin :0 auto;
text-align: center;
width: 50%;
margin-left: 20%;
}
input{
width: 100%;
height: 30px;
border:1px solid; border-radius:22px;
display:block; width:100%; padding:8px 15px;
}
.btn{
width: 45%;
height: 35px;
padding:8px 18px 10px; text-transform:uppercase; font-weight:700; cursor:pointer;
border:1px solid; border-radius:22px;
}
.container{
height: 40%;
}
/* ~~ 로그인폼에서 긁어옴 */

</style>
<script src="resources/jquery-3.3.1.min.js"></script>
<script>
$(function(){
	$("#nickname").on('keyup', function(){
		var nickname = $('#nickname').val();
		
		$.ajax({
			url : "nicknameCheck"
			,type : "post"
			,data : {"nickname" : nickname}
			,success : function(resp){
				if(resp == 1){
					$('#nicknameCheck').text("This nickname is already taken");
					$('#nicknameCheck').css("color" , "red");
				}else if(resp == 0){
					$('#nicknameCheck').text("This nickname is available");
					$('#nicknameCheck').css("color" , "blue");
				}
			}
			,error : function(resp){
				alert("통신실패")
			}
		});
	});
});
</script>
</head>
<body>
	<%@ include file="/WEB-INF/views/header.jsp"%>
	<div class="raw">
		<!-- uncomment code for absolute positioning tweek see top comment in css -->
		<!-- <div class="absolute-wrapper"> </div> -->
		<!-- Menu -->
		<div class="side-menu">
			<nav class="navbar navbar-default" role="navigation"> <!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<div class="brand-wrapper">
					<!-- Hamburger -->
					<button type="button" class="navbar-toggle">
						<span class="sr-only">Toggle navigation</span> <span
							class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
					</button>

					<!-- Brand -->
					<div class="brand-name-wrapper">
						<a class="navbar-brand" href="#"><span class="glyphicon glyphicon-user"></span> ${sessionScope.u.nickname}'s My page </a>
					</div>
				</div>
			</div>

			<!-- Main Menu -->
			<div class="side-menu-container">
				<ul class="nav navbar-nav">
					<li><a href="#"><span class="glyphicon glyphicon-book"></span>
							My Words</a></li>
					<li><a href="#"><span class="glyphicon glyphicon-list-alt"></span>
							Scheduler</a></li>
					<li><a href="goInfoUpdate"><span class="glyphicon glyphicon-wrench"></span>
							Info Update</a></li>
					<li><a href="#"><span class="glyphicon glyphicon-lock"></span>
							Change Password</a></li>
					<li><a href="#"><span class="glyphicon glyphicon-remove"></span>
							Withdrawal</a></li>
				</ul>
			</div>
			<!-- /.navbar-collapse --> </nav>
		</div><!-- side-menu -->

		<!-- Main Content -->
		<div class="container-fluid">
			<div class="side-body">
				<div class="row">
					<div class="center">
						<form action="infoUpdate" method="post">
						<div class="center">
						<h1>[ My Info Update ]</h1>
							<p>ID: <input type="text" name="userid" value="${sessionScope.u.userid}" readonly /></p>
							<p>NAME: <input type="text" name="username" placeholder="${sessionScope.u.username}" /></p>
							<p>NICKNAME: <input type="text" name="nickname" id="nickname" placeholder="${sessionScope.u.nickname}" /></p>
							<span id="nicknameCheck"></span>
							<p>EMAIL: <input type="text" name="email" placeholder="${sessionScope.u.email}" /></p>
							<p>BIRTH DATE: <input type="date" name="birthdate" value="" /></p>
							<input type="hidden" value="${sessionScope.u.birthdate}" id="birthdate">
							<p>PASSWORD: <input type="password" name="userpwd" placeholder="Verify your Password" required /></p>
							<p><input type="submit" value="UPDATE" class="btn" /></p>
						</div><!-- center -->
						</form>
					</div><!-- center -->
				</div><!-- row -->
			</div><!-- side-body -->
		</div><!-- container-fluid -->
	</div><!-- raw -->
	
<c:if test="${not empty msg}">
<script>
$(function(){
	alert("${msg}");
	location.href = "${pageContext.request.contextPath}/";
});
</script>
</c:if>

<%@ include file="/WEB-INF/views/Footer.jsp"%>

</body>

<script type="text/javascript">
$(function(){
	var date = $('#birthdate').val();
	date = date.split(' ');
	console.log(date);

	var birthdate = date[0];
	$('input[name="birthdate"]').val(birthdate);
	console.log(birthdate);
});
/*
$(function(){
	var date = $('#birthdate').val();
	date =date.split('-');
	console.log(date);

	var birthdate = date[0]+"-"+date[1]+"-"+date[2].substring(0,2);
	$('input[name="birthdate"]').val(birthdate);
	console.log(birthdate);
});
*/
</script>

</html>