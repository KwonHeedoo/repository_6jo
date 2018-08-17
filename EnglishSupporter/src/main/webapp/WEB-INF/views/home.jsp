<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>
	
	<c:if test="${sessionScope.userid == null}">
	<a href="./goLoginForm">로그인</a>
	</c:if>
	
	<c:if test="${sessionScope.userid != null}">
	${sessionScope.userid}님. 로그인 중...<a href="logout">로그아웃</a>
	</c:if>

	<a href="./goComposition">Composition</a>
</body>
</html>
