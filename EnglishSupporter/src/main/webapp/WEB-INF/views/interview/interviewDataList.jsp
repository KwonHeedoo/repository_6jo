<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>DataList</title>
<!-- google CDN -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="resources/jquery.serialize-object.min.js"></script>
<title>Report</title>
<script type="text/javascript">
$(function() {
	$('#interview').addClass('active');
	
	$('#finish_button').on('click', function() {
			opener.setFile(sendData);
			window.close();
	});
});
function sendDataNum(datanum,fileName){
	console.log(fileName);
	opener.setFile(datanum,fileName);
	window.close();
}
</script>
<style type="text/css">
body {
    background: #f8f6f6;
    color: #404040;
    font-family: 'Lucida Grande', Verdana, sans-serif;
    font-size: 13px;
    font-weight: normal;
    line-height: 20px;
}
.no{
width: 10%;
}
.rf{
width: 40%;
}
.rd{
width: 40%;
}
.container{
text-align: center;
}
</style>
</head>
<body>
<div class="container">
	<h1 align="center">Recorded Video List</h1>
	<hr>
	<form id="reportCheck">
		<input id="reporter" type="hidden" value="">
	</form>
	<table class="todo-list">
			<tr>
			<th class="no">NO.</th>
			<th class="rf">Recorded Files</th>
			<th class="rd">Recorded Date</th>
			</tr>
		<c:forEach var="data" items="${dataList}" varStatus="status">
			<tr>
				<td>
					${status.count}.
				</td>
				<td>
					<a href='javascript:void(0);' onclick="sendDataNum(${data.dataNum},'${data.saveFile}')"> 
						${data.saveFile}
					</a>
				</td>
				<td>${data.regdate}</td>
			</tr>
		</c:forEach>
	</table>
</div>
</body>
</html>