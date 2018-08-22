<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Matching Board</title>

</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp"%>
	<table border="1">
		<!-- 게시판 제목부분 -->
		<tr id="boardMenu">
			<th>No</th>
			<th class="boardTitle">TITLE</th>
			<th>NICKNAME</th>
			<th>REGDATE</th>
			<th>HITS</th>
			<th>MATCHING</th>
		</tr>
		<!-- 게시판 내용부분 :: 데이터가 없을 경우 -->
		<!-- ==null은 데이터가 진짜 null일때이므로 데이터가 없는 경우에는 empty를 사용해야한다. -->
		<c:if test="${empty boardList}">
			<tr>
				<td colspan="6">There is no Board</td>
			</tr>
		</c:if>
		<!-- 게시판 내용부분 :: 데이터가 있을 경우 -->
		<c:if test="${not empty boardList}">
			<c:forEach var="board" items="${boardList}" varStatus="status">
				<tr>
					<td>${navi.totalRecordsCount - navi.startRecord - (status.count - 1)}</td>
					<td class="boardTitle"><a href="./detailBoard?boardnum=${board.boardnum}&page=${navi.currentPage}&back=false&searchItem=${searchItem}&searchText=${searchText}"
						>${board.title}</a></td>
					<td>${board.userid}</td>
					<td>${board.regdate}</td>
					<td>${board.hitcount}</td>
					<td>
						<c:if test="${empty board.matchid}"><img alt="possible" src="./resources/images/icons/silver.png"></c:if>
						<c:if test="${not empty board.matchid}"><img alt="possible" src="./resources/images/icons/golden.png"></c:if>
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
	<div id="page">
		<a href="./boardList?page=1&searchItem=${searchItem}&searchText=${searchText}">◀◀</a>&emsp; 
		<a href="./boardList?page=${navi.currentPage - 1}&searchItem=${searchItem}&searchText=${searchText}">Prev</a>&emsp;
		<c:forEach var="num" begin="${navi.startPageGroup}" end="${navi.endPageGroup}" step="1">
			<a href="./boardList?page=${num}&searchItem=${searchItem}&searchText=${searchText}" >
			<span <c:if test="${navi.currentPage == num}"> style="color:red; font-size:12pt; font-weight:bold;" </c:if>>${num}&emsp;</span></a>
		</c:forEach>
		<a href="./boardList?page=${navi.currentPage + 1}&searchItem=${searchItem}&searchText=${searchText}">Next</a>&emsp; 
		<a href="./boardList?page=${navi.totalPageCount}&searchItem=${searchItem}&searchText=${searchText}">▶▶</a>
		<form id="searchBox" action="boardList" method="get">
			<select name="searchItem">
				<option value="title" ${searchItem == 'title' ? 'selected' : ''}>Title</option>
				<option value="userid" ${searchItem == 'userid' ? 'selected' : ''}>User</option>
				<option value="content" ${searchItem == 'content' ? 'selected' : ''}>Content</option>
			</select>
			<input id="searchText" type="text" name="searchText" value="${searchText}">
			<input id="search" type="submit" value="Search" onclick="search('searchItem', 'searchText')">
		</form>
	</div>
	<a href="./writeBoardForm?page=${navi.currentPage}"><button class="btn">Write Board</button></a>
<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>
</html>