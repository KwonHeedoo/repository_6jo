<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>My Info Update</title>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

<style type="text/css">
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
.side-body{
height: 500px;
}
</style>
<script src="resources/jquery-3.3.1.min.js"></script>
<script>
$(function(){
	$('#change').on('click', function(){
		
		var currpwd = $('#currpwd').val();
		var newpwd = $('#newpwd').val();
		var checkpwd = $('#checkpwd').val();
		
		if(currpwd == newpwd){
			alert("Please type different password with your current password!");
			return false;
		}else if(newpwd != checkpwd){
			alert("Please retype the same password as you typed!");
			return false;
		}else{
			return true;
		}
		
	});
});
</script>
</head>
<body>
	<%@ include file="/WEB-INF/views/header.jsp"%>
	<%@ include file="/WEB-INF/views/mypage/mypage_sidebar.jsp"%>
		<!-- Main Content -->
		<div class="container-fluid">
			<div class="side-body">
				<div class="row">
					<div class="center">
						<form action="pwdChange" method="post">
						<div class="center">
						<br>
						<h3>[ Password Change ]</h3>
						<br>
							<p><input id="currpwd" type="password" name="currpwd" placeholder="Current Password"/></p>
							<p><input id="newpwd" type="password" name="newpwd" placeholder="New Password"/></p>
							<p><input id="checkpwd" type="password" name="checkpwd" placeholder="Confirm New Password"/></p>
							<br>
							<p><input id="change" type="submit" value="CHANGE" class="btn" /></p>
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
	location.href = "${pageContext.request.contextPath}/goLoginForm";
});
</script>
</c:if>

<%@ include file="/WEB-INF/views/Footer.jsp"%>

</body>
</html>