<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>Insert title here</title>
<style type="text/css">
body {
    background: #f8f6f6;
    color: #404040;
    font-family: 'Lucida Grande', Verdana, sans-serif;
    font-size: 13px;
    font-weight: normal;
    line-height: 20px;
}
.todo-list{
text-align: center;
border-bottom: 1px solid #e6ebed;
width: 100%;
}

.time{
width: 40%;
}
.no{
width: 30%;
}
</style>
</head>
<body>
	<div align="center"><h2>[ Room List ]</h2></div>
	<hr>
 <table class="todo-list">

  </table>
</body>
<script type="text/javascript">
function callPfunction(roomid){
	window.opener.goMatching(roomid);
}

$(function() {
	// 문제목록 가져오기 
	var loginId = '${sessionScope.loginId}';
	console.log(loginId);
	$.ajax({
		method:'post',
		url:'getMRoomList',
		dateType : 'json',
		success :function(data){
			console.log(data);
			var text="";
			text += '<tr><th class="no">Room Number</th>';
			text += '<th class="time">Appointed Time</th>';
			text += '<th class="no">appointed User</th></tr>';
			for (var i = 0; i < data.length; i++) {
				var roomNum =  data[i].roomNum +"";
				console.log("roomNum : " + roomNum);
				console.log(typeof(roomNum));
				 text += "<tr>";
				 text += '<td><a href="javascript:void(0);" onclick="callPfunction(\'';
				 text += roomNum;
				 text += '\');">' + i +'</a></td>';
				 //text += '<td><a href="javascript:void(0);" onclick="callPfunction('+ 'a12345678' + ' );">' + data[i].roomNum +'</a></td>';
				 text += '<td>'+ data[i].appointedTime + '</td>';
				 if(loginId==data[i].userid){
				 text += '<td>'+ data[i].matchingId + '</td>';
				 }else{
				 text += '<td>'+ data[i].userid + '</td>';
				 }
				 text += "</tr>";
			}
			$('table.todo-list').html(text);
		},
		error:function(resp){
			console.log('에러'+resp);
		}
	});
});


</script>
</html>