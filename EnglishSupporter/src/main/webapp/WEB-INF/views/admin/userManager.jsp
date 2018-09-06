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
	$('#userManager').addClass('active');
	
	blackList('sanction');
	
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

// 블랙리스트 정보 요청
function blackList(orderByType){
	$.ajax({
		url : 'blackList'
		, type : 'get'
		, data : {'orderByType' : orderByType}
		, success : function(resp){output(resp);}
		, error : function(){alert('Error!');}
	});
}

//블랙리스트 또는 회원 정보 출력
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
	result += '<th>ReportCount</th>';
	result += '<th>SanctionCount</th>';
	result += '<th>Sanction</th>';
	result += '<th>Release</th>';
	result += '</tr>';
	
	$.each(blackList, function(index, item){
		result += '<tr>';
		result += '<td>' + item.userid + '</td>';
		result += '<td>' + item.nickname + '</td>';
		result += '<td>' + item.email + '</td>';
		result += '<td>' + item.regdate + '</td>';
		result += '<td>' + item.lastdate + '</td>';
		result += '<td>' + item.attendNum + '</td>';
		result += '<td>' + item.reportCount + '</td>';
		result += '<td>' + item.sanctionCount + '</td>';
		result += '<td><button onclick="sanction(\'' + item.userid + '\')">Sanction</button></td>';
		result += '<td><button onclick="release(\'' + item.userid + '\')">Release</button></td>';
		result += '</tr>';
	});
	
	result += '</table>';
	
	$('#blackList').html(result);
}

// 유저 계정 사용 일시 정지
function sanction(userid){
	$.ajax({
		url : 'sanctionUser'
		, type : 'get'
		, data : {'userid' : userid}
		, success : function(resp){
			if(resp === 1){
				alert('Stop User');
				blackList('sanction');
			}else{
				alert('Already Stoped');
			}
		}
		, error : function(){alert('Error!');}
	});
}
</script>
<style type="text/css">
th {
    color: #FFFFFF;
    background-color: #373737;
    text-align: center;
}
</style>
<title>User Management</title>
</head>
<body>
<%@ include file="/WEB-INF/views/admin/adminFrame.jsp"%>
	<div id="container" style="margin-left:350px;">
	<h1>User Management</h1>
	<br/><br/>
	<div class="row">
		Order By&emsp;
		<button onclick="blackList('report')">Report</button>
		<button onclick="blackList('sanction')">Sanction</button>
	</div>
	<br/>
	<div class="row">
		ID&emsp;:&emsp;
		<input id="userid" type="text" name="userid"/>&emsp;
		<input id="search" type="button" value="Search">
	</div>
	<br/>
	<div id="blackList"></div>
	</div>
</body>
</html>