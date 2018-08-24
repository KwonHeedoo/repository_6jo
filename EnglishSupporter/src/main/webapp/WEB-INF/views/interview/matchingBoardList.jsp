<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Matching Board</title>
<script type="text/javascript">
function search(searchItem, searchText){
	location.href = "./boardList?searchItem="+searchItem+"&searchText="+searchText+"&boardType=matching";
}
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp"%>
	<h1>Matching Board</h1>
	<div>
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
					<td class="boardTitle"><a href="./detailBoard?boardNum=${board.boardNum}&boardType=matching&page=${navi.currentPage}&back=false&searchItem=${searchItem}&searchText=${searchText}"
						>${board.title}</a></td>
					<td>${board.userid}</td>
					<td>${board.regdate}</td>
					<td>${board.hitcount}</td>
					<td>
						<c:if test="${empty board.matchingId}"><img alt="possible" src="./resources/images/icons/silver.png"></c:if>
						<c:if test="${not empty board.matchingId}"><img alt="possible" src="./resources/images/icons/golden.png"></c:if>
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
	</div>
	<div id="page">
		<a href="./boardList?page=1&boardType=matching&searchItem=${searchItem}&searchText=${searchText}">◀◀</a>&emsp; 
		<a href="./boardList?page=${navi.currentPage - 1}&boardType=matching&searchItem=${searchItem}&searchText=${searchText}">Prev</a>&emsp;
		<c:forEach var="num" begin="${navi.startPageGroup}" end="${navi.endPageGroup}" step="1">
			<a href="./boardList?page=${num}&boardType=matching&searchItem=${searchItem}&searchText=${searchText}" >
			<span <c:if test="${navi.currentPage == num}"> style="font-size:12pt; font-weight:bold;" </c:if>>${num}&emsp;</span></a>
		</c:forEach>
		<a href="./boardList?page=${navi.currentPage + 1}&boardType=matching&searchItem=${searchItem}&searchText=${searchText}">Next</a>&emsp; 
		<a href="./boardList?page=${navi.totalPageCount}&boardType=matching&searchItem=${searchItem}&searchText=${searchText}">▶▶</a>
		<form id="searchBox" action="boardList" method="get">
			<input type="hidden" name="boardType" value="matching">
			<div class="col-md-4">
			<select name="searchItem">
				<option value="title" ${searchItem == 'title' ? 'selected' : ''}>Title</option>
				<option value="userid" ${searchItem == 'userid' ? 'selected' : ''}>User</option>
				<option value="contents" ${searchItem == 'contents' ? 'selected' : ''}>Contents</option>
			</select>
			</div>
			<div class="col-md-4">
				<input id="searchText" type="text" name="searchText" value="${searchText}">
			</div>
			<div class="col-md-4">
				<input id="search" type="submit" value="Search" onclick="search('searchItem', 'searchText')">
			</div>
		</form>
	</div>
	<a href="./writeBoardForm?page=${navi.currentPage}&boardType=matching"><button class="btn">Write Board</button></a>
<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>
</html>