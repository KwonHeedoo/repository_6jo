<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Resume</title>
<script src="resources/jquery-3.3.1.min.js"></script>
<link href="resources/styles/layout.css" rel="stylesheet" type="text/css" media="all">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<style type="text/css">
  .navbar {
      margin-bottom: 0;
      border-radius: 0;
    }

</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/header.jsp"%>

<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="#">Resume Title : ${Resume.title}</a>
    </div>
  </div>
</nav>
<div class="jumbotron">
  <div class="container text-center">
	<table border="1">
		<!-- 게시판 제목부분 -->
		<tr id="boardMenu">
			<th>No</th>
			<th class="boardTitle">TITLE</th>
			<th>Registration Date</th>
			<th>Update/Delete</th>
		</tr>
		<!-- 게시판 내용부분 :: 데이터가 없을 경우 -->
		<c:if test="${empty clList}">
			<tr>
				<td colspan="4">There is no CoverLetter</td>
			</tr>
		</c:if>
		<!-- 게시판 내용부분 :: 데이터가 있을 경우 -->
		<c:if test="${not empty clList}">
			<c:forEach var="coverletter" items="${clList}" varStatus="status">
				<tr>
					<td>${status.count}</td>
					<td class="boardTitle">
					<a href="./viewMyCoverletter?userid=${coverletter.userid}&title=${coverletter.title}">${coverletter.title}</a>
					</td>
					<td>${coverletter.regdate}</td>
					<td>
					<a href="#" onclick="updateCdocs();">UPDATE</a> / <a href="#" onclick="deleteCdocs();">DELETE</a>
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
	</div>       
</div>

	<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>
</html>

