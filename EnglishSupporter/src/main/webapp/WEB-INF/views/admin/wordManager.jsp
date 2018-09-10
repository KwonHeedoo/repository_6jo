<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
</script>
<style type="text/css">
table{
	width: 80%; 
}
th {
    color: #FFFFFF;
    background-color: #373737;
    text-align: center;
}
button{
border:none;
background-color:white;
}
.accept{
color:blue;
}
.cancel{
color:red;
}
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/admin/adminFrame.jsp"%>
	<div id="container" style="margin-left:350px;">
	<h1>Word Training Management</h1>
	<br>
	<!--  
	<div align="right">
		<select name="sampleTemplete" id=selectbox>
			<option value="1" selected>Level 1</option>
			<option value="2">Level 2</option>
			<option value="3">Level 3</option>
		</select>
	</div>
	-->
		<table border="1" style="text-align:center;">
			<tr>
				<th>Level</th>
				<th>No</th>
				<th>Word</th>
				<th>Meaning</th>
				<th>Update</th>
				<th>Delete</th>
			</tr>
			<c:forEach var="w" items="${wordlist}" varStatus="status">
			<tr>
				<td>${w.wordlevel}</td>
				<td><input type="hidden" value="${w.wordNum}">
				${status.count}</td>
				<td><input type="text" name="word" value="${w.word}" readonly="true"></td>
				<td><input type="text" name="mean" value="${w.meaningK}" readonly="true"></td>
				<td><input id="update" type="button" value="UPDATE"></td>
				<td><input id="delete" type="button" value="DELETE"></td>
			</tr>
			</c:forEach>
		</table>
		<br>
		<div id="navigator">
			<a href="goWordManager?page=${navi.currentPage-1}">◀◀&nbsp</a>
			
			<c:forEach var="num" begin="${navi.startPageGroup}" end="${navi.endPageGroup}">
				<a href="goWordManager?page=${num}">[${num}]&nbsp</a>
			</c:forEach>
			
			<a href="goWordManager?page=${navi.currentPage+1}">▶▶</a>
		</div>
	</div>
</body>
</html>