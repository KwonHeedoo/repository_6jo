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
	adminList();
	
	// 특정 회원 정보 요청
	$('#search').on('click', function(){
		var userid = $('#userid').val();
		
		if(userid.length == 0){
			alert('Please write ID');
			return;
		}
		
		$.ajax({
			url : 'searchUser'
			, type : 'get'
			, data : {'userid' : userid}
			, success : function(resp){output(resp);}
			, error : function(){alert('Error!');}
		});
	});
});

// 관리자 리스트 정보 요청
function adminList(){
	$.ajax({
		url : 'adminList'
		, type : 'get'
		, success : function(resp){output(resp);}
		, error : function(){alert('Error!');}
	});
}

// 관리자 리스트 또는 회원 정보 출력
function output(resp){
	var blackList = resp;
	var result = '';
	
	result += '<table border="1" style="text-align:center;">';
	result += '<tr>';
	result += '<th>ID</th>';
	result += '<th>Nickname</th>';
	result += '<th>e-Mail</th>';
	result += '<th>Regdate</th>';
	result += '<th>LastDate</th>';
	result += '<th>AttendCount</th>';
	result += '<th>BeAdmin</th>';
	result += '<th>BeUser</th>';
	result += '</tr>';
	
	$.each(blackList, function(index, item){
		result += '<tr>';
		result += '<td>' + item.userid + '</td>';
		result += '<td>' + item.nickname + '</td>';
		result += '<td>' + item.email + '</td>';
		result += '<td>' + item.regdate + '</td>';
		result += '<td>' + item.lastdate + '</td>';
		result += '<td>' + item.attendNum + '</td>';
		result += '<td><button onclick="beAdmin(\'' + item.userid + '\')">BeAdmin</button></td>';
		result += '<td><button onclick="beUser(\'' + item.userid + '\')">BeUser</button></td>';
		result += '</tr>';
	});
	
	result += '</table>';
	
	$('#adminList').html(result);
}

// 유저 관리자 등급 조정
function beAdmin(userid){
	<c:if test="${sessionScope.usertype == 'admin'}">
		alert('Already be Admin');
		return;
	</c:if>
	
	//확인
	if (confirm("Are you Sure??") == true){
		$.ajax({
			url : 'beAdmin'
			, type : 'post'
			, data : {'userid' : userid}
			, success : function(resp){
				if(resp === 1){
					alert('Complete change Admin');
					adminList();
				}else{
					alert('Sorry, Can not change Admin');
				}
			}
			, error : function(){alert('Error!');}
		});
	//취소
	}else{
	    return;
	}
}

// 관리자 일반회원으로 회원등급 내리기
function beUser(userid){
	<c:if test="${sessionScope.usertype == 'user'}">
		alert('Already be User');
		return;
	</c:if>
	
	//확인
	if (confirm("Are you Sure??") == true){
		$.ajax({
			url : 'beUser'
			, type : 'post'
			, data : {'userid' : userid}
			, success : function(resp){
				if(resp === 1){
					alert('Complete change User');
					adminList();
				}else{
					alert('Sorry, Can not change User');
				}
			}
			, error : function(){alert('Error!');}
		});
	//취소
	}else{
	    return;
	}
}
</script>
<style type="text/css">
th {
    color: #FFFFFF;
    background-color: #373737;
    text-align: center;
}
</style>
<title>Admin Management</title>
</head>
<body>
<%@ include file="/WEB-INF/views/admin/adminFrame.jsp"%>
	<div id="container" style="margin-left:350px;">
	<h1>Admin Management</h1>
	<br/><br/>
	<div class="row">
		ID&emsp;:&emsp;
		<input id="userid" type="text" name="userid"/>&emsp;
		<input id="search" type="button" value="Search">
	</div>
	<br/>
	<div id="adminList"></div>
	</div>
</body>
</html>