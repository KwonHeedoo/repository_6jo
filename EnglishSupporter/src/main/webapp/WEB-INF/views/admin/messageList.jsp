<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- google CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	messageList();
});

function messageList(){
	$.ajax({
		url : 'messageList'
		, type : 'get'
		, success : function(resp){output(resp);}
		, error : function(){alert('Error!');}
	});
}

function output(resp){
	var messageList = resp;
	var result = '';
	
	result += '<div id="container">';
	result += '<table border="1" style="table-layout:fixed">';
	// 리스트 제목 부분
	result += '<tr>';
	result += '<th>Sender</th>';
	result += '<th>Message</th>';
	result += '<th>Regdate</th>';
	result += '<th>Read</th>';
	result += '</tr>';
	
	// 리스트 내용 부분
	$.each(messageList, function(index, item){
		result += '<tr>';
		result += '<td>' + item.nickname + '</td>';
		result += '<td><a href="#">' + item.message + '</a></td>';
		result += '<td>' + item.regdate + '</td>';
		if(item.status === 0){
			result += '<td>unread</td>';
		}else{
			result += '<td>read</td>';
		}
		result += '</tr>';
	});
	result += '</table>';
	result += '</div>';
	
	$('#messageList').html(result);
}
</script>
<title>Message List</title>
</head>
<body>
<%@ include file="/WEB-INF/views/admin/adminFrame.jsp"%>
<div id="container" style="margin-left:350px;">
	<h1>Message List</h1>
	<br/><br/>
	<div id="messageList"></div>
</div>
</body>
</html>