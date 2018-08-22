<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Home</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<style type="text/css">
.container{
height: 60%;
}


</style>
<script type="text/javascript">
$(function(){
	$('#home').addClass('active');
});
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp"%>
<div class="container">
	<c:if test="${sessionScope.userid == null}">
	<a href="./goLoginForm">로그인</a>
	</c:if>
	
	<c:if test="${sessionScope.userid != null}">
	${sessionScope.userid}님. 로그인 중...<a href="logout">로그아웃</a>
	</c:if>
	<br/>
</div>

<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>
</html>
