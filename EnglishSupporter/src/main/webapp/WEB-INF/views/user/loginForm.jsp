<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp"%>
<h2>[ LOGIN ]</h2>
<form action="login" method="post">
	<p><input type="text" name="userid" placeholder="ID"/></p>
	<p><input type="password" name="userpwd" placeholder="PASSWORD" /></p>
	<p><input type="submit" value="LOGIN" /></p>
</form>
<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>
</html>