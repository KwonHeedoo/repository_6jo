<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- google CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<title>Matching Board</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<style type="text/css">
a {
cursor: pointer;
}

select {
height: 30.98px;
margin-left: 10px;
}
.raw{
display: inline-block;
}
.container{
margin-top: 20px;
padding: 0 auto;

}
td, th{
text-align:center;
}
td.boardTitle{
text-align:left;
}
#boardResult{
text-align: center;
margin-bottom: 20px;
margin-top: 20px;
}
</style>

</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp"%>
	<input id="boardType" type="hidden" value="${boardType}">
	<input id="page" type="hidden" value="${page}">
	<input id="searchItem" type="hidden" value="${searchItem}">
	<input id="searchText" type="hidden" value="${searchText}">

	<div id="boardResult">
	</div>
<%@ include file="/WEB-INF/views/Footer.jsp"%>
<script src="./resources//js/Board/matchingBoardList.js"></script>
</body>
</html>