<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<style type="text/css">
.center{
margin :0 auto;
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
<div class="container" >
	<div class="row">
		<div class="center">
			<h2>[ LOGIN ]</h2>
			<form action="login" method="post">
			<div class="center">
				<p><input type="text" name="userid" placeholder="ID" /></p>
				<p><input type="password" name="userpwd" placeholder="PASSWORD" /></p>
				<p><input type="submit" value="LOGIN" class="btn" /></p>
			</div>
			</form>
		</div>
		<div class="col-4"></div>
	</div><!-- row -->
</div>
<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>
</html>