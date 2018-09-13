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
</head>
<body>
	<h1>DataList</h1>
	<form id="reportCheck">
		<input id="reporter" type="hidden" value="">
	</form>
	<table>
		<c:forEach var="data" items="${dataList}" varStatus="status">
			
			<tr>
				
				<td>
					${status.count}
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
</body>
</html>