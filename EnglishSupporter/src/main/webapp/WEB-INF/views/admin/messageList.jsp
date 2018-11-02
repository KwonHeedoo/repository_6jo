<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	
	result += '<div class="container">';
	result += '<table width="900">';
	// 리스트 제목 부분
	result += '<tr>';
	result += '<th style="width:15%;">SENDER</th>';
	result += '<th style="width:60%;">MESSAGE</th>';
	result += '<th style="width:15%;">REGDATE</th>';
	result += '<th style="width:10%;">CHECK</th>';
	result += '</tr>';
	
	if(!messageList.length){
		result += '<tr>';
		result += '<td colspan="4">There is no Message</td>';
		result += '</tr>';
	}
	
	// 리스트 내용 부분
	if(messageList.length){
		$.each(messageList, function(index, item){
			result += '<tr>';
			result += '<td>' + item.nickname + '</td>';
			result += '<td><a id="msgAll' + item.messageNum + '" ><b>' + item.message + '</b></a></td>';
			result += '<td>' + item.regdate + '</td>';
			if(item.status === 0){
				result += '<td>unread</td>';
			}else{
				result += '<td>read</td>';
			}
			result += '</tr>';
		});
	}
	result += '</table>';
	result += '</div>';
	
	$('#messageList').html(result);
	
	if(messageList){
		$.each(messageList, function(index, item){
			$('#msgAll' + item.messageNum).on('click', function(){
				read(item.messageNum, item.userid, item.nickname, item.message);
			});
		});
	}
}

function read(messageNum, userid, nickname, message){
	
	var form = document.createElement('form');
	form.setAttribute('method', 'post');
	form.setAttribute('action', 'goReceiveMsgBox');
	form.setAttribute('target', 'ReceiveMsgBox');
	
	input = document.createElement('input');
	input.type = 'hidden';
	input.name = 'messageNum';
	input.value = messageNum;
	form.appendChild(input);

	input = document.createElement('input');
	input.type = 'hidden';
	input.name = 'userid';
	input.value = userid;
	form.appendChild(input);
	
	input = document.createElement('input');
	input.type = 'hidden';
	input.name = 'nickname';
	input.value = nickname;
	form.appendChild(input);

	input = document.createElement('input');
	input.type = 'hidden';
	input.name = 'message';
	input.value = message;
	form.appendChild(input);
	
	document.body.appendChild(form);
	
	window.open('', 'ReceiveMsgBox', 'width=400, height=500, location=no, toolbar=no, menubar=no, scrollbars=no, resizable=no');
	
	form.submit();
	
	document.body.removeChild(form);
	
	messageList();
}
</script>
<style type="text/css">
.container{
margin-top: 30px;
margin-bottom: 30px;
height: 50%;
}
a {
cursor: pointer;
}
table, td, th{
border: 1px solid #bcbcbc;
font-size: 20px;
}
td{
text-overflow:ellipsis; 
overflow:hidden;
white-space:nowrap;
}
th{
color: #FFFFFF;
background-color: #373737;
text-align: center;
}
table{
text-align:center;
table-layout: fixed;
width: 1000px;
}
</style>
<title>Message List</title>
</head>
<body>
<c:if test="${sessionScope.loginType eq 'admin'}">
<%@ include file="/WEB-INF/views/admin/adminFrame.jsp"%>
</c:if>
<c:if test="${sessionScope.loginType eq 'user'}">
<%@ include file="/WEB-INF/views/header.jsp"%>
</c:if>
<c:if test="${sessionScope.loginType eq 'admin'}">
	<div id="container" style="margin-left:350px;">`
		<h1>Message List</h1>
		<br/>
		<div id="messageList"></div>
	</div>
</c:if>
<c:if test="${sessionScope.loginType eq 'user'}">
	<div class="container">
		<h1>Message List</h1>
		<br/>
	<div id="messageList"></div></div>
</c:if>
<c:if test="${sessionScope.loginType eq 'user'}">
<%@ include file="/WEB-INF/views/Footer.jsp"%>
</c:if>
</body>
</html>